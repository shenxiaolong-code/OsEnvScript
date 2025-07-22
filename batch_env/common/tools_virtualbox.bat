:: @set _Echo=1
:: set _Stack=%~nx0
@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo. & @echo [+++++ %~nx0] commandLine: %0 %*
where VBoxManage.exe 1>nul 2>nul || set "path=C:\Program Files\Oracle\VirtualBox;%path%"
where VBoxManage.exe 1>nul 2>nul || ( echo VBoxManage.exe not found, please install VirtualBox first. & exit /b 1 )
@where colorTxt.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
:: @where %~nx0 1>nul 2>nul || @set "path=%cd%;%path%"
call colorTxt.bat -init

:: @echo %~nx0 %*
if     {"%~1"}=={""} call :usage
if not {"%~1"}=={""} call :%*
goto :END

:impl
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*

goto :eof

:listVMs
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call colorTxt.bat "{%green_L%}listVMs{%end%}{%br%}"
echo VBoxManage.exe list vms
VBoxManage.exe list vms
goto :eof


:startVM
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call :isVmRunning %~1 && (
    call colorTxt.bat "{%brown%}warning: virtual machine %~1 is already running.{%end%}{%br%}"
    exit /b 0
)

:: no GUI
call colorTxt.bat "{%green_L%}startVM{%end%} {%red%}%~1{%end%}{%br%}"
echo VBoxManage.exe startvm "%~1" --type headless
VBoxManage.exe startvm "%~1" --type headless
call colorTxt.bat "{%green_L%}Waiting for the VM to finish initialization ...{%end%}{%br%}"
timeout /T 6 > nul
:: GUI
:: call colorTxt.bat "{%green_L%}startVM{%end%} {%red%}%~1{%end%}{%br%}"
:: echo VBoxManage.exe startvm "%~1" --type gui
:: VBoxManage.exe startvm "%~1" --type gui
call :isVmRunning %~1 || (
    :: echo Failed to start virtual machine linux_ubuntu.
    call colorTxt.bat "{%red%}Error: Failed to start virtual machine %~1.{%end%}{%br%}"
    call colorTxt.bat "{%red%}Please check if the VM name is correct and if VirtualBox is properly installed.{%end%}{%br%}"
    exit /b 1
)
exit /b 0
goto :eof

:startVMdefault
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
REM Use the exact VM name as shown by 'VBoxManage.exe list vms', without extra quotes
call colorTxt.bat "{%green_L%}Starting virtual machine linux_ubuntu...{%end%}{%br%}"
call :startVM linux_ubuntu
exit /b %errorlevel%
goto :eof

:startVMdefaultGUI
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
REM Use the exact VM name as shown by 'VBoxManage.exe list vms', without extra quotes
set "vmName=linux_ubuntu"
VBoxManage.exe list runningvms | findstr %vmName% >nul
if %errorlevel%==0 (
    call colorTxt.bat "{%green%}virtual machine %vmName% is running.{%end%}{%br%}"
    exit /b 0
) else (
    call colorTxt.bat "{%red%}virtual machine %vmName% is not running.{%end%}{%br%}"
    exit /b 1
)

echo VBoxManage.exe startvm "%vmName%" --type gui
VBoxManage.exe startvm "%vmName%" --type gui
call colorTxt.bat "{%green_L%}Waiting for the VM to finish initialization ...{%end%}{%br%}"
timeout /T 6 > nul
call :isVmRunning %vmName% || (
    :: echo Failed to start virtual machine %vmName%.
    call colorTxt.bat "{%red%}Error: Failed to start virtual machine %vmName%.{%end%}{%br%}"
    call colorTxt.bat "{%red%}Please check if the VM name is correct and if VirtualBox is properly installed.{%end%}{%br%}"
    exit /b 1
)
exit /b 0

goto :eof

:stopVM
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call colorTxt.bat "{%green_L%}stopVM{%end%} {%red%}%~1{%end%}{%br%}"
:: Graceful shutdown
echo VBoxManage.exe controlvm "%~1" acpipowerbutton
VBoxManage.exe controlvm "%~1" acpipowerbutton
:: Force shutdown
:: VBoxManage.exe controlvm "%~1" poweroff
goto :eof

:stopVMdefault
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
REM Use the exact VM name as shown by 'VBoxManage.exe list vms', without extra quotes
call :stopVM  linux_ubuntu
goto :eof

:listRunningVMs
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo VBoxManage.exe list runningvms
VBoxManage.exe list runningvms
goto :eof

:isVmRunning
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
VBoxManage.exe list runningvms | findstr %~1 >nul
if %errorlevel%==0 (
    echo virtual machine %~1 is running
    exit /b 0
) else (
    echo virtual machine %~1 is not running
    exit /b 1
)
goto :eof

:isVmRunningDefault
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call :isVmRunning linux_ubuntu
exit /b %errorlevel%
goto :eof

:queryRunningVMIP
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
VBoxManage guestproperty get "%~1" "/VirtualBox/GuestInfo/Net/0/V4/IP"
exit /b %errorlevel%
goto :eof

:queryRunningDefaultVMIP
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call :startVMdefault && call :queryRunningVMIP linux_ubuntu
exit /b %errorlevel%
goto :eof

:usage
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
echo.
call colorTxt.bat "{%green_L%}usage : {%red%}%~nx0 startVMdefault {%end%}{%br%}"
call colorTxt.bat "{%green_L%}e.g.    {%red%}%~nx0 stopVMdefault {%end%}{%br%}"
echo.
echo press any key to exit current script.
pause 1>nul
exit /b 1
goto :eof


:END
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [----- %~nx0] commandLine: %0 %* & @echo.
:: timeout /t 5