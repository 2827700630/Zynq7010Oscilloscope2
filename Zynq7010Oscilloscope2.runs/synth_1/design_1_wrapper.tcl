# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
namespace eval ::optrace {
  variable script "E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.runs/synth_1/design_1_wrapper.tcl"
  variable category "vivado_synth"
}

# Try to connect to running dispatch if we haven't done so already.
# This code assumes that the Tcl interpreter is not using threads,
# since the ::dispatch::connected variable isn't mutex protected.
if {![info exists ::dispatch::connected]} {
  namespace eval ::dispatch {
    variable connected false
    if {[llength [array get env XILINX_CD_CONNECT_ID]] > 0} {
      set result "true"
      if {[catch {
        if {[lsearch -exact [package names] DispatchTcl] < 0} {
          set result [load librdi_cd_clienttcl[info sharedlibextension]] 
        }
        if {$result eq "false"} {
          puts "WARNING: Could not load dispatch client library"
        }
        set connect_id [ ::dispatch::init_client -mode EXISTING_SERVER ]
        if { $connect_id eq "" } {
          puts "WARNING: Could not initialize dispatch client"
        } else {
          puts "INFO: Dispatch client connection id - $connect_id"
          set connected true
        }
      } catch_res]} {
        puts "WARNING: failed to connect to dispatch server - $catch_res"
      }
    }
  }
}
if {$::dispatch::connected} {
  # Remove the dummy proc if it exists.
  if { [expr {[llength [info procs ::OPTRACE]] > 0}] } {
    rename ::OPTRACE ""
  }
  proc ::OPTRACE { task action {tags {} } } {
    ::vitis_log::op_trace "$task" $action -tags $tags -script $::optrace::script -category $::optrace::category
  }
  # dispatch is generic. We specifically want to attach logging.
  ::vitis_log::connect_client
} else {
  # Add dummy proc if it doesn't exist.
  if { [expr {[llength [info procs ::OPTRACE]] == 0}] } {
    proc ::OPTRACE {{arg1 \"\" } {arg2 \"\"} {arg3 \"\" } {arg4 \"\"} {arg5 \"\" } {arg6 \"\"}} {
        # Do nothing
    }
  }
}

OPTRACE "synth_1" START { ROLLUP_AUTO }
set_param general.usePosixSpawnForFork 1
set_param bd.open.in_stealth_mode 3
OPTRACE "Creating in-memory project" START { }
create_project -in_memory -part xc7z010clg400-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.cache/wt [current_project]
set_property parent.project_path E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_FIFO XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths e:/FPGAproject/17_ad9280_dma_hdmi/repo [current_project]
update_ip_catalog
set_property ip_output_repo e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
OPTRACE "Creating in-memory project" END { }
OPTRACE "Adding files" START { }
read_verilog -library xil_defaultlib E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/hdl/design_1_wrapper.v
add_files E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.srcs/sources_1/bd/design_1/design_1.bd
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_ad9280_sample_0_0/src/ad.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_dma_0_1/design_1_axi_dma_0_1.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_dma_0_1/design_1_axi_dma_0_1_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_vdma_0_0/design_1_axi_vdma_0_0.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_vdma_0_0/design_1_axi_vdma_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_vdma_0_0/design_1_axi_vdma_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_proc_sys_reset_0_0/design_1_proc_sys_reset_0_0_board.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_processing_system7_0_0/design_1_processing_system7_0_0.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_rgb2dvi_0_0/src/rgb2dvi.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_rgb2dvi_0_0/src/rgb2dvi_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_rgb2dvi_0_0/src/rgb2dvi_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_rst_ps7_0_100M_1/design_1_rst_ps7_0_100M_1_board.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_rst_ps7_0_142M_1/design_1_rst_ps7_0_142M_1_board.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_v_axi4s_vid_out_0_1/design_1_v_axi4s_vid_out_0_1_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_v_tc_0_0/design_1_v_tc_0_0_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_1/bd_afc3_psr_aclk_0_board.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_2/bd_afc3_arinsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_3/bd_afc3_rinsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_4/bd_afc3_awinsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_5/bd_afc3_winsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_6/bd_afc3_binsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_7/bd_afc3_aroutsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_8/bd_afc3_routsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_9/bd_afc3_awoutsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_10/bd_afc3_woutsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_11/bd_afc3_boutsw_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_12/bd_afc3_arni_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_13/bd_afc3_rni_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_14/bd_afc3_awni_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_15/bd_afc3_wni_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_16/bd_afc3_bni_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_20/bd_afc3_s00a2s_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_21/bd_afc3_sarn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_22/bd_afc3_srn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_23/bd_afc3_sawn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_24/bd_afc3_swn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_25/bd_afc3_sbn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_26/bd_afc3_m00s2a_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_27/bd_afc3_m00arn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_28/bd_afc3_m00rn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_29/bd_afc3_m00awn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_30/bd_afc3_m00wn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_31/bd_afc3_m00bn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_33/bd_afc3_m01s2a_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_34/bd_afc3_m01arn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_35/bd_afc3_m01rn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_36/bd_afc3_m01awn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_37/bd_afc3_m01wn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_38/bd_afc3_m01bn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_40/bd_afc3_m02s2a_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_41/bd_afc3_m02arn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_42/bd_afc3_m02rn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_43/bd_afc3_m02awn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_44/bd_afc3_m02wn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_45/bd_afc3_m02bn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_47/bd_afc3_m03s2a_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_48/bd_afc3_m03arn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_49/bd_afc3_m03rn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_50/bd_afc3_m03awn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_51/bd_afc3_m03wn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_52/bd_afc3_m03bn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_54/bd_afc3_m04s2a_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_55/bd_afc3_m04arn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_56/bd_afc3_m04rn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_57/bd_afc3_m04awn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_58/bd_afc3_m04wn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/bd_0/ip/ip_59/bd_afc3_m04bn_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_smc_0/smartconnect.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_0_0/bd_0/bd_f60c_ooc.xdc]
set_property used_in_synthesis false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_0_0/bd_0/ip/ip_0/bd_f60c_ila_lib_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_0_0/design_1_system_ila_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_1_0/bd_0/bd_365d_ooc.xdc]
set_property used_in_synthesis false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila_impl.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_0/ila_v6_2/constraints/ila.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_1_0/bd_0/ip/ip_0/bd_365d_ila_lib_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_system_ila_1_0/design_1_system_ila_1_0_ooc.xdc]
set_property used_in_synthesis false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_mem_intercon_imp_auto_us_0/design_1_axi_mem_intercon_imp_auto_us_0_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_mem_intercon_imp_auto_us_0/design_1_axi_mem_intercon_imp_auto_us_0_clocks.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_mem_intercon_imp_auto_us_0/design_1_axi_mem_intercon_imp_auto_us_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/ip/design_1_axi_mem_intercon_imp_auto_pc_0/design_1_axi_mem_intercon_imp_auto_pc_0_ooc.xdc]
set_property used_in_implementation false [get_files -all e:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.gen/sources_1/bd/design_1/design_1_ooc.xdc]

OPTRACE "Adding files" END { }
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.srcs/constrs_1/new/hdmi_out.xdc
set_property used_in_implementation false [get_files E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.srcs/constrs_1/new/hdmi_out.xdc]

read_xdc E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.srcs/constrs_1/new/ad9280.xdc
set_property used_in_implementation false [get_files E:/FPGAproject/Zynq7010Oscilloscope2/Zynq7010Oscilloscope2.srcs/constrs_1/new/ad9280.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

OPTRACE "synth_design" START { }
synth_design -top design_1_wrapper -part xc7z010clg400-1
OPTRACE "synth_design" END { }
if { [get_msg_config -count -severity {CRITICAL WARNING}] > 0 } {
 send_msg_id runtcl-6 info "Synthesis results are not added to the cache due to CRITICAL_WARNING"
}


OPTRACE "write_checkpoint" START { CHECKPOINT }
# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef design_1_wrapper.dcp
OPTRACE "write_checkpoint" END { }
OPTRACE "synth reports" START { REPORT }
generate_parallel_reports -reports { "report_utilization -file design_1_wrapper_utilization_synth.rpt -pb design_1_wrapper_utilization_synth.pb"  } 
OPTRACE "synth reports" END { }
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
OPTRACE "synth_1" END { }
