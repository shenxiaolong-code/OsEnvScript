# 平台环境相关的初始化脚本库 [🌍 English Version](README.md)
本 repo 包含适用于 Windows 和 Linux 环境的自动化脚本库, 可以帮助简化日常开发工作并提升工作效率

[Windows script batch_env](batch_env) 
# WinDbg 增强脚本 [跳转目录](batch_env/windbg)
本脚本集大幅提升了 WinDbg 在高频故障分析场景下的调试体验：
- **右键菜单集成常用操作**：一键执行复杂调试任务，无需记忆繁琐命令。
- **场景化专用分析脚本**：内置针对二次异常调用栈丢失、死锁、崩溃、内存泄漏等典型场景的专用分析命令。用户可通过鼠标双击命令或分步提示，快速定位问题。
- **自定义高频命令面板**：将常用或难记的长命令集成到自定义面板，支持鼠标双击执行，极大提升效率。
- **自动加载专属调试配置**：可根据目标程序自动加载专属调试配置，实现零切换成本，一站式入口。

**实战验证**：已在生产环境中日均高效处理 50+ dump 文件，大幅提升团队问题定位与响应速度。

# 工作hub (chrome扩展) [跳转目录](batch_env/web/chrome_extension)
实现网页 HTML 文件与本地批处理脚本（.bat）的交互，将常用工作集成到网页中，提高工作效率。包含 Chrome 扩展及其实际样例（如 wokhub.html）。
通过鼠标点击网页上的元素(比如链接)，可以:
- 运行本地任意命令，或带参数运行本地命令
- 调用系统默认关联程序打开本地文件或目录
- 在资源管理器中定位并高亮显示指定文件或目录
- 用指定编辑器（如 VS Code）打开文件或目录
- 自动为 Chrome 打开的本地目录页面提供额外功能，见 [screencut_localFolder.png](batch_env/web/chrome_extension/install/test/screencut_localFolder.png)
- 自动生成常用工具链接，见 [screencut_html.png](batch_env/web/chrome_extension/install/test/screencut_html.png) 自动生成部分

详细用法见 [README_CN.md](batch_env/web/chrome_extension/README_CN.md)

# windows操作通用功能 [跳转目录](batch_env/common)
本库用于日常工作自动化：
- 通过右键菜单快速执行常用日常任务。
- 一键收集客户环境下所有必要信息，无需复杂指令。
- 类似于许多高级编程语言，本库以“函数+输入/输出参数”的方式提供功能，代码高度复用。
- 结构关系：模块（module）→ 函数/对象（function/object）→ 输入参数（input parameter）→ 输出参数（output parameter）+ 返回码（return code）。

## 脚本特性概览
- **自文档化**：可自动生成模块 API 文档。
- **调试支持**：帮助开发者快速定位问题。
    1. 支持打印函数调用栈。
    2. 出错时自动暂停。
    3. 出错时自动以彩色文本打印源码路径、行号和出错代码。
- **用例示例**：帮助单元测试和提升易用性。
- **易于维护和更新**：无冗余代码。

# [linux script bash_env](bash_env) 

# Linux GDB 增强脚本  [跳转目录](bash_env/app/gdb)
本套脚本通过原生 GDB + Bash 实现了对标 Windows WinDbg 的高效跨平台调试体验：

- **编辑器无缝集成**：GDB 调试时可自动在 VS Code 或任意编辑器中打开对应源码行。
- **跨机源代码联动**：支持在机器 A 调试时，自动在机器 B 上打开对应源代码，适配远程开发场景。
- **极致响应速度**：核心操作（如单步调试）响应速度远超 VS Code 内置调试器，实测单步操作 <50ms。
- **轻量级实现**：90% 功能为纯 Bash 实现，少量功能用 Python 辅助（核心功能无 Python 依赖）。

# Linux 开发通用功能
- 简化 linux bash 环境下的日常重复性工作。
- 封装常用的命令组合。
- 提供可复用、模块化的 Bash 函数，支持输入/输出参数，便于代码复用与维护。
- 通过 ~/.bashrc 或者 ~/.profile 来自动调用本初始化脚本，参见 setup.sh
