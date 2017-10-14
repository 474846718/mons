
 
 /**
  *package:js.customer-js
  *function: 
  *params:  table:所有注册的用户,shareTable:所有正在监控的用户,roomTable:会议消息处理 
  *description: 注册消息函数
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
 
    var share,table=new Hashtable(),shareTable=new Hashtable(),roomTable = new Hashtable(); 
    roomTable.add('理财经理',''); 
    $(function() {
		$( ".m-chat" ).draggable({ handle:".m-chat-t"});
		$( ".m-share" ).draggable();
	})

 /**
  *package:js.customer-js
  *function: LogMsg()
  *params:  msgTxt:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
    function LogMsg(msgTxt) { 
    	  //document.getElementById('number').innerText = msgTxt;  
    }
 /**
  *package:js.customer-js
  *function: OnTextMessage()
  *params:  strTxt:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/  
	
	function OnTextMessage(strTxt) { share.onMessageHandler('C',strTxt);}
 /**
  *package:js.customer-js
  *function: OnStartShare()
  *params:    
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnStartShare() {LogMsg("event: MeetingCtrl_OnStartShare");}
 /**
  *package:js.customer-js
  *function: OnStopShare()
  *params:    
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnStopShare() {LogMsg("event: MeetingCtrl_OnStopShare");}
 /**
  *package:js.customer-js
  *function: OnShareFailed()
  *params:    
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnShareFailed() {
		LogMsg("event: OnShareFailed");
	}
 /**
  *package:js.customer-js
  *function: OnUserJoin()
  *params:    userId:     ,userNickName:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnUserJoin(userId, userNickName) {
	    table.add(userNickName,userId);
	    if(userNickName=='理财经理'){
	        var back=document.getElementById('user').style.background;
	        if(back == 'url(img/userh.jpg)'){
	             document.getElementById('user').style.background="url(img/user.jpg)";
	        }
	    }
	}
 /**
  *package:js.customer-js
  *function: OnUserLeave()
  *params:    userId:     ,userNickName:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnUserLeave(userId) {
		//$('#data').removeData(userId);
		var name = share.onUserLeaveHandler(userId);
		if(name == '理财经理'){
		    document.getElementById('user').style.background="url(img/userh.jpg)";
		}
	}
 /**
  *package:js.customer-js
  *function: OnDisconnect()
  *params:    
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnDisconnect() { LogMsg("event: Fire_OnDisconnect"); }
/**
  *package:js.customer-js
  *function: OnAskMonitor()
  *params:    userId:     ,userNickName:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
    function OnAskMonitor(userId,userNickName){
	    LogMsg("event: OnAskMonitor userId="+userId+" name="+userNickName);
	    MeetingCtrl.AcceptMonitor(userId);
    }
/**
  *package:js.customer-js
  *function: OnStopMonitor()
  *params:    userId:     ,userNickName:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
    function OnStopMonitor(userId,userNickName) { LogMsg("event: OnStopMonitor userId="+userId);}
/**
  *package:js.customer-js
  *function: onload()
  *params:     strRoomId:  ,strServerIP:   ,serverIp:   ,  oriPhone:    ,destPhone : 
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
	    function onload(){
            var strRoomId = "1839288329349243238488348845443545",strServerIP = "172.16.4.100",serverIp = "10.10.99.91";
         	var oriPhone = "1001",destPhone = "1002";
         	//var strServerIP = "172.16.1.253";
         	share = new Share(strRoomId,strServerIP); 
            share.initial();  
            share.loginServer('3B299596830940CD89235B0B87AB4146',"陈希");
	    }
/**
  *package:js.customer-js
  *function: onunload()
  *params:      
  *description:  界面共享
  *author: 
  *Date:2013年07月03日 10:07:25
 **/    
	    function onunload(){ share.logoutServer();}
	/**
	  *package:js.customer-js
	  *function: userSelect()
	  *params:      msgTxt:  
	  *description:  界面共享
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/  	    
	    function userSelect(msgTxt){ document.getElementById('nameabc').innerText = msgTxt; }
	    
	/**
	  *package:js.customer-js
	  *function: userSelect()
	  *params:      msgTxt:  
	  *description: 选择一个专家进行咨询
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/     
	    function request(){
	        var name = share.getShareName();
	        if(name==''){
	            alert('没有用户共享界面')
	            return;
	        }
	        //1.3请求专家界面
	        share.share(name); 
	    }
	    
	 /**
	  *package:js.customer-js
	  *function: stopRequest()
	  *params:      msgTxt:  
	  *description: 与专家断开连接
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/    
	    function stopRequest(){
	        var name = share.getShareName();
	        if(name==''){
	            alert('没有用户共享界面')
	            return;
	        }
	        //1.3断开专家连接
	        share.setShareName('');
	        share.stopShare(name); 
	    }
     /**
	  *package:js.customer-js
	  *function: sendContent()
	  *params:       
	  *description:  
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/ 
	    function sendContent() {
			share.sendTxt("information","");
		}
	/**
	  *package:js.customer-js
	  *function: userOnclick()
	  *params:       
	  *description:  
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/ 
		function userOnclick(){
			var back=document.getElementById('user').style.background;
	        if(back == 'url(img/userh.jpg)'){
	            return;
	        }
	        share.open_m_chat('kehu');
		    document.getElementById('recordsContent').value='';
		}
	/**
	  *package:js.customer-js
	  *function: onClickCall()
	  *params:       
	  *description:  
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/ 
		function onClickCall(){
		    var serverIp = "10.10.99.91";
         	var oriPhone = "1001";
         	var destPhone = "1002";
		      //alert("http://"+serverIp+"/push_demo/push.php?ani="+oriPhone+"&dnis="+destPhone+"&callback=?");
	        $.getJSON("http://"+serverIp+"/push_demo/push.php?ani="+oriPhone+"&dnis="+destPhone+"&callback=?", function(data){alert(data.res);});
        }

	
	