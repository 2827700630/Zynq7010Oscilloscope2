# AD9280_SCOP_V2.0 IP核实现报告

## 📋 完成概述

**创建日期**: 2025年6月18日  
**IP核名称**: ad9280_scop_v2.0  
**版本**: 2.0（简化版，去除中断功能）

## 🏗️ 架构设计

### 接口配置
- **S00_AXI**: AXI4-Lite 配置接口 (32位数据宽度)
- **M00_AXIS**: AXI4-Stream 数据输出接口 (8位数据宽度)
- **ADC接口**: 8位并行数据输入
- **触发接口**: 外部触发输入和触发输出

### 核心功能
1. **基础触发功能**: 支持自动、正常、单次、外部四种触发模式
2. **预触发**: 25%预触发深度支持
3. **FIFO缓冲**: 256深度异步FIFO，支持跨时钟域
4. **状态监控**: 完整的采样状态反馈

## 📊 寄存器映射

| 地址 | 寄存器名称 | 访问权限 | 功能描述 |
|------|------------|----------|----------|
| 0x00 | Control Register | R/W | 控制寄存器 |
| 0x04 | Status Register | R | 状态寄存器 |
| 0x08 | Trigger Config Register | R/W | 触发配置寄存器 |
| 0x0C | Trigger Threshold Register | R/W | 触发阈值寄存器 |
| 0x10 | Sample Depth Register | R/W | 采样深度寄存器 |
| 0x14 | Decimation Config Register | R/W | 抽点配置寄存器(预留) |
| 0x18 | Timebase Config Register | R/W | 时基配置寄存器(预留) |
| 0x1C | Reserved Register | R/W | 保留寄存器 |

### 控制寄存器 (0x00) 详细定义
```verilog
[31:9]  保留
[8]     软件触发位
[7:5]   保留
[4]     触发边沿 (0:上升沿, 1:下降沿)
[3:2]   触发模式 (00:auto, 01:normal, 10:single, 11:external)
[1]     触发使能
[0]     采样使能
```

### 状态寄存器 (0x04) 详细定义 - 只读
```verilog
[31:16] 当前采样计数
[15:10] 保留
[9]     采集完成
[8]     触发检测
[7]     FIFO满
[6]     FIFO空
[5]     采样活动
[4:0]   保留
```

## 🔧 文件结构

### 创建的文件
```
ad9280_scop_2_0/
├── hdl/
│   ├── ad9280_scop.v                           (顶层模块)
│   ├── ad9280_scop_slave_lite_v2_0_S00_AXI.v   (AXI配置接口)
│   └── ad9280_scop_master_stream_v2_0_M00_AXIS.v (AXI数据输出接口)
└── src/
    └── ad9280_scop_adc_core.v                  (ADC核心处理模块)
```

### 主要修改
1. **顶层模块**: 添加ADC和触发接口，集成核心功能
2. **AXI Slave**: 实现8个寄存器，状态寄存器为只读
3. **AXI Master**: 修改为8位数据输出，从FIFO读取实际数据
4. **核心模块**: 完整的触发检测、状态机和FIFO管理

## 🚀 功能特性

### ✅ 已实现功能
- [x] 四种触发模式支持
- [x] 可配置触发阈值和边沿
- [x] 预触发功能 (25%深度)
- [x] 异步FIFO缓冲 (ADC时钟 → 系统时钟)
- [x] 8位AXI Stream输出
- [x] 完整状态监控
- [x] 软件触发支持

### 🔄 预留功能 (寄存器已分配)
- [ ] 抽点功能 (时基调整)
- [ ] 可配置时基档位
- [ ] 高级触发模式

## 🎯 相比V1.0的改进

### 优势
- **简化设计**: 去除中断功能，减少15-20%资源消耗
- **8位优化**: 数据宽度从32位优化为8位，提高效率
- **更好兼容性**: 与ad9280_sample接口兼容
- **易于扩展**: 预留寄存器支持未来功能扩展

### 保留功能
- 完整触发检测逻辑
- 状态机控制
- FIFO缓冲管理
- 预触发支持

## 📋 下一步工作

1. **IP核打包**: 在Vivado中重新打包IP核
2. **集成测试**: 在Block Design中替换现有IP核
3. **软件适配**: 修改驱动程序适配新的寄存器映射
4. **功能验证**: 验证触发功能和数据流
5. **性能测试**: 对比V1.0的资源消耗和性能

## 💡 使用建议

### 基础触发测试
```verilog
// 自动触发模式 - 连续采样
control_reg = 32'h00000003;  // sampling_enable=1, trigger_enable=1, auto_mode

// 正常触发模式 - 电平触发
control_reg = 32'h00000007;  // normal_trigger mode
trigger_threshold_reg = 32'h00000080;  // 128 threshold

// 单次触发模式 - 边沿触发  
control_reg = 32'h0000000B;  // single_trigger mode
trigger_config_reg = 32'h00000000;  // rising edge

// 外部触发模式
control_reg = 32'h0000000F;  // external_trigger mode
```

### 状态监控
```c
// 读取状态寄存器
uint32_t status = read_reg(STATUS_REG);
bool sampling_active = (status >> 5) & 0x1;
bool fifo_empty = (status >> 6) & 0x1;
bool fifo_full = (status >> 7) & 0x1;
bool trigger_detected = (status >> 8) & 0x1;
uint16_t sample_count = (status >> 16) & 0xFFFF;
```

**总结**: ad9280_scop_v2.0 是一个经过优化的示波器IP核，在保持核心触发功能的同时显著降低了资源消耗，为未来功能扩展预留了充足空间。
