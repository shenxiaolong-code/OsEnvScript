## Purpose [中文版](./README_CN.md)
This directory is designed to enable interaction between web HTML files and local batch scripts (.bat), allowing you to integrate common tasks into a web page and improve work efficiency. It includes a Chrome extension and a practical example (such as wokhub.html).

Screenshot examples:  
Web page: [web/chrome_extension/install/test/screencut_html.png](./web/chrome_extension/install/test/screencut_html.png)  
Local folder: [web/chrome_extension/install/test/screencut_localFolder.png](./web/chrome_extension/install/test/screencut_localFolder.png)

## Features
- Run any local command, with or without parameters
- Open local files or folders with the system's default associated program
- Locate and highlight specific files or folders in File Explorer
- Open files or folders with a specified editor (such as VS Code)
- Provide extra features for local directory pages opened by Chrome (see [screencut_localFolder.png](./web/chrome_extension/install/test/screencut_localFolder.png))
- Auto-generate common tool links (see the auto-generated section in [screencut_html.png](./web/chrome_extension/install/test/screencut_html.png))

All features are implemented by scripts. A console window will pop up during execution. If you want to hide the console, you can use chrome_native_handler.exe instead of chrome_native_handler.bat, but for easier debugging, the exe version is not provided in this package.

## Customization & Enhancement
To personalize or customize your own workhub, modify the following two files (refer to existing examples in the code):
- Web integration file: [web/wokhub.html](./web/wokhub.html)
- Local handler script: [web/chrome_extension/local_app_loader.bat](./web/chrome_extension/local_app_loader.bat)

## Implementation Principle
- In HTML files, set the href of an element to use the localLoader:// protocol. When clicked, the event is handled by the local script [chrome_native_handler.bat](./web/chrome_extension/chrome_native_handler.bat).
- This script extracts the protocol parameters and passes them to [chrome_extension/local_app_loader.bat](./web/chrome_extension/local_app_loader.bat).
- local_app_loader.bat processes the localLoader:// protocol and supports the following commands:
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

## Usage
1. After downloading the complete batch_env, modify all relevant paths in the web/chrome_extension directory to match your local environment.
2. Edit [web/chrome_extension/chrome_native_handler.json](./web/chrome_extension/chrome_native_handler.json) and set the chrome-extension field to your own extension ID.
   - How: Load this extension in Chrome, find it in the extension manager, copy the extension ID, and update the json file.
3. Import [web/chrome_extension/install/localapploader_install.reg](./web/chrome_extension/install/localapploader_install.reg) to install the extension.
4. Open [localAppLoader_test.html](./web/chrome_extension/install/test/localAppLoader_test.html) in Chrome to test the installation (a Windows message box should pop up if successful).

> Windows only.

If you have any questions, please contact the project maintainer or refer to the main `README_CN.md`.
