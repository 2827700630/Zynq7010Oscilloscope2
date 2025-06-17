/* ------------------------------------------------------------ */
/*           HDMI优化字库 - 从STM32 ascii_24x12转换而来          */
/* ------------------------------------------------------------ */

#ifndef HDMI_FONT_24X12_H
#define HDMI_FONT_24X12_H

#include "xil_types.h"

/* 字库参数定义 */
#define HDMI_FONT_WIDTH  12   /* 字符宽度（像素） */
#define HDMI_FONT_HEIGHT 24   /* 字符高度（像素） */
#define HDMI_FONT_COUNT  104  /* 字符数量（ASCII 32-126 + 其他常用字符） */

/* 
 * HDMI优化24x12点阵字库
 * 格式：行列式，逐行扫描，低位在左
 * 每个字符24字节，每字节代表一行的前8个像素，另需4位表示后4个像素
 * 为简化处理，使用24*2=48字节，前12位有效，后4位填0
 * 字节中bit0对应最左边像素，bit11对应最右边像素
 * 
 * 从STM32 ascii_24x12（列行式，逐列扫描，低位在下）转换而来
 */
extern const u16 hdmi_font_24x12[][24];

// Declaration of the character count
extern const unsigned int hdmi_font_char_count;

/**
 * 获取字符在字库中的索引
 * @param c 要查找的字符
 * @return 字符索引，未找到返回0（空格）
 */
int hdmi_get_char_index(char c);

#endif /* HDMI_FONT_24X12_H */
