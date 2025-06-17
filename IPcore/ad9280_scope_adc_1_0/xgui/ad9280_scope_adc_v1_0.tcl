# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_M00_AXIS_TDATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S00_AXI_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S00_AXI_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_AXI_INTR_ADDR_WIDTH" -parent ${Page_0}

  set ADC_DATA_WIDTH [ipgui::add_param $IPINST -name "ADC_DATA_WIDTH"]
  set_property tooltip {ADC data bus width in bits. Must match the actual ADC resolution. Range: 6-16, Default: 8 (for AD9280)} ${ADC_DATA_WIDTH}
  set FIFO_DEPTH [ipgui::add_param $IPINST -name "FIFO_DEPTH"]
  set_property tooltip {Internal FIFO depth for ADC sample storage. Larger values provide better buffering but consume more BRAM resources. Default: 1024} ${FIFO_DEPTH}
  set TRIGGER_THRESHOLD_WIDTH [ipgui::add_param $IPINST -name "TRIGGER_THRESHOLD_WIDTH"]
  set_property tooltip {Width of trigger threshold value in bits. Should match ADC_DATA_WIDTH. Range: 6-16, Default: 8} ${TRIGGER_THRESHOLD_WIDTH}

}

proc update_PARAM_VALUE.ADC_DATA_WIDTH { PARAM_VALUE.ADC_DATA_WIDTH } {
	# Procedure called to update ADC_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ADC_DATA_WIDTH { PARAM_VALUE.ADC_DATA_WIDTH } {
	# Procedure called to validate ADC_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.FIFO_DEPTH { PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to update FIFO_DEPTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.FIFO_DEPTH { PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to validate FIFO_DEPTH
	return true
}

