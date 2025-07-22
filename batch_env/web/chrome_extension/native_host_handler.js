// Author    : Shen Xiaolong( xlshen2002@hotmail.com , xlshen@126.com )
// Copyright : free use,modify,spread, but MUST include this original two line information(Author and Copyright).
// this js need support of localAppLoader.bat :  https://github.com/shenxiaolong-code/DailyWorkHub

// TODO :
// monitor special node change for monitor nvidia CI pipeline build result.
// only keep adding css file and javascript file in the extension, remove all features in this extension to improve flexability.
// this extension is only a framework, instead of feature implemnet.

const excludeList = ["www.office.com", "www.google.com.hk","github.com","apps.nvidia.com","blossom.nvidia.com","dox_gen"];
const whiteList   = ["confluence.nvidia.com"];
const specialList = ["gitlab-master.nvidia.com", "jirasw.nvidia.com"];

console.log(document.URL + " ,\nshen xiaolong's chrome extension is loaded! ...... ");
var g_isLocalURL = document.URL.toLowerCase().startsWith("file:///");

var verbose_mode = false;
// var verbose_mode = true;
// g_thisScripts = "file:///D:/work/svnRepo/shenxiaolong/core/shell_script/batch_env/web/chrome_extension/dynamic_create.js"
var g_webDirPath = "D:/work/svnRepo/shenxiaolong/core/shell_script/batch_env/web";
// var g_webDirPath = document.currentScript.src.slice(8, document.currentScript.src.lastIndexOf("/chrome_extension/"));
// var g_webDirPath = document.currentScript.src.substring(0, document.currentScript.src.lastIndexOf('/'));
// g_webDirPath = g_webDirPath.substring(0, g_webDirPath.lastIndexOf('/'));
var g_isLocalUrl  = document.URL.startsWith('file:///');

console.log("g_webDirPath : " + g_webDirPath );
console.log("g_isLocalUrl : " + g_isLocalUrl );
console.log("log verbose_mode : " + verbose_mode );
console.trace();

if (document.readyState === "loading") {
    document.addEventListener('DOMContentLoaded', function() {
        console.log("document is loaded, start to process ...... ");
        chrome_extension_entry();
    });
} else {
    console.log("document already loaded, call chrome_extension_entry directly");
    chrome_extension_entry();
}

var g_url_type;

// -------------------------------------- load complete ---------------------------------------------------------------------------
function debug_alert()
{
    // console.log(arguments.callee.name);
    // alert(arguments.callee.name);
    //alert("debug_alert");
}

function verify_local_file_exist(filePath){
    // console.log("verify_local_file_exist : " + filePath);
    if(!filePath || !filePath.startsWith("file:///")) return false;

    var xhr = new XMLHttpRequest();
    xhr.open('HEAD', filePath, false); // synchronous request
    try {
        xhr.send();
        return xhr.status >= 200 && xhr.status < 300; // check if the file exists
    } catch (e) {
        console.error("Error checking file existence: ", e);
        console.trace();
        return false;
    }
}

function chrome_extension_entry()
{
    // console.log( "[" + arguments.callee.name + "] is loaded ...... ");
    // https://stackoverflow.com/questions/2343343/how-can-i-determine-the-current-line-number-in-javascript
    console.trace();
    
    //1. create auto elements
    inject_possible_css_style_and_js();    

    var bNeedMonitor = false;
    //2. process html elements
    if(isInList(document.URL,excludeList))
    {
        g_url_type="excludeList";
        console.log(document.URL + " is in excluded url list, skip!");        
        return;
    } 
    else if(isInList(document.URL,specialList))
    {
        g_url_type="specialList";
        process_specialList();       // detect special link attribute for special web
        bNeedMonitor = true;
    }
    else if(isInList(document.URL,whiteList))
    {
        g_url_type="whiteList";
        process_whiteList();               // always open link in new tab
        bNeedMonitor = true;
    }
    else if(g_isLocalURL)
    {
        g_url_type="g_isLocalURL";
        process_local_url();
    }
    else
    {
        g_url_type="general";
        // alert(" [debug]  xiaolong's chrome extension is loaded in function chrome_extension_entry . ");    
        console.log("default case is do nothing! ");
    }

    register_click_event_listener();
    
    console.log("[chrome_extension_entry] Done, static loaded documet is processed. ");
    if(bNeedMonitor)
    {
        setup_new_node_monitor();
    }
}

