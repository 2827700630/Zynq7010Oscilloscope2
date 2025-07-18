#include "xemacps.h"

XEmacPs_Config XEmacPs_ConfigTable[] __attribute__ ((section (".drvcfg_sec"))) = {

	{
		"xlnx,zynq-gem", /* compatible */
		0xe000b000, /* reg */
		0x0, /* dma-coherent */
		0x4016, /* interrupts */
		0xf8f01000, /* interrupt-parent */
		0x0, /* ref-clk */
		"rgmii-id", /* phy-mode */
		0x0, /* phy-handle */
		0x0, /* mdioproducer-baseaddr */
		0x0 /* gmiitorgmii-addr */
	},
	 {
		 NULL
	}
};