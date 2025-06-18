
`timescale 1 ns / 1 ps

	module ad9280_scope_adc #	(
		// Users to add parameters here
		parameter integer ADC_DATA_WIDTH = 8,
		parameter integer FIFO_DEPTH = 1024,
		parameter integer TRIGGER_THRESHOLD_WIDTH = 8,
		// User parameters ends
		// Do not modify the parameters beyond this line


		// Parameters of Axi Slave Bus Interface S00_AXI
		parameter integer C_S00_AXI_DATA_WIDTH	= 32,
		parameter integer C_S00_AXI_ADDR_WIDTH	= 5,
		// Parameters of Axi Master Bus Interface M00_AXIS (修改为8位输出)
		parameter integer C_M00_AXIS_TDATA_WIDTH	= 8,
		parameter integer C_M00_AXIS_START_COUNT	= 32,

		// Parameters of Axi Slave Bus Interface S_AXI_INTR
		parameter integer C_S_AXI_INTR_DATA_WIDTH	= 32,
		parameter integer C_S_AXI_INTR_ADDR_WIDTH	= 5,
		parameter integer C_NUM_OF_INTR	= 1,
		parameter  C_INTR_SENSITIVITY	= 32'hFFFFFFFF,
		parameter  C_INTR_ACTIVE_STATE	= 32'hFFFFFFFF,
		parameter integer C_IRQ_SENSITIVITY	= 1,
		parameter integer C_IRQ_ACTIVE_STATE	= 1
	)	(
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
		input wire  m00_axis_tready,

		// Ports of Axi Slave Bus Interface S_AXI_INTR
		input wire  s_axi_intr_aclk,
		input wire  s_axi_intr_aresetn,
		input wire [C_S_AXI_INTR_ADDR_WIDTH-1 : 0] s_axi_intr_awaddr,
		input wire [2 : 0] s_axi_intr_awprot,
		input wire  s_axi_intr_awvalid,
		output wire  s_axi_intr_awready,
		input wire [C_S_AXI_INTR_DATA_WIDTH-1 : 0] s_axi_intr_wdata,
		input wire [(C_S_AXI_INTR_DATA_WIDTH/8)-1 : 0] s_axi_intr_wstrb,
		input wire  s_axi_intr_wvalid,
		output wire  s_axi_intr_wready,
		output wire [1 : 0] s_axi_intr_bresp,
		output wire  s_axi_intr_bvalid,
		input wire  s_axi_intr_bready,
		input wire [C_S_AXI_INTR_ADDR_WIDTH-1 : 0] s_axi_intr_araddr,
		input wire [2 : 0] s_axi_intr_arprot,
		input wire  s_axi_intr_arvalid,
		output wire  s_axi_intr_arready,
		output wire [C_S_AXI_INTR_DATA_WIDTH-1 : 0] s_axi_intr_rdata,
		output wire [1 : 0] s_axi_intr_rresp,
		output wire  s_axi_intr_rvalid,
		input wire  s_axi_intr_rready,		output wire  irq
	);
	
	// Internal signals
	wire [31:0] control_reg;
	wire [31:0] status_reg;
	wire [31:0] trigger_config_reg;
	wire [31:0] trigger_threshold_reg;
	wire [31:0] sample_depth_reg;
	
	// Control signals
	wire sampling_enable;
	wire trigger_enable;
	wire [1:0] trigger_mode;
	wire trigger_edge;
	wire software_trigger;
		// FIFO signals (修改为8位数据)
	wire fifo_rd_en;
	wire [7:0] fifo_data_out;
// Instantiation of Axi Bus Interface S00_AXI
	ad9280_scope_adc_slave_lite_v1_0_S00_AXI # ( 
		.C_S_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
	) ad9280_scope_adc_slave_lite_v1_0_S00_AXI_inst (
		.control_reg(control_reg),
		.status_reg(status_reg),
		.trigger_config_reg(trigger_config_reg),
		.trigger_threshold_reg(trigger_threshold_reg),
		.sample_depth_reg(sample_depth_reg),
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
	ad9280_scope_adc_master_stream_v1_0_M00_AXIS # ( 
		.C_M_AXIS_TDATA_WIDTH(C_M00_AXIS_TDATA_WIDTH),
		.C_M_START_COUNT(C_M00_AXIS_START_COUNT)
	) ad9280_scope_adc_master_stream_v1_0_M00_AXIS_inst (
		.fifo_rd_en(fifo_rd_en),
		.fifo_data_out(fifo_data_out),
		.fifo_empty(fifo_empty),
		.sampling_active(sampling_active),
		.M_AXIS_ACLK(m00_axis_aclk),
		.M_AXIS_ARESETN(m00_axis_aresetn),
		.M_AXIS_TVALID(m00_axis_tvalid),
		.M_AXIS_TDATA(m00_axis_tdata),
		.M_AXIS_TSTRB(m00_axis_tstrb),
		.M_AXIS_TLAST(m00_axis_tlast),
		.M_AXIS_TREADY(m00_axis_tready)
	);

// Instantiation of Axi Bus Interface S_AXI_INTR
	ad9280_scope_adc_slave_lite_inter_v1_0_S_AXI_INTR # ( 
		.C_S_AXI_DATA_WIDTH(C_S_AXI_INTR_DATA_WIDTH),
		.C_S_AXI_ADDR_WIDTH(C_S_AXI_INTR_ADDR_WIDTH),
		.C_NUM_OF_INTR(C_NUM_OF_INTR),
		.C_INTR_SENSITIVITY(C_INTR_SENSITIVITY),
		.C_INTR_ACTIVE_STATE(C_INTR_ACTIVE_STATE),
		.C_IRQ_SENSITIVITY(C_IRQ_SENSITIVITY),
		.C_IRQ_ACTIVE_STATE(C_IRQ_ACTIVE_STATE)
	) ad9280_scope_adc_slave_lite_inter_v1_0_S_AXI_INTR_inst (
		.S_AXI_ACLK(s_axi_intr_aclk),
		.S_AXI_ARESETN(s_axi_intr_aresetn),
		.S_AXI_AWADDR(s_axi_intr_awaddr),
		.S_AXI_AWPROT(s_axi_intr_awprot),
		.S_AXI_AWVALID(s_axi_intr_awvalid),
		.S_AXI_AWREADY(s_axi_intr_awready),
		.S_AXI_WDATA(s_axi_intr_wdata),
		.S_AXI_WSTRB(s_axi_intr_wstrb),
		.S_AXI_WVALID(s_axi_intr_wvalid),
		.S_AXI_WREADY(s_axi_intr_wready),
		.S_AXI_BRESP(s_axi_intr_bresp),
		.S_AXI_BVALID(s_axi_intr_bvalid),
		.S_AXI_BREADY(s_axi_intr_bready),
		.S_AXI_ARADDR(s_axi_intr_araddr),
		.S_AXI_ARPROT(s_axi_intr_arprot),
		.S_AXI_ARVALID(s_axi_intr_arvalid),
		.S_AXI_ARREADY(s_axi_intr_arready),
		.S_AXI_RDATA(s_axi_intr_rdata),
		.S_AXI_RRESP(s_axi_intr_rresp),
		.S_AXI_RVALID(s_axi_intr_rvalid),
		.S_AXI_RREADY(s_axi_intr_rready),
		.irq(irq)
	);	// Add user logic here
		// Internal signals for ADC core (修改data_out为8位)
	wire core_sampling_active;
	wire core_trigger_detected;
	wire core_acquisition_complete;
	wire core_fifo_full;
	wire core_fifo_empty;
	wire [15:0] core_sample_count;
	wire core_data_valid;
	wire [7:0] core_data_out;  // 修改为8位输出
	wire core_data_ready;
	
	// Extract control signals from registers
	assign sampling_enable = control_reg[0];
	assign trigger_enable = control_reg[1];
	assign trigger_mode = control_reg[3:2];  // 00: auto, 01: normal, 10: single, 11: external
	assign trigger_edge = control_reg[4];    // 0: rising, 1: falling
	assign software_trigger = control_reg[8];
	
	// Status register assembly
	assign status_reg = {
		16'h0,                      // [31:16] Reserved
		core_sample_count,          // [15:0]  Sample count
		6'h0,                       // [31:26] Reserved
		core_acquisition_complete,  // [25]    Acquisition complete
		core_trigger_detected,      // [24]    Trigger detected
		core_fifo_full,            // [23]    FIFO full
		core_fifo_empty,           // [22]    FIFO empty
		core_sampling_active,      // [21]    Sampling active
		1'b0                       // [20]    Reserved
	};
	
	// Output status signals
	assign sampling_active = core_sampling_active;
	assign fifo_full = core_fifo_full;
	assign fifo_empty = core_fifo_empty;
	assign trigger_out = core_trigger_detected;
	
	// Connect data flow
	assign core_data_ready = m00_axis_tready && m00_axis_tvalid;
	assign fifo_data_out = core_data_out;
	assign fifo_rd_en = core_data_ready;
	
	// Instantiate AD9280 scope ADC core
	ad9280_scope_adc_core #(
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
		.data_out(core_data_out),
		.data_ready(core_data_ready)
	);
	
	// User logic ends

	endmodule
