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
#include "xgpiops.h"  // GPIO驱动
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

#define INT_DEVICE_ID XPAR_SCUGIC_SINGLE_DEVICE_ID

// DMA相关定义
#define DMA_DEV_ID 0
/* 中断ID计算：ZYNQ IRQ_F2P基址 + xlconcat端口（vivado中设计）偏移 */
#define ZYNQ_IRQ_F2P_BASE_ID 61									/* ZYNQ Fabric-to-PS中断基础ID，vitis2025.1中xparameters中生成的参数31是错误的 */
#define DMA_XLCONCAT_PORT 2										/* DMA连接在xlconcat的In2端口 */
#define S2MM_INTR_ID (ZYNQ_IRQ_F2P_BASE_ID + DMA_XLCONCAT_PORT) /* 61+2=63 */

/* GPIO和按键定义 */
#define GPIO_DEVICE_ID 0         /* PS GPIO设备ID定义 */
#define BUTTON_MIO_PIN 50                   /* 时基切换按键连接到MIO50 */
#define BUTTON_PRESS_LOW 0                  /* 按键按下时为低电平 */
#define BUTTON_RELEASE_HIGH 1               /* 按键释放时为高电平 */
#define DEBOUNCE_DELAY_MS 50               /* 按键防抖延时(毫秒) */

/* -------------------------------------------------------- */
/*				全局变量									*/
/* -------------------------------------------------------- */

// 显示驱动结构体
DisplayCtrl dispCtrl;
XAxiVdma vdma;

// 视频数据帧缓冲区
u8 frameBuf[DISPLAY_NUM_FRAMES][DEMO_MAX_FRAME] __attribute__((aligned(64)));
u8 *pFrames[DISPLAY_NUM_FRAMES]; // 指向帧缓冲区的指针数组

// 中断结构体和函数
XScuGic INST;

// GPIO驱动实例
XGpioPs Gpio;

// 函数声明
int SetInterruptInit(XScuGic *InstancePtr, u16 IntrID);
int InitializeGpio(void);
int CheckButtonPress(void);

/// @brief 主函数
/// @param 无
/// @return 0
int main(void)
{
	init_platform();
	int Status;
	XAxiVdma_Config *vdmaConfig;
	int i;
	/*
	 * 初始化ScuGic中断
	 */
	Status = SetInterruptInit(&INST, INT_DEVICE_ID);
	if (Status != XST_SUCCESS)
		return XST_FAILURE;

	/*
	 * 初始化GPIO（时基切换按键）
	 */
	Status = InitializeGpio();
	if (Status != XST_SUCCESS) {
		xil_printf("GPIO Initialization Failed\r\n");
		return XST_FAILURE;
	}
	xil_printf("GPIO Initialization Success\r\n");

	/*
	 * 初始化指向3个帧缓冲区的指针数组
	 */
	for (i = 0; i < DISPLAY_NUM_FRAMES; i++)
	{
		pFrames[i] = frameBuf[i];
	}

	xil_printf("Display Demo Initialization\r\n"); // 初始化显示演示
	// 这里可以直接使用printf函数，xil_printf默认不支持浮点数（除非特别配置）
	xil_printf("please connect to HDMI...\r\n"); // 连接到HDMI

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

	// 初始化ADC波形显示模块
	Status = XAxiDma_Adc_Init(dispCtrl.vMode.width, dispCtrl.framePtr[dispCtrl.curFrame], dispCtrl.stride, &INST);
	if (Status != XST_SUCCESS)
	{
		xil_printf("ADC Initialization Failed\r\n");
		cleanup_platform();
		return -1;
	}	xil_printf("[主循环] 开始实时波形显示循环\r\n");
	
	// 时基切换控制变量
	static u8 current_timebase = 3; // 当前时基档位（从档位3开始）
	static u32 last_button_check = 0; // 上次按键检测计数
	
	// 自动演示控制变量（可选功能）
	static u32 auto_demo_counter = 0;
	static u8 auto_demo_enabled = 0; // 0=关闭自动演示，1=开启自动演示

	// 主循环 - 在main函数中进行实时波形更新
	while (1)
	{
		Status = XAxiDma_Adc_Update(dispCtrl.vMode.width, dispCtrl.framePtr[dispCtrl.curFrame], dispCtrl.stride);

		switch (Status)
		{
		case XST_SUCCESS:
			// 波形更新成功，继续循环
			last_button_check++;
			
			// 每10帧检测一次按键（约166ms间隔，假设60FPS）
			if (last_button_check >= 10) {
				last_button_check = 0;
				
				// 检测按键按下
				if (CheckButtonPress()) {
					// 切换到下一个时基档位
					current_timebase++;
					if (current_timebase > TIMEBASE_COUNT) {
						current_timebase = 1; // 循环回到第一档
					}
					set_timebase(current_timebase);
					xil_printf("[按键] 手动切换到时基档位: %d\r\n", current_timebase);
					
					// 按键按下后暂停一下，避免连续触发
					usleep(200000); // 等待200ms
				}
			}
			
			// 可选：自动演示功能（按住按键5秒可切换）
			if (auto_demo_enabled) {
				auto_demo_counter++;
				if (auto_demo_counter >= 300) { // 每5秒自动切换
					auto_demo_counter = 0;
					current_timebase++;
					if (current_timebase > TIMEBASE_COUNT) {
						current_timebase = 1;
					}
					set_timebase(current_timebase);
					xil_printf("[自动] 演示切换到时基档位: %d\r\n", current_timebase);
				}
			}
			break;

		case XST_NO_DATA:
			// 没有新数据，短暂等待
			usleep(1000); // 等待1ms
			break;

		case XST_TIMEOUT:
			xil_printf("[主循环] DMA超时，继续重试\r\n");
			break;

		case XST_FAILURE:
			xil_printf("[主循环] DMA传输失败，继续重试\r\n");
			break;

		default:
			xil_printf("[主循环] 未知状态: %d\r\n", Status);
			break;
		}
	}
	// 注意：这段代码永远不会执行到，因为主循环是无限的
	cleanup_platform();
	return 0;
}

