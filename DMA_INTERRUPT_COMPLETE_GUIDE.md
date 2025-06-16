/**
 * ZYNQ7010示波器工程 - DMA中断修复完整指南
 * =============================================
 * 
 * ## 📋 项目概述
 * 
 * **项目名称**：Zynq7010Oscilloscope2
 * **问题描述**：AXI DMA S2MM中断无法触发，导致ADC数据传输失败
 * **修复结果**：✅ 成功修复，DMA中断正常工作，ADC数据正常采集
 * 
 * ## 🔍 问题诊断过程
 * 
 * ### 症状表现
 * ```
 * [DMA初始化] 开始初始化DMA设备ID: 0, 中断ID: 31
 * [DMA测试] DMA传输已启动，等待中断...
 * [DMA状态] S2MM状态寄存器: 0x00000000
 * [DMA测试] 超时：未收到DMA完成中断  ❌
 * ```
 * 
 * ### 根本原因：中断ID不匹配
 * 
 * **错误的软件配置**：
 * ```c
 * // xparameters.h中的错误定义
 * #define XPAR_FABRIC_AXI_DMA_0_INTR 31  ❌
 * 
 * // 软件中使用错误的中断ID
 * #define S2MM_INTR_ID XPAR_FABRIC_AXI_DMA_0_INTR  // 31
 * ```
 * 
 * **实际硬件连接**（通过Vivado block design分析）：
 * ```
 * axi_dma_0/s2mm_introut → xlconcat_0/In2 → processing_system7_0/IRQ_F2P[2]
 * ```
 * 
 * ## 🔧 修复解决方案
 * 
 * ### 1. 硬件架构分析
 * 
 * **ZYNQ-7000中断系统**：
 * ```
 * ┌─────────────────┬──────────┬────────────────────────┐
 * │   中断类型      │  ID范围  │         描述           │
 * ├─────────────────┼──────────┼────────────────────────┤
 * │ SGI             │  0-15    │ 软件生成中断           │
 * │ PPI             │ 16-31    │ 私有外设中断           │
 * │ SPI             │ 32-60    │ 共享外设中断           │
 * │ IRQ_F2P[0-7]    │ 61-68    │ Fabric到PS中断 ⭐     │
 * └─────────────────┴──────────┴────────────────────────┘
 * ```
 * 
 * **xlconcat中断连接映射**：
 * ```
 * xlconcat_0端口 → IRQ_F2P位 → 中断ID → 连接设备
 * ├── In0        → [0]       → 61     → axi_vdma_0/mm2s_introut
 * ├── In1        → [1]       → 62     → v_tc_0/irq  
 * └── In2        → [2]       → 63     → axi_dma_0/s2mm_introut ⭐
 * ```
 * 
 * ### 2. 软件修复代码
 * 
 * **修复前**（错误）：
 * ```c
 * #define S2MM_INTR_ID       XPAR_FABRIC_AXI_DMA_0_INTR  // 31
 * ```
 * 
 * **修复后**（正确且可维护）：
 * ```c
 * /* 中断ID计算：ZYNQ IRQ_F2P基址 + xlconcat端口偏移 */
 * #define ZYNQ_IRQ_F2P_BASE_ID   61              /* ZYNQ Fabric-to-PS中断基础ID */
 * #define DMA_XLCONCAT_PORT      2               /* DMA连接在xlconcat的In2端口 */
 * #define S2MM_INTR_ID           (ZYNQ_IRQ_F2P_BASE_ID + DMA_XLCONCAT_PORT)  /* 61+2=63 */
 * ```
 * 
 * ### 3. 修改的文件
 * 
 * ✅ **adc_dma_ctrl.h**：
 * ```c
 * - #define S2MM_INTR_ID       XPAR_FABRIC_AXI_DMA_0_INTR
 * + #define ZYNQ_IRQ_F2P_BASE_ID   61
 * + #define DMA_XLCONCAT_PORT      2  
 * + #define S2MM_INTR_ID           (ZYNQ_IRQ_F2P_BASE_ID + DMA_XLCONCAT_PORT)
 * ```
 * 
 * ✅ **main.c**：
 * ```c
 * - #define S2MM_INTR_ID       XPAR_FABRIC_AXI_DMA_0_INTR
 * + #define ZYNQ_IRQ_F2P_BASE_ID   61
 * + #define DMA_XLCONCAT_PORT      2
 * + #define S2MM_INTR_ID           (ZYNQ_IRQ_F2P_BASE_ID + DMA_XLCONCAT_PORT)
 * ```
 * 
 * ## ✅ 修复验证结果
 * 
 * ### 成功的测试输出
 * ```
 * [DMA初始化] 开始初始化DMA设备ID: 0, 中断ID: 63  ✅
 * [中断] DMA S2MM传输完成中断触发  ✅
 * [数据] 检测到有效ADC数据!  ✅
 * [数据] 内容: 8D 8F 8E 90 8F C6 C6 AC AB A9...  ✅
 * ```
 * 
 * ### ADC数据质量验证
 * - ✅ **数据完整性**：前20字节全为非零值
 * - ✅ **数据变化**：8D→8F→8E→90→C6→AC→A9（正常的ADC采样变化）
 * - ✅ **传输速度**：中断及时触发，无延迟
 * - ✅ **系统稳定性**：连续多次传输均正常
 * 
 * ## 🎯 技术要点总结
 * 
 * ### 关键学习点
 * 
 * 1. **不能盲信自动生成文件**：
 *    - xparameters.h可能包含错误
 *    - 需要与实际硬件设计对比验证
 * 
 * 2. **理解ZYNQ中断架构**：
 *    - IRQ_F2P从61开始编号
 *    - xlconcat端口直接对应IRQ_F2P位
 * 
 * 3. **使用可维护的代码设计**：
 *    - 用宏定义表达硬件架构关系
 *    - 避免硬编码魔数
 *    - 添加详细注释说明
 * 
 * ### 调试技巧
 * 
 * 1. **硬件分析优先**：
 *    ```bash
 *    # 分析block design中的连接
 *    grep -n "s2mm_introut" design_1.bd
 *    grep -n "xlconcat" design_1.bd
 *    grep -n "IRQ_F2P" design_1.bd
 *    ```
 * 
 * 2. **软件验证方法**：
 *    ```c
 *    // 在代码中输出实际使用的中断ID
 *    xil_printf("[DMA初始化] 中断ID: %d\r\n", S2MM_INTR_ID);
 *    ```
 * 
 * 3. **状态寄存器监控**：
 *    ```c
 *    // 监控DMA状态变化
 *    u32 sr = XAxiDma_ReadReg(AxiDma.RegBase, XAXIDMA_RX_OFFSET + XAXIDMA_SR_OFFSET);
 *    xil_printf("[DMA状态] S2MM状态: 0x%08X\r\n", sr);
 *    ```
 * 
 * ## 🚀 项目当前状态
 * 
 * ### ✅ 已完成功能
 * - [x] DMA中断正常触发
 * - [x] ADC数据正常采集  
 * - [x] HDMI显示输出正常
 * - [x] 波形实时显示
 * - [x] 代码结构优化（移除测试代码）
 * 
 * ### 🔮 可扩展功能
 * - [ ] 多通道ADC支持
 * - [ ] 触发功能实现
 * - [ ] 波形测量功能
 * - [ ] 数据存储和回放
 * - [ ] 网络接口支持
 * 
 * ## 📚 参考资料
 * 
 * 1. **Xilinx文档**：
 *    - UG585: Zynq-7000 TRM
 *    - PG021: AXI DMA LogiCore IP Product Guide
 *    - UG994: Vivado Design Suite User Guide
 * 
 * 2. **相关示例**：
 *    - xaxidma_example_simple_intr.c
 *    - xscugic 中断控制器示例
 * 
 * ## 📝 维护说明
 * 
 * ### 如果需要修改硬件连接
 * 
 * 1. **更改xlconcat端口**：
 *    ```c
 *    // 只需修改这个宏定义
 *    #define DMA_XLCONCAT_PORT      X  // 改为新的端口号
 *    ```
 * 
 * 2. **重新生成硬件平台**：
 *    - 在Vivado中Export Hardware
 *    - 在Vitis中Update Hardware Specification
 *    - 重新编译应用程序
 * 
 * ### 故障排除检查清单
 * 
 * ❓ **如果中断仍不工作**：
 * - [ ] 检查xlconcat端口连接
 * - [ ] 验证IRQ_F2P使能状态
 * - [ ] 确认DMA时钟配置正确
 * - [ ] 检查AXI4-Stream连接
 * - [ ] 验证复位信号时序
 * 
 */
