/* ------------------------------------------------------------ */
/*				示波器文字显示模块 - 实现					*/
/* ------------------------------------------------------------ */

#include "oscilloscope_text.h"
#include "hdmi_font_16x8.h"
#include "wave.h"
#include <string.h>
#include <stdio.h>
#include <math.h>

/**
 * 获取字符在字体数组中的索引
 */
static int get_char_index(char c) {
    return hdmi_get_char_index_16x8(c);
}

/**
 * 根据颜色获取RGB值
 */
static void get_color_rgb(u8 color, u8 *r, u8 *g, u8 *b) {
    switch (color) {
        case TEXT_COLOR_WHITE:
            *r = 255; *g = 255; *b = 255;
            break;
        case TEXT_COLOR_YELLOW:
            *r = 255; *g = 255; *b = 0;
            break;
        case TEXT_COLOR_CYAN:
            *r = 0; *g = 255; *b = 255;
            break;
        case TEXT_COLOR_GREEN:
            *r = 0; *g = 255; *b = 0;
            break;        case TEXT_COLOR_RED:
            *r = 255; *g = 0; *b = 0;
            break;
        case TEXT_COLOR_BLUE:
            *r = 0; *g = 0; *b = 255;
            break;
        default:
            *r = 255; *g = 255; *b = 255;
            break;
    }
}

/**
 * 在指定位置绘制单个字符
 */
void draw_char(u8 *canvas, u32 canvas_width, u32 x, u32 y, char c, u8 color) {
    int char_index = get_char_index(c);
    u8 r, g, b;
    get_color_rgb(color, &r, &g, &b);    
    // 使用HDMI优化字库：行列式，逐行扫描，低位在左
    for (int row = 0; row < HDMI_FONT_HEIGHT_16X8; row++) {
        u8 line = hdmi_font_16x8[char_index][row];
        for (int col = 0; col < HDMI_FONT_WIDTH_16X8; col++) {
            // HDMI字库格式：bit0对应最左边像素，bit5对应最右边像素
            if (line & (0x01 << col)) {
                draw_point(canvas, x + col, y + row, canvas_width, b, g, r);
            }
        }
    }
}

/**
 * 在指定位置绘制字符串
 */
void draw_string(u8 *canvas, u32 canvas_width, u32 x, u32 y, const char *str, u8 color) {
    u32 current_x = x;
    
    while (*str) {
        draw_char(canvas, canvas_width, current_x, y, *str, color);
        current_x += HDMI_FONT_WIDTH_16X8;
        str++;
    }
}

/**
 * 绘制浮点数（改进版，正确处理负数）
 */
void draw_number_float(u8 *canvas, u32 canvas_width, u32 x, u32 y, float value, u8 decimals, u8 color) {
    char buffer[32];
    
    // 检查并处理异常值
    if (value != value) { // NaN检测
        strcpy(buffer, "NaN");
    } else if (value > 1e9 || value < -1e9) { // 溢出检测
        strcpy(buffer, "OVF");
    } else {
        // 根据小数位数格式化
        switch (decimals) {
            case 0:
                snprintf(buffer, sizeof(buffer), "%.0f", value);
                break;
            case 1:
                snprintf(buffer, sizeof(buffer), "%.1f", value);
                break;
            case 2:
                snprintf(buffer, sizeof(buffer), "%.2f", value);
                break;
            case 3:
                snprintf(buffer, sizeof(buffer), "%.3f", value);
                break;
            default:
                snprintf(buffer, sizeof(buffer), "%.2f", value); // 默认2位小数
                break;
        }
    }
    
    draw_string(canvas, canvas_width, x, y, buffer, color);
}

/**
 * 绘制整数
 */
void draw_number_int(u8 *canvas, u32 canvas_width, u32 x, u32 y, u32 value, u8 color) {
    char buffer[16];
    snprintf(buffer, sizeof(buffer), "%lu", (unsigned long)value);  // 修复格式警告
    draw_string(canvas, canvas_width, x, y, buffer, color);
}

/**
 * 绘制示波器信息面板
 */
