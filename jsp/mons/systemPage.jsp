<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
	String  sysName = request.getParameter("sysName");
	sysName = URLDecoder.decode(sysName,"utf-8");
	
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=sysName %>吞吐量及交易分布</title>
<jsp:include page="inc.jsp"></jsp:include>
<script src="<%=basePath %>/js/menuTree.js" type="text/javascript"></script>
<script src="<%=basePath %>/js/firebugx.js" type="text/javascript"></script>
 
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
<script type="text/javascript" src="../../js/mons/jquery.js" ></script>
<script type="text/javascript" src="../../js/mons/action_clock.js" ></script>
<script type="text/javascript" src="../../js/mons/clock.js" ></script>
<script type="text/javascript" src="../../js/mons/mons.js" ></script>
</head>

<body onload="show3()" value=${param.sysID}>
<div class="pe">
  <div class="pe_title"><p><%=sysName %>吞吐量及交易分布</p></div>
  <div class="pe_box">
	<div class="pe_1"><h4>交易笔数</h4><h5 id="pe_1"></h5></div>
	<div class="pe_2"><h4>平均响应时间</h4><h5 id="pe_2"></h5></div>
	<div class="pe_3"><h4>超时总笔数</h4><h5 id="pe_3"></h5></div>
	<div class="pe_4"><h4>总金额</h4><h5 id="pe_4"></h5></div>
	<div class="pe_5"><h4>业务成功率</h4><h5 id="pe_5"></h5></div>
	<div class="pe_6"><h4>交易成功率</h4><h5 id="pe_6"></h5></div>
	<div class="pe_7"><h4>峰值TPS值</h4><h5 id="pe_7"></h5></div>
	<div class="pe_8"><h4>峰值时间点</h4><h5 id="pe_8"></h5></div>
	<div class="pe_9"><h4><%=sysName %></h4><h5 id="pe_9"></h5></div>
  </div>
  
  <div class="pe_time">
  <table class="pe_time_table">
    <tr>
	   <td>统计周期：</td>
	   <td><input id="J_pe_text1" name="" type="text" class="pe_text" /></td>
	   <td><input id="J_StaBtn" name="" type="button" class="pe_button" value="确定" /></td>
	</tr>
  </table>
   <table class="pe_time_table">
    <tr>
	   <td>刷新周期：</td>
	   <td><input id="J_pe_text2" name="" type="text" class="pe_text2" /></td>
	   <td><input id="J_RefBtn" name="" type="button" class="pe_button" value="确定" /></td>
	</tr>
  </table>  
  </div>
  
  
  <dl class="index_yp">
  <!--yp1 start-->
    
<div class="detail_box">
		    
</div>
	  
<div class="photo_button">
</div>
</dl>

</div>

<!-- 初始化组件 -->
<script type="text/javascript">
var timeData1=60000;//交易监控的轮询时间

var StatisData=300; //统计周期值

var channels;
var warnPara; //预警参数
//var pageNum = 1;//翻页次数

var J_StaBtn=$('#J_StaBtn');
var J_RefBtn=$('#J_RefBtn');
var J_Pe1=$('#J_pe_text1');
var J_Pe2=$('#J_pe_text2');

$(function(){

	document.getElementById("J_pe_text1").value=StatisData;
	document.getElementById("J_pe_text2").value=offset/1000;
	
	initChannelID();
	initbusiType();

	initWarnInfo();

	RefreshSysInfo();
	RefreshData1();
	RefreshData2();
	
	J_StaBtn.click(staBtnFun);
	J_RefBtn.click(refBtnFun);
});

function staBtnFun(){
	StatisData=J_Pe1.val();
	alert("统计周期已设置为 "+StatisData+" 分");
}
function refBtnFun(){
	offset=J_Pe2.val()*1000;
	alert("刷新周期已设置为 "+offset/1000+" 秒");
}

/* 初始化预警信息*/
function initWarnInfo(){
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/GetMonsWarnPara.action',
		data:"selectSysID="+'${param.sysID}',
		dataType:"json",
		async:false,
		success: function(data){
			var dataObj=data.obj;
			warnPara=dataObj;
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.Status);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
}

/* 初始化渠道代码*/
function initChannelID(){
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/ChannelInfoInit.action',
		data:"selectSysID="+'${param.sysID}',
		dataType:"json",
		async:false,
		success: function(data){
			var dataObj=data.obj;
			channels=dataObj;
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.Status);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
}

