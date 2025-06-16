# 2025-06-16T19:43:23.180894500
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq7010Oscilloscope2")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

