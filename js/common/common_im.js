  
 var sourceifmObj; //调用API的iframe 
 jQuery(function(){ 
 	sourceifmObj =document.getElementById('sourceifm').contentWindow; //调用API的iframe 
 	
 });
 
 
  /**
  *package: js/page/common_im.js
  *function:  im_common_im_init()
  *params:  
  *description: iframe对象初始化
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/ 
	
   function im_common_im_init(){
	  
	} 
	
 /**
  *package: js/page/common_im.js
  *function:  im_common_im_login()
  *params: userId:用户ID，userPass:用户密码
  *description: 用户登录
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/ 
 function im_common_im_login(userId,userPass){ 
        sourceifmObj.login(userId,userPass);  
        //alert(5);
        var url = sourceifmObj.getUserStatus("mjd");
        alert("url   " + url);
        getUserStatus(url);
 }
  
 

 
 
  /**
  *package: js/page/common_im.js
  *function:  im_common_im_loginOut()
  *params:  
  *description: 用户退出
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
 
  function im_common_im_loginOut(){
        sourceifmObj.logout();  
 }
 
 /**
  *package: js/page/common_im.js
  *function: im_common_im_sendMessage()
  *params:  userId:用户ID;sendContent:发送内容
  *description: 发送信息(用户肯定会收到, 消息会离线保存)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
 function im_common_im_sendMessage(userId,sendContent){ 
    sourceifmObj.sendMessage(userId,sendContent); 
 }
  /**
  *package: js/page/common_im.js
  *function:im_common_im_sendNoticeMessage()
  *params:  userId:用户ID;sendContent:发送内容
  *description: 发送信息(只有在线能收到,不会离线保存)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
  function im_common_im_sendNoticeMessage(userId,sendContent){
       sourceifmObj.sendNoticeMessge(userId,sendContent); 
 }
 
 
 /**
  *package: js/page/common_im.js
  *function:im_common_im_getUserStatus()
  *params:  userId:用户ID;sendContent:发送内容
  *description: 发送信息(只有在线能收到,不会离线保存)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
 
 function im_common_im_getUserStatus(){ 
     sourceifmObj.getUserStatus2("mjd");
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
  function getUserStatus(url){
 	alert("ajax");
 	$.ajax({
	   type: "post",
	   url: "/myweb/servlet/UserStateManager",
	   data: {"url":url,"timestamp":new Date().getTime()},
	   success: function(msg){
	     alert( "Data Saved: " + msg );
	   }
	});
 }
 
 
 
 
 
 