# WinScript [🌍 English Version](./README.md)

WinScript 是一个 Windows 批处理脚本编程支持库，被广泛应用于我的自动化工具和日常工作流中。

# 设计目的

本库用于日常工作自动化：
- 通过右键菜单快速执行常用日常任务。
- 一键收集客户环境下所有必要信息，无需复杂指令。
- 类似于许多高级编程语言，本库以“函数+输入/输出参数”的方式提供功能，代码高度复用。
- 结构关系：模块（module）→ 函数/对象（function/object）→ 输入参数（input parameter）→ 输出参数（output parameter）+ 返回码（return code）。

---

## WinDbg 增强脚本

本脚本集大幅提升了 WinDbg 在高频故障分析场景下的调试体验：

- **右键菜单集成常用操作**：一键执行复杂调试任务，无需记忆繁琐命令。
- **场景化专用分析脚本**：内置针对二次异常调用栈丢失、死锁、崩溃、内存泄漏等典型场景的专用分析命令。用户可通过鼠标双击命令或分步提示，快速定位问题。
- **自定义高频命令面板**：将常用或难记的长命令集成到自定义面板，支持鼠标双击执行，极大提升效率。
- **自动加载专属调试配置**：可根据目标程序自动加载专属调试配置，实现零切换成本，一站式入口。

**实战验证**：已在生产环境中日均高效处理 50+ dump 文件，大幅提升团队问题定位与响应速度。

---
## 工作hub (chrome集成)
实现网页 HTML 文件与本地批处理脚本（.bat）的交互，将常用工作集成到网页中，提高工作效率。包含 Chrome 扩展及其实际样例（如 wokhub.html）。
- 运行本地任意命令，或带参数运行本地命令
- 调用系统默认关联程序打开本地文件或目录
- 在资源管理器中定位并高亮显示指定文件或目录
- 用指定编辑器（如 VS Code）打开文件或目录
- 自动为 Chrome 打开的本地目录页面提供额外功能，见 [screencut_localFolder.png](./batch_env/web/chrome_extension/install/test/screencut_localFolder.png)
- 自动生成常用工具链接，见 [screencut_html.png](./batch_env/web/chrome_extension/install/test/screencut_html.png) 自动生成部分

详细用法见 [web/chrome_extension/README_CN.md](./batch_env/web/chrome_extension/README_CN.md)

---

# 脚本特性概览

- **自文档化**：可自动生成模块 API 文档。
- **调试支持**：帮助开发者快速定位问题。
    1. 支持打印函数调用栈。
    2. 出错时自动暂停。
    3. 出错时自动以彩色文本打印源码路径、行号和出错代码。
- **用例示例**：帮助单元测试和提升易用性。
- **易于维护和更新**：无冗余代码。

---

# 使用示例

详见：[使用示例](https://github.com/ShenXiaolong1976/WinScript/tree/master/common/userCases)
