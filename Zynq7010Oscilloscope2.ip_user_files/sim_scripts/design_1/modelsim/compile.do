vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xpm
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/axi_datamover_v5_1_37
vlib modelsim_lib/msim/axi_sg_v4_1_21
vlib modelsim_lib/msim/axi_dma_v7_1_36
vlib modelsim_lib/msim/fifo_generator_v13_2_13
vlib modelsim_lib/msim/axi_vdma_v6_3_23
vlib modelsim_lib/msim/proc_sys_reset_v5_0_17
vlib modelsim_lib/msim/axi_infrastructure_v1_1_0
vlib modelsim_lib/msim/axi_vip_v1_1_21
vlib modelsim_lib/msim/processing_system7_vip_v1_0_23
vlib modelsim_lib/msim/axi_lite_ipif_v3_0_4
vlib modelsim_lib/msim/v_tc_v6_1_14
vlib modelsim_lib/msim/v_vid_in_axi4s_v4_0_11
vlib modelsim_lib/msim/v_axi4s_vid_out_v4_0_20
vlib modelsim_lib/msim/v_tc_v6_2_10
vlib modelsim_lib/msim/xlconcat_v2_1_7
vlib modelsim_lib/msim/xlconstant_v1_1_10
vlib modelsim_lib/msim/smartconnect_v1_0
vlib modelsim_lib/msim/axi_register_slice_v2_1_35
vlib modelsim_lib/msim/generic_baseblocks_v2_1_2
vlib modelsim_lib/msim/axi_data_fifo_v2_1_35
vlib modelsim_lib/msim/axi_crossbar_v2_1_37
vlib modelsim_lib/msim/gigantic_mux
vlib modelsim_lib/msim/axi_protocol_converter_v2_1_36
vlib modelsim_lib/msim/axi_clock_converter_v2_1_34
vlib modelsim_lib/msim/blk_mem_gen_v8_4_11
vlib modelsim_lib/msim/axi_dwidth_converter_v2_1_36

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xpm modelsim_lib/msim/xpm
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap axi_datamover_v5_1_37 modelsim_lib/msim/axi_datamover_v5_1_37
vmap axi_sg_v4_1_21 modelsim_lib/msim/axi_sg_v4_1_21
vmap axi_dma_v7_1_36 modelsim_lib/msim/axi_dma_v7_1_36
vmap fifo_generator_v13_2_13 modelsim_lib/msim/fifo_generator_v13_2_13
vmap axi_vdma_v6_3_23 modelsim_lib/msim/axi_vdma_v6_3_23
vmap proc_sys_reset_v5_0_17 modelsim_lib/msim/proc_sys_reset_v5_0_17
vmap axi_infrastructure_v1_1_0 modelsim_lib/msim/axi_infrastructure_v1_1_0
vmap axi_vip_v1_1_21 modelsim_lib/msim/axi_vip_v1_1_21
vmap processing_system7_vip_v1_0_23 modelsim_lib/msim/processing_system7_vip_v1_0_23
vmap axi_lite_ipif_v3_0_4 modelsim_lib/msim/axi_lite_ipif_v3_0_4
vmap v_tc_v6_1_14 modelsim_lib/msim/v_tc_v6_1_14
vmap v_vid_in_axi4s_v4_0_11 modelsim_lib/msim/v_vid_in_axi4s_v4_0_11
vmap v_axi4s_vid_out_v4_0_20 modelsim_lib/msim/v_axi4s_vid_out_v4_0_20
vmap v_tc_v6_2_10 modelsim_lib/msim/v_tc_v6_2_10
vmap xlconcat_v2_1_7 modelsim_lib/msim/xlconcat_v2_1_7
vmap xlconstant_v1_1_10 modelsim_lib/msim/xlconstant_v1_1_10
vmap smartconnect_v1_0 modelsim_lib/msim/smartconnect_v1_0
vmap axi_register_slice_v2_1_35 modelsim_lib/msim/axi_register_slice_v2_1_35
vmap generic_baseblocks_v2_1_2 modelsim_lib/msim/generic_baseblocks_v2_1_2
vmap axi_data_fifo_v2_1_35 modelsim_lib/msim/axi_data_fifo_v2_1_35
vmap axi_crossbar_v2_1_37 modelsim_lib/msim/axi_crossbar_v2_1_37
vmap gigantic_mux modelsim_lib/msim/gigantic_mux
vmap axi_protocol_converter_v2_1_36 modelsim_lib/msim/axi_protocol_converter_v2_1_36
vmap axi_clock_converter_v2_1_34 modelsim_lib/msim/axi_clock_converter_v2_1_34
vmap blk_mem_gen_v8_4_11 modelsim_lib/msim/blk_mem_gen_v8_4_11
vmap axi_dwidth_converter_v2_1_36 modelsim_lib/msim/axi_dwidth_converter_v2_1_36

