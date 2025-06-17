# HDMI示波器界面显示功能说明

## 📺 功能概述

现在您的ZYNQ示波器可以在HDMI上显示专业的数字示波器界面，包括：

- ✅ **时基显示** (μs/div)
- ✅ **电压档位** (V/div) 
- ✅ **频率测量** (Hz/kHz/MHz)
- ✅ **电压峰峰值** (Vpp)
- ✅ **采样率显示** 
- ✅ **波形统计** (最大值、最小值、平均值、RMS)
- ✅ **网格标签** (时间和电压刻度)
- ✅ **状态栏** (运行状态、内存使用、帧率)
- ✅ **标题栏** (设备信息、通道状态)
- ✅ **光标测量** (时间差、频率计算)

## 🎯 新增文件

### 1. 核心文件
- `wave/oscilloscope_text.h` - 文字显示函数声明
- `wave/oscilloscope_text.c` - 8x16点阵字体和文字绘制实现
- `wave/oscilloscope_interface.h` - 完整界面函数声明  
- `wave/oscilloscope_interface.c` - 专业示波器界面实现

### 2. 已修改文件
- `adc_dma_ctrl.c` - 集成了文字显示功能
- `UserConfig.cmake` - 添加了新源文件编译

## 🔧 使用方法

### 1. 基本信息显示
```c
// 定义示波器参数
OscilloscopeParams osc_params = {
    .timebase_us = 100.0,      // 100μs/格
    .voltage_scale = 0.5,      // 0.5V/格  
    .sample_rate = 32260000,   // 32.26MHz采样率
    .trigger_level = 128,      // 中间触发电平
    .trigger_mode = 0          // 自动触发
};

// 计算实际测量值
calculate_measurements(DmaRxBuffer, ADC_CAPTURELEN, &osc_params);

// 绘制信息面板
draw_oscilloscope_info(WaveBuffer, width, WAVE_HEIGHT, &osc_params);
```

### 2. 完整专业界面
```c
// 绘制完整示波器界面
draw_complete_oscilloscope_interface(WaveBuffer, width, WAVE_HEIGHT, 
                                   DmaRxBuffer, ADC_CAPTURELEN, &osc_params);
```

### 3. 光标测量功能
```c
// 绘制测量光标
u32 cursor1_x = width * 0.3;  // 30%位置
u32 cursor2_x = width * 0.7;  // 70%位置
draw_cursor_measurements(WaveBuffer, width, WAVE_HEIGHT, cursor1_x, cursor2_x, &osc_params);
```

## 🎨 界面布局

```
┌─────────────────────────────────────────────────────────────────────┐
│ ZYNQ Digital Oscilloscope v1.0          CH1  AC  1MΩ    TRIG: AUTO │
├─────────────────────────────────────────────────────────────────────┤
│ Time: 100.0μs/div    │                            │ MEASUREMENTS   │
│ Volt: 0.50V/div      │                            │ RMS: 1.234V    │
│ Freq: 1.25kHz        │                            │ AVG: 0.567V    │
│ Vpp: 2.45V           │        波形显示区          │ Period: 0.8ms  │
│ Sample: 32.3MHz      │                            │                │
│                      │                            │ STATISTICS     │
│                      │                            │ Max: 2.345V    │
│                      │                            │ Min: -1.234V   │
│                      │                            │ Avg: 0.567V    │
├─────────────────────────────────────────────────────────────────────┤
│ 时间刻度标签...                                   电压刻度标签... │
├─────────────────────────────────────────────────────────────────────┤
│ RUN    Depth: 1920pts    Memory: 23%              FPS: 60         │
└─────────────────────────────────────────────────────────────────────┘
```

## 📊 显示内容详解

### 📈 主信息面板 (左上角)
- **Time**: 时基，单位μs/div
- **Volt**: 电压档位，单位V/div  
- **Freq**: 自动测量的信号频率
- **Vpp**: 电压峰峰值
- **Sample**: ADC采样率

### 📏 测量面板 (右上角)  
- **RMS**: 有效值电压
- **AVG**: 平均电压
- **Period**: 信号周期

### 📊 统计面板 (右中)
- **Max**: 最大电压值 (红色)
- **Min**: 最小电压值 (蓝色)  
- **Avg**: 平均电压值 (绿色)

### 🏷️ 网格标签
- **时间轴**: 底部显示时间刻度
- **电压轴**: 右侧显示电压刻度

### 📱 状态栏 (底部)
- **RUN**: 运行状态指示
- **Depth**: 当前采样深度  
- **Memory**: 内存使用百分比
- **FPS**: 显示刷新率

## 🎨 颜色编码

```c
#define TEXT_COLOR_WHITE   0  // 白色 - 主要数值
#define TEXT_COLOR_YELLOW  1  // 黄色 - 重要数值/标题
#define TEXT_COLOR_CYAN    2  // 青色 - 标签/单位
#define TEXT_COLOR_GREEN   3  // 绿色 - 状态良好
#define TEXT_COLOR_RED     4  // 红色 - 警告/最大值
```

## ⚙️ 自动测量功能

系统会自动计算以下参数：

### 1. 频率测量
```c
// 通过过零点检测计算频率
if (zero_crossings > 2) {
    float period_samples = (float)(length * 2) / zero_crossings;
    params->frequency_hz = params->sample_rate / period_samples;
}
```

### 2. 电压测量
```c
// 电压峰峰值计算
params->voltage_pp = (max_val - min_val) * params->voltage_scale / 255.0;
```

### 3. 时基计算
```c
// 基于采样率和屏幕宽度自动计算时基
params->timebase_us = (1000000.0 / params->sample_rate) * (ADC_CAPTURELEN / 10.0);
```

## 🔧 自定义配置

### 修改显示位置
```c
// 在oscilloscope_text.h中修改
#define INFO_PANEL_X     50    // 信息面板X位置
#define INFO_PANEL_Y     50    // 信息面板Y位置  
#define LINE_SPACING     20    // 行间距
```

### 修改字体大小
```c
// 在oscilloscope_text.h中修改
#define FONT_WIDTH  8    // 字符宽度
#define FONT_HEIGHT 16   // 字符高度
```

### 添加新测量功能
```c
// 在calculate_measurements函数中添加
// 例如：占空比、上升时间、下降时间等
```

## 🚀 显示效果

现在您的示波器将显示：

1. **专业外观**: 类似商用示波器的界面
2. **实时测量**: 自动计算频率、电压等参数
3. **清晰标识**: 所有数值都有明确的单位和标签
4. **状态监控**: 实时显示系统运行状态
5. **网格标注**: 便于读取波形数值

## 📝 注意事项

1. **字体限制**: 当前只支持数字、基本字母和特殊符号
2. **性能影响**: 文字绘制会增加一些CPU负载
3. **内存使用**: 字体数据占用约2KB程序存储空间
4. **扩展性**: 可以轻松添加更多测量功能和显示内容

您的ZYNQ示波器现在具备了专业示波器的显示界面！🎉
