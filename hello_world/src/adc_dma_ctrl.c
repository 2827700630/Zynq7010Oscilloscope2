/* ------------------------------------------------------------ */
/*				头文件包含定义								*/
/* ------------------------------------------------------------ */

#include "adc_dma_ctrl.h"
#include "wave/wave.h"
#include "string.h"
/*
 * DMA s2mm接收缓冲区
 */
u8 DmaRxBuffer[MAX_DMA_LEN] __attribute__((aligned(64)));
/*
 * 网格缓冲区
 */
u8 GridBuffer[WAVE_LEN];
/*
 * 波形缓冲区
 */
u8 WaveBuffer[WAVE_LEN];
/*
 * DMA结构体
 */
XAxiDma AxiDma;
/*
 * s2mm中断标志
 */
volatile int s2mm_flag;
/*
 * 函数声明
 */
int XAxiDma_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr);
void Dma_Interrupt_Handler(void *CallBackRef);
void frame_copy(u32 width, u32 height, u32 stride, int hor_x, int ver_y, u8 *frame, u8 *CanvasBufferPtr);
void ad9280_sample(u32 adc_addr, u32 adc_len);
void ad9280_simple_test(void);
/*
 *初始化DMA，绘制网格和波形，启动ADC采样
 *
 *@param width 是帧宽度
 *@param frame 是显示帧指针
 *@param stride 是帧跨度
 *@param InstancePtr 是GIC指针
 */
