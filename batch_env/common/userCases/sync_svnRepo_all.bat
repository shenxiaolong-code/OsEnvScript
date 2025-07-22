

@echo off
:: D:\work\oneDrive\work_skills\svnRepo\shenxiaolong\core\WinScript\common\colorTxt.bat
@where colorTxt.bat 1>nul 2>nul || @set "path=%myWinScriptPath%\common;%path%"
call colorTxt.bat -init
echo %~f0
cls
call :syncRepo "%myRepoRoot%"
:: google drive use mirror mode, instead of the stream mode, it can use normal local path.
:: call :syncRepo "G:\My Drive\mySvnRepo"
call :syncRepo "%OneDriveConsumer%\work_skills\svnRepo"
call :syncRepo "D:\temp\git_svn_sync\svn_MiniMPL"
call :syncRepo "C:\work\googleDrive\svn_repo"
goto :END


:syncRepo
echo.
echo ********************************************************************************
call colorTxt.bat "{%green%}sync cloud drive : {%red%}%~1{%end%}{%br%}"
if not exist "%~1" (
    call colorTxt.bat "{%brown%}Skip not existing path : {%red%}%~1{%end%}{%br%}"
    pause
    goto :eof
)
for /f "usebackq tokens=*" %%a in ( ` dir/b "%~1" ` ) do call :syncRepo.one "%~1\%%~a"
call colorTxt.bat "{%brown%}Done sync cloud drive : {%red%}%~1{%end%}{%br%}"
echo.
goto :eof

:syncRepo.one
echo ----------------------------------------------------
call colorTxt.bat "{%blue%}update path : {%cyan%}%~1{%end%}{%br%}"
svn update "%~f1" --accept theirs-full
call colorTxt.bat "{%blue_L%}Done update : {%cyan%}%~1{%end%}{%br%}"
echo.
goto :eof


:END
echo ********************************************************************************
echo.
echo %~f0
call colorTxt.bat "{%brown%}Done.  press any key to exit sync application{%end%}{%br%}"
echo.
pause > nul


