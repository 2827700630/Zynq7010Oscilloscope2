/* ------------------------------------------------------------ */
/*				头文件包含定义								*/
/* ------------------------------------------------------------ */

#include "adc_dma_ctrl.h"
#include "wave/wave.h"
#include "wave/oscilloscope_text.h"  // 新增：文字显示功能
#include "wave/oscilloscope_interface.h"  // 新增：完整界面功能
#include "string.h"

/* 状态码定义 */
#ifndef XST_NO_DATA
#define XST_NO_DATA 3 /* 没有新数据需要处理 */
#endif

#ifndef XST_TIMEOUT
#define XST_TIMEOUT 4 /* 操作超时 */
#endif

u8 DmaRxBuffer[MAX_DMA_LEN] __attribute__((aligned(64))); // DMA S2Mm接收缓冲区
u8 GridBuffer[WAVE_LEN];								  // 网格缓冲区
u8 WaveBuffer[WAVE_LEN];								  // 波形缓冲区
XAxiDma AxiDma;											  // DMA控制器
volatile int s2mm_flag;									  // S2Mm中断标志
volatile int dma_done;									  // DMA传输完成标志

/*
 * 函数声明
 */
int XAxiDma_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr);
void Dma_Interrupt_Handler(void *CallBackRef);
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr);
void ad9280_sample(u32 adc_addr, u32 adc_len);

/**
 * ADC波形显示初始化函数
 *
 * @param width 是帧宽度
 * @param frame 是显示帧指针
 * @param stride 是帧跨度
 * @param InstancePtr 是GIC指针
 * @return XST_SUCCESS 如果成功，否则 XST_FAILURE
 */
int XAxiDma_Adc_Init(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr)
{
	int Status;

	xil_printf("[初始化] 开始ADC波形显示初始化\r\n");
	xil_printf("[配置] 波形宽度: %d, 高度: %d\r\n", width, WAVE_HEIGHT);
	xil_printf("[配置] ADC采集长度: %d, ADC基地址: 0x%08X\r\n", ADC_CAPTURELEN, AD9280_BASE);

	// 初始化标志
	s2mm_flag = 1;
	dma_done = 0;

	// 初始化DMA
	Status = XAxiDma_Initial(DMA_DEV_ID, S2MM_INTR_ID, &AxiDma, InstancePtr);
	if (Status != XST_SUCCESS)
	{
		xil_printf("[错误] DMA初始化失败: %d\r\n", Status);
		return XST_FAILURE;
	}
	xil_printf("[初始化] DMA初始化成功\r\n");

	// 绘制网格（一次性）
	draw_grid(width, WAVE_HEIGHT, GridBuffer);
	xil_printf("[初始化] 网格绘制完成\r\n");

	return XST_SUCCESS;
}

/**
 * ADC波形显示更新函数（单次更新）
 *
 * @param width 是帧宽度
 * @param frame 是显示帧指针
 * @param stride 是帧跨度
 * @return XST_SUCCESS 如果成功，XST_FAILURE 如果失败，XST_TIMEOUT 如果超时
 */
