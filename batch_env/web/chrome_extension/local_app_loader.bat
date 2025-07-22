::Author    : Shen Xiaolong((xlshen@126.com))
::Copyright : free use,modify,spread, but MUST include this original two line information(Author and Copyright).
::usage     : call batchHandler.bat "localLoader://protocol:anyParameters"
::example   : call batchHandler.bat "localLoader://vscodeOpen:/local_vol1_nobackup/xiaoshen/tmp"

:: parameter %* example : "localLoader://vscodeOpen:C:/work/shenxiaolong/core/shell_script/batch_env/userSetting/contextMenu/localAppLoader/"

:: @set _Echo=1
:: @set _Stack=%~nx0
@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo. & @echo [+++++ %~nx0] commandLine: %0 %*
where "%~nx0" 1>nul 2>nul || set "path=%~dp0;%path%"
call :parserProtocol %*
goto :End

:: ********************************* protocol interfaces ***********************************************************************************
:locatePath
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
start explorer.exe /select, "%~f1"
goto :eof

:openFolder
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
start explorer.exe "%~f1"
goto :eof

:editFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call tools_error.bat checkLabel editFile.impl%~x1 "%~f0" bLabelExist
if      defined bLabelExist call :editFile.impl%~x1 "%~f1"
if not  defined bLabelExist call :editFile.impl.default "%~f1"
goto :eof

:openFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call :openFileWithExplorer "%~f1"
goto :eof

:openSshRemoteFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call tools_dailyWork.bat openSshRemoteFile
goto :eof

:copy2clip
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo %~1 | clip
goto :eof

:clipboard
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_userInput.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
set "_tmpCmd=%~1"
set "_tmpCmd=%_tmpCmd:/=%"
call tools_userInput.bat readClipboard _tmpClipboardData
@where colorTxt.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
if not  defined _tmpClipboardData   call colorTxt.bat  "{02}no data is in clipboard , and using default setting.{\n}{#}"
if      defined _tmpClipboardData   call colorTxt.bat "clipboard data : {0d} %_tmpClipboardData% {\n}{#}"
call :%_tmpCmd% %_tmpClipboardData%
goto :eof

:winscpOpen
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: vscode can't diff folder and file without extension name
call %myWinScriptPath%\Companys\AMD\tools_dailyWork.bat scpOpenFolder %*
echo.
goto :eof

:searchContent
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call %myWinScriptPath%\common\tools_userInput.bat readClipboard sstr
:: call "C:\work\OneDrive\PC_tools\SEARCH~1\SR32.EXE" /i /d /p"C:\work\nv_repo\cask_sdk;kernel_exports.json;" /sdepthwise_convolution_fprop
where SR32.EXE 1>nul 2>nul || set "path=%myPcToolsPath%\SEARCH~1;%path%"
if not defined sstr set "sstr=searchConent"
set "searchDir=%~1"
:: start /B SR32.EXE /i /d /p"%searchDir:/=\%;*.txt;*.bat;*.cmd;*.*;" /s%sstr%
start /B SR32.EXE /i /d /p"%searchDir:/=\%;*.txt;*.bat;*.cmd;*.*;"
echo.
goto :eof

:searchFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call %myWinScriptPath%\common\tools_userInput.bat readClipboard sFileName
if not defined sFileName "set sFileName=sFileName"
where es.exe 1>nul 2>nul || set "path=%myPcToolsPath%\EverythingPortable;%path%"
:: cmdline\es.exe "D:\sourceCode\webex-jabbermeeting\" .sln
:: start /B es.exe "C:\work\nv_repo\cask_sdk" %sFileName%
start /B Everything.exe -p "%~1" -s "%sFileName%" 
echo.
goto :eof

:sshLogin
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: vscode can't diff folder and file without extension name
set "tmpServer=%~1"
if {"%tmpServer:~-1%"}=={"/"} set "tmpServer=%tmpServer:~0,-1%"
call %myWinScriptPath%\Companys\AMD\tools_dailyWork.bat sshLoginLinux %tmpServer%
echo.
goto :eof

:vscodeOpen
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: vscode can't diff folder and file without extension name
set "_tmp=%~1"
if not  {"%~2"}=={""}   call :vscodeOpen.remote %*
if      {"%~2"}=={""}   if      {"%_tmp:~1,1%"}=={":"} call :vscodeOpen.local %*
if      {"%~2"}=={""}   if not  {"%_tmp:~1,1%"}=={":"} call :vscodeOpen.remote %*
echo.
goto :eof

:gitLog
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
set "gitLogPath=%~1"
call tools_error.bat checkPathExist "%gitLogPath%"  "%~f0" gitLogMark
@where TortoiseGitProc.exe 1>nul 2 >nul || set "path=C:\Program Files\TortoiseGit\bin;%path%"
start TortoiseGitProc.exe  /command:log /path:"%gitLogPath%"
echo.
goto :eof

