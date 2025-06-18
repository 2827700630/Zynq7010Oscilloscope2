# ADC连续采样状态机修复报告
**时间**: 2025年6月18日  
**项目**: Zynq7010 示波器 v2.0  
**问题**: ADC状态机进入COMPLETE状态后无法重启连续采样

## 问题分析

### 串口输出分析
从最新的串口输出可以看到：
```
控制寄存器: 0x00000001  ← sampling_enable=1, trigger_enable=0
状态寄存器: 0x00650280  ← sampling_active=0, acquisition_complete=1
```

**关键问题**:
- `sampling_enable = 1` (bit[0]) - 采样使能已开启
- `trigger_enable = 0` (bit[1]) - 触发功能已禁用（连续模式）
- `sampling_active = 0` (bit[5]) - 但采样活动为0 ❌
- `acquisition_complete = 1` (bit[9]) - 采集完成标志为1

### 根本原因
ADC状态机设计存在缺陷：
1. **状态转换问题**: 在连续采样模式下，状态机从SAMPLING状态转换到COMPLETE状态后，无法正确转回SAMPLING状态
2. **时序问题**: COMPLETE状态的处理逻辑在一个时钟周期内无法完成状态重置和转换
3. **计数器重置时机**: 样本计数器重置逻辑与状态转换不同步

## 修复方案

### 1. 状态转换逻辑优化

#### 修复前 (有问题的逻辑)
```verilog
SAMPLING: begin
    if (!sampling_enable)
        next_state = IDLE;
    else if (trigger_enable && total_sample_count >= sample_depth)
        next_state = COMPLETE;
    else if (!trigger_enable)
        next_state = SAMPLING;  // 问题：总是停留在SAMPLING
end
```

#### 修复后 (优化的逻辑)
```verilog
SAMPLING: begin
    if (!sampling_enable)
        next_state = IDLE;
    else if (trigger_enable && total_sample_count >= sample_depth)
        next_state = COMPLETE;
    else if (!trigger_enable && total_sample_count >= sample_depth)
        next_state = SAMPLING;  // 连续模式：重置计数器但保持SAMPLING状态
    else
        next_state = SAMPLING;  // 继续采样
end
```

### 2. 计数器重置逻辑改进

#### 修复前
```verilog
// 在达到sample_depth后重置，但时序不当
if (!trigger_enable && total_sample_count >= sample_depth) begin
    sample_count <= 0;
    total_sample_count <= 0;
end
```

#### 修复后
```verilog
// 在达到sample_depth-1时重置，避免时序冲突
if (!trigger_enable && total_sample_count >= (sample_depth - 1)) begin
    sample_count <= 0;
    total_sample_count <= 0;
    acquisition_complete <= 1'b0;  // 清除完成标志
end
```

### 3. COMPLETE状态处理优化

#### 修复前
```verilog
COMPLETE: begin
    if (!trigger_enable) begin
        // 尝试重启，但存在时序问题
        sampling_active <= 1'b1;
        sample_count <= 0;
        total_sample_count <= 0;
        acquisition_complete <= 1'b0;
    end
end
```

#### 修复后
```verilog
COMPLETE: begin
    acquisition_complete <= 1'b1;
    if (!sampling_enable) begin
        sampling_active <= 1'b0;
    end else if (!trigger_enable) begin
        // 连续模式下立即重启
        sampling_active <= 1'b1;
        sample_count <= 0;
        total_sample_count <= 0;
        acquisition_complete <= 1'b0;
    end else begin
        sampling_active <= 1'b0;
        acquisition_complete <= 1'b1;
    end
end
```

## 技术要点

### 1. 连续采样模式实现
- **避免COMPLETE状态**: 在连续模式下尽量避免进入COMPLETE状态
- **在线重置**: 在SAMPLING状态内完成计数器重置
- **状态保持**: 保持`sampling_active=1`以确保AXI Stream输出

### 2. 时序优化
- **提前重置**: 在`total_sample_count >= (sample_depth - 1)`时重置，避免边界条件
- **标志清理**: 及时清除`acquisition_complete`标志
- **状态同步**: 确保状态转换和信号更新在同一时钟周期完成

### 3. AXI Stream独立性
虽然修改了AXI Stream使其不依赖`sampling_active`，但保持ADC状态机的正确工作仍然重要：
- **调试便利**: 正确的状态便于问题诊断
- **系统监控**: 软件可以正确监控ADC工作状态
- **资源管理**: 正确的状态有助于功耗和资源管理

## 预期效果

### 修复后的行为
1. **连续采样**: ADC状态机在连续模式下保持在SAMPLING状态
2. **状态正确**: `sampling_active`保持为1
3. **自动重置**: 达到采样深度后自动重置计数器
4. **AXI输出**: FIFO有数据时立即输出，不依赖采样状态

### 串口输出预期
```
状态寄存器: 0x00xxxxxx
  ✓ 采样状态：活动 (bit[5])     ← sampling_active=1
  ✓ FIFO状态：有数据 (bit[6])   ← 持续有数据
  [AXI Stream] ✓ 满足TVALID输出条件
```

## 风险评估

### 低风险
- 修改都是状态机内部逻辑，不影响外部接口
- 保持了原有的触发模式功能
- 向后兼容现有的软件驱动

### 注意事项
- 需要重新综合IP核才能生效
- 建议在ILA中监控状态机状态以验证修复效果
- 连续采样模式下FIFO可能更容易满，需要确保DMA及时读取

## 总结

本次修复解决了ADC连续采样模式的核心问题：
1. **状态机逻辑**: 优化了SAMPLING状态的转换条件
2. **计数器管理**: 改进了连续模式下的计数器重置时序
3. **状态一致性**: 确保`sampling_active`信号正确反映采样状态

修复后，ADC应该能够在连续模式下正常工作，`sampling_active`保持为1，从而满足AXI Stream输出的条件（虽然AXI Stream已经不依赖此信号，但保持状态正确性仍然重要）。
