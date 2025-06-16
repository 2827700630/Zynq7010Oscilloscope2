#include "xaxivdma.h"

XAxiVdma_Config XAxiVdma_ConfigTable[] __attribute__ ((section (".drvcfg_sec"))) = {

	{
		"xlnx,axi-vdma-6.3", /* compatible */
		0x43000000, /* reg */
		0x1, /* xlnx,num-fstores */
		0x1, /* xlnx,include-mm2s */
		0x1, /* xlnx,include-mm2s-dre */
		0x40, /* xlnx,mm2s-data-width */
		0x0, /* xlnx,include-s2mm */
		0x0, /* xlnx,include-s2mm-dre */
		0x40, /* xlnx,s2mm-data-width */
		0x0, /* xlnx,include-sg */
		0x1, /* xlnx,enable-vidparam-reads */
		0x1, /* xlnx,flush-fsync */
		0x1, /* xlnx,flush-on-fsync */
		0x1000, /* xlnx,mm2s-linebuffer-depth */
		0x200, /* xlnx,s2mm-linebuffer-depth */
		0x1, /* xlnx,mm2s-genlock-mode */
		0x0, /* xlnx,s2mm-genlock-mode */
		0x1, /* xlnx,include-internal-genlock */
		0x1, /* xlnx,s2mm-sof-enable */
		0x18, /* xlnx,mm2s-tdata-width */
		0x20, /* xlnx,s2mm-tdata-width */
		0x0, /* xlnx,enable-debug-info-1 */
		0x0, /* xlnx,enable-debug-info-5 */
		0x1, /* xlnx,enable-debug-info-6 */
		0x1, /* xlnx,enable-debug-info-7 */
		0x0, /* xlnx,enable-debug-info-9 */
		0x0, /* xlnx,enable-debug-info-13 */
		0x1, /* xlnx,enable-debug-info-14 */
		0x1, /* xlnx,enable-debug-info-15 */
		0x0, /* xlnx,enable-debug-all */
		0x20, /* xlnx,addrwidth */
		0x0, /* xlnx,enable-vert-flip */
		{0x401d,  0xffff}, /* interrupts */
		0xf8f01000 /* interrupt-parent */
	},
	 {
		 NULL
	}
};