# WinDbg 增强脚本集  [🌍 English Version](README.md)

本目录包含一套针对 Windows 平台 WinDbg 调试器的增强脚本，旨在大幅提升高频故障分析场景下的调试效率和体验。

## 主要功能

- **右键菜单集成** [跳转目录](contextMenu/)
  
  一键执行常用调试任务，无需记忆复杂命令，极大简化操作流程。

- **场景化专用分析脚本** [跳转目录](script/cmds/)
  
  针对二次异常调用栈丢失、死锁、崩溃、内存泄漏等典型场景，内置专用分析命令。支持鼠标双击命令或分步提示，快速定位问题。

- **自定义高频命令面板** [cmdTree.dbg](script/loadSetting/cmdTree.dbg) [cmdTree_cur.dbg](script/loadSetting/cmdTree_cur.dbg)
  
  可将常用或难记的长命令集成到自定义面板，支持鼠标双击执行，提升调试效率。

- **自动加载专属调试配置** [跳转目录](script/loadSetting/)
  
  可根据目标程序自动加载专属调试配置，实现零切换成本，一站式入口。

- **批量 dump 文件处理** [tools_windbg.bat](tools_windbg.bat)
  
  支持批量分析和处理 dump 文件，适合生产环境下高频问题定位。

## 使用方法
- 直接使用命令行加载脚本：
  ```
  gdb -x script/startCmds.dbg ...
  ```
- 高级用法：定制脚本让初始化脚本自动搜索匹配。例子： [configCustomizedPath_example.bat](setup/configCustomizedPath_example.bat)
- 简单用法：使用桌面右键菜单自动加载 [contextMenu](contextMenu/)

## 特色说明

- 已在生产环境中日均高效处理 50+ dump 文件，显著提升团队响应速度。
- 脚本结构清晰，易于扩展和维护。
- 支持自定义扩展，便于团队协作和知识沉淀。

## 目录结构

- `menu/` 右键菜单相关脚本
- `cmd/` 典型场景分析命令
- `config/` 专属调试配置
- `utils/` 辅助工具脚本
- `README_CN.md` 本说明文档