vlog -work xilinx_vip  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/axi_vip_if.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/clk_vip_if.sv" \
"E:/FPGA/2025.1/Vivado/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xpm  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"E:/FPGA/2025.1/Vivado/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"E:/FPGA/2025.1/Vivado/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"E:/FPGA/2025.1/Vivado/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm  -93  \
"E:/FPGA/2025.1/Vivado/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ipshared/c24c/src/ad9280_sample.v" \
"../../../bd/design_1/ipshared/c24c/hdl/ad9280_sample_v1_0_S00_AXI.v" \
"../../../bd/design_1/ipshared/c24c/hdl/ad9280_sample_v1_0.v" \
"../../../bd/design_1/ip/design_1_ad9280_sample_0_0/sim/design_1_ad9280_sample_0_0.v" \

vcom -work axi_datamover_v5_1_37  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d44a/hdl/axi_datamover_v5_1_vh_rfs.vhd" \

vcom -work axi_sg_v4_1_21  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/b193/hdl/axi_sg_v4_1_rfs.vhd" \

vcom -work axi_dma_v7_1_36  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/cb19/hdl/axi_dma_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/design_1/ip/design_1_axi_dma_0_1/sim/design_1_axi_dma_0_1.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/9097/src/mmcme2_drp.v" \

vcom -work xil_defaultlib  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/9097/src/axi_dynclk_S00_AXI.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/9097/src/axi_dynclk.vhd" \
"../../../bd/design_1/ip/design_1_axi_dynclk_0_0/sim/design_1_axi_dynclk_0_0.vhd" \

vlog -work fifo_generator_v13_2_13  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/dc46/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_13  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_13  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/dc46/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_vdma_v6_3_23  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl/axi_vdma_v6_3_rfs.v" \

vcom -work axi_vdma_v6_3_23  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl/axi_vdma_v6_3_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/design_1/ip/design_1_axi_vdma_0_0/sim/design_1_axi_vdma_0_0.vhd" \

vcom -work proc_sys_reset_v5_0_17  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/9438/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/design_1/ip/design_1_proc_sys_reset_0_0/sim/design_1_proc_sys_reset_0_0.vhd" \

vlog -work axi_infrastructure_v1_1_0  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_vip_v1_1_21  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f16f/hdl/axi_vip_v1_1_vl_rfs.sv" \

vlog -work processing_system7_vip_v1_0_23  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl/processing_system7_vip_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_processing_system7_0_0/sim/design_1_processing_system7_0_0.v" \

vcom -work xil_defaultlib  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/ClockGen.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/SyncAsync.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/SyncAsyncReset.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/DVI_Constants.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/OutputSERDES.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/TMDS_Encoder.vhd" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5c79/src/rgb2dvi.vhd" \
"../../../bd/design_1/ip/design_1_rgb2dvi_0_0/sim/design_1_rgb2dvi_0_0.vhd" \
"../../../bd/design_1/ip/design_1_rst_ps7_0_100M_1/sim/design_1_rst_ps7_0_100M_1.vhd" \
"../../../bd/design_1/ip/design_1_rst_ps7_0_142M_1/sim/design_1_rst_ps7_0_142M_1.vhd" \

vcom -work axi_lite_ipif_v3_0_4  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work v_tc_v6_1_14  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/fd54/hdl/v_tc_v6_1_vh_rfs.vhd" \

vlog -work v_vid_in_axi4s_v4_0_11  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4705/hdl/v_vid_in_axi4s_v4_0_vl_rfs.v" \

vlog -work v_axi4s_vid_out_v4_0_20  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d1ca/hdl/v_axi4s_vid_out_v4_0_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_v_axi4s_vid_out_0_1/sim/design_1_v_axi4s_vid_out_0_1.v" \

vcom -work v_tc_v6_2_10  -93  \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/8632/hdl/v_tc_v6_2_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../bd/design_1/ip/design_1_v_tc_0_0/sim/design_1_v_tc_0_0.vhd" \

vlog -work xlconcat_v2_1_7  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/9c1a/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_xlconcat_0_2/sim/design_1_xlconcat_0_2.v" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/sim/bd_afc3.v" \

vlog -work xlconstant_v1_1_10  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a165/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_0/sim/bd_afc3_one_0.v" \

vcom -work xil_defaultlib  -93  \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_1/sim/bd_afc3_psr_aclk_0.vhd" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/3718/hdl/sc_switchboard_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_2/sim/bd_afc3_arinsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_3/sim/bd_afc3_rinsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_4/sim/bd_afc3_awinsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_5/sim/bd_afc3_winsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_6/sim/bd_afc3_binsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_7/sim/bd_afc3_aroutsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_8/sim/bd_afc3_routsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_9/sim/bd_afc3_awoutsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_10/sim/bd_afc3_woutsw_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_11/sim/bd_afc3_boutsw_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/sc_node_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_12/sim/bd_afc3_arni_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_13/sim/bd_afc3_rni_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_14/sim/bd_afc3_awni_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_15/sim/bd_afc3_wni_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_16/sim/bd_afc3_bni_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d800/hdl/sc_mmu_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_17/sim/bd_afc3_s00mmu_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/2da8/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_18/sim/bd_afc3_s00tr_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/dce3/hdl/sc_si_converter_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_19/sim/bd_afc3_s00sic_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/cef3/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_20/sim/bd_afc3_s00a2s_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_21/sim/bd_afc3_sarn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_22/sim/bd_afc3_srn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_23/sim/bd_afc3_sawn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_24/sim/bd_afc3_swn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_25/sim/bd_afc3_sbn_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/7f4f/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_26/sim/bd_afc3_m00s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_27/sim/bd_afc3_m00arn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_28/sim/bd_afc3_m00rn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_29/sim/bd_afc3_m00awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_30/sim/bd_afc3_m00wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_31/sim/bd_afc3_m00bn_0.sv" \

