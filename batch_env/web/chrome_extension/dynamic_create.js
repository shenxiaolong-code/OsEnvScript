/*
Author    : Shen Xiaolong((xlshen@126.com))
Copyright : free use,modify,spread, but MUST include this original two line information(Author and Copyright).
this js need support of localAppLoader.bat :  https://github.com/shenxiaolong-code/DailyWorkHub
*/
console.log(document.URL + " is loaded! ...... ");
console.log(document.currentScript.src + " is loaded! ...... ");

// document.currentScript.src = "file:///D:/work/svnRepo/shenxiaolong/core/shell_script/batch_env/web/chrome_extension/dynamic_create.js"
// var g_repoDirPath="D:/work/oneDrive/work_skills/svnRepo/shenxiaolong"
var g_repoDirPath = document.currentScript.src.slice(8, document.currentScript.src.lastIndexOf("/shenxiaolong/"));
var g_webDirPath  = document.currentScript.src.slice(8, document.currentScript.src.lastIndexOf("/chrome_extension/"));
var g_isLocalUrl  = document.URL.startsWith('file:///');

console.log("g_repoDirPath = " + g_repoDirPath);
console.log("g_webDirPath = " + g_webDirPath);
console.log("g_isLocalUrl = " + g_isLocalUrl);

/*
// way 1 : recommended way
use script defer load method : https://stackoverflow.com/questions/807878/how-to-make-javascript-execute-after-page-load
use : <script type="text/javascript" defer charset="utf-8"  src="../javascript/in_using/defer_load.js"></script>
to load js file after the document is loaded
document.addEventListener('DOMContentLoaded', function()
{
    // doSomething();   
}, false);
 */
document.addEventListener('DOMContentLoaded', function () {
    create_all_auto_elements_in_head()
}, false)


/*
// way 2 : it will bring additional workload for html development
<body onload="bodyOnLoad()">
*/
function bodyOnLoad() {
    create_all_auto_elements_in_head()
}

// ------------------------ business procedure  ------------------------------------------------------------

function create_all_auto_elements_in_head() {
    // var preTag = document.createElement('pre');
    // var preTag = document.getElementById("first_pre_in_body");
    // get current source file (.html) path
    var thisFilePath = document.URL.substring(8, document.URL.length);
    var thisFolderPath = thisFilePath.substring(0, thisFilePath.lastIndexOf('/') + 1);
    // alert(thisFilePath);

    htmlStream = "<div autogen=\"" + arguments.callee.name + " from dynamic_create.js\">";
    htmlStream += "<a href=\"localLoader://vscodeOpen:" + g_webDirPath + "/javascript/in_using/inject_chrome_auto\">my_extension</a> &nbsp;";
    htmlStream += "[<a class=\"folderIcon\" href=\"" + g_webDirPath + "/\">dir</a>]  &nbsp;";
    htmlStream += "<a href=\"localLoader://editFile:" + g_webDirPath + "/css_build-in/my_css_style_general.css\">my_css_style_general.css</a>  &nbsp;&nbsp;";
    htmlStream += "<a href=\"localLoader://editFile:" + g_webDirPath + "/javascript/in_using/inject_chrome_auto/dynamic_create.js\">dynamic_create.js</a>  &nbsp;&nbsp;";
    htmlStream += "<a href=\"localLoader://editFile:" + g_repoDirPath + "/core/shell_script/batch_env/web/chrome_extension/local_app_loader.bat\">localAppLoader.bat</a> &nbsp;&nbsp;";

    htmlStream += "<a href=\"" + g_repoDirPath + "/core/Note/app_internal/chrome_tips.txt\">chrome_tips</a> &nbsp;&nbsp;";
    htmlStream += "<a href=\"localLoader://vscodeOpen:" + g_repoDirPath + "/setupEnvironment/VSCode_setting/vscode_plugin\">vscode plugin</a> &nbsp;&nbsp;";
    htmlStream += "<a href=\"localLoader://runCmd:calc.exe\">calc.exe</a>  &nbsp;&nbsp;";
    if (!document.URL.endsWith("wokhub.html")) {
        htmlStream += "<a TxtColor href=\""+ g_webDirPath +"/wokhub.html\">通用参考</a>  &nbsp;&nbsp;";
    }
    
    htmlStream += "</div>"

    // preTag.innerHTML += htmlStream;
    //document.body.insertBefore(preTag,document.body.firstChild);
    document.body.innerHTML = htmlStream + document.body.innerHTML;
    //insertNode(preTag, document.body);

    test_body_on_load_event(thisFilePath);
}

function set_path_for_test(node, localUrl, bHasBr = true) {
    if (!node) return;

    if (-1 != localUrl.lastIndexOf('#')) {
        localUrl = localUrl.substring(0, localUrl.lastIndexOf('#'));
    }

    var localFolder = localUrl.substring(0, localUrl.lastIndexOf('/') + 1);
    var fileName = localUrl.substring(localUrl.lastIndexOf('/') + 1);
    var innerText = node.innerText.trim();
    if (!innerText) {
        innerText = fileName;
    }
    else {
        node.innerText = ""
    }

    var htmlStream = "<a href=\"" + localUrl + "\" ><h3 style=\"display: inline;\">" + innerText + "</h3></a>";
    if (bHasBr) {
        htmlStream += "<br>";
    }
    else {
        htmlStream += "&nbsp;&nbsp;";
    }

    // alert(htmlStream);
    node.innerHTML = htmlStream + node.innerHTML;
    node.setAttribute("style", "display: inline-block");         // now new line
}



// ------------------------------ test ------------------------------------------------------
function test_body_on_load_event(curFilePath) {
    // select single element to set conent
    set_path_for_test(document.getElementById('srcPath'), curFilePath);

    // select a group of elements to set conent
    //select <nobr> elements who has attribute "selectTest"
    const matches = document.querySelectorAll("nobr[selectTest]");
    matches.forEach(function (testNode) {
        set_path_for_test(testNode, curFilePath, false);
    });
}

// ------------------------------  dynamic create example  ------------------------------------------------------

function dynamicCreate_pre() {
    var preTag = document.createElement('pre');
    var txt = document.createTextNode("This is a preformatted text.");
    preTag.appendChild(txt);

    document.getElementById("dynamicCreate_pos_id").appendChild(preTag);
    // document.body.appendChild(preTag);
}

function dynamicCreate_tabe() {

    var maxRows = 4;
    var newTable = document.createElement('table');
    newTable.id = "a-table";
    for (var i = 0; i < maxRows; i++) {
        var tr = document.createElement('tr');
        tr.id = "myrow" + i;
        var td1 = document.createElement('td');
        var td2 = document.createElement('td');
        var td3 = document.createElement('td');

        tr.appendChild(td1);
        tr.appendChild(td2);
        tr.appendChild(td3);

        newTable.appendChild(tr);
    }
    document.getElementById("dynamicCreate_pos_id").appendChild(newTable);
    // document.body.appendChild(table);
    // var cells = document.getElementById("a-table").getElementsByTagName("td");
    var cells = newTable.getElementsByTagName("td");
    var i = 0;
    for (i = 0; i < maxRows + 1; i++) {
        var cell = cells[i];
        cell.innerHTML = "cell " + i;
    }
}

// ------------------------------------------------------------------------------------