function get_inner_node_href(node) {
    console.log("find href in node : " + node.nodeName );
    if (node.href) {
        return node.href;
    }
    else
    {
        while (node && node.innerHTML !== "" && node.innerHTML != node.innerText ) {
            let tempDiv = document.createElement('div');
            tempDiv.innerHTML = node.innerHTML;
            if ( node == tempDiv)
                break;

            node = tempDiv;
    
            // 检查当前节点是否有 href 属性
            if (node.href && node.href !== "") {
                return node.href;
            }
    
            // 检查所有子节点是否有 href 属性
            const links = node.querySelectorAll('*[href]');
            for (let i = 0; i < links.length; i++) {
                const link = links[i];
                if (link.href && link.href !== "") {
                    return link.href; // 找到非空 href，立即返回
                }
            }
        }
    }
    return ""; // 如果没有找到 href 属性，返回空字符串
}

function process_localloader_url(href){
    if(href && href.toLowerCase().startsWith('localloader://')){
        console.log("process : " + href );        
        const customProtocolUrl = href;      
        // chrome.scripting.executeScript ??
        // because the localapploader.bat can't receive the correct customProtocolUrl , we use the clip as the deliver method as a workaround
        console.log("write message parameter [ " + customProtocolUrl + "] to clipboard." );
        navigator.clipboard.writeText(customProtocolUrl);
        // 发送消息给 background script    
        if (typeof chrome !== 'undefined' && chrome.runtime && chrome.runtime.sendMessage) {
            chrome.runtime.sendMessage({ message: "open_localloader_url", url: customProtocolUrl });
        } else {
            // workaround : Uncaught Error: Extension context invalidated.
            console.warn("chrome.runtime.sendMessage is not available in this context.");
        }
        
        console.log("Done to process : " + customProtocolUrl );
    } 
    else
    {
        console.log("default process url : " + href );
    }
}

function click_event_handler(event){
    const target = event.target;
    if(target.href) {
        console.log("click_event_handler process : " + target.href );
        if(target.href.toLowerCase().startsWith('localloader://')){
            event.preventDefault(); // 阻止默认行为
            process_localloader_url(target.href);
        }
        else 
        {
            console.log("default process event target url : " + target.href );
        }
    }
    /*
    // this branch causes mutliple click event, so disable it.
    else
    {
        href=get_inner_node_href(target);
        if(href && href.toLowerCase().startsWith('localloader://')) {
            event.preventDefault(); // 阻止默认行为
            process_localloader_url(href);
        }
    }
    */
}

function register_click_event_listener(){
    console.log("register_click_event_listener ... ");
    
    // 监听页面上的链接点击事件
    document.addEventListener('click', click_event_handler);
}

function process_local_url()
{   
    console.log("processing local url : " + document.URL );    
    // url begin with : file:///
    var curUrl= document.URL.toLowerCase();
    if ( -1 != curUrl.lastIndexOf('#') )
    {
        curUrl = curUrl.substring(0, curUrl.lastIndexOf('#'));
    }

    if(curUrl.endsWith(".md"))
    {   // check local .md file
        console.log("skip process_local_url because it is markdown file.");
        return true;
    }

    process_local_url_node();
    process_local_url_customized_attribute();
    process_local_url_create_auto_elements_in_head();
}

function process_local_url_node()
{
    console.log("process_local_url_node for local file.");
    if (!document.body) return;
    const matches = document.body.querySelectorAll('a')
        matches.forEach(function (node) {
            process_local_url_link_A(node);
        });
}

function process_added_node_dynamic_by_js(node)
{
    if ("#text" == node.nodeName) {
        return;
    }
    
    if ("A" == node.nodeName) 
    {
        // verbose_mode && console.log(node.href + " [" + arguments.callee.name + "]  is loaded ......" );
        process_dispatch_link_A(node);
    }
    
    if (node.childElementCount > 0)
    {
        const matches = node.querySelectorAll('a')
        matches.forEach(function (subNode) {
            // verbose_mode && console.log(subNode.href + " [" + arguments.callee.name + "]  is loaded ......" );
            process_dispatch_link_A(subNode);
        });
    }
}

function process_dispatch_link_A(node)
{
    // verbose_mode && console.log(node.href + " [" + arguments.callee.name + "]  is loaded ......" );
    if(g_url_type == "specialList")     process_specialList_dynamic_node(node);
    if(g_url_type == "whiteList")       process_whiteList_dynamic_node(node);
    if(g_url_type == "g_isLocalURL")    process_local_url_link_A(node);
}

