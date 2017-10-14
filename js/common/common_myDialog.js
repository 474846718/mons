/**
 * @author Tianhan
 */
var bluedot_tb_checkboxName="";//定义列表中复选框的名称
var bluedot_head_checkboxId="";//定义列表头的复选框id，获取其单击事件，实现全选和取消
//添加修改删除中调用的打开窗口方法，如果有特殊需求，可以在调用页面重写该方法
function openDialog(urlStr)
{ 
  return openDialogWin(urlStr,"",850,600,0,50);
}

//obj为当前form的名字,没有为null
function openDialogWin(urlStr,obj,width,height,left,top)
{
    top+= (window.screen.availHeight-height)/2;
    left+=(window.screen.availWidth-width)/2;  
    return window.showModalDialog(urlStr,obj, "dialogWidth:"+width+"px; dialogHeight:"+height+"px;dialogLeft:"+left+"px; dialogTop:"+top+"px; status:no; directories:yes;scrollbars:no;Resizable=no;help=no;");     
}

function openWindowOpen(url){
    var iHeight = 600;
    var iWidth=850;
    var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
    var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置; 
      var hdc=window.open(url,"news","width=850px,height=600px,top="+iTop+",left="+iLeft+",toolbar =no, menubar=no, scrollbars=no, resizable=no, location=n o, status=no"); 
    if(hdc==null){
       alert("临时弹出窗口被浏览器阻止！请点击地址栏下的阻止信息，设置允许弹出窗口！") ;
       browserInterceptor();
    } 
    return hdc;
}


function openWindowOpen2(url,targetName,width2,height2){ 
    var iTop = (window.screen.availHeight-30-height2)/2; //获得窗口的垂直位置;
    var iLeft = (window.screen.availWidth-10-width2)/2; //获得窗口的水平位置; 
    var hdc=window.open(url,targetName,"width="+width2+"px,height="+height2+"px,top="+iTop+",left="+iLeft+",scrollbars=yes"); 
    if(hdc==null){
       alert("临时弹出窗口被浏览器阻止！请点击地址栏下的阻止信息，设置允许弹出窗口！") ;
       browserInterceptor();
    } 
    return hdc;
}
var helpParentId  = 0;
var helpChildrenId = 0;
//帮助公用方法
function gotoHelpWindow(){
  if(helpParentId == 0){
     return;
  }
  var url = "help!findHelp.action?help.parentId="+helpParentId+"&help.id="+helpChildrenId;
  openWindowOpen2(url,"help",960,600);    
}
//判断页面元素是否为空
function isEmpty(str){
    if(str==null){
        return true;
    }else if(str.length==0){
        return true;
    }
    return false;
}
   function delobject(delurl){
      if(confirm(delmssage)){          
          jQuery.getJSON(delurl,null,function call(data){   
            if(currentPage>data.totalPage){
                currentPage = data.totalPage;     
            }                         
              handler();
          });    
      }
    }
   
function getCheckboxValues(str){
   var idArray =document.getElementsByName(str);  
   var len = idArray.length;    
   var ids = "";
   for (var i=0;i<len ;i++ ) { 
      if( idArray[i].checked==true )
       {
          ids += ":" + idArray[i].value;
       }
     }
     if(ids !="")
         ids = ids.substring(1,ids.length);
     return ids;
 }
 function getCheckboxValues1(tableid,cheboxid){
     var curGrid = dijit.byId(tableid);
     var col = curGrid.selection.getSelected();
     var ids = ""; 
     if(col.length==0){
        alert(checkboxmessage);
        return null;
     }
     for(var i=0; i<col.length;i++){ 
         var c1 =  curGrid.getItem(i);
         ids +=":"+c1[cheboxid]; 
     }
    if(ids !="")
         ids = ids.substring(1,ids.length);
    return ids;
}
function checkboxAllSelection(tableId,flag){   
        //全选
        if(flag){
          jQuery("[name='"+bluedot_tb_checkboxName+"']").each(function() { 
                    jQuery(this).attr("checked", true); 
                }); 
        }else{
          jQuery("[name='"+bluedot_tb_checkboxName+"']").each(function() { 
                    jQuery(this).attr("checked", false); 
                }); 
        }
        // dijit.byId(tableId).rowSelectCell.toggleAllSelection(flag); 
}

function checkboxAllSelection2(tableId,flag){   
        //全选
         dijit.byId(tableId).rowSelectCell.toggleAllSelection(flag); 
}

