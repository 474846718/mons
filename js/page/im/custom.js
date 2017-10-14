
 
 jQuery(function(){
   adtec.im.custom.init();
 });
 
 /**
  *package: js/page/custom.js
  *function:  adtec.im.custom.init()
  *params: 
  *description:初始化页面时初始化iframe,document.domain
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/ 
  
 adtec.im.custom.init=function(){ 
        jQuery( "#J_m_chat" ).draggable({ handle:".m-chat-t"}); 
 }
   

 /**
  *package: js/page/custom.js
  *function:  
  *params:  
  *description:打开页面时用户登录
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/ 
 adtec.im.custom.onload=function(){
   im_common_im_login("mjd","123456");
 }
  /**
  *package: js/page/custom.js
  *function:  
  *params:  
  *description关闭页面时用户退出
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月05日 09:25:25
 **/ 
  adtec.im.custom.onunload=function(){
  
  	  
  }
 /**
  *package: js/page/custom.js
  *function: adtec.im.custom.divTanchu()
  *params:  
  *description:DIV弹出
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/ 
 adtec.im.custom.divTanchu=function(id){
        im_common_div_divTanchu(id);
 }
 /**
  *package: js/page/custom.js
  *function: adtec.im.custom.divHide()
  *params:  
  *description:DIV关闭
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/

  adtec.im.custom.divHide=function(id){
        im_common_div_divHide(id);
        
 }
 /**
  *package: js/page/custom.js
  *function: adtec.im.custom.sendMessage()
  *params:   userId:用户ID;sendContentObj:发送内容的对象,recordsContentObj:存放消息记录的对象,sendMessagetype:发送消息类型
  *description: 发送信息(用户肯定会收到, 消息会离线保存)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
  adtec.im.custom.sendMessage=function(userId,sendContentObj,sendMessagetype){  
  	  var $sendContentObj=jQuery('#'+sendContentObj); 
  	  var $sendContent=$sendContentObj.val();
  	  var message=adtec.im.custom.fomartHtml(userId,$sendContent,sendMessagetype);  
  	  im_common_im_sendMessage(userId,message);
  	  $('#recordsContent').val(message);
  	  $sendContentObj.val('');
  	   
  	  
     
  }
 /**
  *package: js/page/common.js
  *function:adtec.im.custom.sendNoticeMessage()
  *params:  userId:用户ID;sendContent:发送内容,sendMessagetype:发送消息类型
  *description: 发送信息(只有在线能收到,不会离线保存)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
 adtec.im.custom.sendNoticeMessage=function(userId,sendContent,sendMessagetype){
       im_common_im_sendNoticeMessage(userId,sendContent);
 }
  /**
  *package: js/page/common.js
  *function:adtec.im.custom.sendNoticeMessage()
  *params:  userId:用户ID;sendTime;发送时间,sendContent:发送内容,sendMessagetype:发送消息类型
  *description: 发送信息(只有在线能收到,不会离线保存)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年11月04日 16:25:25
 **/
 
 adtec.im.custom.fomartHtml=function(userId,sendContent,sendMessagetype){
 	    var time=im_common_date_getLocalTime(); 
        var title = userId+" "+time+" \n\n";
        message = title+sendContent+" \n\n";
        return  message;
 }
 
 