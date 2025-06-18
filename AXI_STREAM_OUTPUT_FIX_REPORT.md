# AXI Stream输出逻辑修复报告
**时间**: 2025年6月18日  
**项目**: Zynq7010 示波器 v2.0  
**问题**: ILA显示TVALID=0，TDATA=0，DMA无法接收数据

## 问题分析

### 根本原因
通过深入分析IP核源码发现，AXI Stream输出逻辑存在致命缺陷：

1. **AXI Stream模块问题**:
   - `ad9280_scop_master_stream_v2_0_M00_AXIS.v`中的TVALID生成条件：
   ```verilog
   // 错误的条件：需要sampling_active AND !fifo_empty
   if (sampling_active && !fifo_empty && !streaming_active_reg)
   ```

2. **ADC状态机问题**:
   - `ad9280_scop_adc_core.v`中，当采样完成后，状态转为`COMPLETE`
   - 在`COMPLETE`状态下，`sampling_active`被设置为0
   - 即使FIFO仍有数据，由于`sampling_active=0`，AXI Stream也不会输出

3. **触发模式冲突**:
   - 软件配置的连续采样模式与硬件状态机不匹配
   - 状态机设计偏向于一次性采样而非连续采样

### 串口日志分析
```
[状态分析] 状态寄存器: 0x07810280
  ✓ 采样状态：活动 (bit[7])    <- 实际上是FIFO状态导致的误判
  ✓ FIFO状态：有数据 (bit[6])  <- FIFO确实有数据
  ⚠ FIFO状态：满 (bit[9])      <- FIFO已满但无法输出
```

软件显示"采样活动"，但实际上ADC核心的`sampling_active`信号已经为0，这导致了判断错误。

## 修复方案

### 1. AXI Stream模块修复
**文件**: `ad9280_scop_master_stream_v2_0_M00_AXIS.v`

**修改内容**:
```verilog
// 修复前：依赖sampling_active信号
if (sampling_active && !fifo_empty && !streaming_active_reg) begin
    streaming_active_reg <= 1'b1;
end

// 修复后：只要FIFO有数据就开始输出
if (!fifo_empty && !streaming_active_reg) begin
    streaming_active_reg <= 1'b1;
end
```

**原理**: AXI Stream应该是数据驱动的，只要FIFO有数据就应该输出，而不应该依赖上游的控制信号。

### 2. ADC状态机修复
**文件**: `ad9280_scop_adc_core.v`

**修改内容**:
```verilog
// 添加连续采样支持
SAMPLING: begin
    if (!sampling_enable)
        next_state = IDLE;
    else if (trigger_enable && total_sample_count >= sample_depth)
        next_state = COMPLETE;
    else if (!trigger_enable)
        next_state = SAMPLING;  // 连续采样模式
end

COMPLETE: begin
    if (!sampling_enable)
        next_state = IDLE;
    else if (!trigger_enable)
        next_state = SAMPLING;  // 连续模式下重新开始
end
```

**原理**: 当触发功能禁用时，ADC应该工作在连续采样模式，不断地采集和输出数据。

### 3. 软件配置修复
**文件**: `adc_dma_ctrl.c`

**修改内容**:
```c
// 禁用触发，实现真正的连续采样
control_reg = ADC_CTRL_SAMPLING_EN;  // 只启用采样，不启用触发
```

## 技术要点

### 1. AXI Stream协议合规性
- **TVALID**: 只要有有效数据就应该拉高
- **TREADY**: 由下游DMA控制，表示接收准备
- **TLAST**: 在数据包结束时拉高
- **数据流**: 应该是背压式的，即上游根据TREADY决定是否发送

### 2. 跨时钟域处理
- ADC工作在`adc_clk`域
- AXI Stream工作在`sys_clk`域
- FIFO实现跨时钟域数据传输

### 3. 状态信号设计
- `sampling_active`: 表示ADC正在采样
- `streaming_active_reg`: 表示AXI Stream正在输出
- 两者应该相对独立，流输出不应该依赖采样状态

## 预期效果

### 修复后的行为
1. **ADC侧**: 持续采样，不断向FIFO写入数据
2. **AXI Stream侧**: 只要FIFO有数据就输出，不管ADC采样状态
3. **DMA侧**: 接收到TVALID=1和有效的TDATA
4. **软件侧**: 能够接收到中断并读取采样数据

### ILA预期信号
- `TVALID = 1` (当FIFO非空时)
- `TREADY = 1` (DMA准备接收)
- `TDATA != 0` (实际ADC采样数据)
- `TLAST = 1` (在数据包末尾)

## 下一步验证

1. **重新综合IP核**: 使用修复后的HDL代码
2. **重新编译软件**: 使用修复后的驱动代码
3. **硬件测试**: 观察ILA中的AXI Stream信号
4. **软件验证**: 检查DMA中断和数据接收

## 风险评估

### 低风险
- 修改都是逻辑层面的，不涉及接口变更
- 保持了AXI协议的兼容性
- 修复符合标准的AXI Stream行为

### 中等风险
- 连续采样可能增加功耗
- FIFO可能更容易满，需要确保DMA及时读取

### 缓解措施
- 可通过软件控制启停采样
- 监控FIFO状态，必要时停止采样

## 总结

本次修复解决了AXI Stream输出的根本问题：
1. 去除了不合理的信号依赖关系
2. 实现了真正的连续采样模式
3. 确保了AXI Stream协议的正确实现

修复后，系统应该能够正常进行数据采集和传输。
