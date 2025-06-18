`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/06/14
// Design Name: AD9280 Scope ADC Core (8-bit Output Compatible)
// Module Name: ad9280_scope_adc_core
// Project Name: AD9280 Oscilloscope
// Target Devices: ZYNQ
// Tool Versions: Vivado 2021.1
// Description: AD9280 ADC sampling core with hardware trigger functionality
//              Modified for 8-bit output compatibility with ad9280_sample
// 
// Modifications Applied:
// - Changed output from 32-bit to 8-bit for ad9280_sample compatibility
// - Improved data efficiency from 25% to 100%
// - Maintained all advanced features (trigger, pre-trigger, etc.)
// - Uses optimized Xilinx XPM async FIFO (256x8bit)
// - Direct 8-bit ADC data output without padding
// 
// Key Features:
// - Multiple trigger modes (auto/normal/single/external)
// - Configurable pre-trigger depth
// - Cross-clock domain support (ADC clock vs System clock)
// - 8-bit AXI Stream output (compatible with ad9280_sample)
// - Efficient resource utilization
// 
// Dependencies: 
// - Xilinx XPM Library (xpm_fifo_async)
// 
// Revision:
// Revision 0.01 - File Created
// Revision 0.02 - FIFO Optimized (2025/06/17)
// Revision 0.03 - 8-bit Output Compatibility (2025/06/17)
// Additional Comments:
// Now compatible with ad9280_sample interface for easy IP core replacement
// 
//////////////////////////////////////////////////////////////////////////////////

module ad9280_scope_adc_core #(
    parameter integer ADC_DATA_WIDTH = 8,
    parameter integer FIFO_DEPTH = 256,        // 优化：减少到256，足够1920点采样使用
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
      // Data Output Interface (修改为8位输出，与ad9280_sample兼容)
    output wire data_valid,
    output wire [7:0] data_out,
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
      // FIFO信号定义
    wire [7:0] fifo_data_out;
    wire fifo_empty;
    wire fifo_full_flag;
    wire fifo_prog_empty;
    wire fifo_prog_full;
    wire fifo_rd_rst_busy;
    wire fifo_wr_rst_busy;
    
    // FIFO write control
    assign fifo_wr_en = adc_valid && (state == PRE_TRIGGER || state == SAMPLING);
    assign fifo_data_in = adc_data_reg; // 优化：直接使用8位数据，减少资源消耗
    
    // FIFO read control  
    assign fifo_rd_en = data_ready && !fifo_empty;
      // Output assignments (修改为直接8位输出)
    assign data_valid = !fifo_empty;
    assign data_out = fifo_data_out; // 直接输出8位数据，无需扩展
    assign fifo_full = fifo_prog_full;
    
    // 优化的Xilinx XPM异步FIFO实现
    // 支持不同时钟域，更高效的资源利用
    xpm_fifo_async #(
        .CASCADE_HEIGHT(0),           // DECIMAL
        .CDC_SYNC_STAGES(2),          // DECIMAL
        .DOUT_RESET_VALUE("0"),       // String
        .ECC_MODE("no_ecc"),          // String
        .FIFO_MEMORY_TYPE("auto"),    // String - 自动选择最优存储类型
        .FIFO_READ_LATENCY(1),        // DECIMAL
        .FIFO_WRITE_DEPTH(FIFO_DEPTH), // DECIMAL - 使用参数化深度
        .FULL_RESET_VALUE(0),         // DECIMAL
        .PROG_EMPTY_THRESH(10),       // DECIMAL - 程序化空标志阈值
        .PROG_FULL_THRESH(FIFO_DEPTH-10), // DECIMAL - 程序化满标志阈值
        .RD_DATA_COUNT_WIDTH($clog2(FIFO_DEPTH)+1), // DECIMAL
        .READ_DATA_WIDTH(8),          // DECIMAL - 8位读数据宽度
        .READ_MODE("std"),            // String
        .RELATED_CLOCKS(0),           // DECIMAL - 异步时钟
        .SIM_ASSERT_CHK(0),           // DECIMAL
        .USE_ADV_FEATURES("0707"),    // String - 启用prog_full, prog_empty, rd_data_count, wr_data_count
        .WAKEUP_TIME(0),              // DECIMAL
        .WRITE_DATA_WIDTH(8),         // DECIMAL - 8位写数据宽度
        .WR_DATA_COUNT_WIDTH($clog2(FIFO_DEPTH)+1)  // DECIMAL
    )
    xpm_fifo_async_inst (
        .almost_empty(),              // 1-bit output: Almost Empty
        .almost_full(),               // 1-bit output: Almost Full
        .data_valid(),                // 1-bit output: Read Data Valid
        .dbiterr(),                   // 1-bit output: Double Bit Error
        .dout(fifo_data_out),         // READ_DATA_WIDTH-bit output: Read Data
        .empty(fifo_empty),           // 1-bit output: Empty Flag
        .full(fifo_full_flag),        // 1-bit output: Full Flag
        .overflow(),                  // 1-bit output: Overflow
        .prog_empty(fifo_prog_empty), // 1-bit output: Programmable Empty
        .prog_full(fifo_prog_full),   // 1-bit output: Programmable Full
        .rd_data_count(),             // RD_DATA_COUNT_WIDTH-bit output: Read Data Count
        .rd_rst_busy(fifo_rd_rst_busy), // 1-bit output: Read Reset Busy
        .sbiterr(),                   // 1-bit output: Single Bit Error
        .underflow(),                 // 1-bit output: Underflow
        .wr_ack(),                    // 1-bit output: Write Acknowledge
        .wr_data_count(),             // WR_DATA_COUNT_WIDTH-bit output: Write Data Count
        .wr_rst_busy(fifo_wr_rst_busy), // 1-bit output: Write Reset Busy
        
        .din(fifo_data_in),           // WRITE_DATA_WIDTH-bit input: Write Data
        .injectdbiterr(1'b0),         // 1-bit input: Double Bit Error Injection
        .injectsbiterr(1'b0),         // 1-bit input: Single Bit Error Injection
        .rd_clk(sys_clk),             // 1-bit input: Read clock - 系统时钟域
        .rd_en(fifo_rd_en),           // 1-bit input: Read Enable
        .rst(~adc_rst_n),             // 1-bit input: Reset
        .sleep(1'b0),                 // 1-bit input: Dynamic Power Saving
        .wr_clk(adc_clk),             // 1-bit input: Write clock - ADC时钟域  
        .wr_en(fifo_wr_en)            // 1-bit input: Write Enable
    );

endmodule
