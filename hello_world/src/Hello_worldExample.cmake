set(IOMODULE_NUM_DRIVER_INSTANCES "")
set(UARTLITE_NUM_DRIVER_INSTANCES "")
set(UARTNS550_NUM_DRIVER_INSTANCES "")
set(UARTPS_NUM_DRIVER_INSTANCES "ps7_uart_1")
set(UARTPS0_PROP_LIST "0xe0001000")
list(APPEND TOTAL_UARTPS_PROP_LIST UARTPS0_PROP_LIST)
set(UARTPSV_NUM_DRIVER_INSTANCES "")
set(ps7_ddr_0_memory_0 "0x100000;0x1ff00000")
set(ps7_ram_0_memory_0 "0x0;0x30000")
set(ps7_ram_1_memory_1 "0xffff0000;0xfe00")
set(DDR ps7_ddr_0_memory_0)
set(CODE ps7_ddr_0_memory_0)
set(DATA ps7_ddr_0_memory_0)
set(TOTAL_MEM_CONTROLLERS "ps7_ddr_0_memory_0;ps7_ram_0_memory_0;ps7_ram_1_memory_1")
set(MEMORY_SECTION "MEMORY
{
	ps7_ddr_0_memory_0 : ORIGIN = 0x100000, LENGTH = 0x1ff00000
	ps7_qspi_linear_0_memory_0 : ORIGIN = 0xfc000000, LENGTH = 0x1000000
	ps7_ram_0_memory_0 : ORIGIN = 0x0, LENGTH = 0x30000
	ps7_ram_1_memory_1 : ORIGIN = 0xffff0000, LENGTH = 0xfe00
}")
set(STACK_SIZE 0x2000)
set(HEAP_SIZE 0x2000)
