# IP核升级与硬件平台更新指南

## 🎯 **目标**
将修复后的 `ad9280_scop_2_0` IP核集成到Vivado工程中，生成新的硬件平台，并更新Vitis工程，从根本上解决AXI Stream无数据的问题。

## 📝 **操作步骤**

### **第1步：在Vivado中重新打包IP核**
首先，需要将我们修复过的IP核源代码重新打包，使其成为Vivado IP目录中的最新版本。

1.  **打开Vivado**。
2.  在Tcl Console中执行以下命令，打开IP Packager工程：
    ```tcl
    cd E:/FPGAproject/Zynq7010Oscilloscope2/IPcore/ad9280_scop_2
    edit_ip_project ad9280_scop_2_0/component.xml
    ```
3.  在弹出的IP Packager窗口中，导航到 **"File Groups"** 选项卡。
4.  右键点击 **"Verilog Synthesis"** 并选择 **"Add or Remove Files"**。确保所有HDL源文件（`.v`）都已正确包含。
5.  导航到 **"Customization Parameters"** 选项卡，检查参数是否正确，特别是FIFO深度等。
6.  导航到 **"Review and Package"** 选项卡。
7.  点击 **"Re-Package IP"** 按钮。Vivado会更新IP核，并报告打包是否成功。

### **第2步：在Vivado Block Design中升级IP核**
现在，在您的主工程中更新正在使用的IP核实例。

1.  打开您的主Vivado工程 `Zynq7010Oscilloscope2.xpr`。
2.  打开Block Design。
3.  在IP核仓库（IP Catalog）中，找到 `ad9280_scop_2_0`。如果打包成功，它应该会显示有可用的升级。
4.  在您的Block Design中，找到名为 `ad9280_scop_2_0` 的IP核实例。右键点击它，选择 **"Upgrade IP..."**。
5.  按照向导完成升级。Vivado会自动将实例更新到最新版本。
6.  **运行 "Validate Design"** 确保所有连接都正确无误。

### **第3步：重新生成Bitstream**
IP核更新后，需要重新运行综合（Synthesis）和实现（Implementation）来生成新的比特流文件。

1.  在Flow Navigator中，点击 **"Run Synthesis"**。
2.  综合完成后，点击 **"Run Implementation"**。
3.  实现完成后，点击 **"Generate Bitstream"**。

### **第4步：导出新的硬件平台 (XSA)**
新的比特流包含了更新后的硬件逻辑，现在需要将其导出为Vitis可以使用的格式。

1.  在Vivado菜单栏，选择 **File -> Export -> Export Hardware**。
2.  在弹出的窗口中，确保选中 **"Include bitstream"**。
3.  将导出的XSA文件命名为 `design_1_wrapper_new.xsa` (或您选择的其他名称)，并将其保存在 `E:\FPGAproject\Zynq7010Oscilloscope2` 目录下。

### **第5步：在Vitis中更新硬件平台**
最后，让Vitis工作区指向这个新的硬件定义。

1.  **打开Vitis IDE**。
2.  在Explorer视图中，找到您的平台工程（通常名为 `platform`）。
3.  右键点击 `platform.spr`，选择 **"Update Hardware Specification"**。
4.  在对话框中，选择您刚刚导出的新XSA文件 (`design_1_wrapper_new.xsa`)。
5.  Vitis会自动更新平台。完成后，右键点击平台工程，选择 **"Build Project"**。

### **第6步：重新构建应用并测试**
平台更新后，需要重新构建您的应用程序。

1.  右键点击您的应用工程（`hello_world`），选择 **"Build Project"**。
2.  构建成功后，像往常一样通过 **"Run As -> Launch on Hardware"** 来运行测试。

---

## ✅ **预期结果**
完成以上所有步骤后，您的FPGA将运行包含所有修复的新版IP核。此时：
-   Vitis应用启动后，应能成功读取到IP核的版本号（`0x02000000`）。
-   ADC将能够按预期进行采样，并且AXI Stream总线上会有持续的数据流输出。
-   DMA中断应该可以正常触发。

如果您在任何步骤中遇到问题，请随时告诉我。
