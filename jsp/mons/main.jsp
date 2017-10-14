﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<embed id="warnsound" type="audio/wma" src="images/warn.wma" loop="false" hidden="true" autostart="false"></embed>
<title>全行应用系统交易监控</title>
<jsp:include page="inc.jsp"></jsp:include>
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
	<script src="../../js/mons/jquery.json-2.4.js.js"
		type="text/javascript"></script>
	<script src="../../js/mons/popup.js" type="text/javascript"></script>
	<script src="../../js/count-number.js" type="text/javascript"></script>
	<script type="text/javascript"> 
		function ShowMessage() 
		{ 
			var currTab =$('#index_tabs').tabs('getSelected'); 
			
			alert("www");
		} 
		
	</script> 
</head>
<!--弹出窗口 系统管理-->
<div class="sample_popup"     id="popup" style="visibility: hidden; display: none;">
<div class="menu_form_header" id="popup_drag">
<img class="menu_form_exit"   id="popup_exit" src="../../images/mons/popup_close.png" />
  <a id="AppWarnTitle">报警信息</a>
</div>
<div class="menu_form_content" id="AppWarnInfo" >报警信息</div>
</div>
<!--弹出窗口 系统管理结束-->

<body onload="show3();ShowMessage();">
	
	<div class="hotsys">
		<div class="hotsys_title">
			<div class="container">
			<TABLE>
				<TR>
					<td><IMG src="../../images/mons/clock_new/cb.png" name=a></td>
					<td><IMG src="../../images/mons/clock_new/cb.png" name=b></td>
					<td><IMG src="../../images/mons/clock_new/colon.png" name=c></td>
					<td><IMG src="../../images/mons/clock_new/cb.png" name=d></td>
					<td><IMG src="../../images/mons/clock_new/cb.png" name=e></td>
					<td><IMG src="../../images/mons/clock_new/colon.png" name=f></td>
					<td><IMG src="../../images/mons/clock_new/cb.png" name=g></td>
					<td><IMG src="../../images/mons/clock_new/cb.png" name=h></td>
					<td><IMG src="../../images/mons/clock_new/cam.png" name=j></td>
				</TR>
			</TABLE>

		</div>
		<div class="roll">
			<div id="gsdemo"  class="gsdemo">
			 <ul id="gsdemo1">
			 	<li>业务量:<font class="timer" id="count-number" data-speed="5000" data-from="0" data-to="0">0</font>&nbsp笔数</li>
			 	<li>金&nbsp&nbsp&nbsp额:<font class="timer" id="count-number1" data-speed="5000" data-from="0" data-to="0">0</font>&nbsp元</li>
		   </ul>
				
		    </div>
		</div>	
			<p>桂林银行应用系统监控</p>
		</div>
		
<!--  
		
