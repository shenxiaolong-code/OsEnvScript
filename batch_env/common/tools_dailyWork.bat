::@set _Echo=1
::set _Stack=%~nx0
::set _Debug=1
@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
@@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo. & @echo [+++++ %~nx0] commandLine: %0 %*
@echo %~fs0 %*
@where "%~nx0" 1>nul 2>nul || @set "path=%~dp0;%path%"
@where "tools_amd.bat" 1>nul 2>nul || @set "path=%~dp0..;%path%"

set supportedCmds=;openSshRemoteFile;vscodeOpen;startVMdefaultGUI;
call :devTest %*
goto End

::******************************inner implement  section**************************************************************************
:task.openSshRemoteFile
:: call :task.openSshRemoteFile <linuxServerName> <linuxServerPath>
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
:: call :task.openSshRemoteFile <linuxServerName> <linuxServerPath>
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_virtualbox.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call tools_virtualbox.bat startVMdefault && for /f "tokens=2 delims=:" %%i in ('call tools_virtualbox.bat queryRunningDefaultVMIP ^| findstr "Value: "') do set "vm_ip=%%i"
call tools_string.bat TrimString "%vm_ip%" vm_ip
call colorTxt.bat "{%green_L%}current running vm ip is {%brown_L%}%vm_ip%{%end%}{%br%}"
where code.cmd 1>nul 2>nul || @set "path=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin;%path%"
set "vm_username=xlshen"
:: start code.cmd --folder-uri "vscode-remote://ssh-remote+%vm_username%@%vm_ip%//home/xlshen/scratch/shell_script/bash_env/" --add "/home/xlshen/scratch/tmp/"
:: echo start code.cmd --folder-uri "vscode-remote://ssh-remote+%vm_username%@%vm_ip%//home/xlshen/scratch/shell_script/bash_env/"
:: start code.cmd --folder-uri "vscode-remote://ssh-remote+%vm_username%@%vm_ip%//home/xlshen/scratch/shell_script/bash_env/"
echo start code.cmd --file-uri "vscode-remote://ssh-remote+%vm_username%@%vm_ip%//home/xlshen/scratch/shell_script/bash_env/app/vscode/workspace/daily.code-workspace"
start code.cmd --file-uri "vscode-remote://ssh-remote+%vm_username%@%vm_ip%//home/xlshen/scratch/shell_script/bash_env/app/vscode/workspace/daily.code-workspace"
goto :eof


:task.vscodeOpen
:: call :task.vscodeOpen <filePath>
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
where code.exe 1>nul 2>nul || @set "path=%LOCALAPPDATA%\Programs\Microsoft VS Code\bin;%path%"
where code.exe 1>nul 2>nul || call tools_message.bat errorMsg "Can't find code.exe"  "%~fs0" "vscodeOpen.mark"
echo start "" code.exe "%~f1"
start "" code.exe "%~f1"
goto :eof


:task.startVMdefaultGUI
:: call :task.startVMdefaultGUI
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_virtualbox.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call tools_virtualbox.bat startVMdefaultGUI 
goto :eof

::****************************** framework section**************************************************************************
:devTest
set noSleepGlobal=1
set noPauseGlobal=1
call :checkParameter %*
call :processInput %*
goto :eof

:runCmds
title %*
echo %*
if not defined dryRun call %*
goto :eof

:checkParameter
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@where tools_error.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
:: call tools_error.bat checkParamCount 2 %*
call tools_error.bat checkSupportedCmd "%~1" "%supportedCmds%"
:: call tools_error.bat checkSupportedCmd "%~1" "%supportedCmds%" "%~f0" "checkParameter.mark1"
:: call tools_error.bat checkPathExist "%~f2" "%~f0" "checkParameter.mark2"
@where tools_amd.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\Companys\AMD;%path%"
goto :eof

:processInput
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call :task.%*
goto :eof

::*******************************************************************************************************************

:End
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [----- %~nx0] commandLine: %0 %* & @echo.
:: call tools_message.bat noSleepMsg "%~n0" 5 "quiet"
if {"%_Stack%"} == {"%~nx0"}    pause
if {"%_Echo%"}  == {"1"}        pause