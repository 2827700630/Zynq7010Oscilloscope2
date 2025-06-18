# ad9280_sample IP核工作机制分析报告
**时间**: 2025年6月18日  
**项目**: Zynq7010 示波器 v2.0  
**分析对象**: 原始ad9280_sample IP核

## 核心发现：原IP核是命令触发式，而非连续采样

通过深入分析原始`ad9280_sample` IP核的源码，我发现了一个关键事实：**原IP核确实是达到采样深度后停止采样，等待PS端重新发送命令才会重新开始采样**。

## 详细分析

### 1. 工作模式：命令触发式采样

#### 寄存器定义
- **slv_reg0[0]**: `sample_start` - 采样启动位（由PS端写入）
- **slv_reg1**: `sample_len` - 采样长度（由PS端配置）

#### 状态机行为
```verilog
case(state)
    S_IDLE:
    begin
        if (sample_start_d2)  // 等待PS端启动命令
        begin
            state <= S_SAMP_WAIT;
            start_clr <= 1'b1;   // 清除启动寄存器
        end        
    end
    
    S_SAMPLE:
    begin
        if(adc_data_valid == 1'b1)
        begin
            if(sample_cnt == sample_len_d2)  // 达到采样长度
            begin
                sample_cnt <= 32'd0;
                adc_buf_wr <= 1'b0;
                state <= S_IDLE;      // 返回IDLE状态，等待下一次命令
            end
            else
            begin
                adc_buf_data <= adc_data; 
                adc_buf_wr <= 1'b1;
                sample_cnt <= sample_cnt + 32'd1;
            end
        end
    end        
endcase
```

**关键特征**：
1. **一次性采样**: 达到`sample_len`后立即停止并返回IDLE状态
2. **命令等待**: 必须等待PS端重新写入`sample_start`位才能开始下一次采样
3. **自动清零**: IP核会自动清除`slv_reg0`中的启动位

### 2. 自动清零机制

```verilog
// 在AXI Slave模块中
else if (start_clr_d2)
    slv_reg0 <= {C_S_AXI_DATA_WIDTH{1'b0}};  // 清除整个寄存器
```

**工作流程**：
1. PS端写入`slv_reg0[0] = 1`启动采样
2. IP核检测到启动信号，发送`start_clr`
3. AXI Slave接收到`start_clr`后清零`slv_reg0`
4. 采样开始，直到达到`sample_len`
5. 采样完成，状态机返回IDLE，等待下一次启动命令

### 3. 与新IP核的对比

#### ad9280_sample (原始IP核)
- **模式**: 命令触发式，一次性采样
- **行为**: 采样完成后停止，等待PS端命令
- **优点**: 精确控制，功耗较低
- **缺点**: 需要PS端频繁干预

#### ad9280_scop_2_0 (新设计IP核)  
- **模式**: 连续采样模式（我们的设计目标）
- **行为**: 持续采样，自动循环
- **优点**: 高吞吐量，适合实时显示
- **缺点**: 功耗较高，需要背压控制

## 重要结论

### 1. 设计理念差异
原始IP核设计为**示波器触发采样模式**：
- 每次触发采集固定长度的波形
- 采集完成后分析和显示
- 类似传统数字示波器的工作方式

我们的新IP核设计为**连续数据流模式**：
- 持续采样和输出数据
- 适合实时波形显示
- 类似数据采集系统的工作方式

### 2. 这解释了我们遇到的问题
我们之前的问题根源在于：
1. **设计目标不匹配**: 我们想要连续采样，但借鉴了一次性采样的设计
2. **状态机逻辑**: 新IP核的状态机设计不够完善，在COMPLETE状态后处理不当
3. **AXI Stream输出**: 原IP核也是通过FIFO+AXI Stream输出，但采样模式不同

### 3. 修复方向验证
我们之前的修复方向是正确的：
- **AXI Stream独立化**: 使AXI Stream输出不依赖采样状态
- **连续采样模式**: 修改状态机实现真正的连续采样
- **避免COMPLETE状态**: 在连续模式下避免进入停止状态

## 软件端的对应机制

根据原IP核的设计，PS端软件需要：

```c
// 典型的使用流程
void trigger_sampling(u32 sample_length) {
    // 1. 配置采样长度
    AD9280_SAMPLE_mWriteReg(baseaddr, AD9280_SAMPLE_S00_AXI_SLV_REG1_OFFSET, sample_length);
    
    // 2. 启动采样（写入start位）
    AD9280_SAMPLE_mWriteReg(baseaddr, AD9280_SAMPLE_S00_AXI_SLV_REG0_OFFSET, 0x1);
    
    // 3. 等待采样完成（通过DMA中断或轮询）
    wait_for_dma_complete();
    
    // 4. 处理采样数据
    process_sample_data();
    
    // 5. 重复步骤2开始下一次采样
}
```

## 总结

**是的，您的理解完全正确**！原始的`ad9280_sample` IP核确实是达到采样深度后停止采样，需要PS端重新发送命令才能开始下一次采样。这是一种典型的**触发式采样**设计，而不是连续采样。

这个发现验证了我们修改新IP核实现连续采样的必要性和正确性。我们的目标是实现真正的连续数据流，而不是重复的触发采样。