/**
 *  @brief DemoPrintTest - 在帧缓冲区中打印测试图案
 *  @param frame - 帧缓冲区指针
 *  @param width - 帧宽度
 *  @param height - 帧高度
 *  @param stride - 帧跨度（每行字节数）
 *  @param pattern - 测试图案类型（未使用）
 *  @note 此函数将帧缓冲区分成7个区域，每个区域填充不同的颜色。
 *        最后一个区域填充白色（当宽度不能被7整除时）。
 *        每个区域的宽度为width/7像素。
 *        每个像素使用3个字节（RGB格式），因此stride应为width * 3。
 */
void DemoPrintTest(u8 *frame, u32 width, u32 height, u32 stride, int pattern)
{
	(void)pattern; // 避免未使用参数警告
	u32 xcoi, ycoi;
	u32 iPixelAddr = 0;
	u8 wRed, wBlue, wGreen;
	u32 xInt;

	xInt = width * BYTES_PIXEL / 8; // 每个区域宽度为width/8像素

	for (ycoi = 0; ycoi < height; ycoi++)
	{

		/*
		 * 在最后一个部分区域绘制白色（当宽度不能被7整除时）
		 */
		for (xcoi = 0; xcoi < (width * BYTES_PIXEL); xcoi += BYTES_PIXEL)
		{

			if (xcoi < xInt)
			{ // 白色
				wRed = 255;
				wGreen = 255;
				wBlue = 255;
			}

			else if ((xcoi >= xInt) && (xcoi < xInt * 2))
			{ // 黄色
				wRed = 255;
				wGreen = 255;
				wBlue = 0;
			}
			else if ((xcoi >= xInt * 2) && (xcoi < xInt * 3))
			{ // 青色
				wRed = 0;
				wGreen = 255;
				wBlue = 255;
			}
			else if ((xcoi >= xInt * 3) && (xcoi < xInt * 4))
			{ // 绿色
				wRed = 0;
				wGreen = 255;
				wBlue = 0;
			}
			else if ((xcoi >= xInt * 4) && (xcoi < xInt * 5))
			{ // 洋红色
				wRed = 255;
				wGreen = 0;
				wBlue = 255;
			}
			else if ((xcoi >= xInt * 5) && (xcoi < xInt * 6))
			{ // 红色
				wRed = 255;
				wGreen = 0;
				wBlue = 0;
			}
			else if ((xcoi >= xInt * 6) && (xcoi < xInt * 7))
			{ // 蓝色
				wRed = 0;
				wGreen = 0;
				wBlue = 255;
			}
			else
			{ // 黑色
				wRed = 0;
				wGreen = 0;
				wBlue = 0;
			}

			frame[xcoi + iPixelAddr + 0] = wBlue;
			frame[xcoi + iPixelAddr + 1] = wGreen;
			frame[xcoi + iPixelAddr + 2] = wRed;
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
	Xil_DCacheFlushRange((unsigned int)frame, DEMO_MAX_FRAME);
}

/**
 * @brief SetInterruptInit - 初始化中断控制器
 * @param InstancePtr - 指向中断控制器实例的指针
 * @param IntrID - 中断ID
 * @return XST_SUCCESS on success, XST_FAILURE on failure
 * @note 此函数初始化中断控制器，并注册中断处理程序。
 */
int SetInterruptInit(XScuGic *InstancePtr, u16 IntrID)
{

	XScuGic_Config *Config;
	int Status;

	Config = XScuGic_LookupConfig(IntrID);

	Status = XScuGic_CfgInitialize(InstancePtr, Config, Config->CpuBaseAddress);
	if (Status != XST_SUCCESS)
		return XST_FAILURE;

	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
								 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
								 InstancePtr);

	Xil_ExceptionEnable();

	return XST_SUCCESS;
}

/**
 * @brief InitializeGpio - 初始化GPIO控制器
 * @return XST_SUCCESS on success, XST_FAILURE on failure
 * @note 初始化GPIO控制器，并配置MIO50为输入引脚
 */
int InitializeGpio(void)
{
	XGpioPs_Config *ConfigPtr;
	int Status;

	// 查找GPIO配置
	ConfigPtr = XGpioPs_LookupConfig(GPIO_DEVICE_ID);
	if (ConfigPtr == NULL) {
		xil_printf("[GPIO错误] 无法找到GPIO配置\r\n");
		return XST_FAILURE;
	}

	// 初始化GPIO驱动
	Status = XGpioPs_CfgInitialize(&Gpio, ConfigPtr, ConfigPtr->BaseAddr);
	if (Status != XST_SUCCESS) {
		xil_printf("[GPIO错误] GPIO初始化失败: %d\r\n", Status);
		return XST_FAILURE;
	}

	// 配置MIO50为输入引脚
	XGpioPs_SetDirectionPin(&Gpio, BUTTON_MIO_PIN, 0); // 0=输入，1=输出

	xil_printf("[GPIO] MIO%d配置为时基切换按键输入\r\n", BUTTON_MIO_PIN);
	return XST_SUCCESS;
}

/**
 * @brief CheckButtonPress - 检测按键是否被按下
 * @return 1 if button is pressed, 0 if not pressed
 * @note 检测MIO50按键状态，包含防抖处理
 */
int CheckButtonPress(void)
{
	static u32 button_state = BUTTON_RELEASE_HIGH; // 上次按键状态
	static u32 debounce_counter = 0; // 防抖计数器
	static u32 press_detected = 0; // 按键按下检测标志
	
	u32 current_state = XGpioPs_ReadPin(&Gpio, BUTTON_MIO_PIN);
	
	// 如果状态发生变化，开始防抖计数
	if (current_state != button_state) {
		debounce_counter++;
		
		// 防抖延时：连续检测到相同状态一定次数后确认状态变化
		if (debounce_counter >= 3) { // 约30ms防抖（10帧 * 3次检测）
			button_state = current_state;
			debounce_counter = 0;
			
			// 检测按键从高电平变为低电平（按下动作）
			if (button_state == BUTTON_PRESS_LOW && !press_detected) {
				press_detected = 1; // 标记已检测到按下
				return 1; // 返回按键按下
			}
			
			// 检测按键从低电平变为高电平（释放动作）
			if (button_state == BUTTON_RELEASE_HIGH && press_detected) {
				press_detected = 0; // 清除按下标记
			}
		}
	} else {
		debounce_counter = 0; // 状态稳定，清除防抖计数
	}
	
	return 0; // 没有检测到按键按下
}
