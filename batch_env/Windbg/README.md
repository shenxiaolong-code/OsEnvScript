# WinDbg Enhancement Script Suite  [🌏 中文版](README_CN.md)

This directory contains a set of enhancement scripts for the Windows WinDbg debugger, designed to greatly improve efficiency and experience in high-frequency troubleshooting scenarios.

## Main Features

- **Context Menu Integration** [Directory](contextMenu/)
  
  One-click execution of common debugging tasks, no need to memorize complex commands, greatly simplifying the workflow.

- **Scenario-Based Analysis Scripts** [Directory](script/cmds/)
  
  Built-in commands for typical scenarios such as lost call stacks on second-chance exceptions, deadlocks, crashes, and memory leaks. Quickly locate issues via double-click or step-by-step prompts.

- **Custom High-Frequency Command Panel** [cmdTree.dbg](script/loadSetting/cmdTree.dbg) [cmdTree_cur.dbg](script/loadSetting/cmdTree_cur.dbg)
  
  Integrate frequently used or complex commands into a custom panel for double-click execution, improving debugging efficiency.

- **Auto-Loading Dedicated Debug Configurations** [Directory](script/loadSetting/)
  
  Automatically load dedicated debug configurations based on the target program for seamless switching and a unified entry point.

- **Batch Dump File Processing** [tools_windbg.bat](tools_windbg.bat)
  
  Supports batch analysis and processing of dump files, suitable for high-frequency issue diagnosis in production environments.

## Usage
- Directly load scripts via command line:
  ```
  gdb -x script/startCmds.dbg ...
  ```
- Advanced: Customize scripts to let the initialization script auto-search and match. Example: [configCustomizedPath_example.bat](setup/configCustomizedPath_example.bat)
- Simple: Use the desktop context menu to auto-load [contextMenu](contextMenu/)

## Highlights

- Proven in production, efficiently handling 50+ dump files daily and significantly improving team response speed.
- Clear script structure, easy to extend and maintain.
- Supports custom extensions for team collaboration and knowledge accumulation.

## Directory Structure

- `menu/` Context menu related scripts
- `cmd/` Typical scenario analysis commands
- `config/` Dedicated debug configurations
- `utils/` Utility scripts
- `README.md` This documentation
