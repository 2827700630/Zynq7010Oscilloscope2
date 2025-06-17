/* ------------------------------------------------------------ */
/*           HDMI优化字库16x8 - 从STM32 ascii_16x8转换而来       */
/* ------------------------------------------------------------ */

#ifndef HDMI_FONT_16X8_H
#define HDMI_FONT_16X8_H

#include "xil_types.h"

/* 字库参数定义 */
#define HDMI_FONT_WIDTH_16X8   8    /* 字符宽度（像素） */
#define HDMI_FONT_HEIGHT_16X8  16   /* 字符高度（像素） */
#define HDMI_FONT_COUNT_16X8   95   /* 字符数量（ASCII 32-126） */

/* 
 * HDMI优化16x8点阵字库
 * 格式：行列式，逐行扫描，低位在左
 * 每个字符16字节，每字节代表一行的8个像素
 * 字节中bit0对应最左边像素，bit7对应最右边像素
 * 
 * 从STM32 ascii_16x8（列行式，逐列扫描，低位在下）转换而来
 */
extern const u8 hdmi_font_16x8[][16];

/* ASCII字符映射表 */
extern const char hdmi_ascii_chars_16x8[];

/**
 * 获取字符在字库中的索引
 * @param c 要查找的字符
 * @return 字符索引，未找到返回0（空格）
 */
int hdmi_get_char_index_16x8(char c);

#endif /* HDMI_FONT_16X8_H */