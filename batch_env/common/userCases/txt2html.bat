::@set _Echo=1
::set _Stack=%~nx0
::set _Debug=1
@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo. & @echo [+++++ %~nx0] commandLine: %0 %*
where "%~nx0" 1>nul 2>nul || set "path=%~dp0;%path%"
where "tools_message.bat" 1>nul 2>nul || set "path=%~dp0..;%path%"

rem convert file list to html format , and generate one html file
rem uage : txt2html.bat inputlist output_file_name
rem txt2html.bat "C:\Eshell_script\batch_env\common\inputlist.txt" "filelist"
rem txt2html.bat "C:\Eshell_script\batch_env\common\inputlist"
rem if output_file_name is not defined , default output file name is inputlist.html ,defalut path is %cd%
rem 

rem ------------------begin user setting-------------------
rem whether output debug information
rem set DEBUG=1
rem whther delete existing out file , it might be generated by last execution
rem set DEL_EXISTING_HTMLFILE=1
rem ------------------end user setting-------------------

set "inputlist=%~f1"
set "outputhtml=%~f2"

call :processInput %*
call :processListFile
call :showResult
goto :End

:processInput
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
if {"%~1"}=={""} call :processInput.curFolder & goto :eof
call tools_error.bat checkFileExist "%~fs1" "%~fs0" processInputMark1
set "outputhtml=%~2"
if not defined outputhtml set "outputhtml=%~dpn1.html"
if exist "%outputhtml%" del /f/q "%outputhtml%"
goto :eof

:processInput.curFolder
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
set "_tmpOutDir=%cd%\output"
if not exist "%_tmpOutDir%" mkdir "%_tmpOutDir%"
set "inputlist=%_tmpOutDir%\demo.txt"
dir/s/b /A:-D "%cd%" > "%inputlist%"
call :processInput "%inputlist%"
goto :eof

:processListFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
for /f "usebackq tokens=*" %%i in (` type "%inputlist%" `) do call :processListFile.oneFile "%%i"
goto :eof

:processListFile.oneFile
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
call tools_message.bat enableDebugMsg "%~0" "^<A href='%~fs1'^>%~nx1^</A^>^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp; ^>^> '%outputhtml%'"
:: @echo ^<A href="%~fs1"^>%~f1^</A^>^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp;^&nbsp; >> "%outputhtml%"
set "linkTxt=%~f1"
:: set "linkTxt=%linkTxt:-30%"
:: set "linkTxt=%%linkTxt:C:/work/nviddia/nv_repo/=%%"
@echo ^<A href="%~fs1"^>%linkTxt%^</A^>^<br^> >> "%outputhtml%"
goto :eof

:showResult
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [      %~nx0] commandLine: %0 %*
@echo script[%~nx0] execute complete!
@echo output file : %outputhtml%
start "" "%outputhtml%"
goto :eof

:End
@if defined _Stack @for %%a in ( 1 "%~nx0" "%0" ) do @if {"%%~a"}=={"%_Stack%"} @echo [----- %~nx0] commandLine: %0 %* & @echo.