function Share(_strRoomId,_strServerIP) {
	
	var _this=this;
	var strRoomId ;
    var strServerIP ;
//	var strRoomId = "1839288329349243238488348845443545";
//	var strServerIP = "127.0.0.1";
	var hasInitialDesk = false;
	var strMyUserId = "";
	var isLogin = false;
	var isShare = false;
    var shareName='';//正在监控的用户
	
	var myselfName;
	
	var isAddProfessor=false;//是否已经添加专家
    
	
	_this.setShareName = function(name){
		shareName=name;
	}
	
	_this.getShareName = function(){
		return shareName;
	}
	
	_this.IntialDesk = function()
	{
		if(hasInitialDesk == false)
		{
			// 获取监控系统的ID，该ID会用在监控的初始化
			var vCtrlId = MeetingCtrl.GetCtrlId();
			//设置会议的空间ID
			DeskMonitorCtrl.SetMeetingCtrlId(vCtrlId);
			MeetingCtrl.SetStyle(6);
		}
		hasInitialDesk = true;
	}
	
	_this.NewGuid =function(){
		 var g = "";
		 var i = 32;
		 while(i--){
			 g += ""+Math.floor(Math.random()*16.0).toString(16).toUpperCase()+"";
		 }
		 return g;
	}
	
	/*
	 * 
	 */
	_this.loginServer = function(userId,userName)
	{
		userId = strMyUserId;
		myselfName=userName;
		MeetingCtrl.SetMyUserId(userId,userName);		
		MeetingCtrl.SetServer(strServerIP,440);
		MeetingCtrl.SetRoomId(strRoomId);
		try{
			MeetingCtrl.Login();
		}catch(exception)
		{
			alert("login failed!");
			return false;
		}
		alert("login ok!");
		isLogin=true;
		_this.IntialDesk();
		return true;
	}
	
	/*
	 *1.0检查是否loginserver
	 *2.0检查是否正在监控
	 */
	_this.logoutServer  = function()
	{
		
		//1.0 正在监控的需要停止监控
			var vs = shareTable.values();
			var length = vs.size();
			for(var i =0;i<length;i++)
			{
			    var userId = vs.get(i);
			    _this.TestStopMonitor(userId);
			}
		//2.0 logout
		if(isLogin==true){
			MeetingCtrl.Logout();
		}
	}
	
	_this.startShare = function()
	{
		//1: 灰度   2: 256色   3: 真彩色
		MeetingCtrl.StartShare(3);
	}
	
	/*
	 * 聊天记录处理
	 * 
	 */
	_this.records = function(id,receive){
		var recordsCon = document.getElementById(id).value;
		
		recordsCon = recordsCon+"\n"+receive+"\n";
		
		document.getElementById(id).value=recordsCon;
		document.getElementById("sendContent").value="";
		
		document.getElementById(id).scrollTop = document.getElementById(id).scrollHeight;
	}
	
	/*
	 * 
	 * 发送消息处理
	 * var myDate = new Date();
       myDate.getYear();        //获取当前年份(2位)
       myDate.getFullYear();    //获取完整的年份(4位,1970-????)
       myDate.getMonth();       //获取当前月份(0-11,0代表1月)
       myDate.getDate();        //获取当前日(1-31)
       myDate.getDay();         //获取当前星期X(0-6,0代表星期天)
       myDate.getTime();        //获取当前时间(从1970.1.1开始的毫秒数)
       myDate.getHours();       //获取当前小时数(0-23)
       myDate.getMinutes();     //获取当前分钟数(0-59)
       myDate.getSeconds();     //获取当前秒数(0-59)
       myDate.getMilliseconds();    //获取当前毫秒数(0-999)
       myDate.toLocaleDateString();     //获取当前日期
       var mytime=myDate.toLocaleTimeString();     //获取当前时间
       myDate.toLocaleString( );        //获取日期与时间
       
       app :: information 聊天消息
       app :: adduser     添加用户
	 */
	_this.sendTxt = function(app,message,sign)
	{
		if(app=='information'){
		    var myDate = new Date();
		    var hours = myDate.getHours();
		    var minutes = myDate.getMinutes();
		    var seconds = myDate.getSeconds();
		    var time = hours+":"+minutes+":"+seconds;
		    if(sign=='A'||sign=='C'||sign=='D'){
		        message = document.getElementById("sendContent").value;
		        var title = myselfName+" "+time+" \n\n       ";
		        message = title+message;
		        _this.records('recordsContent',message);
		    }else{
		        message = document.getElementById("b-sendContent").value;
		        var title = myselfName+" "+time+" \n\n       ";
		        message = title+message;
		        _this.records('b-recordsContent',message);
		        document.getElementById("b-sendContent").value="";
		    }
		    message = app+"|"+myselfName +"|"+message+"|"+sign;
		}else if(app=='adduser'){
			isAddProfessor=true;
			message = app+"|"+message;
		}else if(app == 'SHARE'){
			message = app+"|"+message;
		}else if(app =='invite'){
			message = app+'|'+message+'|'+sign;
		}else if (app == 'exitInvite'){
			if(isAddProfessor){
			    message = app+'|'+message+'|'+sign;
		        if(message == '专家'){
	   	    	    _this.divHandler(false,'m-menu-li_zhangsan');
	   	    	    roomTable.remove('陈希');
	   	        }else if(message =='理财经理'){
	   	        	_this.divHandler(false,'m-menu-li_zhuanjia');
	   	        }else if(message =='陈希'){
	   	    	    roomTable.remove('专家');
	   	    	    _this.divHandler(false,'m-menu-li_zhuanjia');
	   	        }
	   	        isAddProfessor=false;
			}
		}
		
		//alert('-------------'+message);
		MeetingCtrl.SendTextMessage(message);
	}
	
	
	_this.TestAskMonitor = function(userid)
	{
		_this.IntialDesk();
		//var obj=document.getElementById('_userlist'); 		
		//var vUserId = obj.options[obj.options.selectedIndex].value;
		MeetingCtrl.AskViewUserDesk(userid);
	}
	
	_this.TestStopMonitor = function(userid){
		MeetingCtrl.StopViewUserDesk(userid);
	}
	
	_this.stopShare = function(name)
	{
		var iscontains = shareTable.containsKey(name);
		if(iscontains){
			var userId = shareTable.get(name);
			_this.TestStopMonitor(userId);
			shareTable.remove(name);
			alert("与["+name+"]客户断开连接");
		}else{
			alert("未与["+name+"]建立连接，请重新选择用户");
		}
	    
	}
	
	_this.share = function(name)
	{
		var iscontains = table.containsKey(name);
		var isshare = shareTable.containsKey(name);
		if(isshare){
			alert("用户【"+name+"】已经在监控请选择其他用户！");
			return;
		}
		if(iscontains){
		     var userId = table.get(name);
			 _this.TestAskMonitor(userId);
	         alert("已发送监控命令给："+name+" UserId："+userId);
	         shareTable.add(name,userId);
		}else{
			 alert(name+"--用户未在线");
		}
	}
	
	var init = function(){
		if(!_strRoomId||!_strServerIP){
			alert("_strRoomId and _strServerIP must be input!")
		}
		strRoomId=_strRoomId;
		strServerIP=_strServerIP;
		strMyUserId=_this.NewGuid();
	}
	
	_this.initial = function()
    {
		MeetingCtrl.InitialCtrl();
		MeetingCtrl.attachEvent("OnTextMessage",OnTextMessage);
		MeetingCtrl.attachEvent("OnStartShare",OnStartShare);
		MeetingCtrl.attachEvent("OnStopShare",OnStopShare);
		MeetingCtrl.attachEvent("OnShareFailed",OnShareFailed);
		MeetingCtrl.attachEvent("OnUserJoin",OnUserJoin);
		MeetingCtrl.attachEvent("OnUserLeave",OnUserLeave);
		MeetingCtrl.attachEvent("OnDisconnect",OnDisconnect);
		MeetingCtrl.attachEvent("OnAskMonitor",OnAskMonitor);
		MeetingCtrl.attachEvent("OnStopMonitor",OnStopMonitor);
	} 
	
	/*
	 *  显示1个窗口 style = 6 ;
	 *  显示4个窗口  style = 1;
	 */
	_this.setStyle= function(style)
	{
		MeetingCtrl.SetStyle(style);
	}
	
    _this.divHandler = function(b , id){
		if(b){
			document.getElementById(id).style.display = "";
		}else{
			document.getElementById(id).style.display = "none";
		}
	}
	
	_this.onMessageHandler = function(user,message)
	{
	   //alert(message);
	   var txtarr = message.split('|');
	   var app =txtarr[0];
	   if(app=="information")
	   {
	   	
	       var name = txtarr[1];
	       var sign = txtarr[3];//sign ’C‘ 客户发送的消息  ’A‘理财经理发给客户的消息  ’B‘理财经理发给专家的消息 ’D‘专家发送的消息
	       if(user=='C'){//处理客户收到的消息
	           if((!isAddProfessor)&&sign=='B'){
	           	return;
	           }
	       }else if(user=='AB'){//处理理财专家收到的消息
	       	    if(isAddProfessor){//已经添加专家

	       	    }else{//未添加专家
	       	    	if(sign=='C'){//
	       	    	}else if(sign=='D'){//在未添加专家，接收到专家消息后，操作跟专家的聊天框
	       	    	   var iscontains = roomTable.containsKey(name);
	                   if(iscontains)
	                   {
		                   _this.records('b-recordsContent',txtarr[2]);//TODO
	                   }
	                   return;
	       	    	}
	       	    }
	       }else if(user=='D'){//处理专家收到的消息
	       	    if((!isAddProfessor)&&sign=='A'){
	       	    	return;
	       	    }
	       }
	       var iscontains = roomTable.containsKey(name);
	       if(iscontains)
	       {
	       	  //alert("--------------"+txtarr[2]);
		       _this.records('recordsContent',txtarr[2]);
	       }
	   }
	   //room添加用户
	   else if(app=="adduser")
	   {
	       for(var i=1;i<=2;i++){
	       	  var u = txtarr[i];
	       	  if(u!=myselfName){
	       	  	roomTable.add(u,'');
	       	  	isAddProfessor=true;
	       	  }
	       }
	   }
	   
	   else if(app=='invite'){//邀请消息
	   	    if(user=='D'){
	   	    	 _this.divHandler(true, 'dl-m-menu-t');
	   	    }else if(user =='AB'){
	   	    	var b = txtarr[1];
	   	    	if(b=='true'){
	   	    		_this.sendTxt("adduser","专家|陈希",'');//邀请客户
	   	    		alert('专家接收了邀请！');
	   	    		_this.divHandler('true','m-menu-li_zhuanjia');
	   	    	}else if(b =='false'){
	   	    		alert('专家拒绝加入！');
	   	    	}
	   	    }else if(user =='C'){
	   	    	_this.divHandler('true','m-menu-li_zhuanjia');
	   	    }
	   	    
	   }
	   
	   else if(app == 'exitInvite'){
	   	    isAddProfessor = false;
	   	    var name = txtarr[1];
	   	    if(user == 'D'){
	   	    	roomTable.remove('陈希');
	   	    	_this.divHandler(false,'m-menu-li_zhangsan');
	   	    }else if(user =='AB'){
	   	    	_this.divHandler(false,'m-menu-li_zhuanjia');
	   	    }else if(user =='C'){
	   	    	roomTable.remove('专家');
	   	    	_this.divHandler(false,'m-menu-li_zhuanjia');
	   	    }
	   	    alert('【'+name+'】'+"离开了会议室");
	   }
	   
	   //开始监控桌面
	   else if(app=='SHARE'){
	   	    if(user =='D'){
	   	    	if(!isAddProfessor){
	   	    		return;
	   	    	}
	   	    }
	   	    var name =txtarr[1];
	   	    var iscontains = roomTable.containsKey(name);
	   	    _this.setShareName(name);//记录共享的用户名称
	   	    if(iscontains&&(name!=myselfName))
	   	    {
	   	    	document.getElementById('m-chat-share').style.left='50%';
	   	    	_this.share(name);
	   	    }
	   }
	}
	
	_this.onUserLeaveHandler = function(userId){
		var keys = table.keys();
		var length = keys.size();
		for(var i=0;i<length;i++)
		{
		    var key = keys.get(i);
		    var value = table.get(key);
		    if(value == userId)
		    {
		        table.remove(key);
		        return key;
		    }
		 }
	}

	/*
	 2.0 name = kehu / licaijingli / zhuanjia
	*/
	_this.open_m_chat = function(name){
	    if(name == 'kehu'){
	        _this.divHandler(true, 'm-chat');
	        //菜单栏
	        _this.divHandler(true, 'tools1');
	        _this.divHandler(true, 'tools2');
	        _this.divHandler(false, 'tools3');
	        _this.divHandler(false, 'tools4');
	        //会议室成员 m-menu-li_zhangsan、m-menu-li_licaijingli、m-menu-li_zhuanjia
	        _this.divHandler(true, 'm-menu-li_zhangsan');
	        _this.divHandler(true, 'm-menu-li_licaijingli');
	        _this.divHandler(false, 'm-menu-li_zhuanjia');
	        //会话邀请 dl-m-menu-t
	        //_this.divHandler(false, 'dl-m-menu-t');
	        //共享桌面 
	        //_this.divHandler(true, 'm-chat-share');
	    }else if(name == 'licaijingli'){
	    	_this.divHandler(true, 'm-chat');
	        //菜单栏
	        _this.divHandler(true, 'tools1');
	        _this.divHandler(true, 'tools2');
	        _this.divHandler(true, 'tools3');
	        _this.divHandler(true, 'tools4');
	        //会议室成员 m-menu-li_zhangsan、m-menu-li_licaijingli、m-menu-li_zhuanjia
	        _this.divHandler(true, 'm-menu-li_zhangsan');
	        _this.divHandler(true, 'm-menu-li_licaijingli');
	        _this.divHandler(false, 'm-menu-li_zhuanjia');
	        //会话邀请 dl-m-menu-t
	        //_this.divHandler(false, 'dl-m-menu-t');
	        //共享桌面 
	        //_this.divHandler(false, 'm-chat-share');
	        //------------------------------------

	        
	    }else if(name =='licaijingli2'){
	    	_this.divHandler(true, 'b-m-chat');
	        //菜单栏
	        _this.divHandler(true, 'b-tools1');
	        _this.divHandler(true, 'b-tools2');
	        _this.divHandler(false,'b-tools3');
	        _this.divHandler(false,'b-tools4');
	        //会议室成员 m-menu-li_zhangsan、m-menu-li_licaijingli、m-menu-li_zhuanjia
	        _this.divHandler(false, 'b-m-menu-li_zhangsan');
	        _this.divHandler(true, 'b-m-menu-li_licaijingli');
	        _this.divHandler(true, 'b-m-menu-li_zhuanjia');
	        //会话邀请 dl-m-menu-t
	        //_this.divHandler(false, 'b-dl-m-menu-t');
	        //共享桌面 
	        //_this.divHandler(true, 'b-m-chat-share');
	    }
	    else if(name =='zhuanjia'){
	    	_this.divHandler(true, 'm-chat');
	        //菜单栏
	        _this.divHandler(true, 'tools1');
	        _this.divHandler(true, 'tools2');
	        _this.divHandler(false, 'tools3');
	        _this.divHandler(false, 'tools4');
	        //会议室成员 m-menu-li_zhangsan、m-menu-li_licaijingli、m-menu-li_zhuanjia
	        _this.divHandler(false, 'm-menu-li_zhangsan');
	        _this.divHandler(true, 'm-menu-li_licaijingli');
	        _this.divHandler(true, 'm-menu-li_zhuanjia');
	        //会话邀请 dl-m-menu-t
	        //_this.divHandler(false, 'dl-m-menu-t');
	        //共享桌面 
	        //_this.divHandler(false, 'm-chat-share');
	    }
	}
	
//	//理财经理邀请专家后，如果关闭任何一方的对话框，则退出专家邀请
//	
//	_this.exitInvite = function(){
//		
//		
//		
//	}
	
	init();

}