function checkIdinStr(str,id){
  if(str == "")
    return false;
  var parStr = str.split(",");
  for(var i=0;i<parStr.length;i++){
     if(parStr == "")
       continue;
     if(parStr[i]==id) 
        return true;
      else
        continue;
  }
  return false;
}
function getDictData(objForm,url,dictType,name,valuename) { 
    var value= objForm[valuename].value;
    url +="?dictType="+dictType+"&name="+name+"&valuename="+valuename+"&value="+value;
    openDialogWin(url,objForm,600,400,0,20);
}
function setDictData(nameId,valueId) { 
    var myObj = new Object(window.dialogArguments); 
    var dictKey = "";
    var dictName = "";
    var dictId= document.getElementsByName("dictId");
    for (var i = 0; i < dictId.length; i++)  {  
      if (dictId[i].checked) { 
         var parStr = (dictId[i].value).split(":"); 
         dictKey += "," + parStr[0];  
         dictName += "||" + parStr[1];  
       }  
     }  
    if (dictKey != "") {
        myObj[valueId].value = dictKey.substring(1,dictKey.length); 
        myObj[nameId].value = dictName.substring(2,dictName.length);
    }
  //关闭窗口        
   window.close();
}

 function getObject(objectId) {
     if(document.getElementById && document.getElementById(objectId)) {  
       return document.getElementById(objectId);
     } else if (document.all && document.all(objectId)) { 
       return document.all(objectId);
     } else if (document.layers && document.layers[objectId]) {  
       return document.layers[objectId];
     } else {
     return false;
     }
}
 function showHide(objname,num){ 
  var obj1 = getObject(objname+"0");   
  var flag;
  if(obj1.style.display == "table-row"){
        flag= true;
  }else if(obj1.style.display == "block"){
        flag=true;
  } else{
        flag=false;
  }
  for(var i=0;i<num;i++){
     var obj = getObject(objname+i);
     if(flag){
         obj.style.display = "none";
     }else{
         if(navigator.userAgent.indexOf("MSIE")>0){
            obj.style.display = "block";
         }else{          
            obj.style.display = "table-row";
         } 
      } 
 }
}

function windowClose(flag){   
  if(flag == undefined)
    flag = true;
  window.returnValue = flag;
  window.close();
}

//弹出层
var showStr="";
var showName="";
var Industry = {
    // 层信息输出
    Show2 : function(){
        jQuery('#drag').width('600px');
        jQuery('#IndustryList').html('<span class="desc">'+showStr+'</span>');
    }
}
 
// 显示层
function IndustrySelect_2(){
    var dragHtml ='<div id="IndustryAlpha">';   
        dragHtml+='     <div id="IndustryList"></div>';//显示内容
        dragHtml+='</div>';
    jQuery('#drag_h').html('<b>'+showName+'</b><span onclick="boxAlpha()">关闭</span>');
    jQuery('#drag_con').html(dragHtml);

    Industry.Show2();
    boxAlpha();
    draglayer();
}

//var params="learning.sourceId="+bluedot_fp_data[i].id+"&learning.sourceType="+sourceType;
//              params+="&learning.resourceName="+encodeURI(bluedot_fp_data[i].fileTitle);
//          bluedot_saveLearning(params);
//保存学习记录
function bluedot_saveLearning(params){
    
    jQuery.post("learning!addLearning.action",params,function call(data){
            
    });
}

//计算倒计时
function bluedot_countdown(beginDate, endDate) {
    //返回对象，用来记录倒计时的信息
    var countdown_display = {
        //倒计时天数
        day:"",  
        //倒计时小时数
        hour:"",
        //倒计时分钟数
        minute:"",
        //倒计时秒数
        second:""
    }
    
    //根据开始和结束时间，计算出倒计时，并存放到放回对象中
    var millisecond = endDate.getTime() - beginDate.getTime();
    countdown_display.day = Math.floor(millisecond / (1000 * 60 * 60 * 24));
    countdown_display.hour = Math.floor(millisecond / (1000 * 60 * 60)) % 24;
    countdown_display.minute = Math.floor(millisecond / (1000 * 60)) % 60;
    countdown_display.second = Math.floor(millisecond / 1000) % 60;
    millisecond = Math.floor(millisecond / 100) % 10; 
    return countdown_display;
}

    //解析日期 需要同时引入date.js
    function bluedot_date_parseDate(propertyValue,format){
        var dateArray = propertyValue.split(".");
        propertyValue = dateArray[0]; 
        propertyValue=propertyValue.replace(/-/g,"/");
        propertyValue=propertyValue.replace("T"," ");
        
        var date=new Date(propertyValue);
        propertyValue=formatDate(date,format);
        return propertyValue;
    }

 
  //str1为开始日期，str2为结束日期