-->
		

		<dl class="hotsys_box">
		
		    <div class="detail_box">
		    
		    </div>
	
			<!--切换按钮-->
			<div class="hotsys_button">
			   
			</div>
			
			 <div class="yujing" id="J_yujing" >
			 <div class="yujing_tab">
			<ul>
				<li id="one1" onclick="setTab('one',1,2)" class="hover"><img src="../../images/mons/yujing_tab_icon1.png" /></li>
				<li id="one2" onclick="setTab('one',2,2)" ><img src="../../images/mons/yujing_tab_icon2.png" /></li>
			</ul>
			<div class="sound_on" id="J_sound_on" ></div>
	        </div>
	        
			 <div id="con_one_1"  class="demo">
			 <div id="J_yujing_font"  ></div>
			 </div>
			 <div id="con_one_2" style="display:none;">
				<div id="demo" class="demo">
					<ul id="demo1" class="demo1">  
					</ul> 
					<ul id="demo2" class="demo1"></ul>
				</div> 
			</div>
			</div> 
			
  		</dl>
	</div>

	<script type="text/javascript"> 
	/*自定义设置 */
	var timeData1=60000;//交易监控的轮询时间
	var timeData2=60000;//预警监控的的轮询时间
	var offset = 2500; //轮换时间
	var pageNum = 1;//翻页次数
	
	var SysdataObj;//系统信息
	
	var isSound = true;
	
	var appTitle="";
	var appContext=""; //应用预警信息
	var appID="";
	var flag="";
	
	var tranTitle="";
	var tranContext="";
	var tranID="";
	var isSound = true;//声音开关
	var isEmbed = false;//是否预警
	
	$(function(){
		init();
		doSoundClick();
		
		initYuJing();
		RefreshSysInfo();
	});
	$(document).ready(function(){
		var movetotop;
		$('#gsdemo').hover(function(){
			clearInterval(movetotop);
		},function(){
			movetotop=setInterval('AutoScroll("#gsdemo")',3000);
		}).trigger('mouseleave');
	});

	function AutoScroll(obj){
		 var li_height= $('#gsdemo1').find('li').height();
	  if( $("#gsdemo1 li").length > 5 ){
		$(obj).find("ul:first").animate({
			marginTop:-li_height+'px'
		},1000,function(){
			$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
		});
	  }
	}

	/*翻牌效果处理*/
	
	var i=-1; //第i+1个tab开始
	var offset = 2500; //轮换时间
	var timer = null;
	function autorollDt(){
		$('dt:first').addClass('active');
		$('dd:first').css('display','block');
		autoroll();
		hookThumb();
	}
	function autoroll(){
		n = pageNum;
		i++;
		if(i > n){
			i = 0;
		}
		slide(i);
		timer = window.setTimeout(autoroll, offset);
	}
	
	function slide(i){
		$('dt').eq(i).addClass('active').siblings().removeClass('active');
		$('dd').eq(i).css('display','block').siblings('dd').css('display','none');
	}
	
	function hookThumb(){
		$('dt').hover(
			function () {
			if (timer) {
				clearTimeout(timer);
				i = $(this).prevAll().length;
				slide(i);
				}
			},
			function () {
				timer = window.setTimeout(autoroll, offset);
				this.blur();
				return false;
			}
		);
		
		$('dd').hover(
			function () {
				if (timer) {
				clearTimeout(timer);
				i = $(this).prevAll().length;
				slide(i);
				}
			},
			function () {
				timer = window.setTimeout(autoroll, offset);
				this.blur();
				return false;
			}
		);
	}
	</script>

	<!-- 预警处理 -->
	<script type="text/javascript">
	
	//预警滚动
	var speed=40;
	var demo=document.getElementById("demo"); 
	var demo2=document.getElementById("demo2"); 
	var demo1=document.getElementById("demo1"); 

	function Marquee(){ 
		if(demo2.offsetTop-demo.scrollTop<=0) 
		  demo.scrollTop-=demo1.offsetHeight; 
		else{ 
		  demo.scrollTop++; 
		} 
	} 
	
	var MyMar=setInterval(Marquee,speed); 
	demo.onmouseover=function() {clearInterval(MyMar);}
	demo.onmouseout=function() {MyMar=setInterval(Marquee,speed);} 
	
	//预警tabs
	function setTab(name,cursel,n){
		for(var i=1;i<=n;i++){
			var menu=document.getElementById(name+i);
			var con=document.getElementById("con_"+name+"_"+i);
			menu.className=i==cursel?"hover":"";
			con.style.display=i==cursel?"block":"none";
		}
	}
	
	// 预警收缩展开效果
	function initYuJingSet(){
		$("div.text").hide();//默认隐藏div，或者在样式表中添加.text{display:none}，推荐使用后者
		$(".demo p").click(function(){
			$(this).next(".text").slideToggle("slow");
		});
		
		$(".close").click(
				function () {
					$(this).parent().fadeTo(400, 0, function () { // Links with the class "close" will close parent
						$(this).slideUp(400);
					});
					return false;
				}	
		);
		
	}

	/* 初始化预警信息*/
	function initYuJing(){
		var m = new Date();
		var hh = ""+m.getHours();
        var mm = ""+m.getMinutes();
        var ss = ""+m.getSeconds();
        var tt = hh+mm+ss;
        
		var param = "";
		param = "MONSTranNO=MON022&jsonStr={\"TimeBg\":\""+'000000'+"\"}";
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data : param,
			dataType : "json",
			success : function(data) {
				var dataObj = data.WarnInfo;//这个.后面的名字要和json返回数据匹配
				var len = dataObj.length;
					if (len > 0) {
						var str="";
						for(var i=0;i<len;i++){
							var date = stringToJsTime(dataObj[i].Date+dataObj[i].Time);
							
							var msg="预警:"+ dataObj[i].Message;
							
							var msg1 = i+"--"+getSysInfo(dataObj[i].MonType)+"系统  时间:"+date.toLocaleTimeString();
							
							str+="<li><span class=\"close\"></span><p>"+msg1
								+"</p><div style=\"display: none;\" class=\"text\">"+msg
								+"</div></li>";
						}
						
						$('#demo1').html(str);
						$('#demo2').html(str);

						//设置预警
						initYuJingSet();
					}
				}
			});
			setTimeout(initYuJing,timeData2);
	}
	//交易预警信息显示
	function TranWarnInfoShow(title,context,sysID)
	{
		appID=sysID;
		appTitle=title;
		flag = 0;
	  tranContext=context;
		TranWarnInfoRefresh();
		popup_show();
	}
	//交易预警信息显示
	function TranWarnInfoRefresh(){
		
/*
		var m = new Date();
		var hh = ""+m.getHours();
        var mm = ""+m.getMinutes();
        var ss = ""+m.getSeconds();
        var tt = hh+mm+ss;
        */
        $('#AppWarnTitle').html(appTitle+"交易告警信息");
        $('#AppWarnInfo').empty();
		var msg="";
		
		var temp = "";
		
		if(typeof(tranContext)!='undefined' && tranContext!='undefined'){

			//alert(tranContext);
			var arr = tranContext.split("|");

			for( var i = 0 ; i < arr.length ; i ++ ){
				
				if(arr[i]!=""){
					//alert(arr[i]);
					var itemArr = arr[i].split(";");
					//alert(itemArr[2]);
					var warnstr="";
					if(itemArr.length >= 7)
					{
							temp = itemArr[3];
						
							if(temp[0]=='0')
								warnstr ="(" + (i+1) + ") 重要警告:";
							else if(temp[0]=='1')
								warnstr ="(" + (i+1) + ") 次要警告:"+"渠道号:["+itemArr[4]+"]<br>";
							else if(temp[0]=='2')
								warnstr ="(" + (i+1) + ") 次要警告:"+"业务类型:["+itemArr[5]+"]<br>";
							else
								warnstr ="(" + (i+1) + ") 次要警告:"+"渠道号:["+itemArr[4]+"],业务类型:["+itemArr[5]+"]<br>";
					}
					var ss = stringToJsTime(itemArr[1]+itemArr[2]);
					//alert(ss);
					warnstr+="&nbsp&nbsp时间:"+ss.toLocaleTimeString()+"<br>&nbsp&nbsp内容:"+itemArr[6];
					
					msg += warnstr+"<br>";
				}		
			}
;		}
		
		$('#AppWarnInfo').html(msg);
		

	}
	//应用预警信息显示
	function AppWarnInfoShow(title,context,sysID){
		appID=sysID;
		appTitle=title;
		flag = 1;
		appContext=context;
		AppWarnInfoRefresh();
		popup_show();
	}

	//应用预警信息显示
	function AppWarnInfoRefresh(){
		
		if(appTitle=="" || appContext=="")
			return;
		
		$('#AppWarnTitle').html(appTitle+"应用告警信息");
		
		var temp = "";
		if(typeof(appContext)!='undefined' && appContext!='undefined'){

			var arr = appContext.split("|");

			for( var i = 0 ; i < arr.length ; i ++ ){
				
				if(arr[i]!=""){
					var itemArr = arr[i].split(";");
					var warnstr="";
					
					if(itemArr.length >= 4)
					if(itemArr[2]=='2')
						warnstr ="(" + (i+1) + ") 重要警告:";
					else if(itemArr[2]=='1')
						warnstr ="(" + (i+1) + ") 次要警告:";
					
					warnstr+="监控对象["+itemArr[0]+"]<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp监控指标["+ itemArr[1]+"]<br>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp警告信息["+itemArr[3]+"]";
					
					temp += warnstr+"<br>";
				}		
			}
		}
		
		$('#AppWarnInfo').html(temp);

	}
	
	</script>

	<!-- 公共处理 -->
	<script type="text/javascript">
	//时间转换函数
	function stringToJsTime(time) {   
	    var y = time.substring(0,4);   
	    var m = time.substring(4,6)-1;   
	    var d = time.substring(6,8);   
	    var h = time.substring(8,10);   
	    var mm = time.substring(10,12);   
	   var ss = time.substring(12,14);   
	    var date = new Date(y,m,d,h,mm,ss,0);
	 
	    return date;   
	}
	
	/* 初始化监控业务*/
	function init(){ 
		var divstr="";
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/SysInfoInit.action', 
			dataType:"json",
			success: function(data){
				//console.info(data);
				var dataObj=data.obj;
				SysdataObj=dataObj;
				var len=dataObj.length;
				if(len>0){
				  var dtStr="";
				  var dlStr="";
				  var index=1;
				  
				  pageNum = len%6+1;
				  
				  for(var i=1;i<=len;i++){
					  if(i%6==1){
						if(i==1){
							dlStr+="<dd class=\"hotsys_a\">";
						}else if(index%2!=1){
							dlStr+="<div id=\"SysInfo_"+index+"\"></div></dd>";
							index++;
							dlStr+="<dd class=\"hotsys_a\">";
						}else{
							dlStr+="<div id=\"SysInfo_"+index+"\"></div></dd>";
							index++;
							dlStr+="<dd class=\"hotsys_b\">";
						}
						
					  	dtStr+="<dt></dt>";
					  }
					  dlStr+="<div class=\"hotsys_"+(i%6==0?"6":i%6)+"\" id=\""+dataObj[i-1].sysId
					  		+"\"></div>";
				  }
				  if(len%6!=1){
					  dlStr+="<div id=\"SysInfo_"+index+"\"></div></dd>";
				  }

				  $(".detail_box").html(dlStr);
				  $(".hotsys_button").html(dtStr);
				  
				  index=1;
				  for(var i=0;i<len;i++){
					  if(i!=0&&i%6==0){
						  var sysIndex="SysInfo_"+index;
						  $('#'+sysIndex).html(divstr);
						  index++;
						  divstr="";
					  }
					  count=i%6+7;
					  
					  var herfstr='systemPage.jsp?sysID='+dataObj[i].sysId+'&sysName='+encodeURI(encodeURI(dataObj[i].sysName));
					  divstr+='<div class=\'hotsys_'+count+'\'><a href=\''+herfstr+'\'><h4>'+dataObj[i].sysName+'</h4></a></div>';  

				  }
				  var sysIndex="SysInfo_"+index;
				  $('#'+sysIndex).html(divstr);
				  
				  autorollDt();
				}
			},
			error: function(XMLHttpRequest,textStatus,errorThown){
				alert(XMLHttpRequest.Status);
				alert(XMLHttpRequest.readyState);
				alert(XMLHttpRequest.textStatus);
			}
		});
	}

	function getImage(id){
		if(id==0){
			return "../../images/mons/light_green.gif";
		}else if(id==1){
			return "../../images/mons/light_yellow.gif";
		}else if(id==2){
			return "../../images/mons/light_red.gif";
		}else if(id==3){
			return "../../images/mons/light_gray.gif";
		}
	}
	
	function setWarnSound(id){
		if(id==true){
			
			isWarnSound(true);
		}
	}
	
	/* 初始化监控数据*/
	 function RefreshSysInfo(){ 
		var param = "";
		var warnInfo = 0;
		param = "MONSTranNO=MON016&jsonStr={\"SysCycle\":[]}";
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data : param,
			dataType : "json",
			success : function(data) {
	
				var dataObj = data.AvgTm;//这个.后面的名字要和json返回数据匹配
				
				//图表数据初始化
				var begin="<OBJECT width='414' height='268' id='MSColumn3D'>"
	                +"<embed src='FusionChartsSWF/MSColumn3D.swf' flashVars=\"&dataXML=<graph caption='成功率/天' "
	                +"xAxisName='天' yAxisName='成功率' legendPosition='RIGHT' showNames='1' showValues='0' bgcolor='f7f7f7' numberSuffix='%25' decimalPrecision='1' formatNumberScale='0'>";
				var end="</graph>\" quality='high' width='380'  height='200' name='MSColumn3D' type='application/x-shockwave-flash'/></OBJECT>";
				var coloum1="</categories><dataset seriesName='交易成功率' color='a2e521' >";
				var category ="<categories>";
				var coloum2="<dataset seriesName='业务成功率' color='fe9f47' >";
				var gsdemo;
				
				var len = dataObj.length;
				if (len > 0) {
						
						for (var i = 0; i < len; i++) {
									if(dataObj[i].ID == '100000')
									{
										var fromCount = $('#count-number').text();
										var fromAmount = $('#count-number1').text();
										//*****此处修正数据不断增加
										//var toCount = fromCount*1 + dataObj[i].Count*1;
										//var toAmount = fromAmount*1 + dataObj[i].Amount*1;
										var toCount = dataObj[i].Count*1;
										var toAmount = dataObj[i].Amount*1;
										//*****此处修正数据不断增加
										//$('count-number').attr('data-to');
										gsdemo='<li>业务量:<font class="timer" id="count-number" data-speed="5000" data-from="'+fromCount+'" data-to="'+ toCount +'">'+toCount+'</font>&nbsp笔数</li>';
										gsdemo +='<li>金&nbsp&nbsp&nbsp额:<font class="timer" id="count-number1" data-speed="5000" data-from="'+fromAmount+'" data-to="'+toAmount+'">'+toAmount+'</font>&nbsp元</li>';
										continue;
									}
										
									var htmlstr="";
									//var herfstr='systemPage.jsp?sysID='+dataObj[i].ID+'&sysName='+getSysInfo(dataObj[i].ID);
									var herfstr='ChannelPage.jsp?sysID='+dataObj[i].ID+'&sysName='+getSysInfo(dataObj[i].ID);
									
									warnInfo=Math.max(dataObj[i].TranWarn,dataObj[i].AppWarn,warnInfo);
									
									
									if(warnInfo>0)
									{
										if( isEmbed == false ) {
    		                          		isEmbed = true;
										}	
									}
								
									if(appID==dataObj[i].ID){
										appTitle=getSysInfo(dataObj[i].ID);
										appContext=dataObj[i].Context;
									}
									
									
									htmlstr += '<table class="hotsys_data2"><tr>'
									    +'<td align="center"><a onclick="TranWarnInfoShow(\''+getSysInfo(dataObj[i].ID)+'\',\''+dataObj[i].TranContext+'\',\''+dataObj[i].ID+'\')">交易</a></td>'
									    +'<td align="left"><img src="'+getImage(dataObj[i].TranWarn)+'" /></td>'
										+'<td align="center"><a onclick="AppWarnInfoShow(\''+getSysInfo(dataObj[i].ID)+'\',\''+dataObj[i].Context+'\',\''+dataObj[i].ID+'\')">应用</a></td>'
									    +'<td align="left"><img src="'+getImage(dataObj[i].AppWarn)+'" /></td></tr>'
									    +'</table>';
									    
									htmlstr += '<table class="hotsys_data"><tr><td>交易笔数</td><td>'
											+ dataObj[i].Count
											+ ' 笔</td></tr>';
									htmlstr += '<tr><td>平均响应时间</td><td>'
											+ dataObj[i].RespTime
											+ ' 秒</td></tr>';
									htmlstr += '<tr><td>交易成功率</td><td>'
											+ dataObj[i].TranRate
											+ '</td></tr>';
									htmlstr += '<tr><td>TPS峰值</td><td>'
											+ dataObj[i].TPSValue
											+ '</td></tr>';
									htmlstr += '<tr><td class="none">TPS峰值时间点</td><td class="none">'
											+ dataObj[i].TPSTime
											+ '</td></tr>';
									htmlstr +='</table>';
									$('#'+dataObj[i].ID).html(htmlstr);
									
									if(flag==0){
										TranWarnInfoRefresh();
									}else if(flag == 1){
										AppWarnInfoRefresh();
									}
									if ( getSysInfo(dataObj[i].ID) != null ){
										category += "<category name='" + getSysInfo(dataObj[i].ID) + "'/>";
										
										coloum1+="<set value='"+dataObj[i].TranRate.replace("%","")+"'/>";	
										coloum2+="<set value='"+dataObj[i].OperRate.replace("%","")+"'/>";
									}
								}
							
								coloum1+="</dataset>";
							  	coloum2+="</dataset>";
					}
					//document.getElementById("warnsound").play();
					$('#gsdemo1').empty();
					$('#gsdemo1').html(gsdemo);
					$('.timer').each(count1);
					setWarnSound(isEmbed);
					$('#J_yujing_font').html(begin+category+coloum1+coloum2+end);
					
				}
		});
		setTimeout(RefreshSysInfo,timeData1);
	}
	
	//获取系统信息
 	function getSysInfo( sys_id ){
		if (SysdataObj == null )
			return;
		
		var len=SysdataObj.length;
		
		for(var i=0;i<len;i++){
			if (SysdataObj[i].sysId == sys_id)
				return SysdataObj[i].sysName;
		}
	}
	
	function herfClick(){
	 	parent.$('#index_tabs').tabs("add", {
	 	      title: title,
	 	      content: content,
	 	      closable: true
	 	});
	}
 	
	</script>

	<!-- 初始化时间组件 -->
	<script>
		var dn;
		c1 = new Image();
		c1.src = "../../images/mons/clock_new/c1.png";
		c2 = new Image();
		c2.src = "../../images/mons/clock_new/c2.png";
		c3 = new Image();
		c3.src = "../../images/mons/clock_new/c3.png";
		c4 = new Image();
		c4.src = "../../images/mons/clock_new/c4.png";
		c5 = new Image();
		c5.src = "../../images/mons/clock_new/c5.png";
		c6 = new Image();
		c6.src = "../../images/mons/clock_new/c6.png";
		c7 = new Image();
		c7.src = "../../images/mons/clock_new/c7.png";
		c8 = new Image();
		c8.src = "../../images/mons/clock_new/c8.png";
		c9 = new Image();
		c9.src = "../../images/mons/clock_new/c9.png";
		c0 = new Image();
		c0.src = "../../images/mons/clock_new/c0.png";
		cb = new Image();
		cb.src = "../../images/mons/clock_new/cb.png";
		cam = new Image();
		cam.src = "../../images/mons/clock_new/cam.png";
		cpm = new Image();
		cpm.src = "../../images/mons/clock_new/cpm.png";
		function extract(h, m, s, type) {
			if (!document.images)
				return;
			if (h <= 9) {
				document.images.a.src = cb.src;
				document.images.b.src = eval("c" + h + ".src");
			} else {
				document.images.a.src = eval("c" + Math.floor(h / 10) + ".src");
				document.images.b.src = eval("c" + (h % 10) + ".src");
			}
			if (m <= 9) {
				document.images.d.src = c0.src;
				document.images.e.src = eval("c" + m + ".src");
			} else {
				document.images.d.src = eval("c" + Math.floor(m / 10) + ".src");
				document.images.e.src = eval("c" + (m % 10) + ".src");
			}
			if (s <= 9) {
				document.g.src = c0.src;
				document.images.h.src = eval("c" + s + ".src");
			} else {
				document.images.g.src = eval("c" + Math.floor(s / 10) + ".src");
				document.images.h.src = eval("c" + (s % 10) + ".src");
			}
			if (dn == "AM")
				document.j.src = cam.src;
			else
				document.images.j.src = cpm.src;
		}
		
		function show3() {
			if (!document.images)
				return;
			var Digital = new Date();
			var hours = Digital.getHours();
			var minutes = Digital.getMinutes();
			var seconds = Digital.getSeconds();
			dn = "AM";
			if ((hours >= 12) && (minutes >= 1) || (hours >= 13)) {
				dn = "PM";
				hours = hours - 12;
			}
			if (hours == 0)
				hours = 12;
			extract(hours, minutes, seconds, dn);
			setTimeout("show3()", 1000);
		}
	
		
		//按钮切换
		function doSoundClick(){
		    jQuery('#J_sound_on').click(function(){
				 var _this=jQuery(this);
				  if(_this.hasClass('sound_off')){
				       _this.removeClass('sound_off').addClass('sound_on');
				       isSound=true;
				  }else{
				       _this.removeClass('sound_on').addClass('sound_off');
				       isSound=false;
				       document.getElementById("warnsound").stop();
				       //$('#warnsound').remove();
				  } 
			}) ;
		}
		
		//
		function isWarnSound(isWarn){
		    if( isSound==true )
		    {
		    	document.getElementById("warnsound").play();
		    }
		    isEmbed = false;
		}

	</script>

</body>
</html>