function process_local_url_customized_localUrl(node,localUrl,bHasBr)
{
    if (!node) return;

    if ( -1 != localUrl.lastIndexOf('#') )
    {
        localUrl = localUrl.substring(0, localUrl.lastIndexOf('#'));
    }
    var innerText = node.innerText.trim();
    if(!innerText)
    {
        var fileName  = localUrl.substring(localUrl.lastIndexOf('/') + 1);
        innerText = fileName;
    }

    var htmlStream = "<a href=\"" + localUrl + "\" ><h3 style=\"display: inline;\">" + innerText + "</h3></a>";
    var localDirPath=localUrl.substring(localUrl.indexOf("C:"),localUrl.lastIndexOf("/"));
    var localDirHtml="&nbsp;[<a class=\"folderIcon\" href=\"" + localDirPath + "\"></a>]"
    htmlStream += localDirHtml ;
    if (bHasBr) {
        // htmlStream += "<br>";
    }
    else
    {
        htmlStream += "&nbsp;&nbsp;";
    }    
    node.innerHTML = htmlStream ;
    // node.outerHTML = htmlStream ;
    set_inline(node);   // now new line    
    //node.insertAdjacentHTML("afterend", localDirHtml );
}

function process_specialList()
{
    console.log("[process_specialList] processing special url : " + document.URL );
    const matches = document.querySelectorAll('a[class="issue-link"],a[class="js-prefetch-document"],a[title="View as plain text"],a[title="Open Blue Ocean"],a[data-qa-selector="pipeline_commit_status"]')
    matches.forEach(function (node) {        
        open_link_A_in_new_tab(node);
    });
}

function process_specialList_dynamic_node(node)
{
    if ("A" != node.nodeName) 
    {
        // verbose_mode && console.log(" [" + arguments.callee.name + "]  is loaded ......" );
        return ;
    }
    // console.log(node.href + " [" + arguments.callee.name + "]  is loaded ......" );
    if(node_hasAttributeValue(node,"class=issue-link,class=js-prefetch-document,title=View as plain text,title=Open Blue Ocean,data-qa-selector=pipeline_commit_status"))
    {
        open_link_A_in_new_tab(node);
    }
}
function node_hasAttributeValue(node,attributeValue)
{
    const attribute_array = attributeValue.split(",");
    attribute_array.forEach(element => {
        const attributes = element.split("=");
        if(node.hasAttribute(attributes[0] && (node.getAttribute(attributes[0])==attributes[1])))
        {
            return true;
        }
    });

    return false;
}

function process_whiteList()
{
    console.log("[process_whiteList] processing whiteList url : " + document.URL );
    const matches = document.querySelectorAll('a')
    matches.forEach(function (node) {
        open_link_A_in_new_tab(node);        
    });
}
function process_whiteList_dynamic_node(node)
{
    if ("A" != node.nodeName) 
    {
        // verbose_mode && console.log(" [" + arguments.callee.name + "]  is loaded ......" );
        return ;
    }
    // console.log(node.href + " [" + arguments.callee.name + "]  is loaded ......" );
    open_link_A_in_new_tab(node);
}

function process_local_url_customized_attribute()
{   
    // processed customized html node attribute
    // console.log(" [" + arguments.callee.name + "]  is loaded ...... ");
    const localUrl_matches = document.querySelectorAll('[localUrl]');
    localUrl_matches.forEach(function (node) {
        process_local_url_customized_localUrl(node, node.getAttribute("localUrl"), !node.getAttribute("oneLine"));
    });

    const pre_matches = document.querySelectorAll('pre[title]');
    pre_matches.forEach(function (node) {        
        var htmlStream = "<B style=\"color: red\">" + node.getAttribute("title") + "</B><br>";
        node.innerHTML = htmlStream + node.innerHTML;
    });

    const TxtColor_matches = document.querySelectorAll('[TxtColor]');
    TxtColor_matches.forEach(function (node) {        
        // example : <B class="TxtColor"> xxxx </B>
        // TxtColor =  "<B class=\"TxtColor\">"  + node.innerHTML + "</B>";
        TxtColor = "<B style=\"color: red\">" + node.innerHTML + "</B>";
        node.innerHTML = TxtColor;
    });

    const inline_matches = document.querySelectorAll('[inline]');
    inline_matches.forEach(function (node) {
        set_inline(node);
    });
}