:vncConnect
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where vncviewer.exe 1>nul 2>nul || @set "path=C:\Program Files\RealVNC\VNC Viewer;%path%"
:: withoud password input : vncviewer -> File -> Export Connections : ... to generate the .vnc file
:: "C:\Program Files\RealVNC\VNC Viewer\vncviewer.exe" -config C:\temp\vncexport\srdcws451-1.vnc
start /B vncviewer.exe -config %1
echo.
goto :eof


:runCmd
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where vncviewer.exe 1>nul 2>nul || @set "path=C:\Program Files\RealVNC\VNC Viewer;%path%"
set "tmpCmd=%~1"
if {"%tmpCmd:~-1%"}=={"/"} set "tmpCmd=%tmpCmd:~0,-1%"
if {"%_Stack%"} == {"%~nx0"}    echo "start /B %tmpCmd%"
:: if {"%_Echo%"}  == {"1"}        pause
:: start /B %tmpCmd%
call %tmpCmd%
goto :eof

:testURL
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo commandLine: 
echo %~f0 %0 %*
echo testURL : %*
start /B msg %username% /v /w /time:99999 "test message from %~nx0 : %*"
goto :eof

:: ******************************************* parse protocol *************************************************************************
:parserProtocol
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
set "cmds=%~1"
:: call :parserProtocol.decodeUrl %*
call :parserProtocol.escapeBlank
set "localURL=%cmds:~12%"         &;rem remove protocol part localLoader:
:: echo localURL=%localURL%
if {"%localURL:~0,2%"}=={"//"}   set "localURL=%localURL:~2%"
:: echo localURL=%localURL%
set appVar=%localURL::=&;rem %
:: echo appVar=%appVar%
set "argVar=%localURL:*:=%"
:: echo argVar=%argVar%
call :%appVar% "%argVar%"
goto :eof

:parserProtocol.decodeUrl
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: can't resolve %% issue : it will expand the bat variable. e.g.  %E6% => E6
:: file:///C:/work/OneDrive/work_skills/english/%E6%97%A5%E5%B8%B8%E7%94%A8%E8%AF%AD%E8%8B%B1%E6%96%87%E7%BC%A9%E5%86%99.txt
:: decode to :
:: file:///C:/work/OneDrive/work_skills/english/日常用语英文缩写.txt
call set "url=%~1"
:: 使用PowerShell命令解码URL
set "powershellScript=[System.Web.HttpUtility]::UrlDecode('%url%')"
for /f "delims=" %%i in ('powershell -Command "& {%powershellScript%}"') do set "decodedPath=%%i"
echo "decodedPath : %decodedPath%"
pause   &;rem fix me
goto :eof

:parserProtocol.escapeBlank
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
if defined _Debug echo before : %cmds%
:: re-escape blank char with # because localLoader protocol needs to use # to escape blank char. else an illegal char is embedded.
:: example   : <a href="localLoader://runCmd:cmd.exe /c C:/work/OneDrive/sync_svnRepo_all.bat"> update svn repo to cloud disk  </a> 
:: escape to : <a href="localLoader://runCmd:cmd.exe!/c!C:/work/OneDrive/sync_svnRepo_all.bat"> update svn repo to cloud disk  </a> 
:: example : start /B cmd.exe /c c:\temp\myScript.bat "enable"
set "cmds=%cmds:!= %"
if defined _Debug echo after  : %cmds%
goto :eof

:: ******************************************* inner implement begin *************************************************************************

:editFile.impl
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call :vscodeOpen %*
goto :eof

:editFile.impl.bat
:editFile.impl.txt
:editFile.impl.log
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call tools_txtFile.bat openTxtFile "%~f1"
goto :eof

:editFile.impl.default
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call :vscodeOpen.local "%~f1"
goto :eof

:editFile.impl.html
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call :vscodeOpen.local "%~f1"
goto :eof

:openFileWithExplorer
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_txtFile.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
echo explorer.exe open file : %~f1
start /B explorer.exe "%~f1"
goto :eof

:vscodeOpen.remote
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: call :vscodeOpen.remote.checkServerAndPath %*
call %myWinScriptPath%\common\tools_linux.bat vscodeOpen "computelab-303.nvidia.com" "%~1"
echo.
goto :eof

:vscodeOpen.local
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: code.cmd --help
@where tools_error.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call tools_error.bat checkPathExist "%~1"
:: where Code.exe    1>nul 2>nul || @set "path=%LOCALAPPDATA%\Programs\Microsoft VS Code\;%path%"
:: start /B Code.exe -n --log off "%~1"
where Code.exe  1>nul 2>nul || @set "path=%LOCALAPPDATA%\Programs\Microsoft VS Code\;%path%"
start /B Code.exe -n --log off "%~1"
echo.
goto :eof

:errorMsg
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo.
echo %*
echo.
pause 
goto :End
goto :eof

:: ******************************************* inner implement end *************************************************************************
:End
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [----- %~nx0] commandLine: %0 %* & @echo.
if {"%_Stack%"} == {"%~nx0"}    pause
if {"%_Echo%"}  == {"1"}        pause