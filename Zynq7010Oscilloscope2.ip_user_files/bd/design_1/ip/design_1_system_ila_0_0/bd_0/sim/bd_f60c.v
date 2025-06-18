//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Command: generate_target bd_f60c.bd
//Design : bd_f60c
//Purpose: IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "bd_f60c,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=bd_f60c,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=7,numReposBlks=7,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SBD,synth_mode=None}" *) (* HW_HANDOFF = "design_1_system_ila_0_0.hwdef" *) 
module bd_f60c
   (SLOT_0_AXIS_tdata,
    SLOT_0_AXIS_tlast,
    SLOT_0_AXIS_tready,
    SLOT_0_AXIS_tstrb,
    SLOT_0_AXIS_tvalid,
    SLOT_1_AXI_araddr,
    SLOT_1_AXI_arcache,
    SLOT_1_AXI_arlen,
    SLOT_1_AXI_arprot,
    SLOT_1_AXI_arready,
    SLOT_1_AXI_arsize,
    SLOT_1_AXI_arvalid,
    SLOT_1_AXI_awaddr,
    SLOT_1_AXI_awcache,
    SLOT_1_AXI_awlen,
    SLOT_1_AXI_awprot,
    SLOT_1_AXI_awready,
    SLOT_1_AXI_awsize,
    SLOT_1_AXI_awvalid,
    SLOT_1_AXI_bready,
    SLOT_1_AXI_bresp,
    SLOT_1_AXI_bvalid,
    SLOT_1_AXI_rdata,
    SLOT_1_AXI_rlast,
    SLOT_1_AXI_rready,
    SLOT_1_AXI_rvalid,
    SLOT_1_AXI_wdata,
    SLOT_1_AXI_wlast,
    SLOT_1_AXI_wready,
    SLOT_1_AXI_wstrb,
    SLOT_1_AXI_wvalid,
    clk,
    resetn);
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TDATA" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SLOT_0_AXIS, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1, FREQ_HZ 166666672, HAS_TKEEP 0, HAS_TLAST 1, HAS_TREADY 1, HAS_TSTRB 1, INSERT_VIP 0, LAYERED_METADATA undef, PHASE 0.0, TDATA_NUM_BYTES 1, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0" *) input [7:0]SLOT_0_AXIS_tdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TLAST" *) input SLOT_0_AXIS_tlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TREADY" *) input SLOT_0_AXIS_tready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TSTRB" *) input [0:0]SLOT_0_AXIS_tstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 SLOT_0_AXIS TVALID" *) input SLOT_0_AXIS_tvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARADDR" *) (* X_INTERFACE_MODE = "Monitor SlaveType" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME SLOT_1_AXI, ADDR_WIDTH 32, ARUSER_WIDTH 0, AWUSER_WIDTH 0, BUSER_WIDTH 0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1, DATA_WIDTH 32, FREQ_HZ 166666672, HAS_BRESP 1, HAS_BURST 0, HAS_CACHE 1, HAS_LOCK 0, HAS_PROT 1, HAS_QOS 0, HAS_REGION 0, HAS_RRESP 0, HAS_WSTRB 1, ID_WIDTH 0, INSERT_VIP 0, MAX_BURST_LENGTH 128, NUM_READ_OUTSTANDING 2, NUM_READ_THREADS 1, NUM_WRITE_OUTSTANDING 16, NUM_WRITE_THREADS 1, PHASE 0.0, PROTOCOL AXI4, READ_WRITE_MODE WRITE_ONLY, RUSER_BITS_PER_BYTE 0, RUSER_WIDTH 0, SUPPORTS_NARROW_BURST 0, WUSER_BITS_PER_BYTE 0, WUSER_WIDTH 0" *) input [31:0]SLOT_1_AXI_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARCACHE" *) input [3:0]SLOT_1_AXI_arcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARLEN" *) input [7:0]SLOT_1_AXI_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARPROT" *) input [2:0]SLOT_1_AXI_arprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARREADY" *) input SLOT_1_AXI_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARSIZE" *) input [2:0]SLOT_1_AXI_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI ARVALID" *) input SLOT_1_AXI_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWADDR" *) input [31:0]SLOT_1_AXI_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWCACHE" *) input [3:0]SLOT_1_AXI_awcache;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWLEN" *) input [7:0]SLOT_1_AXI_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWPROT" *) input [2:0]SLOT_1_AXI_awprot;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWREADY" *) input SLOT_1_AXI_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWSIZE" *) input [2:0]SLOT_1_AXI_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI AWVALID" *) input SLOT_1_AXI_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI BREADY" *) input SLOT_1_AXI_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI BRESP" *) input [1:0]SLOT_1_AXI_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI BVALID" *) input SLOT_1_AXI_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI RDATA" *) input [31:0]SLOT_1_AXI_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI RLAST" *) input SLOT_1_AXI_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI RREADY" *) input SLOT_1_AXI_rready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI RVALID" *) input SLOT_1_AXI_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI WDATA" *) input [31:0]SLOT_1_AXI_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI WLAST" *) input SLOT_1_AXI_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI WREADY" *) input SLOT_1_AXI_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI WSTRB" *) input [3:0]SLOT_1_AXI_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 SLOT_1_AXI WVALID" *) input SLOT_1_AXI_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, ASSOCIATED_BUSIF SLOT_0_AXIS:SLOT_1_AXI, ASSOCIATED_RESET resetn, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK1, FREQ_HZ 166666672, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST.RESETN RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME RST.RESETN, INSERT_VIP 0, POLARITY ACTIVE_LOW" *) input resetn;

  wire [7:0]SLOT_0_AXIS_tdata;
  wire SLOT_0_AXIS_tlast;
  wire SLOT_0_AXIS_tready;
  wire [0:0]SLOT_0_AXIS_tstrb;
  wire SLOT_0_AXIS_tvalid;
  wire [31:0]SLOT_1_AXI_araddr;
  wire [3:0]SLOT_1_AXI_arcache;
  wire [7:0]SLOT_1_AXI_arlen;
  wire [2:0]SLOT_1_AXI_arprot;
  wire SLOT_1_AXI_arready;
  wire [2:0]SLOT_1_AXI_arsize;
  wire SLOT_1_AXI_arvalid;
  wire [31:0]SLOT_1_AXI_awaddr;
  wire [3:0]SLOT_1_AXI_awcache;
  wire [7:0]SLOT_1_AXI_awlen;
  wire [2:0]SLOT_1_AXI_awprot;
  wire SLOT_1_AXI_awready;
  wire [2:0]SLOT_1_AXI_awsize;
  wire SLOT_1_AXI_awvalid;
  wire SLOT_1_AXI_bready;
  wire [1:0]SLOT_1_AXI_bresp;
  wire SLOT_1_AXI_bvalid;
  wire [31:0]SLOT_1_AXI_rdata;
  wire SLOT_1_AXI_rlast;
  wire SLOT_1_AXI_rready;
  wire SLOT_1_AXI_rvalid;
  wire [31:0]SLOT_1_AXI_wdata;
  wire SLOT_1_AXI_wlast;
  wire SLOT_1_AXI_wready;
  wire [3:0]SLOT_1_AXI_wstrb;
  wire SLOT_1_AXI_wvalid;
  wire clk;
  wire [7:0]net_slot_0_axis_tdata;
  wire net_slot_0_axis_tlast;
  wire net_slot_0_axis_tready;
  wire [0:0]net_slot_0_axis_tstrb;
  wire net_slot_0_axis_tvalid;
  wire [1:0]net_slot_1_axi_ar_cnt;
  wire [1:0]net_slot_1_axi_ar_ctrl;
  wire net_slot_1_axi_arready;
  wire net_slot_1_axi_arvalid;
  wire [1:0]net_slot_1_axi_aw_cnt;
  wire [1:0]net_slot_1_axi_aw_ctrl;
  wire [31:0]net_slot_1_axi_awaddr;
  wire [3:0]net_slot_1_axi_awcache;
  wire [7:0]net_slot_1_axi_awlen;
  wire [2:0]net_slot_1_axi_awprot;
  wire net_slot_1_axi_awready;
  wire [2:0]net_slot_1_axi_awsize;
  wire net_slot_1_axi_awvalid;
  wire [1:0]net_slot_1_axi_b_cnt;
  wire [1:0]net_slot_1_axi_b_ctrl;
  wire net_slot_1_axi_bready;
  wire [1:0]net_slot_1_axi_bresp;
  wire net_slot_1_axi_bvalid;
  wire [1:0]net_slot_1_axi_r_cnt;
  wire [2:0]net_slot_1_axi_r_ctrl;
  wire net_slot_1_axi_rlast;
  wire net_slot_1_axi_rready;
  wire net_slot_1_axi_rvalid;
  wire [2:0]net_slot_1_axi_w_ctrl;
  wire [31:0]net_slot_1_axi_wdata;
  wire net_slot_1_axi_wlast;
  wire net_slot_1_axi_wready;
  wire [3:0]net_slot_1_axi_wstrb;
  wire net_slot_1_axi_wvalid;
  wire resetn;

  bd_f60c_g_inst_0 g_inst
       (.aclk(clk),
        .aresetn(resetn),
        .m_slot_0_axis_tdata(net_slot_0_axis_tdata),
        .m_slot_0_axis_tlast(net_slot_0_axis_tlast),
        .m_slot_0_axis_tready(net_slot_0_axis_tready),
        .m_slot_0_axis_tstrb(net_slot_0_axis_tstrb),
        .m_slot_0_axis_tvalid(net_slot_0_axis_tvalid),
        .m_slot_1_axi_ar_cnt(net_slot_1_axi_ar_cnt),
        .m_slot_1_axi_arready(net_slot_1_axi_arready),
        .m_slot_1_axi_arvalid(net_slot_1_axi_arvalid),
        .m_slot_1_axi_aw_cnt(net_slot_1_axi_aw_cnt),
        .m_slot_1_axi_awaddr(net_slot_1_axi_awaddr),
        .m_slot_1_axi_awcache(net_slot_1_axi_awcache),
        .m_slot_1_axi_awlen(net_slot_1_axi_awlen),
        .m_slot_1_axi_awprot(net_slot_1_axi_awprot),
        .m_slot_1_axi_awready(net_slot_1_axi_awready),
        .m_slot_1_axi_awsize(net_slot_1_axi_awsize),
        .m_slot_1_axi_awvalid(net_slot_1_axi_awvalid),
        .m_slot_1_axi_b_cnt(net_slot_1_axi_b_cnt),
        .m_slot_1_axi_bready(net_slot_1_axi_bready),
        .m_slot_1_axi_bresp(net_slot_1_axi_bresp),
        .m_slot_1_axi_bvalid(net_slot_1_axi_bvalid),
        .m_slot_1_axi_r_cnt(net_slot_1_axi_r_cnt),
        .m_slot_1_axi_rlast(net_slot_1_axi_rlast),
        .m_slot_1_axi_rready(net_slot_1_axi_rready),
        .m_slot_1_axi_rvalid(net_slot_1_axi_rvalid),
        .m_slot_1_axi_wdata(net_slot_1_axi_wdata),
        .m_slot_1_axi_wlast(net_slot_1_axi_wlast),
        .m_slot_1_axi_wready(net_slot_1_axi_wready),
        .m_slot_1_axi_wstrb(net_slot_1_axi_wstrb),
        .m_slot_1_axi_wvalid(net_slot_1_axi_wvalid),
        .slot_0_axis_tdata(SLOT_0_AXIS_tdata),
        .slot_0_axis_tlast(SLOT_0_AXIS_tlast),
        .slot_0_axis_tready(SLOT_0_AXIS_tready),
        .slot_0_axis_tstrb(SLOT_0_AXIS_tstrb),
        .slot_0_axis_tvalid(SLOT_0_AXIS_tvalid),
        .slot_1_axi_araddr(SLOT_1_AXI_araddr),
        .slot_1_axi_arcache(SLOT_1_AXI_arcache),
        .slot_1_axi_arlen(SLOT_1_AXI_arlen),
        .slot_1_axi_arprot(SLOT_1_AXI_arprot),
        .slot_1_axi_arready(SLOT_1_AXI_arready),
        .slot_1_axi_arsize(SLOT_1_AXI_arsize),
        .slot_1_axi_arvalid(SLOT_1_AXI_arvalid),
        .slot_1_axi_awaddr(SLOT_1_AXI_awaddr),
        .slot_1_axi_awcache(SLOT_1_AXI_awcache),
        .slot_1_axi_awlen(SLOT_1_AXI_awlen),
        .slot_1_axi_awprot(SLOT_1_AXI_awprot),
        .slot_1_axi_awready(SLOT_1_AXI_awready),
        .slot_1_axi_awsize(SLOT_1_AXI_awsize),
        .slot_1_axi_awvalid(SLOT_1_AXI_awvalid),
        .slot_1_axi_bready(SLOT_1_AXI_bready),
        .slot_1_axi_bresp(SLOT_1_AXI_bresp),
        .slot_1_axi_bvalid(SLOT_1_AXI_bvalid),
        .slot_1_axi_rdata(SLOT_1_AXI_rdata),
        .slot_1_axi_rlast(SLOT_1_AXI_rlast),
        .slot_1_axi_rready(SLOT_1_AXI_rready),
        .slot_1_axi_rvalid(SLOT_1_AXI_rvalid),
        .slot_1_axi_wdata(SLOT_1_AXI_wdata),
        .slot_1_axi_wlast(SLOT_1_AXI_wlast),
        .slot_1_axi_wready(SLOT_1_AXI_wready),
        .slot_1_axi_wstrb(SLOT_1_AXI_wstrb),
        .slot_1_axi_wvalid(SLOT_1_AXI_wvalid));
  bd_f60c_ila_lib_0 ila_lib
       (.clk(clk),
        .probe0(net_slot_0_axis_tdata),
        .probe1(net_slot_0_axis_tstrb),
        .probe10(net_slot_1_axi_awprot),
        .probe11(net_slot_1_axi_awsize),
        .probe12(net_slot_1_axi_b_cnt),
        .probe13(net_slot_1_axi_bresp),
        .probe14(net_slot_1_axi_r_cnt),
        .probe15(net_slot_1_axi_wdata),
        .probe16(net_slot_1_axi_wstrb),
        .probe17(net_slot_1_axi_aw_ctrl),
        .probe18(net_slot_1_axi_w_ctrl),
        .probe19(net_slot_1_axi_b_ctrl),
        .probe2(net_slot_0_axis_tvalid),
        .probe20(net_slot_1_axi_ar_ctrl),
        .probe21(net_slot_1_axi_r_ctrl),
        .probe3(net_slot_0_axis_tready),
        .probe4(net_slot_0_axis_tlast),
        .probe5(net_slot_1_axi_ar_cnt),
        .probe6(net_slot_1_axi_aw_cnt),
        .probe7(net_slot_1_axi_awaddr),
        .probe8(net_slot_1_axi_awcache),
        .probe9(net_slot_1_axi_awlen));
  bd_f60c_slot_1_ar_0 slot_1_ar
       (.In0(net_slot_1_axi_arvalid),
        .In1(net_slot_1_axi_arready),
        .dout(net_slot_1_axi_ar_ctrl));
  bd_f60c_slot_1_aw_0 slot_1_aw
       (.In0(net_slot_1_axi_awvalid),
        .In1(net_slot_1_axi_awready),
        .dout(net_slot_1_axi_aw_ctrl));
  bd_f60c_slot_1_b_0 slot_1_b
       (.In0(net_slot_1_axi_bvalid),
        .In1(net_slot_1_axi_bready),
        .dout(net_slot_1_axi_b_ctrl));
  bd_f60c_slot_1_r_0 slot_1_r
       (.In0(net_slot_1_axi_rvalid),
        .In1(net_slot_1_axi_rready),
        .In2(net_slot_1_axi_rlast),
        .dout(net_slot_1_axi_r_ctrl));
  bd_f60c_slot_1_w_0 slot_1_w
       (.In0(net_slot_1_axi_wvalid),
        .In1(net_slot_1_axi_wready),
        .In2(net_slot_1_axi_wlast),
        .dout(net_slot_1_axi_w_ctrl));
endmodule