int XAxiDma_Adc_Wave(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr)
{
	int Status;
	u32 wave_width = width;

	xil_printf("[初始化] 开始ADC波形显示初始化\r\n");
	xil_printf("[配置] 波形宽度: %d, 高度: %d\r\n", wave_width, WAVE_HEIGHT);
	xil_printf("[配置] ADC采集长度: %d, ADC基地址: 0x%08X\r\n", ADC_CAPTURELEN, AD9280_BASE);

	s2mm_flag = 1;
	Status = XAxiDma_Initial(DMA_DEV_ID, S2MM_INTR_ID, &AxiDma, InstancePtr);
	if (Status != XST_SUCCESS)
	{
		xil_printf("[错误] DMA初始化失败: %d\r\n", Status);
		return XST_FAILURE;
	}
	xil_printf("[初始化] DMA初始化成功\r\n");

	/* 网格覆盖 */
	draw_grid(wave_width, WAVE_HEIGHT, GridBuffer);
	xil_printf("[初始化] 网格绘制完成\r\n");

	// // 添加AD9280基础连通性测试
	// xil_printf("[测试] 检查AD9280寄存器连通性...\r\n");

	// // 测试REG2和REG3是否可写
	// AD9280_SAMPLE_mWriteReg(AD9280_BASE, AD9280_SAMPLE_S00_AXI_SLV_REG2_OFFSET, 0xAAAAAAAA);
	// u32 test_val2 = AD9280_SAMPLE_mReadReg(AD9280_BASE, AD9280_SAMPLE_S00_AXI_SLV_REG2_OFFSET);

	// AD9280_SAMPLE_mWriteReg(AD9280_BASE, AD9280_SAMPLE_S00_AXI_SLV_REG3_OFFSET, 0x55555555);
	// u32 test_val3 = AD9280_SAMPLE_mReadReg(AD9280_BASE, AD9280_SAMPLE_S00_AXI_SLV_REG3_OFFSET);

	// xil_printf("[测试] REG2写入0xAAAAAAAA, 读回0x%08X\r\n", test_val2);
	// xil_printf("[测试] REG3写入0x55555555, 读回0x%08X\r\n", test_val3);

	// // 复位测试寄存器	AD9280_SAMPLE_mWriteReg(AD9280_BASE, AD9280_SAMPLE_S00_AXI_SLV_REG2_OFFSET, 0);
	// AD9280_SAMPLE_mWriteReg(AD9280_BASE, AD9280_SAMPLE_S00_AXI_SLV_REG3_OFFSET, 0);

	// 添加性能统计和ADC采集计数器
	static u32 frame_count = 0;
	static u32 adc_sample_count = 0;

	while (1)
	{
		if (s2mm_flag)
		{
			/* 清除s2mm_flag */
			s2mm_flag = 0;

			frame_count++;
			adc_sample_count++;

			/* 将网格复制到波形缓冲区 */
			memcpy(WaveBuffer, GridBuffer, WAVE_LEN);
			/* 波形覆盖 */
			draw_wave(wave_width, WAVE_HEIGHT, (void *)DmaRxBuffer, WaveBuffer, UNSIGNEDCHAR, ADC_BITS, YELLOW, ADC_COE);
			/* 将画布复制到帧缓冲区 */
			frame_copy(wave_width, WAVE_HEIGHT, stride, WAVE_START_COLUMN, WAVE_START_ROW, frame, WaveBuffer);

			// // 每100次ADC采集通过串口发送原始数据
			// if (adc_sample_count % 10 == 0)
			// {
			// 	// 直接发送前256字节的原始ADC数据（十六进制格式，无其他格式化）
			// 	u32 send_length = (ADC_CAPTURELEN > 256) ? 256 : ADC_CAPTURELEN;
			// 	for (u32 i = 0; i < send_length; i++)
			// 	{
			// 		xil_printf("%02X ", DmaRxBuffer[i]);
			// 	}
			// 	// xil_printf("\r\n");
			// }

			// 每100帧显示一次性能统计
			if (frame_count % 100 == 0)
			{
				xil_printf("[性能] 已更新%d帧波形，已采集%d次ADC数据\r\n", frame_count, adc_sample_count);
			}

			/* 延迟10ms，减少系统负载 */
			usleep(10000);
			/* 开始采样 */
			ad9280_sample(AD9280_BASE, ADC_CAPTURELEN);

			/* 启动从AD9280到DDR3的DMA传输 */ Status = XAxiDma_SimpleTransfer(&AxiDma, (UINTPTR)DmaRxBuffer,
																			  ADC_CAPTURELEN, XAXIDMA_DEVICE_TO_DMA);
			if (Status != XST_SUCCESS)
			{
				s2mm_flag = 1; // 重新尝试
				continue;
			}

			// 超高频轮询DMA状态（每1ms检查一次，优化波形连续性）
			for (int i = 0; i < 2000; i++)
			{				  // 最多等待2秒
				usleep(1000); // 等待1ms

				// 检查DMA状态
				u32 dma_sr = XAxiDma_ReadReg(AxiDma.RegBase, XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET); // 检查IOC完成位
				if (dma_sr & 0x1000)
				{ // IOC中断标志位
					// 清除中断标志
					XAxiDma_IntrAckIrq(&AxiDma, XAXIDMA_IRQ_IOC_MASK, XAXIDMA_DEVICE_TO_DMA);

					// 使数据缓存无效
					Xil_DCacheInvalidateRange((INTPTR)DmaRxBuffer, ADC_CAPTURELEN);

					// 设置完成标志，继续正常流程
					s2mm_flag = 1;
					break;
				}

				// 每100次（100ms）打印一次状态，减少串口输出干扰
				if (i % 100 == 99)
				{
					xil_printf("[DMA] 等待中... (%dms)\r\n", (i + 1));
				}
			}
			if (!s2mm_flag)
			{
				xil_printf("[警告] DMA传输超时，尝试简化传输\r\n");
				// 直接进行简化测试，这个通常能成功
				ad9280_simple_test();
				s2mm_flag = 1; // 重置标志，继续下一次循环
			}
		}
	}
	return XST_SUCCESS;
}

/*
 *这是ADC采样函数，使用它来启动ADC数据采样	 *
 *@param adc_addr ADC基地址
 *@param adc_len 是ADC数据位宽的采样长度
 */
void ad9280_sample(u32 adc_addr, u32 adc_len)
{
	// 快速配置模式，减少调试输出以提高实时性
	u32 reg2;

	// 复位并配置长度
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_START, 0);
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_LENGTH, adc_len);

	// 使能配置
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_SAMPLE_S00_AXI_SLV_REG2_OFFSET, 0x1);
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_SAMPLE_S00_AXI_SLV_REG3_OFFSET, 0x1);

	// 启动采样
	AD9280_SAMPLE_mWriteReg(adc_addr, AD9280_START, 1);

}

