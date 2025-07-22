
:: response immediately
echo { "result": "success", "message": "Received and processing" }

echo test : %~f0
echo receive %*

set "cur_base_dir=%~dp0"
set "cur_base_dir=%cur_base_dir:~0,-1%"

call %cur_base_dir%\..\..\common\tools_userInput.bat readClipboard clip_msg

:: expect : localloader://openFile:C:/work/nvidia/note/vscode_workspace/empty.code-workspace
(
    echo.
    echo receive date  %date% %time%
    echo log from : %~f0
    echo receive %*
    echo from clip : %clip_msg%            
) >>  %TEMP%\history.txt


:: need console window to debug issue, use start command
start "" %cur_base_dir%\local_app_loader.bat %clip_msg%
:: use call command to avoid console window without debug
:: call %cur_base_dir%\local_app_loader.bat %clip_msg%

exit /b 0