/* 以系统号初始化统计数据*/
function RefreshData1(){ 
	var param = "";
	param = "MONSTranNO=MON021&jsonStr={\"SysID\":\""+'${param.sysID}'+"\",\"Cycle\":\""+
		StatisData+"\",\"Flag\":\""+
		0+"\"}";
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data : param,
		dataType : "json",
		success : function(data) {
			var dataObj = data.SysSum;//这个.后面的名字要和json返回数据匹配
			var len = dataObj.length;
				if (len > 0) {
					for(var i=0;i<len;i++){
						
					var htmlstr="";
					
					var RespTime = dataObj[i].RespTime + "s";
					var TranRateNum = Number(dataObj[i].TranRate.replace('%',''));
					var OperRateNum = Number(dataObj[i].OperRate.replace('%',''));
					
					var TranRate=dataObj[i].TranRate;
					var OperRate=dataObj[i].OperRate;
				
					if( warnPara.length == 1 ){
						if ( Number(dataObj[i].RespTime) > warnPara[0].respTime )
							RespTime = "<span>" + dataObj[i].RespTime + "s</span>";
							
						if ( TranRateNum < warnPara[0].tranRate )
							TranRate = "<span>" + dataObj[i].TranRate + "</span>";
							
						if ( OperRateNum < warnPara[0].operRate )
							OperRate = "<span>" + dataObj[i].OperRate + "</span>";
					}
				
					htmlstr += '<table class="pe_data"><tr><td>交易笔数</td><td>'
							+ dataObj[i].Count
							+ ' 笔</td></tr>';
					htmlstr += '<tr><td>平均响应时间</td><td>'
							+  RespTime
							+ '</td></tr>';
					htmlstr += '<tr><td>超时总笔数</td><td>'
							+ dataObj[i].TimeOut
							+ '</td></tr>';
					htmlstr += '<tr><td>交易总金额</td><td>'
							+ dataObj[i].Amount
							+ '</td></tr>';
					htmlstr += '<tr><td>业务成功率</td><td>'
							+ OperRate
							+ '</td></tr>';
					htmlstr += '<tr><td class="none">交易成功率</td><td class="none">'
							+ TranRate
							+ '</td></tr>';
					htmlstr +='</table>';
					var cid="c"+dataObj[i].BusiType;
					$('#'+cid).html(htmlstr);
					}
						  }
						}
					});
			setTimeout(RefreshData1,timeData1);
		}
		
/* 以业务类型初始化统计数据*/
function RefreshData2(){ 
	var param = "";
	param = "MONSTranNO=MON021&jsonStr={\"SysID\":\""+'${param.sysID}'+"\",\"Cycle\":\""+
		StatisData+"\",\"Flag\":\""+
		1+"\"}";
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data : param,
		dataType : "json",
		success : function(data) {
			var dataObj = data.SysSum;//这个.后面的名字要和json返回数据匹配
			var len = dataObj.length;
			if (len > 0) {
				for(var i=0;i<len;i++){
					var htmlstr="";
					
					var RespTime = dataObj[i].RespTime + "s";
					var TranRateNum = Number(dataObj[i].TranRate.replace('%',''));
					var OperRateNum = Number(dataObj[i].OperRate.replace('%',''));
					
					var TranRate=dataObj[i].TranRate;
					var OperRate=dataObj[i].OperRate;
					
					if( warnPara.length == 1 ){
						if ( Number(dataObj[i].RespTime) > warnPara[0].respTime )
							RespTime = "<span>" + dataObj[i].RespTime + "s</span>";
							
						if ( TranRateNum < warnPara[0].tranRate )
							TranRate = "<span>" + dataObj[i].TranRate + "</span>";
							
							
						if ( OperRateNum < warnPara[0].operRate )
							OperRate = "<span>" + dataObj[i].OperRate + "</span>";
					}
				
					htmlstr += '<table class="pe_data"><tr><td>交易笔数</td><td>'
							+ dataObj[i].Count
							+ ' 笔</td></tr>';
					htmlstr += '<tr><td>平均响应时间</td><td>'
							+ RespTime
							+ ' </td></tr>';
					htmlstr += '<tr><td>超时总笔数</td><td>'
							+ dataObj[i].TimeOut
							+ '</td></tr>';
					htmlstr += '<tr><td>交易总金额</td><td>'
							+ dataObj[i].Amount
							+ '</td></tr>';
					htmlstr += '<tr><td>业务成功率</td><td>'
							+ OperRate
							+ '</td></tr>';
					htmlstr += '<tr><td class="none">交易成功率</td><td class="none">'
							+ TranRate
							+ '</td></tr>';
					htmlstr +='</table>';
					var bid="b"+dataObj[i].BusiType;
					$('#'+bid).html(htmlstr);
				}
					  }
					}
				});
			setTimeout(RefreshData2,timeData1);
		}

