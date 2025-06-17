`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/14
// Design Name: AD9280 Scope ADC Core
// Module Name: ad9280_scope_adc_core
// Project Name: AD9280 Oscilloscope
// Target Devices: ZYNQ
// Tool Versions: Vivado 2021.1
// Description: AD9280 ADC sampling core with hardware trigger functionality
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module ad9280_scope_adc_core #(
    parameter integer ADC_DATA_WIDTH = 8,
    parameter integer FIFO_DEPTH = 1024,
    parameter integer SAMPLE_DEPTH_WIDTH = 16
)(
    // Clock and Reset
    input wire adc_clk,
    input wire adc_rst_n,
    input wire sys_clk,
    input wire sys_rst_n,
    
    // ADC Interface
    input wire [ADC_DATA_WIDTH-1:0] adc_data,
    
    // Control Interface
    input wire sampling_enable,
    input wire trigger_enable,
    input wire [1:0] trigger_mode,  // 00: auto, 01: normal, 10: single, 11: external
    input wire trigger_edge,        // 0: rising, 1: falling
    input wire software_trigger,
    input wire [ADC_DATA_WIDTH-1:0] trigger_threshold,
    input wire [SAMPLE_DEPTH_WIDTH-1:0] sample_depth,
    input wire ext_trigger,
    
    // Status Interface
    output reg sampling_active,
    output reg trigger_detected,
    output reg acquisition_complete,
    output wire fifo_full,
    output wire fifo_empty,
    output reg [SAMPLE_DEPTH_WIDTH-1:0] sample_count,
    
    // Data Output Interface
    output wire data_valid,
    output wire [31:0] data_out,
    input wire data_ready
);

    // Internal signals
    reg [1:0] adc_sync;
    reg [ADC_DATA_WIDTH-1:0] adc_data_reg;
    reg [ADC_DATA_WIDTH-1:0] prev_adc_data;
    reg adc_valid;
    
    // Trigger detection
    reg [2:0] ext_trigger_sync;
    reg trigger_detected_reg;
    reg software_trigger_reg;
    reg software_trigger_prev;
    
    // Sample control
    reg [SAMPLE_DEPTH_WIDTH-1:0] pre_trigger_count;
    reg [SAMPLE_DEPTH_WIDTH-1:0] total_sample_count;
    
    // State machine
    localparam IDLE = 3'b000;
    localparam WAIT_TRIGGER = 3'b001;
    localparam PRE_TRIGGER = 3'b010;
    localparam SAMPLING = 3'b011;
    localparam COMPLETE = 3'b100;
    
    reg [2:0] state;
    reg [2:0] next_state;
    
    // FIFO signals
    wire fifo_wr_en;
    wire fifo_rd_en;
    wire [31:0] fifo_data_in;
    wire [31:0] fifo_data_out;
    wire fifo_prog_full;
    wire fifo_prog_empty;
    
    // ADC data synchronization and validation
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            adc_sync <= 2'b00;
            adc_data_reg <= 0;
            prev_adc_data <= 0;
            adc_valid <= 1'b0;
        end else begin
            adc_sync <= {adc_sync[0], 1'b1};
            prev_adc_data <= adc_data_reg;
            adc_data_reg <= adc_data;
            adc_valid <= adc_sync[1];
        end
    end
    
    // External trigger synchronization
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            ext_trigger_sync <= 3'b000;
        end else begin
            ext_trigger_sync <= {ext_trigger_sync[1:0], ext_trigger};
        end
    end
    
    // Software trigger edge detection
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            software_trigger_reg <= 1'b0;
            software_trigger_prev <= 1'b0;
        end else begin
            software_trigger_prev <= software_trigger_reg;
            software_trigger_reg <= software_trigger;
        end
    end
    
    // Trigger detection logic
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            trigger_detected_reg <= 1'b0;
        end else begin
            trigger_detected_reg <= 1'b0;
            
            if (trigger_enable && adc_valid) begin
                case (trigger_mode)
                    2'b00: // Auto trigger
                        trigger_detected_reg <= 1'b1;
                    
                    2'b01: // Normal trigger - level based
                        trigger_detected_reg <= (adc_data_reg >= trigger_threshold);
                    
                    2'b10: // Single trigger - edge based
                        if (trigger_edge == 1'b0) // Rising edge
                            trigger_detected_reg <= (prev_adc_data < trigger_threshold) && 
                                                   (adc_data_reg >= trigger_threshold);
                        else // Falling edge
                            trigger_detected_reg <= (prev_adc_data >= trigger_threshold) && 
                                                   (adc_data_reg < trigger_threshold);
                    
                    2'b11: // External trigger
                        trigger_detected_reg <= ext_trigger_sync[2] && !ext_trigger_sync[1];
                endcase
            end
            
            // Software trigger override
            if (software_trigger_reg && !software_trigger_prev) begin
                trigger_detected_reg <= 1'b1;
            end
        end
    end
    
    // State machine
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        
        case (state)
            IDLE: begin
                if (sampling_enable) begin
                    if (trigger_enable)
                        next_state = WAIT_TRIGGER;
                    else
                        next_state = SAMPLING;
                end
            end
            
            WAIT_TRIGGER: begin
                if (!sampling_enable)
                    next_state = IDLE;
                else if (trigger_detected_reg)
                    next_state = PRE_TRIGGER;
            end
            
            PRE_TRIGGER: begin
                if (!sampling_enable)
                    next_state = IDLE;
                else if (pre_trigger_count >= (sample_depth >> 2)) // 25% pre-trigger
                    next_state = SAMPLING;
            end
            
            SAMPLING: begin
                if (!sampling_enable)
                    next_state = IDLE;
                else if (total_sample_count >= sample_depth)
                    next_state = COMPLETE;
            end
            
            COMPLETE: begin
                if (!sampling_enable)
                    next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Sample counters and control
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            sample_count <= 0;
            pre_trigger_count <= 0;
            total_sample_count <= 0;
            sampling_active <= 1'b0;
            trigger_detected <= 1'b0;
            acquisition_complete <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    sample_count <= 0;
                    pre_trigger_count <= 0;
                    total_sample_count <= 0;
                    sampling_active <= 1'b0;
                    trigger_detected <= 1'b0;
                    acquisition_complete <= 1'b0;
                end
                
                WAIT_TRIGGER: begin
                    sampling_active <= 1'b1;
                    if (adc_valid && trigger_detected_reg) begin
                        trigger_detected <= 1'b1;
                    end
                end
                
                PRE_TRIGGER: begin
                    if (adc_valid) begin
                        pre_trigger_count <= pre_trigger_count + 1;
                        sample_count <= sample_count + 1;
                        total_sample_count <= total_sample_count + 1;
                    end
                end
                
                SAMPLING: begin
                    if (adc_valid) begin
                        sample_count <= sample_count + 1;
                        total_sample_count <= total_sample_count + 1;
                    end
                end
                
                COMPLETE: begin
                    sampling_active <= 1'b0;
                    acquisition_complete <= 1'b1;
                end
            endcase
        end
    end
    
    // FIFO write control
    assign fifo_wr_en = adc_valid && (state == PRE_TRIGGER || state == SAMPLING || state == WAIT_TRIGGER);
    assign fifo_data_in = {24'h0, adc_data_reg};
    
    // FIFO read control
    assign fifo_rd_en = data_ready && !fifo_prog_empty;
    
    // Output assignments
    assign data_valid = !fifo_prog_empty;
    assign data_out = fifo_data_out;
    assign fifo_full = fifo_prog_full;
    assign fifo_empty = fifo_prog_empty;
    
    // Simple FIFO implementation
    // Note: In actual design, use Xilinx FIFO IP for better performance
    reg [31:0] fifo_mem [0:FIFO_DEPTH-1];
    reg [$clog2(FIFO_DEPTH):0] fifo_wr_ptr;
    reg [$clog2(FIFO_DEPTH):0] fifo_rd_ptr;
    reg [$clog2(FIFO_DEPTH):0] fifo_count;
    
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            fifo_wr_ptr <= 0;
        end else if (fifo_wr_en && !fifo_prog_full) begin
            fifo_mem[fifo_wr_ptr[$clog2(FIFO_DEPTH)-1:0]] <= fifo_data_in;
            fifo_wr_ptr <= fifo_wr_ptr + 1;
        end
    end
    
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            fifo_rd_ptr <= 0;
        end else if (fifo_rd_en && !fifo_prog_empty) begin
            fifo_rd_ptr <= fifo_rd_ptr + 1;
        end
    end
    
    // FIFO count management
    always @(posedge adc_clk or negedge adc_rst_n) begin
        if (!adc_rst_n) begin
            fifo_count <= 0;
        end else begin
            case ({fifo_wr_en && !fifo_prog_full, fifo_rd_en && !fifo_prog_empty})
                2'b10: fifo_count <= fifo_count + 1;
                2'b01: fifo_count <= fifo_count - 1;
                default: fifo_count <= fifo_count;
            endcase
        end
    end
    
    assign fifo_data_out = fifo_mem[fifo_rd_ptr[$clog2(FIFO_DEPTH)-1:0]];
    assign fifo_prog_full = (fifo_count >= (FIFO_DEPTH - 4));
    assign fifo_prog_empty = (fifo_count == 0);

endmodule