int XAxiDma_Adc_Update(u32 width, u8 *frame, u32 stride)
{
	int Status;
	static u32 frame_count = 0;

	// 检查是否需要更新
	if (!s2mm_flag)
	{
		return XST_NO_DATA; // 没有新数据需要处理
	}

	// 清除标志并开始处理
	s2mm_flag = 0;
	dma_done = 0;
	frame_count++;

	// 复制网格到波形缓冲区（高效方法：预绘制的网格）
	memcpy(WaveBuffer, GridBuffer, WAVE_LEN);

	// 在网格基础上绘制波形数据
	draw_wave(width, WAVE_HEIGHT, (void *)DmaRxBuffer, WaveBuffer, UNSIGNEDCHAR, ADC_BITS, YELLOW, ADC_COE);

	// 在网格和波形基础上添加示波器信息（文字和标签）
	static OscilloscopeParams osc_params = {
		.timebase_us = 100.0,      // 100μs/格
		.voltage_scale = 1.0,      // 1.0V/格（修正：对应AD8056的-5V到+5V输入范围）
		.sample_rate = 32260000,   // 32.26MHz采样率
		.trigger_level = 128,      // 中间触发电平
		.trigger_mode = 0          // 自动触发
	};
	
	// 计算实际测量值
	calculate_measurements(DmaRxBuffer, ADC_CAPTURELEN, &osc_params);
	
	// 计算时基（基于采样率和屏幕宽度）
	osc_params.timebase_us = (1000000.0 / osc_params.sample_rate) * (ADC_CAPTURELEN / 10.0); // 10个网格
	
	// 只绘制示波器信息面板（文字），不重绘网格
	draw_oscilloscope_info(WaveBuffer, width, WAVE_HEIGHT, &osc_params);
	draw_grid_labels(WaveBuffer, width, WAVE_HEIGHT, &osc_params);

	// 将画布复制到帧缓冲区
	frame_copy(width, WAVE_HEIGHT, stride, WAVE_START_COLUMN, WAVE_START_ROW, frame, WaveBuffer);

	// 性能统计（每100帧显示一次）
	if (frame_count % 100 == 0)
	{
		xil_printf("[性能] 已更新%d帧波形\r\n", frame_count);
	}

	// 开始下一次ADC采样
	ad9280_sample(AD9280_BASE, ADC_CAPTURELEN);

	// 启动DMA传输
	Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)DmaRxBuffer,
									ADC_CAPTURELEN, XAXIDMA_DEVICE_TO_DMA);
	if (Status != XST_SUCCESS)
	{
		xil_printf("[错误] DMA传输启动失败: %d\r\n", Status);
		s2mm_flag = 1; // 设置标志重新尝试
		return XST_FAILURE;
	}

	// 等待中断信号（非阻塞等待）
	int timeout_count = 0;
	while (!dma_done && timeout_count < 2000)
	{
		usleep(1000); // 等待1ms
		timeout_count++;

		// 每100ms打印一次等待状态
		if (timeout_count % 100 == 0)
		{
			xil_printf("[DMA] 等待中断... (%dms)\r\n", timeout_count);
		}
	}

	if (!dma_done)
	{
		xil_printf("[警告] DMA传输超时，尝试重置\r\n");
		// 重置DMA
		XAxiDma_Reset(&AxiDma);
		while (!XAxiDma_ResetIsDone(&AxiDma))
		{
			// 等待重置完成
		}
		// 重新启用中断
		XAxiDma_IntrEnable(&AxiDma, XAXIDMA_IRQ_IOC_MASK, XAXIDMA_DEVICE_TO_DMA);
		s2mm_flag = 1; // 重置标志
		return XST_TIMEOUT;
	}

	return XST_SUCCESS;
}

/**
 * 这是ADC采样函数，使用它来启动ADC数据采样
 *
 * @param adc_addr ADC基地址
 * @param adc_len 是ADC数据位宽的采样长度
 */
void ad9280_sample(u32 adc_addr, u32 adc_len)
{
	// 快速配置模式，减少调试输出以提高实时性
	// u32 reg2;  // 注释掉未使用的变量

	// 复位并配置长度
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_START, 0);
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_LENGTH, adc_len);

	// 使能配置
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_SAMPLE_S00_AXI_SLV_REG2_OFFSET, 0x1);
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_SAMPLE_S00_AXI_SLV_REG3_OFFSET, 0x1);

	// 启动采样
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_START, 1);
}

/**
 * 将画布缓冲区数据复制到帧中的特定位置
 *
 *@param hor_x  复制的起始水平位置
 *@param ver_y  复制的起始垂直位置
 *@param width  复制的宽度
 *@param height 复制的高度
 *
 *@note  hor_x+width应小于帧宽度，ver_y+height应小于帧高度
 */
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr)
{
	u32 i;
	u32 FrameOffset;
	u32 CanvasOffset;
	u32 CopyLen = width * BYTES_PIXEL;

	for (i = 0; i < height; i++)
	{
		FrameOffset = (ver_y + i) * stride + hor_x * BYTES_PIXEL;
		CanvasOffset = i * width * BYTES_PIXEL;
		memcpy(frame + FrameOffset, CanvasBufferPtr + CanvasOffset, CopyLen);
	}

	FrameOffset = ver_y * stride;

	Xil_DCacheFlushRange((INTPTR)frame + FrameOffset, height * stride);
}

/**
 * 初始化DMA并连接中断到处理程序，开启s2mm中断
 *
 *@param DeviceId    DMA设备ID
 *@param IntrID      DMA中断ID
 *@param XAxiDma     DMA指针
 *@param InstancePtr GIC指针
 *
 *@note  无
 */