function add_nvidia_repo_online_url(node)
{    
    // console.log("[" + arguments.callee.name + "]  is loaded ...... ");
    link_href=node.href;
    if( link_href.toLowerCase().startsWith("file:///")  && link_href.includes("/nv_repo/") && ( link_href.includes("/cask6") || link_href.includes("/cask_sdk") ) )
    {
        // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "]  is enabled ...... ");
        let prefixArray = ['https://gitlab-master.nvidia.com/dlarch-fastkernels/cask_sdk/-/blob/dev','https://gitlab-master.nvidia.com/dlarch-fastkernels/cask/-/blob/main'];
        var isCask6 = link_href.includes("/cask6") ? 1:0;
        var tailUrl = link_href.slice(link_href.indexOf("/nv_repo/") + 9);
        if(tailUrl.includes(":")){
            node.href = link_href.slice(0,link_href.lastIndexOf(":"));
            tailUrl = tailUrl.replace(":","#L")
        }
        var onlineUrl = prefixArray[isCask6] + tailUrl.slice(tailUrl.indexOf("/"));        
        var onlineHtml="<a href=\"" + onlineUrl + "\" target=\"_blank\">O</a>"
        return onlineHtml;
        //node.insertAdjacentHTML("afterend", onlineHtml);
    }
    return ""
}

function add_folder_browser_for_local_file(node)
{    
    // console.log("[" + arguments.callee.name + "]  is loaded ...... ");
    if ( !node.href.startsWith("file:///") || node.href.slice(-1)=='/' )
    {
        // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "]  is canceled because it is not local file ...... ");
        return "";
    }

    var fileHtml = "" ;
    var bAddEdit = node.hasAttribute("editable");
    if(!node.hasAttribute("class") && !bAddEdit)
    {
        const exts = [".txt", ".bat", ".cmd"];
        bAddEdit = exts.includes(node.href.slice(-4)) ? 1 : 0; 
    }
    var localPath=node.href.slice(8);       // file:///
    if(bAddEdit)
    {
        fileHtml += "<a style=\"color:rgb(120, 18, 216);text-decoration:none\" title=\"edit file : " + localPath + "\" style=\"text-decoration: none\" href=\"localLoader://editFile:" + localPath + "\"> @ </a>&nbsp;"            
    }

    var folderPath = localPath.substring(0,localPath.lastIndexOf('/'));
    fileHtml += "<a class=\"folderIcon\" style=\"color:rgb(120, 18, 216);text-decoration:none\" title=\"open foler : " + folderPath + "\"  href=\"" + folderPath + "\"> dir </a>"  

    // node.insertAdjacentHTML("afterend", fileHtml);
    return fileHtml;
}

function process_local_url_link_A(node)
{
    if(!node.href) return ;
    // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "]  is loaded ...... ");

    var attr=node.getAttribute('class');
    if (attr)
    {
        if("icon file"  == attr)    process_local_foler_file(node);
        if("icon dir"   == attr)    process_local_foler_dir(node);
        if("icon up"    == attr)    process_local_foler_parent_dir(node);    
    }
    else
    {
        if (verbose_mode)   console.log( node.href + " is general link ... ");
        var html_steam = add_nvidia_repo_online_url(node);
        html_steam += " " + add_folder_browser_for_local_file(node);
        if (html_steam.trim())
        {
            node.insertAdjacentHTML("afterend", " [ " + html_steam + " ] ");
        }
        
        if (!node.innerText.trim())
        {
            if (!node.innerHTML.trim())
            {   // A link content might be picture or other elements
                node.innerText = node.href.trim();
            }
        }
        else
        {
            node.innerText = node.innerText.trim();       
        }
    }
}