/* 初始化业务类型*/
function initbusiType(){

	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/BusiInfoInit.action', 
		data:"selectSysID="+'${param.sysID}',
		dataType:"json",
		async:false,
		success: function(data){
			dataObj=data.obj;
			var len1=channels.length;
			var len2=dataObj.length;
			var len=len1>len2?len1:len2;
			var dlStr="";
			var dtStr="";
			var index=1;
			//pageNum = len%3+1;
			if(len==0){
				dlStr+=" <dd class=\"yp_card1\"></dd>";
				$(".detail_box").html(dlStr);
			}
				
			for(var i=1;i<=len;i++){
				  if(i%3==1){
					if(i==1){
						dlStr+=" <dd class=\"yp_card1\">";
					}else if(index%2!=1){
						dlStr+="</dd>";
						index++;
						dlStr+=" <dd class=\"yp_card3\">";
					}else{
						dlStr+="</dd>";
						index++;
						dlStr+=" <dd class=\"yp_card2\">";
					}
					
				  	dtStr+="<dt></dt>";
				  }

				  
				  if(i<=len1)
				  {	  
					var hrefstrChannel='<a href=\"ChannelTranPage.jsp?sysID='+'${param.sysID}'
							+'&channelName='+channels[i-1].channelDesc
							+'&Para1='+channels[i-1].channelId
							+'&Para2='
							+"\"</a>";
					
				  	dlStr+="<div class=\"yp_card_"+(i%3==0?"3":i%3)+"\"> "
				  		+"<table class=\"pe_box2\">"
				  		+"<tr><td class=\"pe_box2_td1\">"+hrefstrChannel
				  		+channels[i-1].channelDesc+"</td>"
				  		+"<td><table class=\"pe_data\">"
				  		+"<div id=\"c"+channels[i-1].channelId+"\"></div>"
				  		+"</table></td></tr></table></div>";
				  }
				  if(i<=len2)
				  {
					  var hrefstrBusiType='<a href=\"ChannelTranPage.jsp?sysID='+'${param.sysID}'+'&channelName='+dataObj[i-1].busiDesc+"\"</a>";
					  
					  var hrefstrBusiType='<a href=\"ChannelTranPage.jsp?sysID='+'${param.sysID}'
						+'&channelName='+dataObj[i-1].busiDesc
						+'&Para1='
						+'&Para2='+dataObj[i-1].busiType
						+"\"</a>";
					  dlStr+="<div class=\"yp_card_"+(i%3==0?"6":i%3+3)+"\"> "
				  		+"<table class=\"pe_box2\">"
				  		+"<tr><td class=\"pe_box2_td1\">"+hrefstrBusiType
				  		+dataObj[i-1].busiDesc+"</td>"
				  		+"<td><table class=\"pe_data\">"
				  		+"<div id=\"b"+dataObj[i-1].busiType+"\"></div>"
				  		+"</table></td></tr></table></div>";
				  }
			  }
			  dlStr+="</dd>";
			  //alert(dlStr);
			  //alert(dtStr);
			  $(".detail_box").html(dlStr);
			  $(".photo_button").html(dtStr);
			
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.responseText);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
}

/* 初始化监控数据*/
function RefreshSysInfo(){ 
	var param = "";

	param = "MONSTranNO=MON016&jsonStr={\"SysCycle\":[]}";
	
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data : param,
		dataType : "json",
		success : function(data) {
			var dataObj = data.AvgTm;//这个.后面的名字要和json返回数据匹配
			var len = dataObj.length;
			
				if (len > 0) {
					for (var i = 0; i < len; i++) {
						
						if(dataObj[i].ID == '${param.sysID}' )
						{
							document.getElementById("pe_1").innerHTML=dataObj[i].Count+'笔';
							document.getElementById("pe_2").innerHTML=dataObj[i].RespTime+'s';
							document.getElementById("pe_3").innerHTML=dataObj[i].TimeOut+'笔';
							document.getElementById("pe_4").innerHTML=dataObj[i].Amount;
							document.getElementById("pe_5").innerHTML=dataObj[i].OperRate;
							document.getElementById("pe_6").innerHTML=dataObj[i].TranRate;
							document.getElementById("pe_7").innerHTML=dataObj[i].TPSValue;
							document.getElementById("pe_8").innerHTML=dataObj[i].TPSTime;
							document.getElementById("pe_9").innerHTML=dataObj[i].Count+'笔';
						}
					}
				}
			}
		});
			
	    setTimeout(RefreshSysInfo,timeData1);
	}
</script>
<!-- 初始化时间组件 -->
	<script>
		var dn;
		c1 = new Image();
		c1.src = "../../images/mons/clock/c1.gif";
		c2 = new Image();
		c2.src = "../../images/mons/clock/c2.gif";
		c3 = new Image();
		c3.src = "../../images/mons/clock/c3.gif";
		c4 = new Image();
		c4.src = "../../images/mons/clock/c4.gif";
		c5 = new Image();
		c5.src = "../../images/mons/clock/c5.gif";
		c6 = new Image();
		c6.src = "../../images/mons/clock/c6.gif";
		c7 = new Image();
		c7.src = "../../images/mons/clock/c7.gif";
		c8 = new Image();
		c8.src = "../../images/mons/clock/c8.gif";
		c9 = new Image();
		c9.src = "../../images/mons/clock/c9.gif";
		c0 = new Image();
		c0.src = "../../images/mons/clock/c0.gif";
		cb = new Image();
		cb.src = "../../images/mons/clock/cb.gif";
		cam = new Image();
		cam.src = "../../images/mons/clock/cam.gif";
		cpm = new Image();
		cpm.src = "../../images/mons/clock/cpm.gif";
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
</script>


<script type="text/javascript"> 
$(document).ready(function(){
$('dt:first').addClass('active');
$('dd:first').css('display','block');
autoroll();
hookThumb();
});
var i=-1; //第i+1个tab开始
var offset = 5000; //轮换时间
var timer = null;
function autoroll(){
n = $('dt').length-1;
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
</body>
</html>
