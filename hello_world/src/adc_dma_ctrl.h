#ifndef ADC_DMA_CTRL_H
#define ADC_DMA_CTRL_H

/* ------------------------------------------------------------ */
/*				头文件包含定义								*/
/* ------------------------------------------------------------ */

#include "math.h"
#include "xscugic.h"
#include "ad9280_scop.h"      // 修改：使用新的IP核驱动
#include "xaxidma.h"
#include "sleep.h"
#include "xparameters.h"

/************************** 兼容性定义 *****************************/
/* 为了保持与旧代码的兼容性，将旧的函数名和寄存器名映射到新的IP核 */

// 函数名称兼容性映射
#define AD9280_SCOPE_ADC_mWriteReg(BaseAddress, RegOffset, Data) \
    AD9280_SCOP_mWriteReg(BaseAddress, RegOffset, Data)

#define AD9280_SCOPE_ADC_mReadReg(BaseAddress, RegOffset) \
    AD9280_SCOP_mReadReg(BaseAddress, RegOffset)

// 寄存器名称兼容性映射 (旧名称 -> 新名称)
#define AD9280_CONTROL_REG           AD9280_SCOP_S00_AXI_SLV_REG0_OFFSET   // 0x00
#define AD9280_STATUS_REG            AD9280_SCOP_S00_AXI_SLV_REG1_OFFSET   // 0x04
#define AD9280_TRIGGER_CONFIG        AD9280_SCOP_S00_AXI_SLV_REG2_OFFSET   // 0x08
#define AD9280_TRIGGER_LEVEL         AD9280_SCOP_S00_AXI_SLV_REG3_OFFSET   // 0x0C
#define AD9280_SAMPLE_DEPTH          AD9280_SCOP_S00_AXI_SLV_REG4_OFFSET   // 0x10
#define AD9280_DECIMATION_CONFIG     AD9280_SCOP_S00_AXI_SLV_REG5_OFFSET   // 0x14
#define AD9280_TIMEBASE_CONFIG       AD9280_SCOP_S00_AXI_SLV_REG6_OFFSET   // 0x18
#define AD9280_RESERVED_REG          AD9280_SCOP_S00_AXI_SLV_REG7_OFFSET   // 0x1C

/*
 *DMA 重定义
 */
#define MAX_DMA_LEN 0x800000 /* DMA最大长度（字节） */
#define DMA_DEV_ID 0
/* 中断ID计算：ZYNQ IRQ_F2P基址 + xlconcat端口偏移 */
#define ZYNQ_IRQ_F2P_BASE_ID 61                                 /* ZYNQ Fabric-to-PS中断基础ID */
#define DMA_XLCONCAT_PORT 2                                     /* DMA连接在xlconcat的In2端口 */
// #define S2MM_INTR_ID (ZYNQ_IRQ_F2P_BASE_ID + DMA_XLCONCAT_PORT) /* 61+2=63 */
#define S2MM_INTR_ID 31

/* 设备ID兼容性定义 - 如果xparameters.h中缺失 */
#ifndef XPAR_XAXIDMA_0_DEVICE_ID
#define XPAR_XAXIDMA_0_DEVICE_ID 0
#endif

#ifndef XPAR_XSCUGIC_0_DEVICE_ID
#define XPAR_XSCUGIC_0_DEVICE_ID 0
#endif

/*
 * AD9280 Scope ADC 定义 - 适配新的IP核
 */
#define AD9280_BASE XPAR_AD9280_SCOP_0_BASEADDR  // 修改：使用新的IP核基地址

// 控制寄存器位定义
#define ADC_CTRL_SAMPLING_EN    (1 << 0)   // 采样使能
#define ADC_CTRL_TRIGGER_EN     (1 << 1)   // 触发使能
#define ADC_CTRL_TRIGGER_MODE_SHIFT  2      // 触发模式位位置
#define ADC_CTRL_TRIGGER_MODE_MASK   0x3    // 触发模式掩码
#define ADC_CTRL_TRIGGER_EDGE   (1 << 4)   // 触发边沿选择
#define ADC_CTRL_SOFTWARE_TRIG  (1 << 8)   // 软件触发

// 触发模式定义
#define TRIGGER_MODE_AUTO       0   // 自动触发
#define TRIGGER_MODE_NORMAL     1   // 普通触发
#define TRIGGER_MODE_SINGLE     2   // 单次触发
#define TRIGGER_MODE_EXTERNAL   3   // 外部触发

// 状态寄存器位定义 - 根据IP核源码修正
// 从IP核源码 ad9280_scop.v 第169-175行的定义：
// status_reg = {
//     core_sample_count,          // [31:16] Sample count
//     6'h0,                       // [15:10] Reserved  
//     core_acquisition_complete,  // [9]     Acquisition complete
//     core_trigger_detected,      // [8]     Trigger detected
//     core_fifo_full,            // [7]     FIFO full
//     core_fifo_empty,           // [6]     FIFO empty
//     core_sampling_active,      // [5]     Sampling active ← 关键！
//     5'h0                       // [4:0]   Reserved
// };

