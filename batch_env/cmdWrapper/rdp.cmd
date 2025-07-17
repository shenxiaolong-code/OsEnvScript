set "ip=%~1"
set "usrName=%~2"
set "usrPwd=%~3"
start cmdkey.exe /generic:%ip% /user:%usrName% /pass:"%usrPwd%" & start mstsc.exe /v %ip%