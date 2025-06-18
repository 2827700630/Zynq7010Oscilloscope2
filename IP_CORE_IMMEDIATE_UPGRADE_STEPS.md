# AD9280_SCOP_2.0 IP核立即升级操作步骤

## 🚨 当前问题确认
- **状态寄存器分析**: 0x00650280
  - bit[5]=0: sampling_active未活动 ❌
  - bit[7]=1: FIFO满，有数据 ✅
  - bit[9]=1: 采集完成 ✅
  - 样本计数=101: 已采集到数据 ✅

- **根本原因**: 当前运行的仍是旧IP核逻辑，采样完成后sampling_active=0，导致AXI Stream无法输出

## 🔧 立即操作步骤

### 步骤1: 升级IP核版本号
**当前版本**: 2.3 → **目标版本**: 2.4

```tcl
# 在Vivado TCL Console执行
set_property version 2.4 [get_ips ad9280_scop_0]
```

或手动修改 `component.xml` 第5行：
```xml
<spirit:version>2.4</spirit:version>
```

### 步骤2: 重新打包IP核
1. 打开Vivado
2. **Tools** → **Create and Package New IP**
3. 选择 **Package a specified directory**
4. 选择路径: `e:\FPGAproject\Zynq7010Oscilloscope2\IPcore\ad9280_scop_2\ad9280_scop_2_0`
5. **Identification** 页面修改版本号为 `2.4`
6. **Review and Package** → **Re-Package IP**

### 步骤3: 升级Block Design中的IP实例
1. 打开Block Design (`design_1`)
2. 右键点击 `ad9280_scop_0` 实例
3. 选择 **Upgrade IP**
4. 确认升级到版本 `2.4`

### 步骤4: 验证IP核更新
检查IP核属性，确认：
- 版本号：2.4
- FIFO_DEPTH参数：1024
- 连续采样逻辑已生效

### 步骤5: 重新综合和实现
```tcl
# TCL Console执行
reset_run synth_1
launch_runs synth_1 -jobs 4
wait_on_run synth_1

reset_run impl_1
launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1
```

### 步骤6: 导出硬件平台
1. **File** → **Export** → **Export Hardware**
2. 选择 **Include bitstream**
3. 导出到: `e:\FPGAproject\Zynq7010Oscilloscope2\design_1_wrapper.xsa`

### 步骤7: 更新Vitis平台
```bash
# 在Vitis Terminal执行
cd e:/FPGAproject/Zynq7010Oscilloscope2/platform
xsct -batch -eval "platform create -name zynq_platform -hw ../design_1_wrapper.xsa"
```

### 步骤8: 重新编译软件
```bash
cd e:/FPGAproject/Zynq7010Oscilloscope2/hello_world/build
cmake ..
ninja
```

### 步骤9: 烧录和测试
1. 烧录新的 `BOOT.bin`
2. 运行软件，观察串口输出
3. 确认 `sampling_active=1` 时AXI Stream能正常输出

## 🔍 预期结果
升级后的状态寄存器应显示：
- **bit[5]=1**: sampling_active活动 ✅
- **TVALID=1, TDATA≠0**: AXI Stream正常输出 ✅
- **DMA中断触发**: 数据传输完成 ✅

## ⚠️ 注意事项
1. 确保IP核版本号递增（2.3→2.4）
2. Block Design必须显示IP实例已升级
3. 重新综合前确认代码修改已生效
4. 备份当前工程状态

## 🐛 故障排除
如果升级后仍有问题：
1. 检查ILA中采样状态机状态
2. 确认时钟和复位信号正常
3. 验证AXI Stream握手信号
4. 检查FIFO读写指针和标志位

---
**创建时间**: $(Get-Date)  
**问题状态**: sampling_active=0导致AXI Stream无输出  
**解决方案**: IP核版本升级+重新综合实现
