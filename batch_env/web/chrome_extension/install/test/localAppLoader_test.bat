@echo off
cls
echo.
start "" "localloader://testURL:/local_vol1_nobackup/xiaoshen/tmp/"
:: start "" "localloader:testURL:/local_vol1_nobackup/xiaoshen/tmp/"

echo if a message box popups , the install/test is sucessfully, else fails.

echo.
timeout /t 30