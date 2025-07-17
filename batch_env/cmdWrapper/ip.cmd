@echo off
set ipV4=
for /f "usebackq tokens=2 delims=:" %%i in ( ` ipconfig ^| find /i "IPv4 Address" ` ) do if not defined ipV4 set ipV4=%%i
set "ipV4=%ipV4: =%"
echo "%ipV4%" is copied into curremt system clipboard.
echo %ipV4%| clip