// ------------------------ local foler ------------------------------------------------------------
function process_local_foler_file(node)
{
    // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "] is loaded ...... ");        

    // node.innerText = "updated: " + node.innerText;
    var fileType=node.href.substring(node.href.lastIndexOf('.'));
    if(fileType.length > 0 && fileType[0] != ".")
    {   // filter no extension name
        fileType = "";
    }

    // node.innerText = fileType+ " : " + node.innerText;
    var fileLocalPath=node.href.substring(8);    
    if(!path_can_open(fileLocalPath))
    {
        append_info(node.parentNode.parentNode,fileLocalPath,true,true);
        // node.href = "localLoader://openFolder:"+fileLocalPath.substring(0,fileLocalPath.lastIndexOf('/')+1);        
        // node.href = gen_MS_search_string(fileLocalPath);
        return;
    }

    var htmlStream = "<td>";           
    htmlStream += " &nbsp;&nbsp;<a href=\"localLoader://locatePath:" + fileLocalPath + "\">explorer locate</a></td><td>";        

    // let fileEditArray = ['.bat','.cmd','.txt','.ini'];
    if ( ['.bat','.cmd','.txt','.ini'].includes(fileType) ) 
    {
        node.innerText=node.innerText.trim();
        htmlStream += " &nbsp;&nbsp;<a href=\"localLoader://editFile:" + fileLocalPath + "\">edit</a>";        
    } 
    else if(  ['.doc','.pptx','.xlsx','.code-workspace','.msg','.sln','.exe','.msi'].includes(fileType) )
    {
        node.href = "localLoader://openFile:" + fileLocalPath;
    } 
    else if(  ['.zip','.tar','.gz'].includes(fileType) )
    {
        node.href = "localLoader://locatePath:" + fileLocalPath;
    }
    else
    {
        htmlStream += " &nbsp;&nbsp;<a href=\"localLoader://openFile:" + fileLocalPath + "\">defaultOpen</a></td><td>"; 
        htmlStream += " &nbsp;&nbsp;<a href=\"localLoader://vscodeOpen:" + fileLocalPath + "\">vscodeEdit</a>";                
    }
    htmlStream += " </td>";
    
    node.parentNode.parentNode.innerHTML = node.parentNode.parentNode.innerHTML + htmlStream;
}

function process_local_foler_dir(node)
{   
    // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "] is loaded ...... ");        
    var folderLocalPath=node.href.substring(8);    
    if(!path_can_open(folderLocalPath))
    {
        append_info(node.parentNode.parentNode,folderLocalPath,true,true);
        return;
    }

    var htmlStream_head = "<td>";
    htmlStream_head += " &nbsp;&nbsp;<a href=\"localLoader://vscodeOpen:" + folderLocalPath + "\">vscodeOpen</a> </td><td>";        
    htmlStream_head += " &nbsp;&nbsp;<a href=\"localLoader://openFolder:" + folderLocalPath + "\">explorer Open</a> </td>";    
    htmlStream_head += " </td>";    
    
    node.parentNode.parentNode.innerHTML = node.parentNode.parentNode.innerHTML + htmlStream_head;
}

function process_local_foler_parent_dir(node)
{
    // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "] is loaded ...... ");        

    var folderLocalPath = document.location.pathname.substring(1,document.location.pathname.length);  
    if(!path_can_open(folderLocalPath))
    {
        append_info(node.parentNode,folderLocalPath);
        return;
    }
    
    var htmlStream_head = " &nbsp;&nbsp;&nbsp;&nbsp; <a href=\"localLoader://openFolder:" + folderLocalPath + "\">explorer Open</a> ";
    htmlStream_head += " &nbsp;&nbsp;&nbsp;&nbsp; <a href=\"localLoader://vscodeOpen:" + folderLocalPath + "\">vscodeOpen</a> ";
    htmlStream_head += " &nbsp;&nbsp;&nbsp;&nbsp; <a href=\"localLoader://searchFile:" + folderLocalPath + "\">search file</a> ";        
    htmlStream_head += " &nbsp;&nbsp;&nbsp;&nbsp; <a href=\"localLoader://searchContent:" + folderLocalPath + "\">search content</a> ";        
    node.parentNode.innerHTML = node.parentNode.innerHTML + htmlStream_head;
}

// ------------------------ general insert------------------------------------------------------------
function inject_possible_css_style_and_js() 
{    
    if(!document.head) return ;
    // console.log("[" + arguments.callee.name + "] is loaded .....");

    var curUrl= document.URL.toLowerCase();
    if ( -1 != curUrl.lastIndexOf('#') )
    {
        curUrl = curUrl.substring(0, curUrl.lastIndexOf('#'));
    }

    if(curUrl.endsWith(".md"))
    {  // check local .md file
        console.log("skip inject_possible_css_style_and_js because it is markdown file.");
        return;
    }

    var cssFile = document.head.querySelectorAll('link[rel="stylesheet"]');
    if (0 == cssFile.length) 
    {   // avoid conflict with exist css style
        var css_file_path = g_webDirPath + "/css/my_css_style_main.css";
        console.log("loading css file :  file:///" + css_file_path );    
        var htmlStream_head = "<style> @import url(\"" + css_file_path + "\"); </style>";
        // htmlStream_head += "<script type=\"text/javascript\" charset=\"utf-8\" src=\"" + g_webDirPath + "/javascript/in_using/dynamic_create.js\"></script>"
        // D:/work/svnRepo/shenxiaolong/core/shell_script/batch_env/web/chrome_extension/dynamic_create.js"></script>

        console.log("add css tyle because no-css-style setting.");
        document.head.innerHTML += htmlStream_head;
        return;
    }
    else
    {
        console.log("skip inject_possible_css_style_and_js to avoid conflict because css setting exists.");
    }    
}

