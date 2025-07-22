it is used to load local application and script from a web link to improve daily work productivity : speed up repeated work by automation.
By click the link , you can do :
. open your local folder, instead of listing its folder content.
. open/edit a local file by your expected application directly, instead of popuping a downloading message box to confirm download..
. run a local script/application with parameter or from your clipboard data.
. connect remote linux folder via local vscode directly.
. connect remote server via ssh protocol directly.
. open remote linux folder via winscp directly.
. connect remote linux server via vnc directly without vnc viewer.
. connect remote windows desktop via windows RDP services directly without manual interaction.


because browser can't run any local application or script from a web link because of security issue.
here use a protocol way to workaround this requirement.

you need to do:
1. update the localAppLoader.bat path to your real local path in localAppLoader.reg
2. double-click file localAppLoader.reg to import it into your register and verify it is imported sucessfully.
3. run the test file  localAppLoader_test.bat or localAppLoader_test.html
   if test it with localAppLoader_test.html, to click one link, one message will popup -- it is sucessfully.
4. update the localAppLoader.bat based on your daily work business.
   the original localAppLoader.bat is my work hub script -- its nested/called script lies in the repo WinScript -- you can find them in my repo list. 
   
how to debug :
1. debug frontend web
   in chrome inspect, debug native_host_handler.js
2. debug backend native host
   in chrome extension check view , click "Service Worker" to debug chrome_msg_listener.js

