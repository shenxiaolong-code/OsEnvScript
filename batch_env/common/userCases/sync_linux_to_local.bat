

@echo off
@title %0 %* 2>nul
@where "%~nx0" 1>nul 2>nul || @set "path=%~dp0;%path%"
@where "tools_linux.bat" 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call %myWinScriptPath%\common\colorTxt.bat "-init"

for /f "delims=" %%# in ('powershell get-date -format "{yyyyMMdd_HHmmss}"') do set "backup_dt=%%#"
if not defined myLocalFolderRoot    set myLocalFolderRoot=C:\work\OneDrive\work_skills\svnRepo\linuxPratice
start "" "%myLocalFolderRoot%"

call :syncLinuxFolder.linuxScript
call :syncLinuxFolder.dockerScript
call :syncLinuxFolder.linuxRepo
goto :END

::download linux shell script.
:syncLinuxFolder.linuxScript
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"}  @echo [      %~nx0] commandLine: %0 %*
call %myWinScriptPath%\common\colorTxt.bat "%green%collect vscode gdb debug setting ... %end%%br%"
:: scp -r user@your.server.example.com:/path/to/foo /home/user/Desktop/
set localFolder=%myLocalFolderRoot%\linuxScript
if exist "%localFolder%\" move /y "%localFolder%" "%localFolder%_%backup_dt%" 
call tools_linux.bat copyLinuxFolder2Local  "/home/xiaolongs/linuxScript" "%localFolder%"
echo Done : %localFolder%
@echo.
goto :eof

::download linux docker script.
:syncLinuxFolder.dockerScript
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"}  @echo [      %~nx0] commandLine: %0 %*
call %myWinScriptPath%\common\colorTxt.bat "%green%collect vscode gdb debug setting ... %end%%br%"
:: scp -r user@your.server.example.com:/path/to/foo /home/user/Desktop/
set localFolder=%myLocalFolderRoot%\docker
if exist "%localFolder%\" move /y "%localFolder%" "%localFolder%_%backup_dt%" 
call tools_linux.bat copyLinuxFolder2Local  "/home/scratch.xiaolongs_gpu_1/docker" "%localFolder%"
echo Done : %localFolder%
@echo.
goto :eof

::download linux cpp program pratice
:syncLinuxFolder.linuxRepo
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"}  @echo [      %~nx0] commandLine: %0 %*
call %myWinScriptPath%\common\colorTxt.bat "%green%collect cpp develop pratice ... %end%%br%"
:: scp -r user@your.server.example.com:/path/to/foo /home/user/Desktop/
set localFolder=%myLocalFolderRoot%\linuxRepo
if exist "%localFolder%\" move /y "%localFolder%" "%localFolder%_%backup_dt%" 
call tools_linux.bat copyLinuxFolder2Local  "/home/xiaolongs/linuxRepo" "%localFolder%"
echo Done : %localFolder%
@echo.
goto :eof


:END
echo ********************************************************************************
echo.
echo Done.  press any key to exit sync application.
echo.
echo %~f0 %*
pause > nul