void draw_oscilloscope_info(u8 *canvas, u32 canvas_width, u32 canvas_height, OscilloscopeParams *params) {
    u32 x = INFO_PANEL_X;
    u32 y = INFO_PANEL_Y;
    
    /* 绘制背景框 */
    // 可以选择绘制一个半透明的背景框
    
    /* 时基信息 */
    draw_string(canvas, canvas_width, x, y, "Time: ", TEXT_COLOR_CYAN);
    draw_number_float(canvas, canvas_width, x + 6*FONT_WIDTH, y, params->timebase_us, 1, TEXT_COLOR_WHITE);
    draw_string(canvas, canvas_width, x + 12*FONT_WIDTH, y, "μs/div", TEXT_COLOR_CYAN);
    y += LINE_SPACING;
    
    /* 电压档位 */
    draw_string(canvas, canvas_width, x, y, "Volt: ", TEXT_COLOR_CYAN);
    draw_number_float(canvas, canvas_width, x + 6*FONT_WIDTH, y, params->voltage_scale, 2, TEXT_COLOR_WHITE);
    draw_string(canvas, canvas_width, x + 12*FONT_WIDTH, y, "V/div", TEXT_COLOR_CYAN);
    y += LINE_SPACING;
    
    /* 频率 */
    draw_string(canvas, canvas_width, x, y, "Freq: ", TEXT_COLOR_CYAN);
    if (params->frequency_hz >= 1000000) {
        draw_number_float(canvas, canvas_width, x + 6*FONT_WIDTH, y, params->frequency_hz/1000000.0, 2, TEXT_COLOR_WHITE);
        draw_string(canvas, canvas_width, x + 12*FONT_WIDTH, y, "MHz", TEXT_COLOR_CYAN);
    } else if (params->frequency_hz >= 1000) {
        draw_number_float(canvas, canvas_width, x + 6*FONT_WIDTH, y, params->frequency_hz/1000.0, 1, TEXT_COLOR_WHITE);
        draw_string(canvas, canvas_width, x + 12*FONT_WIDTH, y, "kHz", TEXT_COLOR_CYAN);
    } else {
        draw_number_int(canvas, canvas_width, x + 6*FONT_WIDTH, y, (u32)params->frequency_hz, TEXT_COLOR_WHITE);
        draw_string(canvas, canvas_width, x + 12*FONT_WIDTH, y, "Hz", TEXT_COLOR_CYAN);
    }
    y += LINE_SPACING;
    
    /* 电压峰峰值 */
    draw_string(canvas, canvas_width, x, y, "Vpp: ", TEXT_COLOR_CYAN);
    draw_number_float(canvas, canvas_width, x + 5*FONT_WIDTH, y, params->voltage_pp, 2, TEXT_COLOR_WHITE);
    draw_string(canvas, canvas_width, x + 11*FONT_WIDTH, y, "V", TEXT_COLOR_CYAN);
    y += LINE_SPACING;
    
    /* 采样率 */
    draw_string(canvas, canvas_width, x, y, "Sample: ", TEXT_COLOR_CYAN);
    if (params->sample_rate >= 1000000) {
        draw_number_float(canvas, canvas_width, x + 8*FONT_WIDTH, y, params->sample_rate/1000000.0, 1, TEXT_COLOR_WHITE);
        draw_string(canvas, canvas_width, x + 14*FONT_WIDTH, y, "MHz", TEXT_COLOR_CYAN);
    } else if (params->sample_rate >= 1000) {
        draw_number_int(canvas, canvas_width, x + 8*FONT_WIDTH, y, params->sample_rate/1000, TEXT_COLOR_WHITE);
        draw_string(canvas, canvas_width, x + 14*FONT_WIDTH, y, "kHz", TEXT_COLOR_CYAN);
    } else {
        draw_number_int(canvas, canvas_width, x + 8*FONT_WIDTH, y, params->sample_rate, TEXT_COLOR_WHITE);
        draw_string(canvas, canvas_width, x + 14*FONT_WIDTH, y, "Hz", TEXT_COLOR_CYAN);
    }
}