/*
 *将画布缓冲区数据复制到帧中的特定位置
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

/*
 *初始化DMA并连接中断到处理程序，开启s2mm中断
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
	/* 初始化XAxiDma设备 */
	CfgPtr = XAxiDma_LookupConfig(DeviceId);
	if (!CfgPtr)
	{
		xil_printf("No config found for %d\r\n", DeviceId);
		return XST_FAILURE;
	}

	Status = XAxiDma_CfgInitialize(XAxiDma, CfgPtr);
	if (Status != XST_SUCCESS)
	{
		xil_printf("Initialization failed %d\r\n", Status);
		return XST_FAILURE;
	}

	Status = XScuGic_Connect(InstancePtr, IntrID,
							 (Xil_ExceptionHandler)Dma_Interrupt_Handler,
							 (void *)XAxiDma);

	if (Status != XST_SUCCESS)
	{
		return Status;
	}
	XScuGic_Enable(InstancePtr, IntrID);

	/* 禁用MM2S中断，启用S2MM中断 */
	XAxiDma_IntrEnable(XAxiDma, XAXIDMA_IRQ_IOC_MASK,
					   XAXIDMA_DEVICE_TO_DMA);
	XAxiDma_IntrDisable(XAxiDma, XAXIDMA_IRQ_ALL_MASK,
						XAXIDMA_DMA_TO_DEVICE);

	return XST_SUCCESS;
}

/*
 *回调函数
 *检查中断状态并设置s2mm标志
 */
void Dma_Interrupt_Handler(void *CallBackRef)
{
	XAxiDma *XAxiDmaPtr;
	XAxiDmaPtr = (XAxiDma *)CallBackRef;

	int s2mm_sr;
	s2mm_sr = XAxiDma_IntrGetIrq(XAxiDmaPtr, XAXIDMA_DEVICE_TO_DMA);
	if (s2mm_sr & XAXIDMA_IRQ_IOC_MASK)
	{
		xil_printf("[中断] DMA传输完成中断触发\r\n");
		/* 清除中断 */
		XAxiDma_IntrAckIrq(XAxiDmaPtr, XAXIDMA_IRQ_IOC_MASK,
						   XAXIDMA_DEVICE_TO_DMA);
		/* 使给定地址范围的数据缓存无效 */
		Xil_DCacheInvalidateRange((INTPTR)DmaRxBuffer, ADC_CAPTURELEN);

		// 检查数据有效性
		int zero_count = 0;
		int nonzero_count = 0;
		for (int i = 0; i < 20; i++)
		{
			if (DmaRxBuffer[i] == 0)
				zero_count++;
			else
				nonzero_count++;
		}

		xil_printf("[数据] 检查前20字节: 零值:%d 非零值:%d\r\n", zero_count, nonzero_count);
		xil_printf("[数据] 内容: %02X %02X %02X %02X %02X %02X %02X %02X\r\n",
				   DmaRxBuffer[0], DmaRxBuffer[1], DmaRxBuffer[2], DmaRxBuffer[3],
				   DmaRxBuffer[4], DmaRxBuffer[5], DmaRxBuffer[6], DmaRxBuffer[7]);

		if (nonzero_count > 0)
		{
			xil_printf("[数据] 检测到有效ADC数据!\r\n");
		}
		else
		{
			xil_printf("[数据] 警告: ADC数据全零，检查AD9280时钟和配置!\r\n");
		}

		s2mm_flag = 1;
	}
}

// 添加时钟域转换的考虑
// AD9280使用32MHz时钟，DMA使用142MHz时钟
// 这可能需要时钟域同步机制

/* ------------------------------------------------------------ */
/*					可能的问题分析								*/
/* ------------------------------------------------------------ */
/*
 * 从design.v可以看到AD9280模块连接：
 * - adc_clk: 32.258MHz (FCLK_CLK2) - 用于ADC采样
 * - m00_axis_aclk: 142MHz (FCLK_CLK1) - 用于AXIS输出
 * - s00_axi_aclk: 100MHz (FCLK_CLK0) - 用于寄存器控制
 *
 * 可能的问题：
 * 1. AD9280内部时钟域同步问题
 * 2. 外部ADC时钟(adc_clk)没有正确输出到AD9280芯片
 * 3. AD9280需要特定的使能序列
 * 4. AXIS接口的TLAST信号生成逻辑问题
 */

/*
 * 简化的AD9280测试函数
 * 尝试最小配置来触发AXIS数据输出
 */
