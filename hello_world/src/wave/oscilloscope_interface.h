/* ------------------------------------------------------------ */
/*			示波器界面完整演示程序 - 头文件					*/
/* ------------------------------------------------------------ */

#ifndef OSCILLOSCOPE_INTERFACE_H
#define OSCILLOSCOPE_INTERFACE_H

#include "oscilloscope_text.h"

/* 函数声明 */
void draw_complete_oscilloscope_interface(u8 *canvas, u32 canvas_width, u32 canvas_height, 
                                        u8 *waveform_data, u32 waveform_length, 
                                        OscilloscopeParams *params);

void draw_cursor_measurements(u8 *canvas, u32 canvas_width, u32 canvas_height, 
                            u32 cursor1_x, u32 cursor2_x, OscilloscopeParams *params);

void draw_waveform_statistics(u8 *canvas, u32 canvas_width, u32 canvas_height, 
                            u8 *waveform_data, u32 waveform_length, OscilloscopeParams *params);

#endif /* OSCILLOSCOPE_INTERFACE_H */