int XAxiDma_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr)
{
	XAxiDma_Config *CfgPtr;
	int Status;

	xil_printf("[DMA初始化] 开始初始化DMA设备ID: %d, 中断ID: %d\r\n", DeviceId, IntrID);

	/* 初始化XAxiDma设备 */
	CfgPtr = XAxiDma_LookupConfig(DeviceId);
	if (!CfgPtr)
	{
		xil_printf("[错误] 找不到设备ID %d 的配置\r\n", DeviceId);
		return XST_FAILURE;
	}

	xil_printf("[DMA初始化] DMA基地址: 0x%08X\r\n", (u32)CfgPtr->BaseAddr);

	Status = XAxiDma_CfgInitialize(XAxiDma, CfgPtr);
	if (Status != XST_SUCCESS)
	{
		xil_printf("[错误] DMA配置初始化失败: %d\r\n", Status);
		return XST_FAILURE;
	}

	/* 检查DMA是否有S2MM功能 - 简化检查 */
	if (!XAxiDma_HasSg(XAxiDma))
	{
		/* 对于简单DMA模式，检查配置文件 */
		if (CfgPtr->HasS2Mm != 1)
		{
			xil_printf("[错误] DMA设备不支持S2MM\r\n");
			return XST_FAILURE;
		}
	}

	/* 连接中断处理程序 */
	Status = XScuGic_Connect(InstancePtr, IntrID,
							 (Xil_ExceptionHandler)Dma_Interrupt_Handler,
							 (void *)XAxiDma);

	if (Status != XST_SUCCESS)
	{
		xil_printf("[错误] 中断连接失败: %d\r\n", Status);
		return Status;
	}

	/* 启用GIC中的中断 */
	XScuGic_Enable(InstancePtr, IntrID);
	xil_printf("[DMA初始化] 中断已启用\r\n");

	/* 禁用MM2S中断，启用S2MM中断 */
	XAxiDma_IntrEnable(XAxiDma, XAXIDMA_IRQ_IOC_MASK, XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(XAxiDma, XAXIDMA_IRQ_ALL_MASK, XAXIDMA_DMA_TO_DEVICE);

	xil_printf("[DMA初始化] S2MM中断已启用，MM2S中断已禁用\r\n");

	return XST_SUCCESS;
}

/**
 * 回调函数
 * 检查中断状态并设置s2mm标志
 * 基于Xilinx标准示例改进
 */
void Dma_Interrupt_Handler(void *CallBackRef)
{
	XAxiDma *XAxiDmaPtr;
	u32 IrqStatus;
	int TimeOut;

	XAxiDmaPtr = (XAxiDma *)CallBackRef;

	/* 读取待处理的中断 */
	IrqStatus = XAxiDma_IntrGetIrq(XAxiDmaPtr, XAXIDMA_DEVICE_TO_DMA);

	/* 确认待处理的中断 */
	XAxiDma_IntrAckIrq(XAxiDmaPtr, IrqStatus, XAXIDMA_DEVICE_TO_DMA);

	/*
	 * 如果没有中断被断言，则不做任何操作
	 */
	if (!(IrqStatus & XAXIDMA_IRQ_ALL_MASK))
	{
		return;
	}

	/*
	 * 如果错误中断被断言，设置错误标志，重置硬件以从错误中恢复
	 */
	if ((IrqStatus & XAXIDMA_IRQ_ERROR_MASK))
	{
		xil_printf("[错误] DMA S2MM传输错误中断: 0x%08X\r\n", IrqStatus);

		/* 重置DMA */
		XAxiDma_Reset(XAxiDmaPtr);

		TimeOut = 10000; // RESET_TIMEOUT_COUNTER
		while (TimeOut)
		{
			if (XAxiDma_ResetIsDone(XAxiDmaPtr))
			{
				break;
			}
			TimeOut -= 1;
		}

		/* 设置错误标志 */
		dma_done = 1;
		s2mm_flag = 1;
		return;
	}

	/*
	 * 如果完成中断被断言，则设置完成标志
	 */
	if ((IrqStatus & XAXIDMA_IRQ_IOC_MASK))
	{
		// xil_printf("[中断] DMA S2MM传输完成中断触发\r\n");

		/* 使给定地址范围的数据缓存无效 */
		Xil_DCacheInvalidateRange((INTPTR)DmaRxBuffer, ADC_CAPTURELEN);

		/* 设置DMA完成标志 */
		dma_done = 1;
		s2mm_flag = 1;
	}
}
