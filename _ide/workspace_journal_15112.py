# 2025-06-17T22:13:51.185986300
import vitis

client = vitis.create_client()
client.set_workspace(path="Zynq7010Oscilloscope2")

platform = client.get_component(name="platform")
status = platform.build()

comp = client.get_component(name="hello_world")
comp.build()

status = platform.build()

comp.build()

vitis.dispose()

