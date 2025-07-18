# bash_env
一个面向 Linux 的 Bash 脚本支持库。

# 目的
- 简化 linux bash 环境下的日常重复性工作。
- 封装常用的命令组合。
- 提供可复用、模块化的 Bash 函数，支持输入/输出参数，便于代码复用与维护。
- 通过 ~/.bashrc 或者 ~/.profile 来自动调用本初始化脚本，参见 setup.sh

## Linux GDB 增强脚本

本套脚本通过原生 GDB + Bash 实现了对标 Windows WinDbg 的高效跨平台调试体验：

- **编辑器无缝集成**：GDB 调试时可自动在 VS Code 或任意编辑器中打开对应源码行。
- **跨机源代码联动**：支持在机器 A 调试时，自动在机器 B 上打开对应源代码，适配远程开发场景。
- **极致响应速度**：核心操作（如单步调试）响应速度远超 VS Code 内置调试器，实测单步操作 <50ms。
- **轻量级实现**：90% 功能为纯 Bash 实现，少量功能用 Python 辅助（核心功能无 Python 依赖）。

