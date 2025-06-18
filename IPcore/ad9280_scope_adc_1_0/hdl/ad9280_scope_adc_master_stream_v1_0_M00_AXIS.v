`timescale 1 ns / 1 ps

module ad9280_scope_adc_master_stream_v1_0_M00_AXIS #
(
	// Users to add parameters here

	// User parameters ends
	// Do not modify the parameters beyond this line
	// Width of S_AXIS address bus. The slave accepts the read and write addresses of width C_M_AXIS_TDATA_WIDTH.
	parameter integer C_M_AXIS_TDATA_WIDTH	= 8,  // 修改为8位，与ad9280_sample兼容
	// Start count is the number of clock cycles the master will wait before initiating/issuing any transaction.
	parameter integer C_M_START_COUNT	= 32
)
(
	// Users to add ports here
	input wire fifo_rd_en,
	input wire [C_M_AXIS_TDATA_WIDTH-1:0] fifo_data_out,
	input wire fifo_empty,
	input wire sampling_active,
	// User ports ends
	// Do not modify the ports beyond this line

	// Global ports
	input wire  M_AXIS_ACLK,
	// 
	input wire  M_AXIS_ARESETN,
	// Master Stream Ports. TVALID indicates that the master is driving a valid transfer, A transfer takes place when both TVALID and TREADY are asserted. 
	output wire  M_AXIS_TVALID,
	// TDATA is the primary payload that is used to provide the data that is passing across the interface from the master.
	output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] M_AXIS_TDATA,
	// TSTRB is the byte qualifier that indicates whether the content of the associated byte of TDATA is processed as a data byte or a position byte.
	output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] M_AXIS_TSTRB,
	// TLAST indicates the boundary of a packet.
	output wire  M_AXIS_TLAST,
	// TREADY indicates that the slave can accept a transfer in the current cycle.
	input wire  M_AXIS_TREADY
);
	// AXI Stream internal signals (修改为8位数据)
	reg [C_M_AXIS_TDATA_WIDTH-1:0] stream_data_out;
	reg axis_tvalid_reg;
	reg axis_tlast_reg;
	
	// Internal control signals
	wire tx_en;
	reg [15:0] transfer_count;
	reg streaming_active;
	
	// I/O Connections assignments
	assign M_AXIS_TVALID = axis_tvalid_reg;
	assign M_AXIS_TDATA = stream_data_out;
	assign M_AXIS_TLAST = axis_tlast_reg;
	assign M_AXIS_TSTRB = {(C_M_AXIS_TDATA_WIDTH/8){1'b1}};
	
	// Transfer enable when both valid and ready
	assign tx_en = M_AXIS_TREADY && axis_tvalid_reg;
	
	// Stream control logic
	always @(posedge M_AXIS_ACLK) begin		if (!M_AXIS_ARESETN) begin
			axis_tvalid_reg <= 1'b0;
			axis_tlast_reg <= 1'b0;
			stream_data_out <= 8'h0;  // 修改为8位初始值
			transfer_count <= 16'h0;
			streaming_active <= 1'b0;
		end else begin
			// Start streaming when sampling is active and FIFO has data
			if (sampling_active && !fifo_empty && !streaming_active) begin
				streaming_active <= 1'b1;
				transfer_count <= 16'h0;
			end
			
			// Stop streaming when sampling is inactive and FIFO is empty
			if (!sampling_active && fifo_empty && streaming_active) begin
				streaming_active <= 1'b0;
				axis_tvalid_reg <= 1'b0;
				axis_tlast_reg <= 1'b1; // Signal end of stream
			end
			
			// Generate TVALID when streaming is active and FIFO has data
			if (streaming_active && !fifo_empty) begin
				axis_tvalid_reg <= 1'b1;
				
				// Transfer data when ready
				if (tx_en) begin
					stream_data_out <= fifo_data_out;
					transfer_count <= transfer_count + 1;
					
					// Generate TLAST for end of packet (every 1024 transfers or when not sampling)
					if (transfer_count >= 1023 || (!sampling_active && fifo_empty)) begin
						axis_tlast_reg <= 1'b1;
						transfer_count <= 16'h0;
					end else begin
						axis_tlast_reg <= 1'b0;
					end
				end
			end else begin
				axis_tvalid_reg <= 1'b0;
				axis_tlast_reg <= 1'b0;
			end
		end
	end

endmodule
