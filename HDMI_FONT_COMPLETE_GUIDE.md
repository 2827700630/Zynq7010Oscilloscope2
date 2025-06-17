# HDMI字体系统完整指南

## 概述
本文档是Zynq7010示波器项目中HDMI字体显示系统的完整技术指南，涵盖了从STM32字库转换、集成、问题修复到优化的全过程。

## 目录
1. [字体系统架构](#字体系统架构)
2. [STM32到HDMI字库转换](#STM32到HDMI字库转换)
3. [字库集成步骤](#字库集成步骤)
4. [显示问题修复](#显示问题修复)
5. [快速集成指南](#快速集成指南)
6. [技术参考](#技术参考)

---

## 字体系统架构

### HDMI显示缓冲区特点
- **内存布局**: 行优先(row-major)顺序
- **像素格式**: 24位RGB (每像素3字节)
- **扫描方式**: 逐行扫描，从左到右，从上到下
- **缓冲区大小**: 1920×1080×3 = 6,220,800字节

### 字库数据格式对比

#### STM32原始格式（列行式）
```c
// 16字节/字符，8像素宽×16像素高
// 低字节(0-7): 上半部分8行
// 高字节(8-15): 下半部分8行  
// 每字节内: bit7=顶部像素，bit0=底部像素
const u8 stm32_font[char_count][16];
```

#### HDMI最优格式（行列式）
```c
// 16字节/字符，8像素宽×16像素高
// 字节0-15: 第0-15行
// 每字节内: bit0=最左像素，bit7=最右像素
const u8 hdmi_font_16x8[][16];
```

### 字体规格对比

| 字体类型 | 尺寸 | 字符数 | 数据量 | 适用场景 |
|---------|------|--------|--------|---------|
| 8x6字体 | 6×8像素 | 95个 | 480字节 | 小尺寸显示，信息密集 |
| 16x8字体 | 8×16像素 | 95个 | 1520字节 | 标准显示，可读性好 |

---

## STM32到HDMI字库转换

### 转换算法原理

#### 数据结构分析
STM32字库采用**列行式**组织，适合逐列扫描的OLED显示器：
- **逐列扫描**: 先绘制第0列的16个像素，再绘制第1列...
- **位序排列**: 每字节内bit7在上，bit0在下

HDMI显示采用**行列式**组织，适合逐行扫描的显示器：
- **逐行扫描**: 先绘制第0行的8个像素，再绘制第1行...
- **位序排列**: 每字节内bit0在左，bit7在右

#### 转换步骤
```python
def convert_stm32_to_hdmi():
    for char_idx, stm32_char in enumerate(stm32_ascii_16x8):
        hdmi_char = []
        
        # 处理16行
        for row in range(16):
            hdmi_row = 0
            
            # 处理8列
            for col in range(8):
                if row < 8:
                    # 上半部分：使用低字节(0-7)
                    stm32_byte = stm32_char[col]
                    bit_pos = 7 - row  # bit7=顶部
                else:
                    # 下半部分：使用高字节(8-15)
                    stm32_byte = stm32_char[col + 8]
                    bit_pos = 7 - (row - 8)
                
                # 提取像素并重组
                if stm32_byte & (1 << bit_pos):
                    hdmi_row |= (1 << col)
            
            hdmi_char.append(hdmi_row)
        
        # 关键修正：交换前8字节和后8字节
        corrected_data = hdmi_char[8:16] + hdmi_char[0:8]
        hdmi_font.append(corrected_data)
```

### 转换工具使用

#### Python转换脚本: `font_converter_16x8.py`
```bash
# 运行转换脚本
python font_converter_16x8.py

# 输出文件
- hdmi_font_16x8.h  # 头文件
- hdmi_font_16x8.c  # 源文件
```

#### 生成的API接口
```c
// 字库参数
#define HDMI_FONT_WIDTH_16X8   8
#define HDMI_FONT_HEIGHT_16X8  16
#define HDMI_FONT_COUNT_16X8   95

// 字库数组
extern const u8 hdmi_font_16x8[][16];

// 字符索引查找
int hdmi_get_char_index_16x8(char c);
```

---

## 字库集成步骤

### 1. 文件集成
```bash
# 复制字库文件到项目
cp hdmi_font_16x8.h hello_world/src/wave/
cp hdmi_font_16x8.c hello_world/src/wave/
```

### 2. 更新构建配置
```cmake
# 在 UserConfig.cmake 中添加
set(USER_COMPILE_SOURCES
    # ...existing sources...
    "wave/hdmi_font_16x8.c"
)
```

### 3. 更新头文件
```c
// 在 oscilloscope_text.h 中修改
#define FONT_WIDTH  8    /* 字符宽度 */
#define FONT_HEIGHT 16   /* 字符高度 */
```

### 4. 更新源代码
```c
// 在 oscilloscope_text.c 中修改
#include "hdmi_font_16x8.h"

static int get_char_index(char c) {
    return hdmi_get_char_index_16x8(c);
}

// 更新绘制循环
for (int row = 0; row < HDMI_FONT_HEIGHT_16X8; row++) {
    u8 line = hdmi_font_16x8[char_index][row];
    for (int col = 0; col < HDMI_FONT_WIDTH_16X8; col++) {
        // ...drawing logic...
    }
}
```

---

## 显示问题修复

### 问题现象
在HDMI显示器上，字符出现**上下分裂**和**颠倒**问题：
- 字符被分成上下两部分
- 上半部分和下半部分位置颠倒

### 根本原因
STM32字库的数据组织方式与预期不符，需要**交换前8字节和后8字节**。

### 修复方法
在Python转换脚本中添加字节交换逻辑：
```python
# 修正：将前8字节和后8字节互换
# 原始: [0-7, 8-15] -> 修正: [8-15, 0-7]
corrected_data = char_data[8:16] + char_data[0:8]
```

### 修复效果对比
**修复前（错误显示）**:
```c
{0x12, 0x12, 0x22, 0x22, 0x42, 0xC7, 0x00, 0x00, 
 0x00, 0x00, 0x00, 0x3F, 0x42, 0x42, 0x42, 0x3E}, /* 'R' */
```

**修复后（正确显示）**:
```c
{0x00, 0x00, 0x00, 0x3F, 0x42, 0x42, 0x42, 0x3E, 
 0x12, 0x12, 0x22, 0x22, 0x42, 0xC7, 0x00, 0x00}, /* 'R' */
```

---

## 快速集成指南

### 5分钟快速部署

1. **准备字库文件**
   ```bash
   # 确保有以下文件
   hello_world/src/wave/hdmi_font_16x8.h
   hello_world/src/wave/hdmi_font_16x8.c
   ```

2. **更新配置文件**
   ```cmake
   # UserConfig.cmake 添加一行
   "wave/hdmi_font_16x8.c"
   ```

3. **修改字体大小**
   ```c
   // oscilloscope_text.h 修改两行
   #define FONT_WIDTH  8
   #define FONT_HEIGHT 16
   ```

4. **更新包含文件**
   ```c
   // oscilloscope_text.c 修改一行
   #include "hdmi_font_16x8.h"
   ```

5. **编译验证**
   ```bash
   cd hello_world/build
   ninja clean && ninja
   ```

### 常见问题解决

**Q: 编译错误 "undefined reference"**
A: 检查UserConfig.cmake是否正确添加了hdmi_font_16x8.c

**Q: 字符显示空白**
A: 检查字体尺寸定义是否更新为8×16

**Q: 字符位置偏移**
A: 检查draw_string函数中的字符间距计算

---

## 技术参考

### 绘制函数API
```c
// 绘制单个字符
void draw_char(u8 *canvas, u32 canvas_width, u32 x, u32 y, 
               char c, u8 color);

// 绘制字符串
void draw_string(u8 *canvas, u32 canvas_width, u32 x, u32 y, 
                 const char *str, u8 color);

// 绘制浮点数
void draw_number_float(u8 *canvas, u32 canvas_width, u32 x, u32 y, 
                       float value, u8 decimals, u8 color);
```

### 颜色定义
```c
#define TEXT_COLOR_WHITE   0
#define TEXT_COLOR_YELLOW  1
#define TEXT_COLOR_CYAN    2
#define TEXT_COLOR_GREEN   3
#define TEXT_COLOR_RED     4
#define TEXT_COLOR_BLUE    5
```

### 内存映射
```c
// 像素地址计算
u32 pixel_addr = (y * canvas_width + x) * 3;
canvas[pixel_addr + 0] = blue;   // B
canvas[pixel_addr + 1] = green;  // G  
canvas[pixel_addr + 2] = red;    // R
```

### 性能优化建议
1. **批量绘制**: 尽量减少单个字符绘制调用
2. **缓存复用**: 对固定文字使用预渲染缓存
3. **区域更新**: 只更新变化的屏幕区域
4. **字库选择**: 根据显示需求选择合适的字体大小

---

## 版本历史

- **v1.0**: 初始8x6字库实现
- **v2.0**: 16x8字库转换和集成
- **v2.1**: 修复字符上下分裂问题
- **v3.0**: 性能优化和代码清理

---

**文档日期**: 2025年6月17日  
**最后更新**: v3.0 字体系统完整版  
**适用版本**: Vitis 2025.1, Zynq7010示波器项目