function process_local_url_create_auto_elements_in_head()
{
    console.log("process_local_url_create_auto_elements_in_head is loading ...");
    // var preTag = document.createElement('pre');
    // var preTag = document.getElementById("first_pre_in_body");
    // get current source file (.html) path
    var thisFilePath = document.URL.substring(8, document.URL.length);
    var thisFolderPath = thisFilePath.substring(0,thisFilePath.lastIndexOf('/')+1);
    // alert(thisFilePath);

    // var htmlStream = "<style> @import url(\"" + g_webDirPath + "/css/my_css_style_main.css\"); </style>";
    // htmlStream =  "<form style=\"display:inline;\">"
    // htmlStream  = "<div autogen=\""+ arguments.callee.name +" from inject.js\">";
    htmlStream = "<B style=\"color: rgb(185, 174, 174)\"> " + thisFilePath + " </B> &nbsp;&nbsp;"
    htmlStream += "<a href=\"localLoader://editFile:" + thisFilePath  + "\" title=\"edit file:" + thisFilePath + "\">edit</a> &nbsp;&nbsp;";
    htmlStream += "<a class=\"folderIcon\" href=\"" + thisFolderPath + "\"  title=\"browse folder:" + thisFolderPath + "\">dir</a> &nbsp;&nbsp; &nbsp;&nbsp; ";
    
    // https://stackoverflow.com/questions/22001674/inline-javascript-onclick-function
    htmlStream += "<button onclick='(function(){ document.querySelectorAll(\"input#cp2clip\")[0].value=\"\"  ; })();' ><B style=\"color: red\">clear</B></button>&nbsp;";
    htmlStream += "<input type=\"text\" id=\"cp2clip\" value=\"copy2clipboad\"> </input>&nbsp;" ;    
    // it seems that javascript can't call the function in browser extension package
    // it can only call built-in function (e.g. alert) and the function which is defined in head ( include the head static-included script )    
    // below doesn't work :
    // htmlStream += "<button onclick='(function(){ debug_alert() ;   })();' > copy_to_clipboard_not_work  </button>";
    // htmlStream += "<button onclick='(function(){ copy_text_to_clipblard(document.querySelectorAll(\"input#cp2clip\")[0].value ) ;   })();' > copy_to_clipboard_not_work  </button>";
    htmlStream += "<button onclick='(function(){ navigator.clipboard.writeText( document.querySelectorAll(\"input#cp2clip\")[0].value ) ; alert(\"path is copied into current system clipboard:\\r\\n\" + document.querySelectorAll(\"input#cp2clip\")[0].value );  ; })();' ><B style=\"color: red\">copy_to_clipboard</B></button>";

    htmlStream += "</div>"    
    // preTag.innerHTML += htmlStream;
    //document.body.insertBefore(preTag,document.body.firstChild);
    document.body.innerHTML = htmlStream + document.body.innerHTML;
    //insertNode(preTag, document.body);
}

// ------------------------ monitor ------------------------------------------------------------
// setup document sub-node add event listener.
var g_observer;
function setup_new_node_monitor()
{
    // console.log( "[" + arguments.callee.name + "] is loaded ...... ");

    g_observer = new MutationObserver(function (mutations) {
        mutations.forEach(function (mutation) {
            for (var i = 0; i < mutation.addedNodes.length; i++)
            process_added_node_dynamic_by_js(mutation.addedNodes[i]);
        })
    });
    monitor_new_node_add_event();
}

