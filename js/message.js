
    var myselfName = "";
    var onlineUser = new Hashtable();
    var isLogout = true;
    
	document.domain = "192.168.2.119";
	
	function onload(){
	    top.ifm1.login("kdliang", "123456");
	    $('#J_onlineNum').html(onlineUser.size());
	}

	function ffff(ssss) {
		alert(ssss);
	}
	
	function LogMsg(msgTxt) {
		//document.getElementById('logmsg').innerText = msgTxt;
		alert(msgTxt);
		//console.info(msgTxt);
	}
	//-------------------回调函数--------------------//
	/*
	 * 在与服务器异常中断的时候会被调用
	 */
	function callback_onHandleConError(e) {
		LogMsg("OnHandleConError:" + e);
	}
	/*
	 * 与服务器连接中断通知
	 * 1表示正常中断
	 * 0表示异常中断
	 */
	function callback_onHandleDisconnect(normal) {
	    isLogout= true;
		LogMsg("OnHandleDisconnect: normal="+normal);
	}
	/*
	 * 登录成功
	 */
	function callback_onHandleConnected(userName) {
	    isLogout=false;
	    myselfName=userName;
	    top.ifm1.brdMessageBrdToAll("login");
	    //登录成功后发布广播 登录成功
		LogMsg("onHandleConnected:" + userName + "登录成功");
	}

	/*
	 * 表示接收到一个广播消息，具体看JSConnection的发送广播
	 * From：发起广播的人
	 * mesType:消息类型
	 * body：消息内容
	 */
	function callback_onHandleBroadCastMessage(userName, type, body) {
	    //var txtarr = body.split('|');
	    var app = body;
	    
	    if(userName == myselfName){
	        //LogMsg("onHandleBroadCastMessage: userName=" + userName + " type=" + type + " body=" + body);
	        return;
	    }
	    
	    if(app=="login"){
	        //收到A登录成功后，告诉A你的状态 
	        onlineUser.add(userName,"true");
	        
	        top.ifm1.sendMessage(userName, "online");
	        $('#J_onlineNum').html(onlineUser.size());
	        //LogMsg("onHandleBroadCastMessage: userName=" + userName + "登录成功");
	        
	    }else if(app=="logout"){
	        onlineUser.remove(userName);
	        $('#J_onlineNum').html(onlineUser.size());
	        LogMsg("callback_onHandleBroadCastMessage: onlineUser.size="+ onlineUser.size());
	        //LogMsg("onHandleBroadCastMessage: userName=" + userName + "退出成功");
	    }
	    
	}

	/*
	 * 表示接收到某人发送的消息，该函数为sendNoticeMessage的回调
	 */
	function callback_onHandleNoticeMessage(userName, body) {
		LogMsg("onHandleNoticeMessage: userName=" + userName + " body=" + body);
	}

	/*
	 * 表示接收到某人发送的消息，该函数为sendMessage的回调
	 */
	function callback_onHandleChatMessage(userName, body) {
	    var txtarr = body.split('|');
	    var app =txtarr[0];
	    if(app=="online"){
	         onlineUser.add(userName,"true");
	    }
	    $('#J_onlineNum').html(onlineUser.size());
		LogMsg("onHandleChatMessage: onlineUser.size="+ onlineUser.size());
	}

	/*
	 * 表示接收到一个群聊的消息
	 * roomJid ： 房间ID
	 * fromUser：发送人
	 * body：内容
	 */
	function callback_onHandleGroupChatMessage(roomId, fromUser, body) {
		LogMsg("OnHandleGroupChatMessage: roomId=" + roomId + " fromUser=" + fromUser + " body=" + body);
	}


	/*
	 * 表示发送消息错误了
	 * From :表示错误消息的发送者（可能是一个用户的userid，或者一个房间的roomid，body：错误的具体原因）
	 */
	function callback_onHandleErrorMessage(userName, body) {
		LogMsg("onHandleErrorMessage: userName=" + userName + " body=" + body);
	}

	/*
	 * 表示有人邀请你加入某个聊天组
	 * to：组id
	 * from：表示发起邀请的人
	 * pass：表示房间密码
	 * reason：邀请原因说明
	 * 1、接收邀请
	 * 2、拒绝邀请
	 * 3、自动退出组
	 * 4、组建立者删除成员
	 */

	function callback_onHandleRoomInvite(to, from, pass, reason) {
        LogMsg("OnHandleRoomInvite: to=" + to + " from=" + from + "pass=" + pass + " reason=" + reason);
        //joinRoomInvite(to,pass);
	}

	function callback_onHandleRoomUserJoin(roomJid, userId, nickName) {
	    LogMsg("OnHandleRoomUserJoin: roomJid=" + roomJid + " userId=" + userId + "nickName=" + nickName);

	}

	function callback_onHandleRoomUserLeave(roomJid, userId, nickName) {
        LogMsg("OnHandleRoomUserLeave: roomJid=" + roomJid + " userId=" + userId + "nickName=" + nickName);
	}

	//---------------------end----------------------//
	function login() {
		var v_name = document.getElementById("v_name").value;
		var v_pass = document.getElementById("v_pass").value;
		top.ifm1.login(v_name, v_pass);
	}

	function logout() {
	    if(!isLogout){
	        top.ifm1.brdMessageBrdToAll("logout");
	    }
		//top.ifm1.logout();
	}

	function sendMessage() {
		var userid = document.getElementById("v_id").value;
		var messageContent = document.getElementById("messageContent").value;
		top.ifm1.sendMessage(userid, messageContent);
	}

	function sendRealMessage() {
		var userid = document.getElementById("v_id").value;
		var messageContent = document.getElementById("messageContent").value;
		top.ifm1.sendRealMessage(userid, messageContent);
	}

	function inviteUserToRoom() {
		var inviteUserId = document.getElementById('inviteuserid').value;
		var reason = document.getElementById('room_subject').value;
		top.ifm1.inviteUserToRoom(inviteUserId, reason);
	}

	function roomMessageToGroup() {
		var vmsg = document.getElementById('room_messageContent').value;
		top.ifm1.roomMessageToGroup(vmsg);
	}

	function brdMessage() {
		var brdrecv = document.getElementById('brdrecv').value;
		var vMsg = document.getElementById('brd_messageContent').value;
		if (brdrecv == 'online') {
			top.ifm1.brdMessageToOnlineUser(vMsg);
		} else if (brdrecv == 'all') {
			top.ifm1.brdMessageBrdToAll(vMsg);
		}
	}

	function brdMessageToGroup() {
		var vGroupId = document.getElementById('brd_grp').value;
		var vMsg = document.getElementById('brd_grp_messageContent').value;
		top.ifm1.brdMessageToGroup(vGroupId, vMsg);
	}
	
	function joinRoomInvite(to,pass){
	    top.ifm1.joinRoomInvite(to,pass);
	}
	
	function getUserStatus(){
	    var userId = document.getElementById('v_state').value;
	    var status = top.ifm1.getUserStatus(userId);
	    alert('用户：['+userId+']状态：'+status);
	}