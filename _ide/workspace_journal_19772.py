# 2025-06-16T10:36:11.940258
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq7010Oscilloscope2")

platform = client.get_component(name="platform")
status = platform.update_hw(hw_design = "$COMPONENT_LOCATION/../design_1_wrapper.xsa")

status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

vitis.dispose()