function monitor_new_node_add_event()
{    
    // monitor dynamic loaded.        
    var localFolderNodes = document.body.querySelectorAll('div[id="parentDirLinkBox"]');
    var isLocalFolder = localFolderNodes.length > 0;
    if ( !isLocalFolder )
    {
        console.log("[monitor_new_node_add_event] start event listener for adding link node dynamic ...... ");
        // local folder sorting will cause heavily burden and cause chrome hang.
        g_observer.observe(document.documentElement, {
            childList: true,
            subtree: true
        });
    }
    else
    {
        console.log("[monitor_new_node_add_event] disable event listener for local folder! ");
    }
}

// ------------------------ general feature------------------------------------------------------------

function copy_text_to_clipblard(msg, with_alert=true)
{
    if(with_alert)  alert(msg);
    navigator.clipboard.writeText(msg);
    node=document.getElementById("copied");
    if(node) node.textContent = msg;
    console.log('copy_text_to_clipblard : ' + msg);
}

function set_inline(node)
{
    node.setAttribute("style","display: inline-block");         // now new line
}

function open_link_A_in_new_tab(node)
{
    // because current no any browser supports css3 : target-new:tab
    // here workaround to open the link in new tab which has not specified the "target" attribute.
    // https://www.w3schools.com/cssref/css3_pr_target-new.asp
    // https://stackoverflow.com/questions/1265887/call-javascript-function-on-hyperlink-click
    // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "]  is loaded ...... ");
    node.setAttribute("target", "_blank");
    node.onclick = function() { open_link_url_in_new_tab(node)  ; return false ; }
}

function open_link_url_in_new_tab(node)
{
    // alert(node.href);
    // https://www.geeksforgeeks.org/how-to-open-url-in-new-tab-using-javascript/
    window.open(node.href, "_blank");                           // open url in new tab
    return false;
}

function isInList(url,list)
{    
    for (const x of list) { 
        if (url.includes(x))
        {
            return true;
        }
    }
    
    return false;
}

function add_tips(node, tipText)
{
    node.setAttribute("title",tipText);
}

function path_can_open(localPath)
{
    if( -1 != localPath.lastIndexOf(' '))
    {
        return false;
    }

    if( -1 != localPath.lastIndexOf('&'))
    {
        return false;
    }

    if( -1 != localPath.lastIndexOf('%'))
    {
        return false;
    }

    return true;
}

function gen_MS_search_string(fileLocalPath)
{
    var newHref = "search-ms:query=";
    newHref += fileLocalPath.substring(fileLocalPath.lastIndexOf('/') + 1);
    newHref += "&crumb=location:";
    newHref += fileLocalPath.substring(0, fileLocalPath.lastIndexOf('/')).replaceAll('/', '\\');
    newHref += "&"
    // file:///C:/work/nviddia/project_note/cuDNN%20v8%20backend%20API%20Introduction.pptx
    // =>
    // expected : search-ms:query=cuDNN%20v8%20backend%20API%20Introduction.pptx&crumb=location:C:\work\nviddia\project_note&
    return newHref;
}

function append_info(node, localPath, isFile=false,isInTable=false)
{
    // Uncaught TypeError: 'caller', 'callee', and 'arguments' properties may not be accessed on strict mode functions or the arguments objects for calls to them
    // if (verbose_mode)   console.log( node.href + " [" + arguments.callee.name + "] is loaded ...... ");        

    // htmlStream = "<B style=\"color: red\">" + node.innerHTML + "</B>";
    // var htmlStream = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<B style=\"color: red\">path include unsupported char</B>"; 
    var htmlStream = isInTable ? "<td>&nbsp;&nbsp;" : "&nbsp;&nbsp;&nbsp;&nbsp;";
    if(isFile)
    {
        // htmlStream += "<a href=\"search-ms:query=cuDNN%20v8%20backend%20API%20Introduction.pptx&crumb=location:C:\\work\\nviddia\\project_note&\"> OKExample </a> &nbsp;&nbsp;&nbsp;&nbsp; ";
        htmlStream += "<a href=\"" + gen_MS_search_string(localPath) +"\">explorer locate</a>";  
        htmlStream += isInTable ? "</td><td>&nbsp;&nbsp;"  : " &nbsp;&nbsp;&nbsp;&nbsp;";    
    }
    htmlStream += "<button onclick='(function(){ navigator.clipboard.writeText(\"" + localPath + "\") ; \
    alert(\"path is copied into current system clipboard:\\r\\n" + localPath + "\");  ; })();' ><B style=\"color: red\">copy path</B></button>";
    if (isInTable) htmlStream += "</td>";
    node.innerHTML = node.innerHTML + htmlStream ;    
}