function checkDateIsSmall(dateBegin,dateEnd){      
    //如果是字符串转换为日期型 
    if (typeof (dateBegin) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateBegin = bluedot_date_parseDate(dateBegin, "yyyy/MM/dd");
        dateBegin = new Date(dateBegin);
    }
    var beginTime = dateBegin.getTime();
    
    //如果是字符串转换为日期型 
    if (typeof (dateEnd) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateEnd = bluedot_date_parseDate(dateEnd, "yyyy/MM/dd");
        dateEnd = new Date(dateEnd);  
    }
    var endTime = dateEnd.getTime();
    
    if(beginTime < endTime) {
        return true;
    }
    return false;
}

function checkDateIsSmall2(dateBegin,dateEnd){     
    if(dateBegin == "" || dateEnd == ""){
        return true;
    }
    //如果是字符串转换为日期型 
    if (typeof (dateBegin) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateBegin = bluedot_date_parseDate(dateBegin, "yyyy/MM/dd");
        dateBegin = new Date(dateBegin);
    }
    var beginTime = dateBegin.getTime();
    
    //如果是字符串转换为日期型 
    if (typeof (dateEnd) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateEnd = bluedot_date_parseDate(dateEnd, "yyyy/MM/dd");
        dateEnd = new Date(dateEnd);  
    }
    var endTime = dateEnd.getTime();
    
    if(beginTime <= endTime) {
        return true;
    }
    return false;
}
 
/*
 * 比较两个时间的天数差
 * @param {Object} DateBegin  格式为日期型 或者 有效日期格式字符串
 * @param {Object} DateEnd    格式为日期型 或者 有效日期格式字符串
 */
function bluedot_date_computeDaysBetween(dateBegin, dateEnd) {
    //如果是字符串转换为日期型 
    if (typeof (dateBegin) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateBegin = bluedot_date_parseDate(dateBegin, "yyyy/MM/dd HH:mm:ss");
        dateBegin = new Date(dateBegin);
    }
    
    //如果是字符串转换为日期型 
    if (typeof (dateEnd) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateEnd = bluedot_date_parseDate(dateEnd, "yyyy/MM/dd HH:mm:ss");
        dateEnd = new Date(dateEnd);  
    }
    
    // 86400000 为一天的毫秒数
    var day = (dateEnd.getTime() - dateBegin.getTime()) / 86400000;
    return Math.round(day);
}

/*
 * 比较两个时间相差的毫秒数
 * @param {Object} DateBegin  格式为日期型 或者 有效日期格式字符串
 * @param {Object} DateEnd    格式为日期型 或者 有效日期格式字符串
 */
function bluedot_date_computeDaysBetween2(dateBegin, dateEnd) {
    //如果是字符串转换为日期型 
    if (typeof (dateBegin) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateBegin = bluedot_date_parseDate(dateBegin, "yyyy/MM/dd HH:mm:ss");
        dateBegin = new Date(dateBegin);
    }
    
    //如果是字符串转换为日期型 
    if (typeof (dateEnd) == 'string' )
    {   
        //调用格式化日期的方法，将有效的日期格式化为  "yyyy/MM/dd HH:mm:ss" 的格式
        dateEnd = bluedot_date_parseDate(dateEnd, "yyyy/MM/dd HH:mm:ss");
        dateEnd = new Date(dateEnd);  
    }
    
    // 86400000 为一天的毫秒数
    var day = (dateEnd.getTime() - dateBegin.getTime()) / 86400000;
    return day;
}

//截取字符串  str字符串   count以该数为标准截取
function bluedot_string_cutString(str,count){
    if(str){
        if(str.length > count){
            return str.substring(0,count)+"...";
        }else{
            return str;
        }
    }
}

