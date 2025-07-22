## 目的 [🌍 English Version](./README.md)
本目录用于实现网页 HTML 文件与本地批处理脚本（.bat）的交互，将常用工作集成到网页中，提高工作效率。包含 Chrome 扩展及其实际样例（如 wokhub.html）。

截图示例：  
网页文件: [web/chrome_extension/install/test/screencut_html.png](./web/chrome_extension/install/test/screencut_html.png)  
本机目录: [web/chrome_extension/install/test/screencut_localFolder.png](./web/chrome_extension/install/test/screencut_localFolder.png)

## 功能
- 运行本地任意命令，或带参数运行本地命令
- 调用系统默认关联程序打开本地文件或目录
- 在资源管理器中定位并高亮显示指定文件或目录
- 用指定编辑器（如 VS Code）打开文件或目录
- 自动为 Chrome 打开的本地目录页面提供额外功能，见 [web/chrome_extension/install/test/screencut_localFolder.png](./web/chrome_extension/install/test/screencut_localFolder.png)
- 自动生成常用工具链接，见 [web/chrome_extension/install/test/screencut_html.png](./web/chrome_extension/install/test/screencut_html.png) 自动生成部分

所有功能均由脚本实现，执行时会弹出控制台窗口。如需隐藏控制台，可用 chrome_native_handler.exe 替换 chrome_native_handler.bat，但为便于观察执行过程，本包未提供 exe 版本。

## 定制增强
个性化或定制你自己的 workhub，可修改以下两个文件（可参考已有同类例子）：
- 网页集成文件 [web/wokhub.html](./web/wokhub.html)
- 本机处理脚本 [web/chrome_extension/local_app_loader.bat](./web/chrome_extension/local_app_loader.bat)

## 实现原理
- 在 HTML 文件中，元素 href 使用 localLoader:// 协议，点击后由本地脚本 [chrome_native_handler.bat](./web/chrome_extension/chrome_native_handler.bat) 接管。
- 该脚本提取协议参数并传递给 [chrome_extension/local_app_loader.bat](./web/chrome_extension/local_app_loader.bat)。
- local_app_loader.bat 处理 localLoader:// 协议，支持如下命令：
  * runCmd
  * locatePath
  * openFolder
  * editFile
  * openFile
  * openSshRemoteFile
  * copy2clip
  * winscpOpen
  * searchContent
  * searchFile
  * sshLogin
  * vscodeOpen
  * vncConnect
  * testURL

## 使用方法
1. 下载完整 batch_env 后，修改 web/chrome_extension 目录下所有涉及路径的地方为本地实际路径。
2. 修改 [web/chrome_extension/chrome_native_handler.json](./web/chrome_extension/chrome_native_handler.json) 中的 chrome-extension 字段为你自己的扩展 ID。
   - 方法：在 Chrome 加载本扩展后，在扩展管理器中复制扩展 ID，更新到 json 文件。
3. 导入 [web/chrome_extension/install/localapploader_install.reg](./web/chrome_extension/install/localapploader_install.reg) 安装本扩展。
4. 在 Chrome 中打开 [localAppLoader_test.html](./web/chrome_extension/install/test/localAppLoader_test.html) 测试安装是否成功（成功会弹出 Windows 消息窗）。

> 仅支持 Windows 系统。

如有疑问，请联系项目维护者或查阅主目录下的 `README_CN.md`。
