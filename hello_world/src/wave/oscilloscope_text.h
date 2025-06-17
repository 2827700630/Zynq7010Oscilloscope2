/* ------------------------------------------------------------ */
/*				示波器文字显示模块 - 头文件					*/
/* ------------------------------------------------------------ */

#ifndef OSCILLOSCOPE_TEXT_H
#define OSCILLOSCOPE_TEXT_H

#include "xil_types.h"

/* 字体大小定义 */
#define FONT_WIDTH  6    /* 字符宽度（像素） - 使用HDMI优化字库 */
#define FONT_HEIGHT 8    /* 字符高度（像素） - 使用HDMI优化字库 */

/* 文字颜色定义 */
#define TEXT_COLOR_WHITE   0
#define TEXT_COLOR_YELLOW  1
#define TEXT_COLOR_CYAN    2
#define TEXT_COLOR_GREEN   3
#define TEXT_COLOR_RED     4
#define TEXT_COLOR_BLUE    5  // 新增蓝色定义

/* 显示位置定义 */
#define INFO_PANEL_X     50    /* 信息面板起始X坐标 */
#define INFO_PANEL_Y     50    /* 信息面板起始Y坐标 */
#define LINE_SPACING     20    /* 行间距 */

/* ADC转换参数定义 */
#define ADC_REFERENCE_VOLTAGE  2.0f   /* ADC参考电压 2V (0~2V输入范围) */
#define ADC_BITS               8      /* ADC位数 */
#define ADC_MAX_CODE          255     /* ADC最大码值 */

/* 根据您的转换关系：VAD = (1/5)VIN + 1 
 * 即：VIN = 5*(VAD - 1)
 * 当VAD=2V时，VIN=5V；当VAD=0V时，VIN=-5V
 * 输入电压范围：-5V ~ +5V (10Vpp)
 */
#define INPUT_VOLTAGE_OFFSET  1.0f    /* ADC偏移电压 1V */
#define INPUT_VOLTAGE_GAIN    5.0f    /* 输入电压增益系数 */

/* 电压转换宏 */
#define ADC_CODE_TO_INPUT_VOLTAGE(code) \
    (INPUT_VOLTAGE_GAIN * (((float)(code) * ADC_REFERENCE_VOLTAGE / ADC_MAX_CODE) - INPUT_VOLTAGE_OFFSET))

/* 示波器参数结构体 */
typedef struct {
    float timebase_us;      /* 时基 (微秒/格) */
    float voltage_pp;       /* 电压峰峰值 (V) */
    float frequency_hz;     /* 频率 (Hz) */
    float voltage_scale;    /* 电压档位 (V/格) */
    u32 sample_rate;        /* 采样率 (Hz) */
    u32 trigger_level;      /* 触发电平 */
    u8 trigger_mode;        /* 触发模式 */
} OscilloscopeParams;

/* 函数声明 */
void draw_char(u8 *canvas, u32 canvas_width, u32 x, u32 y, char c, u8 color);
void draw_string(u8 *canvas, u32 canvas_width, u32 x, u32 y, const char *str, u8 color);
void draw_number_float(u8 *canvas, u32 canvas_width, u32 x, u32 y, float value, u8 decimals, u8 color);
void draw_number_int(u8 *canvas, u32 canvas_width, u32 x, u32 y, u32 value, u8 color);
void draw_oscilloscope_info(u8 *canvas, u32 canvas_width, u32 canvas_height, OscilloscopeParams *params);
void draw_grid_labels(u8 *canvas, u32 canvas_width, u32 canvas_height, OscilloscopeParams *params);
void calculate_measurements(u8 *waveform_data, u32 length, OscilloscopeParams *params);

#endif /* OSCILLOSCOPE_TEXT_H */
