# Platform Environment Initialization Script Library [🌏 中文版](README_CN.md)
This repository provides automation script libraries for Windows and Linux environments to simplify daily development and boost productivity.

# WinDbg Enhancement Scripts [Directory](batch_env/Windbg)
Significantly improves WinDbg debugging experience for high-frequency issue analysis:
- **Context menu integration**: One-click execution of complex debugging tasks, no need to memorize commands.
- **Scenario-based analysis scripts**: Built-in commands for lost call stacks, deadlocks, crashes, memory leaks, etc. Quickly locate issues via double-click or guided steps.
- **Custom command panel**: Integrate frequently used or complex commands for double-click execution.
- **Auto-load debug configs**: Automatically load target-specific configs for seamless switching.

**Proven in production**: Efficiently handles 50+ dump files daily, greatly improving team response speed.
See [READMEN.md](batch_env/Windbg/README.md) for details.

# Workhub (Chrome Extension) [Directory](batch_env/web/chrome_extension)
Integrate web HTML files with local batch scripts (.bat) to centralize routine tasks in a web page. Includes Chrome extension and real examples (e.g., wokhub.html).
By clicking web elements (links), you can:
- Run any local command, with or without parameters
- Open local files or folders with the default app
- Locate and highlight files/folders in Explorer
- Open files/folders in a specified editor (e.g., VS Code)
- Add extra features to Chrome's local folder view ([screencut_localFolder.png](batch_env/web/chrome_extension/install/test/screencut_localFolder.png))
- Auto-generate tool links ([screencut_html.png](batch_env/web/chrome_extension/install/test/screencut_html.png))

See [READMEN.md](batch_env/web/chrome_extension/README.md) for details.

# Windows General Automation [Directory](batch_env/common)
Automate daily Windows tasks:
- Quickly execute common tasks via context menu
- One-click collection of all necessary info from client environments
- Functionality provided as "function + input/output parameters" for high code reuse
- Structure: module → function/object → input parameter → output parameter + return code

## Script Features
- **Self-documenting**: Auto-generate module API docs
- **Debug support**: Fast troubleshooting
    1. Print call stack
    2. Auto-pause on error
    3. Print source path, line, and code in color on error
- **Usage examples**: For unit testing and usability
- **Easy maintenance**: No redundant code

[Linux script bash_env](bash_env)

# Linux GDB Enhancement Scripts [Directory](bash_env/app/gdb)
Provides efficient, cross-platform debugging with native GDB + Bash, matching Windows WinDbg experience:
- **Editor integration**: Auto-open source lines in VS Code or any editor during GDB debugging
- **Cross-machine source sync**: Open source on machine B while debugging on machine A (supports remote dev)
- **Ultra-fast response**: Core operations (e.g., step) respond much faster than VS Code's built-in debugger (<50ms)
- **Lightweight**: 90% pure Bash, minimal Python (core features have no Python dependency)

# Linux General Automation
- Simplify repetitive Linux bash tasks
- Encapsulate common command combinations
- Provide reusable, modular Bash functions with input/output parameters
- Auto-load init scripts via ~/.bashrc or ~/.profile (see setup.sh)