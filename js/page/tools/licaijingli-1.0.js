    
    
 /**
  *package:js.licaijingli-js
  *function: 
  *params:  table:所有注册的用户,shareTable:所有正在监控的用户,roomTable:会议消息处理 
  *description: 注册消息函数
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
    
    
   var share,table=new Hashtable(),shareTable=new Hashtable(),roomTable = new Hashtable();  
    roomTable.add('陈希','');
    roomTable.add('专家',''); 
    $(function () {
		$( ".m-chat" ).draggable({ handle:".m-chat-t"});
		$( ".m-share" ).draggable();
		//$( ".b-m-chat" ).draggable({ handle:".b-m-chat-t"});
	})
        
 /**
  *package:js.licaijingli-js
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
  *package:js.licaijingli-js
  *function: OnTextMessage()
  *params:  strTxt:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
	 
	function OnTextMessage(strTxt) { share.onMessageHandler('AB',strTxt); }
/**
  *package:js.licaijingli-js
  *function: OnStartShare()
  *params:   
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
	function OnStartShare() { LogMsg("event: MeetingCtrl_OnStartShare"); }
/**
  *package:js.licaijingli-js
  *function: OnStopShare()
  *params:   
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
	function OnStopShare() { LogMsg("event: MeetingCtrl_OnStopShare"); }
/**
  *package:js.licaijingli-js
  *function: OnShareFailed()
  *params:   
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/ 
	function OnShareFailed() { LogMsg("event: OnShareFailed"); }
/**
  *package:js.licaijingli-js
  *function: OnUserJoin()
  *params:   
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnUserJoin(userId, userNickName) { table.add(userNickName,userId); }
/**
  *package:js.licaijingli-js
  *function: OnUserLeave()
  *params:   userId:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnUserLeave(userId) {
		//$('#data').removeData(userId);
		share.onUserLeaveHandler(userId);
	}
/**
  *package:js.licaijingli-js
  *function: OnDisconnect()
  *params:    
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	function OnDisconnect() {
		LogMsg("event: Fire_OnDisconnect");
	}
/**
  *package:js.licaijingli-js
  *function: OnAskMonitor()
  *params:    userId:      userNickName:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
    function OnAskMonitor(userId,userNickName)  {
	    LogMsg("event: OnAskMonitor userId="+userId+" name="+userNickName);
	    MeetingCtrl.AcceptMonitor(userId);
    }
/**
  *package:js.licaijingli-js
  *function: OnStopMonitor()
  *params:    userId:      userNickName:
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
    function OnStopMonitor(userId,userNickName)  {
	    LogMsg("event: OnStopMonitor userId="+userId);
    }
 /**
  *package:js.licaijingli-js
  *function: onload()
  *params:     
  *description:  
  *author: 
  *Date:2013年07月03日 10:07:25
 **/
	    function onload(){
            var strRoomId = "1839288329349243238488348845443545",strServerIP = "172.16.4.100";
         	//var strServerIP = "172.16.1.253";
         	share = new Share(strRoomId,strServerIP); 
            share.initial();  
            share.loginServer('3B299596830940CD89235B0B87AB4146',"理财经理");
	    }
	/**
	  *package:js.licaijingli-js
	  *function: onload()
	  *params:     
	  *description:  1.0 onunload 界面共享
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/
	    function onunload(){ share.logoutServer();  }
	 /**
	  *package:js.licaijingli-js
	  *function: userSelect()
	  *params:     msgTxt
	  *description:  
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/
	    function userSelect(msgTxt){ document.getElementById('nameabc').innerText = msgTxt; }
	    
	 /**
	  *package:js.licaijingli-js
	  *function: request()
	  *params:     
	  *description:  选择一个专家进行咨询 
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/
	    function request(){
	        var name = share.getShareName();
	        if(name==''){
	            alert('没有用户共享界面');
	            return;
	        }
	        //1.3请求专家界面 
	        share.share(name); 
	    }
	    
	 /**
	  *package:js.licaijingli-js
	  *function: stopRequest()
	  *params:     
	  *description:   与专家断开连接
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
	        share.stopShare(name); 
	    }
	 /**
	  *package:js.licaijingli-js
	  *function: sendContent()
	  *params:     
	  *description:   
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/ 
	    function sendContent() {
			share.sendTxt("information","",'');
		}
     /**
	  *package:js.licaijingli-js
	  *function: invite()
	  *params:     
	  *description:   
	  *author: 
	  *Date:2013年07月03日 10:07:25
	 **/ 
		function invite(){   share.sendTxt("adduser","专家|陈希",''); }
	/**
	  *package:js.licaijingli-js
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
	        $.getJSON("http://"+serverIp+"/push_demo/push.php?ani="+oriPhone+"&dnis="+destPhone+"&callback=?", function(data){alert(data.res);});
        }
        