//解析日期
function bluedot_list_parseDate(propertyValue,format){
    var dateArray = propertyValue.split(".");
    propertyValue = dateArray[0];
    propertyValue=(propertyValue.toString()).replace(/-/g,"/"); 
    propertyValue=propertyValue.replace("T"," ");
    
    var date=new Date(propertyValue);
    propertyValue=formatDate(date,format);
    return propertyValue;
}
function browserInterceptor(){
        var msgw,msgh,bordercolor;
        msgw=600;//提示窗口的宽度
        msgh=500;//提示窗口的高度
        titleheight=25 //提示窗口标题高度
        bordercolor="#33CC33";//提示窗口的边框颜色
        titlecolor="#c51100";//提示窗口的标题颜色
        var sWidth,sHeight;
        sWidth=screen.width-22;
        sHeight=screen.height-180; 
        var bgObj=document.createElement("div");
        bgObj.setAttribute('id','bgDiv');
        bgObj.style.position="absolute";
        bgObj.style.top="0";
        bgObj.style.background="#cccccc";
        bgObj.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=3,opacity=25,finishOpacity=75";
        bgObj.style.opacity="0.6";
        bgObj.style.left="0";
        bgObj.style.width=sWidth + "px";
        bgObj.style.height=sHeight + "px";
        bgObj.style.zIndex = "10000";
        document.body.appendChild(bgObj);
        var msgObj=document.createElement("div")
        msgObj.setAttribute("id","msgDiv");
        msgObj.setAttribute("align","center");
        msgObj.style.background="white";
        msgObj.style.border="1px solid " + bordercolor;
        msgObj.style.position = "absolute";
        msgObj.style.left = "42%";
        msgObj.style.top = "17%";
        msgObj.style.font="12px/1.6em Verdana, Geneva, Arial, Helvetica, sans-serif";
        msgObj.style.marginLeft = "-225px" ;
        msgObj.style.marginTop = -75+document.documentElement.scrollTop+"px";
        msgObj.style.width = msgw + "px";
        msgObj.style.height =msgh + "px";
        msgObj.style.textAlign = "center";
        msgObj.style.lineHeight ="25px";
        msgObj.style.zIndex = "10001";
       var title=document.createElement("h4");
       title.setAttribute("id","msgTitle");
       title.setAttribute("align","center");
       title.style.margin="0";
       title.style.padding="3px";
       title.style.background=bordercolor;
       title.style.filter="progid:DXImageTransform.Microsoft.Alpha(startX=20, startY=20, finishX=100, finishY=100,style=1,opacity=75,finishOpacity=100);";
       title.style.opacity="0.75";
       title.style.border="1px solid " + bordercolor;
       title.style.height="18px";
       title.innerHTML='点击此处关闭';
       title.style.font="12px Verdana, Geneva, Arial, Helvetica, sans-serif";
       title.title="点击关闭";
       title.style.cursor="pointer";
       title.onclick=function(){
            document.body.removeChild(bgObj);
            document.getElementById("msgDiv").removeChild(title);
            document.body.removeChild(msgObj);
       }
       document.body.appendChild(msgObj);
       document.getElementById("msgDiv").appendChild(title);
       var txt=document.createElement("p");
       txt.style.margin="1em 0"
       txt.setAttribute("id","msgTxt");

       var navigatorFlag = true;
       var ua = navigator.userAgent.toLowerCase();
       if (document.getBoxObjectFor){
          navigatorFlag = false;   
       } 
       if(navigatorFlag){
           txt.innerHTML='<img src="img/common/ie.jpg"/>';
       }else{
           txt.innerHTML='<img src="img/common/firfox.jpg"/>';
       } 
       document.getElementById("msgDiv").appendChild(txt);
   }

var bluedot_fileCheck_identity ;   
function fileServerCheck(fileUrl){
    var indexCount = fileUrl.indexOf("ems_file");
    var urlRoot = fileUrl.substring(0,indexCount);
    var filePath = fileUrl.substring(indexCount);
    if(filePath.indexOf(".swf")!=-1 || filePath.indexOf(".flv")!=-1 || filePath.indexOf(".html")!=-1){
        jQuery.getScript(urlRoot+"/ems_file/servlet/FileServerCheck.do?fileViewUrl="+filePath,function(){
            var msg = info.msg;
            if(msg != "true"){
                alert("文件服务器中不存在该文件");
                bluedot_fileCheck_identity = false;
                return false;
            }else {
                bluedot_fileCheck_identity = true;
                return true;
            }
        });
    }else{
        alert("文件服务器中不存在该文件");
        bluedot_fileCheck_identity = false;
        return false;
    }
    
}


//点对点发送消息
var bluedot_commonMessage_receiveUsers = '';
function bluedot_send_commonMessage(usersList){
    
}

//过滤html标签
function replaceHTML(str){
    if(str == undefined){
       return "";
    }
    var regu = "^([+-]?)\\d*\\.?\\d+$"; 
    var re = new RegExp(regu);  
    if(str != ""){
         if(!re.test(str)){    
             str = str.replace(/&/g, '&amp;');
             str = str.replace(/</g, '&lt;');
          str = str.replace(/>/g, '&gt;');
         }
    }
   return str;
 }  