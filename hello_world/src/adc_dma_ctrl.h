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
#define S2MM_INTR_ID       XPAR_FABRIC_AXI_DMA_0_INTR

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
 *波形定义
 */
#define WAVE_LEN            1920*400*3     /* 波形总长度（字节） */
#define WAVE_START_ROW      100            /* 网格和波形在帧中的起始行 */
#define WAVE_START_COLUMN   0              /* 网格和波形在帧中的起始列 */
#define WAVE_HEIGHT         400   		   /* 网格和波形高度（增大以便观察） */
/*
 *函数定义
 */
int XAxiDma_Adc_Wave(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr);


