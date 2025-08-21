/* ------------------------------------------------------------ */
/*			示波器界面绘制模块								*/
/* ------------------------------------------------------------ */

#include "oscilloscope_interface.h"
#include "oscilloscope_text.h"
#include "wave.h"
#include <math.h>

/**
 * 绘制完整的示波器界面
 */
void draw_complete_oscilloscope_interface(u8 *canvas, u32 canvas_width, u32 canvas_height,
                                          u8 *waveform_data, u32 waveform_length,
                                          OscilloscopeParams *params)
{
    // 1. 清空画布（黑色背景）
    for (u32 i = 0; i < canvas_width * canvas_height * 3; i++)
    {
        canvas[i] = 0;
    }

    // 2. 绘制网格
    draw_grid(canvas_width, canvas_height, canvas);

    // 3. 绘制波形数据
    if (waveform_data != NULL && waveform_length > 0)
    {
        // 使用wave.c中的draw_wave函数绘制波形
        draw_wave(canvas_width, canvas_height, waveform_data, canvas,
                  UNSIGNEDCHAR, 8, 0, 1); // 黄色波形
    }

    // 4. 绘制示波器信息面板
    if (params != NULL)
    {
        draw_oscilloscope_info(canvas, canvas_width, canvas_height, params);
    }

    // 5. 绘制网格标签
    if (params != NULL)
    {
        draw_grid_labels(canvas, canvas_width, canvas_height, params);
    }
}

/**
 * 绘制光标测量线（可选功能）
 */
void draw_cursor_measurements(u8 *canvas, u32 canvas_width, u32 canvas_height,
                              u32 cursor1_x, u32 cursor2_x, OscilloscopeParams *params)
{

    /* 绘制垂直光标线 */
    for (u32 y = 0; y < canvas_height; y++)
    { // 光标1 - 黄色虚线
        if (y % 4 < 2)
        {
            draw_point(canvas, cursor1_x, y, canvas_width, 0, 255, 255); // 黄色 (B,G,R)
        }

        // 光标2 - 青色虚线
        if (y % 4 < 2)
        {
            draw_point(canvas, cursor2_x, y, canvas_width, 255, 255, 0); // 青色 (B,G,R)
        }
    }

    /* 计算和显示光标间的时间差 */
    float time_diff = fabs((float)(cursor2_x - cursor1_x)) * params->timebase_us / (canvas_width / 10.0);

    u32 cursor_info_x = 10;
    u32 cursor_info_y = canvas_height - 80;

    draw_string(canvas, canvas_width, cursor_info_x, cursor_info_y, "ΔT: ", TEXT_COLOR_CYAN);
    draw_number_float(canvas, canvas_width, cursor_info_x + 4 * FONT_WIDTH, cursor_info_y, time_diff, 2, TEXT_COLOR_WHITE);
    draw_string(canvas, canvas_width, cursor_info_x + 10 * FONT_WIDTH, cursor_info_y, "μs", TEXT_COLOR_CYAN);

    cursor_info_y += LINE_SPACING;

    /* 频率计算 */
    if (time_diff > 0)
    {
        float freq = 1000000.0 / time_diff;
        draw_string(canvas, canvas_width, cursor_info_x, cursor_info_y, "1/ΔT: ", TEXT_COLOR_CYAN);
        if (freq >= 1000000)
        {
            draw_number_float(canvas, canvas_width, cursor_info_x + 6 * FONT_WIDTH, cursor_info_y, freq / 1000000, 2, TEXT_COLOR_WHITE);
            draw_string(canvas, canvas_width, cursor_info_x + 12 * FONT_WIDTH, cursor_info_y, "MHz", TEXT_COLOR_CYAN);
        }
        else if (freq >= 1000)
        {
            draw_number_float(canvas, canvas_width, cursor_info_x + 6 * FONT_WIDTH, cursor_info_y, freq / 1000, 1, TEXT_COLOR_WHITE);
            draw_string(canvas, canvas_width, cursor_info_x + 12 * FONT_WIDTH, cursor_info_y, "kHz", TEXT_COLOR_CYAN);
        }
        else
        {
            draw_number_int(canvas, canvas_width, cursor_info_x + 6 * FONT_WIDTH, cursor_info_y, (u32)freq, TEXT_COLOR_WHITE);
            draw_string(canvas, canvas_width, cursor_info_x + 12 * FONT_WIDTH, cursor_info_y, "Hz", TEXT_COLOR_CYAN);
        }
    }
}

/**
 * 绘制波形统计信息
 */
void draw_waveform_statistics(u8 *canvas, u32 canvas_width, u32 canvas_height,
                              u8 *waveform_data, u32 waveform_length, OscilloscopeParams *params)
{

    if (!waveform_data || waveform_length == 0)
        return;

    u32 stats_x = 400;
    u32 stats_y = 50;

    draw_string(canvas, canvas_width, stats_x, stats_y, "STATISTICS", TEXT_COLOR_CYAN);
    stats_y += LINE_SPACING;

    /* 计算统计值 */
    u8 min_val = 255, max_val = 0;
    u32 sum = 0;

    for (u32 i = 0; i < waveform_length; i++)
    {
        u8 val = waveform_data[i];
        if (val < min_val)
            min_val = val;
        if (val > max_val)
            max_val = val;
        sum += val;
    }

    float avg_val = (float)sum / waveform_length;

    /* 转换为电压值 */
    float min_voltage = (min_val * params->voltage_scale * 8) / 255.0 - (params->voltage_scale * 4);
    float max_voltage = (max_val * params->voltage_scale * 8) / 255.0 - (params->voltage_scale * 4);
    float avg_voltage = (avg_val * params->voltage_scale * 8) / 255.0 - (params->voltage_scale * 4);

    /* 显示统计信息 */
    draw_string(canvas, canvas_width, stats_x, stats_y, "Max: ", TEXT_COLOR_WHITE);
    draw_number_float(canvas, canvas_width, stats_x + 5 * FONT_WIDTH, stats_y, max_voltage, 3, TEXT_COLOR_RED);
    draw_string(canvas, canvas_width, stats_x + 12 * FONT_WIDTH, stats_y, "V", TEXT_COLOR_WHITE);
    stats_y += LINE_SPACING;

    draw_string(canvas, canvas_width, stats_x, stats_y, "Min: ", TEXT_COLOR_WHITE);
    draw_number_float(canvas, canvas_width, stats_x + 5 * FONT_WIDTH, stats_y, min_voltage, 3, TEXT_COLOR_BLUE);
    draw_string(canvas, canvas_width, stats_x + 12 * FONT_WIDTH, stats_y, "V", TEXT_COLOR_WHITE);
    stats_y += LINE_SPACING;

    draw_string(canvas, canvas_width, stats_x, stats_y, "Avg: ", TEXT_COLOR_WHITE);
    draw_number_float(canvas, canvas_width, stats_x + 5 * FONT_WIDTH, stats_y, avg_voltage, 3, TEXT_COLOR_GREEN);
    draw_string(canvas, canvas_width, stats_x + 12 * FONT_WIDTH, stats_y, "V", TEXT_COLOR_WHITE);
}
