# WinScript [中文版](./README_CN.md)

WinScript is a Windows batch scripting support library, widely used in my automation tools and daily workflows.

# Purpose

This library is designed for daily work automation:

- Quickly execute common daily tasks via right-click menu.
- Collect all necessary information from customer environments with one click, no complex commands required.
- Like many advanced programming languages, this library provides features in a "function + input/output parameter" style for high code reusability.
- Structure: module → function/object → input parameter → output parameter + return code.

---

## WinDbg Enhancement Scripts

This script set greatly improves the debugging experience of WinDbg in high-frequency failure analysis scenarios:

- **Right-click menu integration for common operations**: Execute complex debugging tasks with one click, no need to remember complicated commands.
- **Scenario-specific analysis scripts**: Built-in commands for typical scenarios such as lost secondary exception call stacks, deadlocks, crashes, memory leaks, etc. Users can quickly locate problems by double-clicking commands or following step-by-step prompts.
- **Custom high-frequency command panel**: Integrate frequently used or hard-to-remember long commands into a custom panel, supporting double-click execution for maximum efficiency.
- **Auto-load dedicated debug configurations**: Automatically load dedicated debug configurations based on the target program, achieving zero-switching cost and a one-stop entry.

**Proven in practice**: Efficiently handles 50+ dump files per day in production, greatly improving team problem diagnosis and response speed.

---
## Workhub (Chrome Integration)
Enables interaction between web HTML files and local batch scripts (.bat), allowing you to integrate common tasks into a web page and improve work efficiency. Includes a Chrome extension and practical examples (such as wokhub.html).
- Run any local command, with or without parameters
- Open local files or folders with the system's default associated program
- Locate and highlight specific files or folders in File Explorer
- Open files or folders with a specified editor (such as VS Code)
- Provide extra features for local directory pages opened by Chrome (see [screencut_localFolder.png](./batch_env/web/chrome_extension/install/test/screencut_localFolder.png))
- Auto-generate common tool links (see the auto-generated section in [screencut_html.png](./batch_env/web/chrome_extension/install/test/screencut_html.png))

For detailed usage, see [web/chrome_extension/README.md](./batch_env/web/chrome_extension/README.md)

---

# Script Features Overview

- **Self-documenting**: Can automatically generate module API documentation.
- **Debug support**: Helps developers quickly locate problems.
    1. Supports printing function call stacks.
    2. Automatically pauses on errors.
    3. Automatically prints source path, line number, and error code in color on error.
- **Example use cases**: Helps with unit testing and improves usability.
- **Easy to maintain and update**: No redundant code.

---

# Usage Examples

See: [Usage Examples](https://github.com/ShenXiaolong1976/WinScript/tree/master/common/userCases)
