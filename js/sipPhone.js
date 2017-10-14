function SipPhone(_vBps, _vVideoSize) {

	var _this = this;

	var vInital = false;
	// var vBps = 384; //默认是384 bps
	// var vVideoSize ="cif"; //默认是384 bps

	var vBps; // 默认是384 bps
	var vVideoSize; // 默认是384 bps

	var certificateName;
	var certificateCode;
	var clientName;
	var iSupportVideo;
	var userName;
	var pwd;
	var serverIP;

	_this.setUserName = function(_userName) {
		userName = _userName;
	}

	_this.getUserName = function() {
		return userName;
	}

	_this.setPwd = function(_pwd) {
		pwd = _pwd;
	}

	_this.getPwd = function() {
		return pwd;
	}

	_this.setServerIP = function(_serverIP) {
		serverIP = _serverIP;
	}

	_this.getServerIP = function() {
		return serverIP;
	}

	_this.setCertificateName = function(_certificateName) {
		certificateName = _certificateName;
	}

	_this.getCertificateName = function() {
		return certificateName;
	}

	_this.setCertificateCode = function(_certificateCode) {
		certificateCode = _certificateCode;
	}

	_this.getCertificateCode = function() {
		return certificateCode;
	}

	_this.setClientName = function(_clientName) {
		clientName = _clientName;
	}

	_this.getClientName = function() {
		return clientName;
	}

	_this.setISupportVideo = function(_iSupportVideo) {
		iSupportVideo = _iSupportVideo;
	}

	_this.getISupportVideo = function() {
		return iSupportVideo;
	}

	var init = function() {
		if (!_vBps || !_vVideoSize) {
			// alert("_vBps and _vVideoSize must be input!");
			return;
		}
		vBps = _vBps;
		vVideoSize = _vVideoSize;
	}

	var InitialEvent = function() {
		// alert("InitialEvent");
	}

	var $E = function(id) {
		return document.getElementById(id)
	}

	var $F = function(id) {
		var vE = $E(id);
		return vE.value;
	}

	var InitialAudio = function() {
		var vMicCount = SipPhoneCtrl.Audio_GetMicDeviceCount();
		var vCurDevice = SipPhoneCtrl.Audio_GetCurrentMicDeviceName();
		for (var i = 0; i < vMicCount; i++) {
			var vDeviceName = SipPhoneCtrl.Audio_GetMicDeviceName(i);
			$E('micDevice').options.add(new Option(vDeviceName, vDeviceName));
			if (vCurDevice == vDeviceName) {
				$E('micDevice').selectedIndex = $E('micDevice').options.length
						- 1;
			}
		}

		var vSpeakerCount = SipPhoneCtrl.Audio_GetSpeakerDeviceCount();
		vCurDevice = SipPhoneCtrl.Audio_GetCurrentSpeakerDeviceName();
		for (i = 0; i < vSpeakerCount; i++) {
			var vDeviceName = SipPhoneCtrl.Audio_GetSpeakerDeviceName(i);
			$E('speakerDevice').options
					.add(new Option(vDeviceName, vDeviceName));
			if (vCurDevice == vDeviceName) {
				$E('speakerDevice').selectedIndex = $E('speakerDevice').options.length
						- 1;
			}
		}
	}

	var InitialVideo = function() {
		var vMicCount = SipPhoneCtrl.Video_GetVideoDeviceCount();
		var vCurDevice = SipPhoneCtrl.Video_GetVideoCurrentDevice();
		for (var i = 0; i < vMicCount; i++) {
			var vDeviceName = SipPhoneCtrl.Video_GetVideoDeviceName(i);
			$E('videoDevice').options.add(new Option(vDeviceName, vDeviceName));
			if (vCurDevice == vDeviceName) {
				$E('videoDevice').selectedIndex = $E('videoDevice').options.length
						- 1;
			}
		}
		InitialVideoSize();
	}

	// 初始化系统支持的图像大小
	var InitialVideoSize = function() {
		var vMicCount = SipPhoneCtrl.Video_GetVideoSupportVideoSizeCount();
		var vCurDevice = vVideoSize; // SipPhoneCtrl.Video_GetCurrentVideoFrameSize();
		for (var i = 0; i < vMicCount; i++) {
			var vDeviceName = SipPhoneCtrl.Video_GetVideoSizeName(i);
			$E('id_videoSize').options
					.add(new Option(vDeviceName, vDeviceName));
			if (vCurDevice == vDeviceName) {
				$E('id_videoSize').selectedIndex = $E('id_videoSize').options.length
						- 1;
			}
		}
		SipPhoneCtrl.Video_SetVideoTargetBPS(vBps);
		SipPhoneCtrl.Video_SetVideoFrameSize(vVideoSize);
		_this.onshowPreVideo(1);
	}

	/*
	 * ---------------初始化------------------- SetAuthCode(string name,string
	 * codec)::注册证书 RETURN::null
	 * 
	 * SetMyName(string name)::设置客户端的名字 RETURN::null
	 * 
	 * Initial(int iSupportVideo)::是否支持视频 RETURN::null
	 * 
	 * ---------------音频API------------------- Int
	 * Audio_GetMicDeviceCount()::获取本地麦克风的个数 String
	 * Audio_GetCurrentMicDeviceName()::获取当前麦克风设备名字 String
	 * Audio_GetMicDeviceName(int iIndex)：：获取对应的麦克风设备名字
	 * 
	 * Int Audio_GetSpeakerDeviceCount()：：
	 * 
	 */
	_this.initial = function() {
//		if (vInital == true)
			//return;
		alert("-----++++++-----");
		SipPhoneCtrl.SetAuthCode(certificateName, certificateCode);
		SipPhoneCtrl.SetMyName(clientName);
		SipPhoneCtrl.Initial(iSupportVideo);

		InitialAudio();
		InitialVideo();
		InitialEvent();
		vInital = true;
	}

	_this.OnRegister = function() {
		// alert($F('serverIP'));
		SipPhoneCtrl.DoRegister($E('userName').value, $E('pwd').value,
				$F('serverIP'));
	}
	_this.onRegister = function() {
		// alert($F('serverIP'));
		SipPhoneCtrl.DoRegister(userName, pwd, serverIP);
	}

	_this.OnUnRegister = function() {
		SipPhoneCtrl.UnRegister();
	}

	_this.OnDial = function() {
		SipPhoneCtrl.Video_SetVideoTargetBPS($F('id_kbps'));
		SipPhoneCtrl.Video_SetVideoFrameFPS(15);
		SipPhoneCtrl.Video_SetVideoFrameSize($F('id_videoSize'));
		// SipPhoneCtrl.Dial($E('phone').value);
		SipPhoneCtrl.Dial('1002');
	}

	// 挂断电话
	_this.OnHangup = function() {
		SipPhoneCtrl.Hangup();
	}

	_this.onMicDeviceChange = function() {
		SipPhoneCtrl.Audio_SetCurrentMicDeviceName(deviceName);
	}

	_this.onSpeakerDeviceChange = function() {
		SipPhoneCtrl.Audio_SetCurrentSpeakerDeviceName(deviceName);
	}

	// 表示视频大小发生了改变
	_this.onVideoSizeChange = function() {
		SipPhoneCtrl.Video_SetVideoFrameSize(videoSize);
	}

	// 表示视频设备更换了
	_this.onVideoDeviceChange = function() {
		SipPhoneCtrl.Video_SetVideoCurrentDeviceByName(deviceName);
	}

	_this.OnDtmf = function() {
		SipPhoneCtrl.SendDTMF(dtmf);
	}

	// 设置是否显示本地视频
	_this.onshowPreVideo = function(showV) {
		SipPhoneCtrl.Video_SetViewPreView(showV);
	}

	init();
}






