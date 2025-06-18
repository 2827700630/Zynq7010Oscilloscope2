`timescale 1 ns / 1 ps
	module ad9280_scop #	(
		// Users to add parameters here
		parameter integer ADC_DATA_WIDTH = 8,
		parameter integer FIFO_DEPTH = 1024,
		parameter integer TRIGGER_THRESHOLD_WIDTH = 8,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5,

		// Parameters of Axi Master Bus Interface M00_AXIS
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 8,
		parameter integer C_M00_AXIS_START_COUNT	= 32
	)
	(
		// Users to add ports here
		// ADC interface
		input wire                          adc_clk,
		input wire                          adc_rst_n,
		input wire [ADC_DATA_WIDTH-1:0]     adc_data,
		
		// Trigger interface
		input wire                          ext_trigger,
		output wire                         trigger_out,
		
		// Status signals
		output wire                         sampling_active,
		output wire                         fifo_full,
		output wire                         fifo_empty,
		// User ports ends
		// Do not modify the ports beyond this line


		// Ports of Axi Slave Bus Interface S00_AXI
		input wire  s00_axi_aclk,
		input wire  s00_axi_aresetn,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_awaddr,
		input wire [2 : 0] s00_axi_awprot,
		input wire  s00_axi_awvalid,
		output wire  s00_axi_awready,
		input wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_wdata,
		input wire [(C_S00_AXI_DATA_WIDTH/8)-1 : 0] s00_axi_wstrb,
		input wire  s00_axi_wvalid,
		output wire  s00_axi_wready,
		output wire [1 : 0] s00_axi_bresp,
		output wire  s00_axi_bvalid,
		input wire  s00_axi_bready,
		input wire [C_S00_AXI_ADDR_WIDTH-1 : 0] s00_axi_araddr,
		input wire [2 : 0] s00_axi_arprot,
		input wire  s00_axi_arvalid,
		output wire  s00_axi_arready,
		output wire [C_S00_AXI_DATA_WIDTH-1 : 0] s00_axi_rdata,
		output wire [1 : 0] s00_axi_rresp,
		output wire  s00_axi_rvalid,
		input wire  s00_axi_rready,

		// Ports of Axi Master Bus Interface M00_AXIS
		input wire  m00_axis_aclk,
		input wire  m00_axis_aresetn,
		output wire  m00_axis_tvalid,
		output wire [C_M00_AXIS_TDATA_WIDTH-1 : 0] m00_axis_tdata,
		output wire [(C_M00_AXIS_TDATA_WIDTH/8)-1 : 0] m00_axis_tstrb,
		output wire  m00_axis_tlast,
		input wire  m00_axis_tready	);
// IP Core Version Information (for REG7)
// Version format: {Major[7:0], Minor[7:0], Patch[7:0], Build[7:0]}
localparam [31:0] IP_VERSION = {8'd2, 8'd4, 8'd0, 8'd1};  // Version 2.4.0.1
// Major: 2 (ad9280_scop_2.x)
// Minor: 4 (升级版本)  
// Patch: 0 (补丁版本)
// Build: 1 (构建编号)

// Instantiation of Axi Bus Interface S00_AXI
	ad9280_scop_slave_lite_v2_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) ad9280_scop_slave_lite_v2_0_S00_AXI_inst (
		.control_reg(control_reg),
		.status_reg(status_reg),
		.trigger_config_reg(trigger_config_reg),
		.trigger_threshold_reg(trigger_threshold_reg),		.sample_depth_reg(sample_depth_reg),
		.decimation_config_reg(decimation_config_reg),
		.timebase_config_reg(timebase_config_reg),
		.reserved_reg(IP_VERSION),  // 直接连接版本信息
		.S_AXI_ACLK(s00_axi_aclk),
		.S_AXI_ARESETN(s00_axi_aresetn),
		.S_AXI_AWADDR(s00_axi_awaddr),
		.S_AXI_AWPROT(s00_axi_awprot),
		.S_AXI_AWVALID(s00_axi_awvalid),
		.S_AXI_AWREADY(s00_axi_awready),
		.S_AXI_WDATA(s00_axi_wdata),
		.S_AXI_WSTRB(s00_axi_wstrb),
		.S_AXI_WVALID(s00_axi_wvalid),
		.S_AXI_WREADY(s00_axi_wready),
		.S_AXI_BRESP(s00_axi_bresp),
		.S_AXI_BVALID(s00_axi_bvalid),
		.S_AXI_BREADY(s00_axi_bready),
		.S_AXI_ARADDR(s00_axi_araddr),
		.S_AXI_ARPROT(s00_axi_arprot),
		.S_AXI_ARVALID(s00_axi_arvalid),
		.S_AXI_ARREADY(s00_axi_arready),
		.S_AXI_RDATA(s00_axi_rdata),
		.S_AXI_RRESP(s00_axi_rresp),
		.S_AXI_RVALID(s00_axi_rvalid),
		.S_AXI_RREADY(s00_axi_rready)
	);

// Instantiation of Axi Bus Interface M00_AXIS
	ad9280_scop_master_stream_v2_0_M00_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M00_AXIS_START_COUNT)
	) ad9280_scop_master_stream_v2_0_M00_AXIS_inst (
		.fifo_rd_en(fifo_rd_en),
		.fifo_data_out(fifo_data_out),
		.fifo_empty(fifo_empty),
		.sampling_active(sampling_active),
		.sample_depth(sample_depth_reg[15:0]),
		.M_AXIS_ACLK(m00_axis_aclk),
		.M_AXIS_ARESETN(m00_axis_aresetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready)
	);

	// Add user logic here
	
	// Internal signals
	wire [31:0] control_reg;
	wire [31:0] status_reg;	wire [31:0] trigger_config_reg;
	wire [31:0] trigger_threshold_reg;
	wire [31:0] sample_depth_reg;
	wire [31:0] decimation_config_reg;
	wire [31:0] timebase_config_reg;
	// reserved_reg已直接连接到IP_VERSION，无需wire声明
	
	// Control signals
	wire sampling_enable;
	wire trigger_enable;
	wire [1:0] trigger_mode;
	wire trigger_edge;
	wire software_trigger;
	
	// FIFO signals (修改为8位数据)
	wire fifo_rd_en;
	wire [7:0] fifo_data_out;
	wire core_data_valid;
	wire core_data_ready;
	
	// Status signals from core
	wire core_sampling_active;
	wire core_trigger_detected;
	wire core_acquisition_complete;
	wire core_fifo_full;
	wire core_fifo_empty;
	wire [15:0] core_sample_count;
	
	// Extract control signals from registers
	assign sampling_enable = control_reg[0];
	assign trigger_enable = control_reg[1];
	assign trigger_mode = control_reg[3:2];  // 00: auto, 01: normal, 10: single, 11: external
	assign trigger_edge = control_reg[4];    // 0: rising, 1: falling
	assign software_trigger = control_reg[8];
	
	// Status register assembly
	assign status_reg = {
		core_sample_count,          // [31:16] Sample count
		6'h0,                       // [15:10] Reserved
		core_acquisition_complete,  // [9]     Acquisition complete
		core_trigger_detected,      // [8]     Trigger detected
		core_fifo_full,            // [7]     FIFO full
		core_fifo_empty,           // [6]     FIFO empty
		core_sampling_active,      // [5]     Sampling active
		5'h0                       // [4:0]   Reserved
	};
		// Output status signals
	assign sampling_active = core_sampling_active;
	assign fifo_full = core_fifo_full;
	assign fifo_empty = core_fifo_empty;
	assign trigger_out = core_trigger_detected;
	
	// Connect data flow - fifo_rd_en is now controlled by AXI Master module
	assign core_data_ready = fifo_rd_en;  // Use the fifo_rd_en from AXI Master
	
	// Instantiate AD9280 scope ADC core
	ad9280_scop_adc_core #(
		.ADC_DATA_WIDTH(ADC_DATA_WIDTH),
		.FIFO_DEPTH(FIFO_DEPTH),
		.SAMPLE_DEPTH_WIDTH(16)
	) adc_core_inst (
		// Clock and Reset
		.adc_clk(adc_clk),
		.adc_rst_n(adc_rst_n),
		.sys_clk(s00_axi_aclk),
		.sys_rst_n(s00_axi_aresetn),
		
		// ADC Interface
		.adc_data(adc_data),
		
		// Control Interface
		.sampling_enable(sampling_enable),
		.trigger_enable(trigger_enable),
		.trigger_mode(trigger_mode),
		.trigger_edge(trigger_edge),
		.software_trigger(software_trigger),
		.trigger_threshold(trigger_threshold_reg[ADC_DATA_WIDTH-1:0]),
		.sample_depth(sample_depth_reg[15:0]),
		.ext_trigger(ext_trigger),
		
		// Status Interface
		.sampling_active(core_sampling_active),
		.trigger_detected(core_trigger_detected),
		.acquisition_complete(core_acquisition_complete),
		.fifo_full(core_fifo_full),
		.fifo_empty(core_fifo_empty),
		.sample_count(core_sample_count),
		
		// Data Output Interface
		.data_valid(core_data_valid),
		.data_out(fifo_data_out),
		.data_ready(core_data_ready)
	);
	// User logic ends

	endmodule
