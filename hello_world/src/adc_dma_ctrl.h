/* ------------------------------------------------------------ */
/*				头文件包含定义								*/
/* ------------------------------------------------------------ */

#include "math.h"
#include "xscugic.h"
#include "ad9280_sample.h"
#include "xaxidma.h"
#include "sleep.h"
#include "xparameters.h"
/*
 *DMA 重定义
 */
#define MAX_DMA_LEN		   0x800000      /* DMA最大长度（字节） */
#define DMA_DEV_ID		   0
/* 中断ID计算：ZYNQ IRQ_F2P基址 + xlconcat端口偏移 */
#define ZYNQ_IRQ_F2P_BASE_ID   61              /* ZYNQ Fabric-to-PS中断基础ID */
#define DMA_XLCONCAT_PORT      2               /* DMA连接在xlconcat的In2端口 */
#define S2MM_INTR_ID           (ZYNQ_IRQ_F2P_BASE_ID + DMA_XLCONCAT_PORT)  /* 61+2=63 */

/* 设备ID兼容性定义 - 如果xparameters.h中缺失 */
#ifndef XPAR_XAXIDMA_0_DEVICE_ID
#define XPAR_XAXIDMA_0_DEVICE_ID        0
#endif

#ifndef XPAR_XSCUGIC_0_DEVICE_ID  
#define XPAR_XSCUGIC_0_DEVICE_ID        0
#endif
/*
 *ADC 定义
 */
#define AD9280_BASE        XPAR_AD9280_SAMPLE_0_BASEADDR
#define AD9280_START       AD9280_SAMPLE_S00_AXI_SLV_REG0_OFFSET
#define AD9280_LENGTH      AD9280_SAMPLE_S00_AXI_SLV_REG1_OFFSET
#define ADC_CAPTURELEN     1920           /* ADC采集长度 */
#define ADC_COE            1              /* ADC系数 */
#define ADC_BYTE           1              /* ADC数据字节数 */
#define ADC_BITS           8
/*
 *波形定义 - 全屏显示优化
 */
#define WAVE_LEN            1920*1080*3    /* 波形总长度（字节）- 占满全屏 */
#define WAVE_START_ROW      0              /* 网格和波形在帧中的起始行 - 从顶部开始 */
#define WAVE_START_COLUMN   0              /* 网格和波形在帧中的起始列 - 从左边开始 */
#define WAVE_HEIGHT         1080   		   /* 网格和波形高度 - 占满全屏高度 */
/*
 *函数定义
 */
int XAxiDma_Adc_Wave(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr);
int XAxiDma_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr);

/*
 *全局变量声明
 */
extern volatile int s2mm_flag;
extern volatile int dma_done;


