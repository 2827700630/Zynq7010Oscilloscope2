
/***************************** 头文件包含 *******************************/
#include "ad9280_sample.h"
#include "xparameters.h"
#include "stdio.h"
#include "xil_io.h"

/************************** 常量定义 ***************************/
#define READ_WRITE_MUL_FACTOR 0x10

/************************** 函数定义 ***************************/
/**
 *
 * 对驱动程序/设备运行自测试。注意如果执行设备重置，这可能是一个破坏性测试。
 *
 * 如果硬件系统构建不正确，此函数可能永远不会返回给调用者。
 *
 * @param   baseaddr_p 是要操作的AD9280_SAMPLE实例的基地址。
 *
 * @return
 *
 *    - XST_SUCCESS   如果所有自测试代码通过
 *    - XST_FAILURE   如果任何自测试代码失败
 *
 * @note    此函数要工作必须关闭缓存。
 * @note    如果数据内存和设备不在同一总线上，自测试可能会失败。
 *
 */
XStatus AD9280_SAMPLE_Reg_SelfTest(void * baseaddr_p)
{
	u32 baseaddr;
	int write_loop_index;
	int read_loop_index;
	int Index;

	baseaddr = (u32) baseaddr_p;
	xil_printf("******************************\n\r");
	xil_printf("* 用户外设自测试\n\r");
	xil_printf("******************************\n\n\r");

	/*
	 * 写入用户逻辑从模块寄存器并回读
	 */
	xil_printf("用户逻辑从模块测试...\n\r");

	for (write_loop_index = 0 ; write_loop_index < 4; write_loop_index++)
	  AD9280_SAMPLE_mWriteReg (baseaddr, write_loop_index*4, (write_loop_index+1)*READ_WRITE_MUL_FACTOR);
	for (read_loop_index = 0 ; read_loop_index < 4; read_loop_index++)
	  if ( AD9280_SAMPLE_mReadReg (baseaddr, read_loop_index*4) != (read_loop_index+1)*READ_WRITE_MUL_FACTOR){
	    xil_printf ("Error reading register value at address %x\n", (int)baseaddr + read_loop_index*4);
	    return XST_FAILURE;
	  }

	xil_printf("   - 从寄存器写入/读取通过\n\n\r");

	return XST_SUCCESS;
}