vlog -work smartconnect_v1_0  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/0133/hdl/sc_exit_v1_0_vl_rfs.sv" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_32/sim/bd_afc3_m00e_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_33/sim/bd_afc3_m01s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_34/sim/bd_afc3_m01arn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_35/sim/bd_afc3_m01rn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_36/sim/bd_afc3_m01awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_37/sim/bd_afc3_m01wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_38/sim/bd_afc3_m01bn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_39/sim/bd_afc3_m01e_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_40/sim/bd_afc3_m02s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_41/sim/bd_afc3_m02arn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_42/sim/bd_afc3_m02rn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_43/sim/bd_afc3_m02awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_44/sim/bd_afc3_m02wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_45/sim/bd_afc3_m02bn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_46/sim/bd_afc3_m02e_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_47/sim/bd_afc3_m03s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_48/sim/bd_afc3_m03arn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_49/sim/bd_afc3_m03rn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_50/sim/bd_afc3_m03awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_51/sim/bd_afc3_m03wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_52/sim/bd_afc3_m03bn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_53/sim/bd_afc3_m03e_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_54/sim/bd_afc3_m04s2a_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_55/sim/bd_afc3_m04arn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_56/sim/bd_afc3_m04rn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_57/sim/bd_afc3_m04awn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_58/sim/bd_afc3_m04wn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_59/sim/bd_afc3_m04bn_0.sv" \
"../../../bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_60/sim/bd_afc3_m04e_0.sv" \

vlog -work axi_register_slice_v2_1_35  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/c5b7/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  -sv -L axi_vip_v1_1_21 -L smartconnect_v1_0 -L processing_system7_vip_v1_0_23 -L xilinx_vip "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_smc_0/sim/design_1_axi_smc_0.sv" \

vlog -work generic_baseblocks_v2_1_2  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/0c28/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_data_fifo_v2_1_35  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4846/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_37  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a1a7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_mem_intercon_imp_xbar_0/sim/design_1_axi_mem_intercon_imp_xbar_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/sim/bd_f60c.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_0/sim/bd_f60c_ila_lib_0.v" \

vlog -work gigantic_mux  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/b2b0/hdl/gigantic_mux_v1_0_cntr.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_1/bd_f60c_g_inst_0_gigantic_mux.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_1/sim/bd_f60c_g_inst_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_2/sim/bd_f60c_slot_1_aw_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_3/sim/bd_f60c_slot_1_w_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_4/sim/bd_f60c_slot_1_b_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_5/sim/bd_f60c_slot_1_ar_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_6/sim/bd_f60c_slot_1_r_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_0_0/sim/design_1_system_ila_0_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/sim/bd_365d.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_0/sim/bd_365d_ila_lib_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_1/bd_365d_g_inst_0_gigantic_mux.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_1/sim/bd_365d_g_inst_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_2/sim/bd_365d_slot_0_aw_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_3/sim/bd_365d_slot_0_w_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_4/sim/bd_365d_slot_0_b_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_5/sim/bd_365d_slot_0_ar_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_6/sim/bd_365d_slot_0_r_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_7/sim/bd_365d_slot_1_aw_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_8/sim/bd_365d_slot_1_w_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_9/sim/bd_365d_slot_1_b_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_10/sim/bd_365d_slot_1_ar_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_11/sim/bd_365d_slot_1_r_0.v" \
"../../../bd/design_1/ip/design_1_system_ila_1_0/sim/design_1_system_ila_1_0.v" \
"../../../bd/design_1/sim/design_1.v" \

vlog -work axi_protocol_converter_v2_1_36  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work axi_clock_converter_v2_1_34  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/9a28/hdl/axi_clock_converter_v2_1_vl_rfs.v" \

vlog -work blk_mem_gen_v8_4_11  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a32c/simulation/blk_mem_gen_v8_4.v" \

vlog -work axi_dwidth_converter_v2_1_36  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/db4c/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5fb3/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/ec67/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/6cfa/hdl" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/f0b6/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/a8e4/hdl/verilog" "+incdir+../../../../../../FPGA/2025.1/Vivado/data/rsb/busdef" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/5431/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/4e08/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/537f/hdl/verilog" "+incdir+../../../../Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ipshared/d41f/hdl/verilog" "+incdir+E:/FPGA/2025.1/Vivado/data/xilinx_vip/include" \
"../../../bd/design_1/ip/design_1_axi_mem_intercon_imp_auto_us_0/sim/design_1_axi_mem_intercon_imp_auto_us_0.v" \
"../../../bd/design_1/ip/design_1_axi_mem_intercon_imp_auto_pc_0/sim/design_1_axi_mem_intercon_imp_auto_pc_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