proc update_PARAM_VALUE.TRIGGER_THRESHOLD_WIDTH { PARAM_VALUE.TRIGGER_THRESHOLD_WIDTH } {
	# Procedure called to update TRIGGER_THRESHOLD_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.TRIGGER_THRESHOLD_WIDTH { PARAM_VALUE.TRIGGER_THRESHOLD_WIDTH } {
	# Procedure called to validate TRIGGER_THRESHOLD_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to update C_M00_AXIS_TDATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to validate C_M00_AXIS_TDATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_M00_AXIS_START_COUNT { PARAM_VALUE.C_M00_AXIS_START_COUNT } {
	# Procedure called to update C_M00_AXIS_START_COUNT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_M00_AXIS_START_COUNT { PARAM_VALUE.C_M00_AXIS_START_COUNT } {
	# Procedure called to validate C_M00_AXIS_START_COUNT
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to update C_S00_AXI_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_DATA_WIDTH { PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to validate C_S00_AXI_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to update C_S00_AXI_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_ADDR_WIDTH { PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to validate C_S00_AXI_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to update C_S00_AXI_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_BASEADDR { PARAM_VALUE.C_S00_AXI_BASEADDR } {
	# Procedure called to validate C_S00_AXI_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to update C_S00_AXI_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S00_AXI_HIGHADDR { PARAM_VALUE.C_S00_AXI_HIGHADDR } {
	# Procedure called to validate C_S00_AXI_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH { PARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH } {
	# Procedure called to update C_S_AXI_INTR_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH { PARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH } {
	# Procedure called to validate C_S_AXI_INTR_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH } {
	# Procedure called to update C_S_AXI_INTR_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH { PARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH } {
	# Procedure called to validate C_S_AXI_INTR_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_NUM_OF_INTR { PARAM_VALUE.C_NUM_OF_INTR } {
	# Procedure called to update C_NUM_OF_INTR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_NUM_OF_INTR { PARAM_VALUE.C_NUM_OF_INTR } {
	# Procedure called to validate C_NUM_OF_INTR
	return true
}

proc update_PARAM_VALUE.C_INTR_SENSITIVITY { PARAM_VALUE.C_INTR_SENSITIVITY } {
	# Procedure called to update C_INTR_SENSITIVITY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_INTR_SENSITIVITY { PARAM_VALUE.C_INTR_SENSITIVITY } {
	# Procedure called to validate C_INTR_SENSITIVITY
	return true
}

proc update_PARAM_VALUE.C_INTR_ACTIVE_STATE { PARAM_VALUE.C_INTR_ACTIVE_STATE } {
	# Procedure called to update C_INTR_ACTIVE_STATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_INTR_ACTIVE_STATE { PARAM_VALUE.C_INTR_ACTIVE_STATE } {
	# Procedure called to validate C_INTR_ACTIVE_STATE
	return true
}

proc update_PARAM_VALUE.C_IRQ_SENSITIVITY { PARAM_VALUE.C_IRQ_SENSITIVITY } {
	# Procedure called to update C_IRQ_SENSITIVITY when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IRQ_SENSITIVITY { PARAM_VALUE.C_IRQ_SENSITIVITY } {
	# Procedure called to validate C_IRQ_SENSITIVITY
	return true
}

proc update_PARAM_VALUE.C_IRQ_ACTIVE_STATE { PARAM_VALUE.C_IRQ_ACTIVE_STATE } {
	# Procedure called to update C_IRQ_ACTIVE_STATE when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_IRQ_ACTIVE_STATE { PARAM_VALUE.C_IRQ_ACTIVE_STATE } {
	# Procedure called to validate C_IRQ_ACTIVE_STATE
	return true
}

proc update_PARAM_VALUE.C_S_AXI_INTR_BASEADDR { PARAM_VALUE.C_S_AXI_INTR_BASEADDR } {
	# Procedure called to update C_S_AXI_INTR_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_INTR_BASEADDR { PARAM_VALUE.C_S_AXI_INTR_BASEADDR } {
	# Procedure called to validate C_S_AXI_INTR_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_AXI_INTR_HIGHADDR { PARAM_VALUE.C_S_AXI_INTR_HIGHADDR } {
	# Procedure called to update C_S_AXI_INTR_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_AXI_INTR_HIGHADDR { PARAM_VALUE.C_S_AXI_INTR_HIGHADDR } {
	# Procedure called to validate C_S_AXI_INTR_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH { MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}] ${MODELPARAM_VALUE.C_M00_AXIS_TDATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_M00_AXIS_START_COUNT { MODELPARAM_VALUE.C_M00_AXIS_START_COUNT PARAM_VALUE.C_M00_AXIS_START_COUNT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_M00_AXIS_START_COUNT}] ${MODELPARAM_VALUE.C_M00_AXIS_START_COUNT}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH { MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH PARAM_VALUE.C_S00_AXI_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH { MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH PARAM_VALUE.C_S00_AXI_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S00_AXI_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S00_AXI_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH { MODELPARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH PARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_INTR_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH { MODELPARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH PARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_AXI_INTR_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_NUM_OF_INTR { MODELPARAM_VALUE.C_NUM_OF_INTR PARAM_VALUE.C_NUM_OF_INTR } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_NUM_OF_INTR}] ${MODELPARAM_VALUE.C_NUM_OF_INTR}
}

proc update_MODELPARAM_VALUE.C_INTR_SENSITIVITY { MODELPARAM_VALUE.C_INTR_SENSITIVITY PARAM_VALUE.C_INTR_SENSITIVITY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_INTR_SENSITIVITY}] ${MODELPARAM_VALUE.C_INTR_SENSITIVITY}
}

proc update_MODELPARAM_VALUE.C_INTR_ACTIVE_STATE { MODELPARAM_VALUE.C_INTR_ACTIVE_STATE PARAM_VALUE.C_INTR_ACTIVE_STATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_INTR_ACTIVE_STATE}] ${MODELPARAM_VALUE.C_INTR_ACTIVE_STATE}
}

proc update_MODELPARAM_VALUE.C_IRQ_SENSITIVITY { MODELPARAM_VALUE.C_IRQ_SENSITIVITY PARAM_VALUE.C_IRQ_SENSITIVITY } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IRQ_SENSITIVITY}] ${MODELPARAM_VALUE.C_IRQ_SENSITIVITY}
}

proc update_MODELPARAM_VALUE.C_IRQ_ACTIVE_STATE { MODELPARAM_VALUE.C_IRQ_ACTIVE_STATE PARAM_VALUE.C_IRQ_ACTIVE_STATE } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_IRQ_ACTIVE_STATE}] ${MODELPARAM_VALUE.C_IRQ_ACTIVE_STATE}
}

proc update_MODELPARAM_VALUE.ADC_DATA_WIDTH { MODELPARAM_VALUE.ADC_DATA_WIDTH PARAM_VALUE.ADC_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ADC_DATA_WIDTH}] ${MODELPARAM_VALUE.ADC_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.FIFO_DEPTH { MODELPARAM_VALUE.FIFO_DEPTH PARAM_VALUE.FIFO_DEPTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.FIFO_DEPTH}] ${MODELPARAM_VALUE.FIFO_DEPTH}
}

proc update_MODELPARAM_VALUE.TRIGGER_THRESHOLD_WIDTH { MODELPARAM_VALUE.TRIGGER_THRESHOLD_WIDTH PARAM_VALUE.TRIGGER_THRESHOLD_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.TRIGGER_THRESHOLD_WIDTH}] ${MODELPARAM_VALUE.TRIGGER_THRESHOLD_WIDTH}
}