#define ADC_STATUS_SAMPLING_ACTIVE    (1 << 5)   // bit[5] - 采样活动状态 ✓
#define ADC_STATUS_FIFO_EMPTY         (1 << 6)   // bit[6] - FIFO空状态 ✓
#define ADC_STATUS_FIFO_FULL          (1 << 7)   // bit[7] - FIFO满状态 ✓
#define ADC_STATUS_TRIGGER_DETECTED   (1 << 8)   // bit[8] - 触发检测状态 ✓
#define ADC_STATUS_ACQUISITION_COMPLETE (1 << 9) // bit[9] - 采集完成状态 ✓

// 兼容性别名：数据就绪状态 = FIFO非空状态
#define ADC_STATUS_DATA_READY         ADC_STATUS_FIFO_FULL // 使用FIFO满作为数据就绪的指示

// 高位状态（样本计数）
#define ADC_STATUS_SAMPLE_COUNT_MASK  0xFFFF0000  // bit[31:16] - 样本计数

// IP核版本信息定义 (REG7 - 0x1C)
#define IP_VERSION_REG_OFFSET         AD9280_RESERVED_REG
#define IP_VERSION_MAJOR_MASK         0xFF000000  // bit[31:24] - 主版本号
#define IP_VERSION_MINOR_MASK         0x00FF0000  // bit[23:16] - 次版本号  
#define IP_VERSION_PATCH_MASK         0x0000FF00  // bit[15:8]  - 补丁版本号
#define IP_VERSION_BUILD_MASK         0x000000FF  // bit[7:0]   - 构建版本号

#define IP_VERSION_MAJOR_SHIFT        24
#define IP_VERSION_MINOR_SHIFT        16
#define IP_VERSION_PATCH_SHIFT        8
#define IP_VERSION_BUILD_SHIFT        0

// 期望的IP核版本定义
#define EXPECTED_IP_VERSION_MAJOR     2   // ad9280_scop_2.x
#define EXPECTED_IP_VERSION_MINOR     4   // 升级版本
#define EXPECTED_IP_VERSION_PATCH     0   // 补丁版本
#define EXPECTED_IP_VERSION_BUILD     1   // 构建编号

#define ADC_CAPTURELEN 1920 /* ADC采集长度 */
#define ADC_COE 1           /* ADC系数 */
#define ADC_BYTE 1          /* ADC数据字节数 - 新IP核仍然是8位输出 */
#define ADC_BITS 8
#define ADC_DEFAULT_TRIGGER_LEVEL 128  /* 默认触发电平（中间值） */
/*
 *波形定义 - 全屏显示优化
 */
#define WAVE_LEN 1920 * 1080 * 3 /* 波形总长度（字节）- 占满全屏 */
#define WAVE_START_ROW 0         /* 网格和波形在帧中的起始行 - 从顶部开始 */
#define WAVE_START_COLUMN 0      /* 网格和波形在帧中的起始列 - 从左边开始 */
#define WAVE_HEIGHT 1080         /* 网格和波形高度 - 占满全屏高度 */
/*
 * 函数定义 - 包含新IP核的高级功能
 */
int XAxiDma_Adc_Init(u32 width, u8 *frame, u32 stride, XScuGic *InstancePtr);
int XAxiDma_Adc_Update(u32 width, u8 *frame, u32 stride);
int XAxiDma_Initial(u16 DeviceId, u16 IntrID, XAxiDma *XAxiDma, XScuGic *InstancePtr);

// 新增：AD9280 Scope ADC 高级功能函数
void ad9280_sample(u32 adc_addr, u32 adc_len);  // 已修改为连续采集模式
void ad9280_configure_trigger(u32 adc_addr, u8 trigger_mode, u8 trigger_level, u8 trigger_edge);
void ad9280_software_trigger(u32 adc_addr);
void ad9280_advanced_sample(u32 adc_addr, u32 adc_len, u8 trigger_mode, u8 trigger_level);

// ADC状态结构体
typedef struct {
	u8 sampling_active;
	u8 fifo_empty;
	u8 fifo_full;
	u8 trigger_detected;
	u8 acquisition_complete;
	u16 sample_count;
} adc_status_t;

adc_status_t ad9280_get_status(u32 adc_addr);

// 新增：ADC调试和诊断函数
void ad9280_debug_registers(u32 adc_addr);
void ad9280_reset_and_init(u32 adc_addr);
int ad9280_comprehensive_init(u32 adc_addr, u32 sample_len);
void ad9280_force_data_output(u32 adc_addr);
void ad9280_check_axi_stream_status(u32 adc_addr);
void ad9280_manual_fifo_read_test(u32 adc_addr);

// 新增：IP核版本验证函数
typedef struct {
    u8 major;
    u8 minor;
    u8 patch;
    u8 build;
} ip_version_t;

ip_version_t ad9280_get_ip_version(u32 adc_addr);
int ad9280_verify_ip_version(u32 adc_addr);
void ad9280_print_ip_version(u32 adc_addr);

/*
 *全局变量声明
 */
extern volatile int s2mm_flag;
extern volatile int dma_done;

#endif /* ADC_DMA_CTRL_H */
