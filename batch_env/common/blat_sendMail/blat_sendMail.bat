@if {"%_Echo%"}=={"1"} ( @echo on ) else ( @echo off )
::Blat configure parameters
set smtpServer=smtpout.ap.mt.mtnet
set mailSender=tony.shen@mt.com
set retryTimes=1

::test Blat send mail parameter
set recipientList=tony.shen@mt.com
::set recipientList=xufeng.sheng@mt.com,tony.shen@mt.com
set mailTitle="My Mail Title"
set mailBody="My Mail Body"
set mailBodyFile=%~f0
set mailAttached=%~f0

::configure blat
::for exchange "cn11se32.ap.mt.mtnet", try its smtp server as "smtpout.ap.mt.mtnet"
::it result will be saved in registry "HKEY_LOCAL_MACHINE\SOFTWARE\Public Domain"
@echo configure blat: blat -install %smtpServer% %mailSender% %retryTimes%
blat -install %smtpServer% %mailSender% %retryTimes%

@echo send mail to %recipientList%
@echo.
@echo first mail ^> ^> ^> ^> ^> ^> ^> ^> 
blat.exe %mailBodyFile% -to %recipientList%  -s %mailTitle% -attach %mailAttached%
@echo.
@echo second mail ^> ^> ^> ^> ^> ^> ^> ^> 
blat.exe dummyBodyFile -to %recipientList%  -s %mailTitle% -body %mailBody% -attach %mailAttached%
@echo.
@echo third mail ^> ^> ^> ^> ^> ^> ^> ^>
@echo pls input mail message(end with ^^Z and return key):
blat.exe - -to %recipientList%  -s %mailTitle% -attach %mailAttached% 