/**
 * 绘制网格标签
 * 网格布局：1920x1080，主网格线间距120x108像素
 * 水平主线：10条（y = 0, 108, 216, 324, 432, 540, 648, 756, 864, 972）
 * 垂直主线：16条（x = 0, 120, 240, 360, 480, 600, 720, 840, 960, 1080, 1200, 1320, 1440, 1560, 1680, 1800）
 */
void draw_grid_labels(u8 *canvas, u32 canvas_width, u32 canvas_height, OscilloscopeParams *params) {
    
    /* 在屏幕底部显示时间刻度 */
    u32 time_labels_y = canvas_height - 30;
    u32 horizontal_grid_lines = 16; // 实际有16条垂直主网格线
    u32 grid_spacing_x = 120; // 水平网格间距120像素
    
    for (u32 i = 0; i <= horizontal_grid_lines; i++) {
        u32 x = i * grid_spacing_x; // 精确对应网格线位置
        
        // 计算时间值：中心线(第8条线)为0时间，左侧为负，右侧为正
        float time_value = ((float)i - 8.0) * params->timebase_us;
        
        // 绘制时间标签（每隔一条线显示标签，避免拥挤）
        if (i % 2 == 0 && x < canvas_width) {
            // 调整x坐标，让文字居中显示在网格线上
            u32 text_x = (x >= 2*FONT_WIDTH) ? (x - 2*FONT_WIDTH) : 0;
            draw_number_float(canvas, canvas_width, text_x, time_labels_y, time_value, 1, TEXT_COLOR_GREEN);
        }
    }
    
    /* 在屏幕右侧显示电压刻度 */
    u32 voltage_labels_x = canvas_width - 80;
    u32 vertical_grid_lines = 10; // 实际有10条水平主网格线
    u32 grid_spacing_y = 108; // 垂直网格间距108像素
    
    for (u32 i = 0; i <= vertical_grid_lines; i++) {
        u32 y = i * grid_spacing_y; // 精确对应网格线位置
        
        // 计算电压值：中心线(第5条线)为0V，上方为正，下方为负
        float voltage_value = (5.0 - (float)i) * params->voltage_scale;
        
        // 绘制电压标签（每隔一条线显示标签，避免拥挤）
        if (i % 2 == 0 && y < canvas_height) {
            // 调整y坐标，让文字垂直居中显示在网格线上
            u32 text_y = (y >= FONT_HEIGHT/2) ? (y - FONT_HEIGHT/2) : 0;
            draw_number_float(canvas, canvas_width, voltage_labels_x, text_y, voltage_value, 2, TEXT_COLOR_GREEN);
        }
    }
}

/**
 * 计算波形测量值
 */
void calculate_measurements(u8 *waveform_data, u32 length, OscilloscopeParams *params) {
    if (!waveform_data || length == 0) return;
    
    u8 min_val = 255, max_val = 0;
    u32 sum = 0;
    u32 zero_crossings = 0;
    u8 last_val = waveform_data[0];
    
    /* 计算最大值、最小值和平均值 */
    for (u32 i = 0; i < length; i++) {
        u8 val = waveform_data[i];
        if (val < min_val) min_val = val;
        if (val > max_val) max_val = val;
        sum += val;
        
        /* 检测过零点（用于频率计算） */
        if (i > 0) {
            u8 avg = (min_val + max_val) / 2;
            if ((last_val < avg && val >= avg) || (last_val > avg && val <= avg)) {
                zero_crossings++;
            }
        }
        last_val = val;
    }
    
    /* 使用正确的ADC转换关系计算电压值 */
    float min_voltage = ADC_CODE_TO_INPUT_VOLTAGE(min_val);
    float max_voltage = ADC_CODE_TO_INPUT_VOLTAGE(max_val);
    
    /* 计算电压峰峰值 */
    params->voltage_pp = max_voltage - min_voltage;
    
    /* 估算频率 */
    if (zero_crossings > 2) {
        float period_samples = (float)(length * 2) / zero_crossings;
        params->frequency_hz = params->sample_rate / period_samples;
    } else {
        params->frequency_hz = 0; // 无法测量频率
    }
}
