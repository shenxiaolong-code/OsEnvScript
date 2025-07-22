
console.log("Chrome extension message listener is initialized.");
chrome.runtime.onMessage.addListener(
  function(request, sender, sendResponse) {
    console.log("received click message " + request );
    if (request.message === "open_localloader_url") {
      console.log("process received open_localloader_url message : " + request.url);
      const customProtocolUrl = request.url;

      // 创建包含 URL 的 JSON 对象
      const message = { "url": customProtocolUrl };

      // 将 JSON 对象转换为字符串
      const messageString = JSON.stringify(message);

      // 连接到 Native Host
      const port = chrome.runtime.connectNative('com.example.localapploader');
      if(port) {
        console.log("sucessful to connectNative with port : " + port);
        console.log("[" + new Date().toLocaleTimeString()+ "] send message to native host , nsg : " + messageString);

        // 发送消息给 Native Host
        port.postMessage(messageString);

        /*
        // single direct message, needn't listen the native message
        // 监听来自 Native Host 的消息（可选）
        port.onMessage.addListener(function(msg) {
          console.log("Received from Native Host: " + msg);
        });

        port.onDisconnect.addListener(function() {
          console.log("Disconnected from Native Host");
        });
        */

        console.log("[" + new Date().toLocaleTimeString()+ "] Done to send message to native host.");
      }
      else
      {
        console.log("Fails to connectNative");
      }
    }
    else {
      console.log("Received unknown message: " + request.message);
    }
  }
);