void ad9280_simple_test(void)
{
	xil_printf("\r\n[简化测试] 开始AD9280最小配置测试...\r\n");

	// 最小配置测试
	u32 base_addr = AD9280_BASE;

	// 复位所有寄存器
	AD9280_SAMPLE_mWriteReg(base_addr, 0, 0);
	AD9280_SAMPLE_mWriteReg(base_addr, 4, 0);
	AD9280_SAMPLE_mWriteReg(base_addr, 8, 0);
	AD9280_SAMPLE_mWriteReg(base_addr, 12, 0);
	usleep(10000);

	// 设置最小长度
	AD9280_SAMPLE_mWriteReg(base_addr, 4, 64); // 最小64字节
	xil_printf("[简化测试] 设置长度64字节\r\n");

	// *** 关键修复：确保start_clr信号正确处理 ***
	xil_printf("[关键修复] 开始start_clr信号测试...\r\n");

	// 启动并监控start_clr反馈
	AD9280_SAMPLE_mWriteReg(base_addr, 0, 1); // 启动
	xil_printf("[关键修复] 发送启动信号\r\n");

	// 等待start_clr信号，然后手动生成ack
	for (int i = 0; i < 50; i++)
	{
		usleep(1000); // 1ms
		u32 reg0 = AD9280_SAMPLE_mReadReg(base_addr, 0);
		u32 reg2 = AD9280_SAMPLE_mReadReg(base_addr, 8);

		if (i % 10 == 0)
		{
			xil_printf("[关键修复] %dms: REG0=0x%08X REG2=0x%08X\r\n", i, reg0, reg2);
		}

		// 检查是否有DMA活动
		u32 dma_sr = XAxiDma_ReadReg(AxiDma.RegBase, XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);
		if (dma_sr != 0)
		{
			xil_printf("[关键修复] *** DMA状态变化: 0x%08X (第%dms) ***\r\n", dma_sr, i);

			// 手动处理DMA完成
			if (dma_sr & 0x1000)
			{ // IOC中断挂起
				xil_printf("[手动处理] 检测到DMA传输完成，手动处理中断\r\n");

				// 清除中断标志
				XAxiDma_IntrAckIrq(&AxiDma, XAXIDMA_IRQ_IOC_MASK, XAXIDMA_DEVICE_TO_DMA);
				xil_printf("[手动处理] DMA中断标志已清除\r\n");

				// 使数据缓存无效
				Xil_DCacheInvalidateRange((INTPTR)DmaRxBuffer, 64);

				// 检查接收到的数据
				xil_printf("[数据检查] 接收到的前16字节数据:\r\n");
				for (int j = 0; j < 16; j++)
				{
					xil_printf("%02X ", DmaRxBuffer[j]);
					if ((j + 1) % 8 == 0)
						xil_printf("\r\n");
				}

				// 检查数据有效性
				int nonzero_count = 0;
				for (int j = 0; j < 64; j++)
				{
					if (DmaRxBuffer[j] != 0)
						nonzero_count++;
				}
				xil_printf("[数据检查] 64字节中非零数据: %d个\r\n", nonzero_count);

				if (nonzero_count > 0)
				{
					xil_printf("[成功] *** AD9280数据传输成功! ***\r\n");
					// 设置标志并返回主循环
					s2mm_flag = 1;
					return;
				}
				else
				{
					xil_printf("[警告] 数据全为零，可能是ADC输入问题\r\n");
				}
			}

			return;
		}
	}

	// 尝试不同的使能组合
	u32 enable_configs[] = {0x1, 0x3, 0x7, 0xF, 0x10, 0x20, 0x80, 0xFF};
	int config_count = sizeof(enable_configs) / sizeof(u32);

	for (int i = 0; i < config_count; i++)
	{
		// 配置REG2
		AD9280_SAMPLE_mWriteReg(base_addr, 8, enable_configs[i]);
		usleep(1000);

		// 启动
		AD9280_SAMPLE_mWriteReg(base_addr, 0, 1);
		usleep(5000);

		// 检查状态
		u32 reg2_status = AD9280_SAMPLE_mReadReg(base_addr, 8);
		u32 dma_sr = XAxiDma_ReadReg(AxiDma.RegBase, XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);

		xil_printf("[简化测试] 配置0x%02X: REG2=0x%08X, DMA=0x%08X\r\n",
				   enable_configs[i], reg2_status, dma_sr);

		if (dma_sr != 0)
		{
			xil_printf("[简化测试] *** 发现DMA响应! ***\r\n");
			return;
		}
	}
	xil_printf("[简化测试] 所有配置均无DMA响应\r\n");
	xil_printf("[关键问题] start_clr_ack反馈机制可能有问题\r\n");
	xil_printf("[关键问题] AD9280状态机可能卡在S_SAMP_WAIT状态\r\n");
}
