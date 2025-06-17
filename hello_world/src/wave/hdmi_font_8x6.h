/* ------------------------------------------------------------ */
/*           HDMI优化字库 - 从STM32 ascii_8x6转换而来            */
/* ------------------------------------------------------------ */

#ifndef HDMI_FONT_8X6_H
#define HDMI_FONT_8X6_H

#include "xil_types.h"

/* 字库参数定义 */
#define HDMI_FONT_WIDTH  6    /* 字符宽度（像素） */
#define HDMI_FONT_HEIGHT 8    /* 字符高度（像素） */
#define HDMI_FONT_COUNT  104  /* 字符数量（ASCII 32-126 + 其他常用字符） */

/* 
 * HDMI优化8x6点阵字库
 * 格式：行列式，逐行扫描，低位在左
 * 每个字符8字节，每字节代表一行的6个像素
 * 字节中bit0对应最左边像素，bit5对应最右边像素
 * 
 * 从STM32 ascii_8x6（列行式，逐列扫描，低位在下）转换而来
 */
extern const u8 hdmi_font_8x6[][8];

/* ASCII字符映射表 */
extern const char hdmi_ascii_chars[];

/**
 * 获取字符在字库中的索引
 * @param c 要查找的字符
 * @return 字符索引，未找到返回0（空格）
 */
int hdmi_get_char_index(char c);

#endif /* HDMI_FONT_8X6_H */
