onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xil_defaultlib -L xilinx_vip -L xpm -L axi_datamover_v5_1_37 -L axi_sg_v4_1_21 -L axi_dma_v7_1_36 -L fifo_generator_v13_2_13 -L axi_vdma_v6_3_23 -L proc_sys_reset_v5_0_17 -L axi_infrastructure_v1_1_0 -L axi_vip_v1_1_21 -L processing_system7_vip_v1_0_23 -L axi_lite_ipif_v3_0_4 -L v_tc_v6_1_14 -L v_vid_in_axi4s_v4_0_11 -L v_axi4s_vid_out_v4_0_20 -L v_tc_v6_2_10 -L xlconcat_v2_1_7 -L xlconstant_v1_1_10 -L smartconnect_v1_0 -L axi_register_slice_v2_1_35 -L generic_baseblocks_v2_1_2 -L axi_data_fifo_v2_1_35 -L axi_crossbar_v2_1_37 -L gigantic_mux -L axi_protocol_converter_v2_1_36 -L axi_clock_converter_v2_1_34 -L blk_mem_gen_v8_4_11 -L axi_dwidth_converter_v2_1_36 -L xilinx_vip -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.design_1 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {design_1.udo}

run 1000ns

quit -force
