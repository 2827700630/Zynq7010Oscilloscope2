/* ------------------------------------------------------------ */
/*				头文件包含定义								*/
/* ------------------------------------------------------------ */

#include "display_demo.h"
#include "display_ctrl/display_ctrl.h"
#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "platform.h"
#include "sleep.h"
#include "adc_dma_ctrl.h"
/*
 * XPAR 重定义
 */
#define DYNCLK_BASEADDR XPAR_AXI_DYNCLK_0_BASEADDR
#define VGA_VDMA_ID 0
#define DISP_VTC_ID 0
#define VID_VTC_IRPT_ID XPS_FPGA3_INT_ID
#define VID_GPIO_IRPT_ID XPS_FPGA4_INT_ID
#define SCU_TIMER_ID XPAR_SCUTIMER_DEVICE_ID
#define UART_BASEADDR XPAR_PS7_UART_1_BASEADDR

#define INT_DEVICE_ID      XPAR_SCUGIC_SINGLE_DEVICE_ID


/* ------------------------------------------------------------ */
/*				全局变量									*/
/* ------------------------------------------------------------ */

/*
 * 显示驱动结构体
 */
DisplayCtrl dispCtrl;
XAxiVdma vdma;


/*
 * 视频数据帧缓冲区
 */
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME] __attribute__ ((aligned(64)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; //指向帧缓冲区的指针数组



/*
 * 中断结构体和函数
 */
XScuGic INST ;

int SetInterruptInit(XScuGic *InstancePtr, u16 IntrID) ;
/* ------------------------------------------------------------ */
/*				函数定义									*/
/* ------------------------------------------------------------ */


int main(void)
{
    init_platform();
	int Status;
	XAxiVdma_Config *vdmaConfig;
	int i;

	/*
	 * 初始化ScuGic中断
	 */
	Status = SetInterruptInit(&INST, INT_DEVICE_ID) ;
	if (Status != XST_SUCCESS)
		return XST_FAILURE ;

	/*
	 * 初始化指向3个帧缓冲区的指针数组
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
	{
		pFrames[i] = frameBuf[i];
	}

	xil_printf("Display Demo Initialization\r\n");// 初始化显示演示
	//这里可以直接使用printf函数，xil_printf默认不支持浮点数（除非特别配置）
	xil_printf("please connect to HDMI...\r\n");// 连接到HDMI

	/*
	 * 初始化VDMA驱动
	 */
	vdmaConfig = XAxiVdma_LookupConfig(VGA_VDMA_ID);
	if (!vdmaConfig)
	{
		xil_printf("No video DMA found for ID %d\r\n", VGA_VDMA_ID);

	}
	Status = XAxiVdma_CfgInitialize(&vdma, vdmaConfig, vdmaConfig->BaseAddress);
	if (Status != XST_SUCCESS)
	{
		xil_printf("VDMA Configuration Initialization failed %d\r\n", Status);

	}

	/*
	 * 初始化显示控制器并启动
	 */
	Status = DisplayInitialize(&dispCtrl, &vdma, DISP_VTC_ID, DYNCLK_BASEADDR, pFrames, DEMO_STRIDE);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Display Ctrl initialization failed during demo initialization%d\r\n", Status);

	}
	Status = DisplayStart(&dispCtrl);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Couldn't start display during demo initialization%d\r\n", Status);

	}

	DemoPrintTest(dispCtrl.framePtr[dispCtrl.curFrame], dispCtrl.vMode.width, dispCtrl.vMode.height, dispCtrl.stride, DEMO_PATTERN_3);

	usleep(1000); // 等待1秒钟

	Status = XAxiDma_Adc_Wave(dispCtrl.vMode.width, dispCtrl.framePtr[dispCtrl.curFrame],  dispCtrl.stride, &INST) ;
	if (Status != XST_SUCCESS)
	{
		xil_printf("ADC Running Failed\r\n");
	}

    cleanup_platform();
	return 0;
}



void DemoPrintTest(u8 *frame, u32 width, u32 height, u32 stride, int pattern)
{
	(void)pattern;  // 避免未使用参数警告
	u32 xcoi, ycoi;
	u32 iPixelAddr = 0;
	u8 wRed, wBlue, wGreen;
	u32 xInt;

	xInt = width*BYTES_PIXEL / 8; //每个区域宽度为width/8像素

	for(ycoi = 0; ycoi < height; ycoi++)
	{

		/*
		 * 在最后一个部分区域绘制白色（当宽度不能被7整除时）
		 */

		for(xcoi = 0; xcoi < (width*BYTES_PIXEL); xcoi+=BYTES_PIXEL)
		{

			if (xcoi < xInt) {                                   //白色
				wRed = 255;
				wGreen = 255;
				wBlue = 255;
			}

			else if ((xcoi >= xInt) && (xcoi < xInt*2)){         //黄色
				wRed = 255;
				wGreen = 255;
				wBlue = 0;
			}
			else if ((xcoi >= xInt*2) && (xcoi < xInt*3)){        //青色
				wRed = 0;
				wGreen = 255;
				wBlue = 255;
			}
			else if ((xcoi >= xInt*3) && (xcoi < xInt*4)){        //绿色
				wRed = 0;
				wGreen = 255;
				wBlue = 0;
			}
			else if ((xcoi >= xInt*4) && (xcoi < xInt*5)){        //洋红色
				wRed = 255;
				wGreen = 0;
				wBlue = 255;
			}
			else if ((xcoi >= xInt*5) && (xcoi < xInt*6)){        //红色
				wRed = 255;
				wGreen = 0;
				wBlue = 0;
			}
			else if ((xcoi >= xInt*6) && (xcoi < xInt*7)){        //蓝色
				wRed = 0;
				wGreen = 0;
				wBlue = 255;
			}
			else {                                                //黑色
				wRed = 0;
				wGreen = 0;
				wBlue = 0;
			}

			frame[xcoi+iPixelAddr + 0] = wBlue;
			frame[xcoi+iPixelAddr + 1] = wGreen;
			frame[xcoi+iPixelAddr + 2] = wRed;
			/*
			 * 此模式一次打印一条垂直线，因此地址必须按stride递增
			 * 而不是仅仅递增1
			 */
		}
		iPixelAddr += stride;

	}

	/*
	 * 刷新帧缓冲区内存范围以确保更改写入实际内存，
	 * 因此VDMA可以访问
	 */
	Xil_DCacheFlushRange((unsigned int) frame, DEMO_MAX_FRAME);
}


int SetInterruptInit(XScuGic *InstancePtr, u16 IntrID)
{

	XScuGic_Config * Config ;
	int Status ;

	Config = XScuGic_LookupConfig(IntrID) ;

	Status = XScuGic_CfgInitialize(InstancePtr, Config, Config->CpuBaseAddress) ;
	if (Status != XST_SUCCESS)
		return XST_FAILURE ;

	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			(Xil_ExceptionHandler) XScuGic_InterruptHandler,
			InstancePtr);

	Xil_ExceptionEnable();


	return XST_SUCCESS ;

}
