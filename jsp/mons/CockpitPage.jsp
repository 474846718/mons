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
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title><%=sysName%>统计图表</title>
<script src="<%=basePath%>/js/mons/mons.js" type="text/javascript"></script>
<script src="../../js/FusionCharts/FusionCharts.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="./jquery-easyui-1.4.1/demo.css">
<script type="text/javascript" src="./jquery-easyui-1.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="./jquery-easyui-1.4.1/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="./jquery-easyui-1.4.1/themes/icon.css">
<script type="text/javascript" src="./jquery-easyui-1.4.1/jquery.easyui.min.js" ></script>
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" ></script>

<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/form.css"  />
<script type="text/javascript" src="<%=basePath %>/js/ztree/jquery.ztree.all-3.5.min.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/ztree/zTreeStyle/zTreeStyle.css"/>
<link rel="stylesheet" href="<%=basePath%>/css/mons/index.css" type="text/css">


<script src="<%=basePath%>/js/jquery.table2.js" type="text/javascript"></script>	
<script src="<%=basePath%>/js/grid.js" type="text/javascript"></script>	

<script type="text/javascript">
var ChartLine = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
var ChartLine1 = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
var ChartLine2 = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
var ChartLine3 = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
var J_MinBgDate = $('#J_MinBgDate');
var J_MinBgTime = $('#J_MinBgTime');
var J_MinEdTime = $('#J_MinEdTime');
var J_DayBgDate = $('#J_DayBgDate');
var J_DayEdDate = $('#J_DayEdDate');

$(document).ready(function(){
	// FusionCharts("Column3D").dispose();
	 dataTimeSpinnerInit();
	 getDate();
	 $('#J_MinSearch').click(minSearchFun);
	 $('#J_DaySearch').click(daySearchFun);
	 $('#J_MonSearch').click(monSearchFun);
	 $('#J_YearSearch').click(yearSearchFun);
	 //initFusionCharts0();
	 //initFusionCharts1();
	 //initFusionCharts2();
	 //initFusionCharts3();
});
function minSearchFun(){
	var jFlag = $('#J_MinIndex').combobox('getValue');
	var jBgDate = $('#J_MinBgDate').datebox('getValue');
	jBgDate = jBgDate.replace("-","").replace("-","");
	var jBgTime = $('#J_MinBgTime').timespinner('getValue');
	jBgTime = jBgTime.replace(":","").replace(":","");
	var jEdTime = $('#J_MinEdTime').timespinner('getValue');
	jEdTime = jEdTime.replace(":","").replace(":","");
	var yMinAxis = $('#J_MinIndex').combobox('getText');
	var str="{\"AvgTm_ID\":\""+'${param.sysID}'+"\",\"Flag\":\""+
	"0"+"\",\"TranDate\":\""+
	jBgDate+"\",\"TimeBg\":\""+
	jBgTime+"\",\"TimeEd\":\""+jEdTime+"\"}";
	
	initFusionCharts(str,yMinAxis,jFlag,'detail0','0');
}
function daySearchFun(){
	var jFlag = $('#J_DayIndex').combobox('getValue');
	var jBgDate = $('#J_DayBgDate').datebox('getValue');
	jBgDate = jBgDate.replace("-","").replace("-","");
	var jEdDate = $('#J_DayEdDate').datebox('getValue');
	jEdDate = jEdDate.replace("-","").replace("-","");
	var yDayAxis = $('#J_DayIndex').combobox('getText');
	var str="{\"AvgTm_ID\":\""+'${param.sysID}'+"\",\"Flag\":\""+
	"1"+"\",\"TranDate\":\""+jBgDate+"\",\"EdDate\":\""+jEdDate+"\"}";
	
	initFusionCharts(str,yDayAxis,jFlag,'detail1','1');
}
function monSearchFun(){
	var jFlag = $('#J_MonIndex').combobox('getValue');
	var jBgDate = $('#J_MonBgDate').datebox('getValue');
	jBgDate = jBgDate.replace("-","");
	var jEdDate = $('#J_MonEdDate').datebox('getValue');
	jEdDate = jEdDate.replace("-","");
	var yMonAxis = $('#J_MonIndex').combobox('getText');
	var str="{\"AvgTm_ID\":\""+'${param.sysID}'+"\",\"Flag\":\""+
	"2"+"\",\"TranDate\":\""+jBgDate+"\",\"EdDate\":\""+jEdDate+"\"}";
	
	initFusionCharts(str,yMonAxis,jFlag,'detail2','2');
}
function yearSearchFun(){
	var jFlag = $('#J_YearIndex').combobox('getValue');
	var yYearAxis = $('#J_YearIndex').combobox('getText');
	var str="{\"AvgTm_ID\":\""+'${param.sysID}'+"\",\"Flag\":\""+"3"+"\"}";

	initFusionCharts(str,yYearAxis,jFlag,'detail3','3');
}
function initFusionCharts( str, yAxis, jFlag, detail,vFlag){
	var param = "MONSTranNO=INQ025&jsonStr="+str;
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data:param,
		dataType:"json",
		success: function(data){
			
			var dataObj=data.Statis;
			
			var step;
			if(vFlag == 0){
				step = "2";
			}else{
				step = "1";
			}
			var begin="<graph caption='"+yAxis+"/时间' xAxisName='时间' rotateNames='1' yAxisName='"+yAxis+"'  outCnvBaseFontColor='000000' labelStep='"
			    + step +"'  bgColor='035785,0986c4' bgAlpha='100' canvasBorderColor='ffffff' showNames='1' decimalPrecision='2' formatNumberScale='0' "
				+" drawAnchors ='1' baseFontColor='000000'  lineThickness='2' showLimits='2' labelDisplay='Rotate' slantLabels='1'";
			if(jFlag == 5 || jFlag == 6){
				var tmp = "numberSuffix='%25'";
				begin += tmp;
			}
			begin +=">";
			var end="</graph>";
			var coloum="<categories>";
			var isValue1="<dataset seriesName='"+yAxis+"' color='FF6666'>";
			var len=dataObj.length;
			if(len>0){
			  
				for(var i=len-1;i>=0;i--){
						  if(vFlag == 0){
							  var fTime = dataObj[i].Time.substring(0,2)+":"+dataObj[i].Time.substring(2,4);
						  }else if(vFlag == 1){
							  var fTime = dataObj[i].Time.substring(0,4)+"-"+dataObj[i].Time.substring(4,6)+"-"+dataObj[i].Time.substring(6,8);
						  }else if(vFlag == 2){
							  var fTime = dataObj[i].Time.substring(0,4)+"-"+dataObj[i].Time.substring(4,6);
						  }else if(vFlag == 3){
							  var fTime = dataObj[i].Time.substring(0,4);
						  }
						  if(jFlag == 0){
						  		coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].Count +"'/>";
					  	  }else if(jFlag == 1){
					  			coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].Amount +"'/>";
				   		  }else if(jFlag == 2){
					   			coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].TpsValue +"'/>";
					  	  }else if(jFlag == 3){
					  			coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].RespTime +"'/>";
						  		
					      }else if(jFlag == 4){
					    	  	coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].TimeOut +"'/>";
						  		
						  }else if(jFlag == 5){
							  	coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].OperRate +"'/>";
			   			  }else if(jFlag == 6){
			   					coloum+="<category name='"+fTime +"'/>";
								isValue1+="<set value='"+dataObj[i].TranRate +"'/>";
					  	  }
			   }
			   coloum+="</categories>";
			   isValue1+="</dataset>";
			}
			//FusionCharts("Column3D").dispose();
			if(detail == 'detail0'){
				//ChartColumn3D = new FusionCharts("FusionChartsSWF/Column3D.swf", "Column3D", "1250", "315");
				//ChartColumn3D.setDataXML(begin+coloum+end);
				ChartLine = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
				ChartLine.setDataXML(begin+coloum+isValue1+end);
				ChartLine.render(detail);
			}else if(detail == 'detail1'){
				ChartLine1 = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
				//alert(begin+isValue1);
				ChartLine1.setDataXML(begin+coloum+isValue1+end);
				ChartLine1.render(detail);
			}else if(detail == 'detail2'){
				ChartLine2 = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
				ChartLine2.setDataXML(begin+coloum+isValue1+end);
				ChartLine2.render(detail);
			}else{
				ChartLine3 = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "1250", "358");
				ChartLine3.setDataXML(begin+coloum+isValue1+end);
				ChartLine3.render(detail);
			}
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.Status);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
}
function dataTimeSpinnerInit(){
	$('#J_MinBgTime').timespinner('setValue', '00:00');  
	$('#J_MinEdTime').timespinner('setValue', '23:59');
    var currDate=new Date();
	var str=FormatDate(currDate);
	$('#J_MinBgDate').datebox('setValue', str);
	
	var y = currDate.getFullYear();
	var m = currDate.getMonth();
	var firstDay = new Date(y,m,1);
	var lastDay = new Date(y,m+1,0);
	var str1 = FormatDate(firstDay);
	$('#J_DayBgDate').datebox('setValue',str1);
	var str2 = FormatDate(lastDay);
	$('#J_DayEdDate').datebox('setValue',str2);
}
function FormatDate(date){
	var str=date.getFullYear()+'-';
	str+=(date.getMonth()+1)>=10?date.getMonth()+1:"0"+(date.getMonth()+1);
	str+="-";
	str+=date.getDate()>=10?date.getDate():"0"+date.getDate();
	return str;
}
function cutMenu()
{
	//alert(topNum);
	var menu=document.getElementById("Col_menu");

	if(menu.style.display=="")
	{
		menu.style.display="none";
		$('#dataGrid').datagrid('resize',{width:'96%',height:700});
	}
	else
	{
		menu.style.display="";
		$('#dataGrid').datagrid('resize',{width:'96%',height:500});
	}
}

function myformatter(date){
	var y = date.getFullYear();
	var m = date.getMonth()+1;
	var d = date.getDate();
	return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
}
function myparser(s){
	if (!s) return new Date();
	var ss = (s.split('-'));
	var y = parseInt(ss[0],10);
	var m = parseInt(ss[1],10);
	var d = parseInt(ss[2],10);
	if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
		return new Date(y,m-1,d);
	} else {
		return new Date();
	}
}

$(function(){
   var currDate=new Date();
	var str=FormatDate(currDate);
	//alert(currDate);
	//$('#J_tranDate').datetimespinner('setValue', str);
});
function FormatDate(date){
	var str=date.getFullYear()+'-';
	str+=(date.getMonth()+1)>=10?date.getMonth()+1:"0"+(date.getMonth()+1);
	str+="-";
	str+=date.getDate()>=10?date.getDate():"0"+date.getDate();
	return str;
}
	function formatter1(date){
		if (!date){return '';}
		return $.fn.datebox.defaults.formatter.call(this, date);
	}
	function parser1(s){
		if (!s){return null;}
		return $.fn.datebox.defaults.parser.call(this, s);
	}
	function formatter2(date){
		if (!date){return '';}
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		return y + '-' + (m<10?('0'+m):m);
	}
	function parser2(s){
		if (!s){return null;}
		var ss = s.split('-');
		var y = parseInt(ss[0],10);
		var m = parseInt(ss[1],10);
		if (!isNaN(y) && !isNaN(m)){
			return new Date(y,m-1,1);
		} else {
			return new Date();
		}
	}

	
	function formatter3(date){
		if (!date){return '';}
		var y = date.getFullYear();
		var m = date.getMonth() + 1;
		return y + '-' + (m<10?('0'+m):m);
	}
	function parser3(s){
		if (!s){return null;}
		var ss = s.split('-');
		var y = parseInt(ss[0],10);
		var m = parseInt(ss[1],10);
		if (!isNaN(y) && !isNaN(m)){
			return new Date(y,m-1,1);
		} else {
			return new Date();
		}
	}

</script>

</head>
<body>
	
	<div class="nps_top">
		<div class="nps_top_left">
			<em><font class="logo_title1"><%=sysName %></font> <font
				class="logo_title2">统计图表</font></em>
		</div>
		<div class="nps_top_right">
			交易日期：<span id="t001">2014</span> 年 <span  id="t002">2</span> 月 
			<span  id="t003">26</span> 日 <span id="t004">14</span> 时 <span  id="t005">35</span> 分
			<span  id="t006">35</span> 秒
		</div>
	</div>
	<div class="nps_content">
		
		<table class="nps_map">
			<tr>
			    <td><a href="javascript:cutMenu()">统计列表</a></td>
			</tr>
		</table>
		<table class="table_list" id="Col_menu">
			<tr>
      			<th>统计维度\统计指标</th>
      			<th>业务量</th>
      			<th>金额</th>
      			<th>峰值时间点</th>
      			<th>峰值TPS</th>
      			<th>平均响应时间</th>
      			<th>超时笔数</th>
      			<th>业务成功率</th>
      			<th>交易成功率</th>
    		</tr>
    		<tr>
      			<td>分钟</td>
      			<td id="minCount">0</td>
      			<td id="minAmount">0.00</td>
			    <td id="minTime">00:00</td>
			    <td id="minValue">0</td>
			    <td id="minResp">0.00</td>
			    <td id="minOut">0</td>
			    <td id="minOper">0.00%</td>
			    <td id="minTran">0.00%</td>
    		</tr>
	 		<tr>
      			<td>日</td>
      			<td id="dayCount">0</td>
      			<td id="dayAmount">0.00</td>
      			<td id="dayTime">00:00</td>
      			<td id="dayValue">0</td>
      			<td id="dayResp">0.00</td>
      			<td id="dayOut">0</td>
      			<td id="dayOper">0.00%</td>
      			<td id="dayTran">0.00%</td>
    		</tr>
			 <tr>
		      <td>月</td>
		      <td id="monthCount">0</td>
		      <td id="monthAmount">0.00</td>
		      <td id="monthTime">00:00</td>
		      <td id="monthValue">0</td>
		      <td id="monthResp">0.00</td>
		      <td id="monthOut">0</td>
		      <td id="monthOper">0.00%</td>
		      <td id="monthTran">0.00%</td>
		    </tr>
			 <tr>
		      <td>年</td>
		      <td id="yearCount">0</td>
		      <td id="yearAmount">0.00</td>
		      <td id="yearTime">00:00</td>
		      <td id="yearValue">0</td>
		      <td id="yearResp">0.00</td>
		      <td id="yearOut">0</td>
		      <td id="yearOper">0.00%</td>
		      <td id="yearTran">0.00%</td>
		    </tr>
		</table>
		<div class="nps_map">
  			<div class="easyui-tabs" style="width:100%;height:500px">
				<div title="分钟统计图" style="padding:20px">
					<table>
        			<th style="width:80px;text-align:right;">统计指标:</th>
        			<td>
        						<select id="J_MinIndex" name="index"  class="easyui-combobox" style="width:100px;"	panelHeight="150px" onchange="indexchange(this.options[this.options.selectedIndex].value)">
											<option value="0">业务量</option>
											<option value="1">总金额</option>
											<option value="2">TPS值</option>
											<option value="3">平均响应时间</option>
											<option value="4">超时笔数</option>
											<option value="5">业务成功率</option>
											<option value="6">交易成功率</option>
								</select>
        			</td>
        			
        			<th style="width:80px;text-align:right;" >日期:</th>
        			<td>
        				<input name="minBgDate" type="text" id="J_MinBgDate" class="easyui-datebox"/>
        		    </td>
        		
        		  <th style="width:80px;text-align:right;">开始时间:</th>
        		        	<td >
        		        		<input name="minBgTime" type="text" id="J_MinBgTime" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:false"  editable="true" />
        					</td>
        		<th style="width:80px;text-align:right;">结束时间:</th>
        					<td>
								<input name="minEdTime" type="text" id="J_MinEdTime" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:01',showSeconds:false" editable="true" />
        					</td>
        					<th style="width:20px"></th>
        					
        					<th><a href="#" class="form_button3" iconCls="icon-search" id="J_MinSearch" >查询</a>
							</th>
        			
						</table>
						<div id="detail0" style="margin:50px 50px 50px 50px"></div>
		</div>
		<div title="日统计图" style="padding:20px">
			<table>
        			<th style="width:80px;text-align:right;">统计指标:</th>
        			
        			<td>
        						<select id="J_DayIndex" name="dayIndex"  class="easyui-combobox" style="width:100px;"	panelHeight="150px" onchange="indexchange(this.options[this.options.selectedIndex].value)">
											<option value="0">业务量</option>
											<option value="1">总金额</option>
											<option value="2">TPS值</option>
											<option value="3">平均响应时间</option>
											<option value="4">超时笔数</option>
											<option value="5">业务成功率</option>
											<option value="6">交易成功率</option>
									</select>
        			</td>
        			
        			<th style="width:80px;text-align:right;" >开始日期:</th>
        			<td>
        				<input name="dayBgDate" type="text" id="J_DayBgDate" class="easyui-datebox"/>
        		    </td>
        		    <th style="width:80px;text-align:right;" >结束日期:</th>
        			<td>
        				<input name="dayEdDate" type="text" id="J_DayEdDate" class="easyui-datebox"/>
        		    </td>
        		    <th style="width:20px"></th>
        					<th><a href="#" class="form_button3" iconCls="icon-search" id="J_DaySearch" >查询</a>
							</th>
				</table>
			<div id="detail1" style="margin:50px"></div>
		</div>
		<div title="月统计图"  style="padding:20px">
			 		<table>
        			<th style="width:80px;text-align:right;">统计指标:</th>
        			
        			<td>
        						<select id="J_MonIndex" name="index"  class="easyui-combobox" style="width:100px;"	panelHeight="150px" onchange="indexchange(this.options[this.options.selectedIndex].value)">
											<option value="0">业务量</option>
											<option value="1">总金额</option>
											<option value="2">TPS值</option>
											<option value="3">平均响应时间</option>
											<option value="4">超时笔数</option>
											<option value="5">业务成功率</option>
											<option value="6">交易成功率</option>
									</select>
        			</td>
        			
        			<th style="width:80px;text-align:right;">开始日期:</th>
        			<td>
        		        <input id="J_MonBgDate"  style="width:180px"/>
						<script>
						    $(function () {
						        $('#J_MonBgDate').datebox({
						            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
						                span.trigger('click'); //触发click事件弹出月份层
						                if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
						                    tds = p.find('div.calendar-menu-month-inner td');
						                    tds.click(function (e) {
						                        e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
						                        var year = /\d{4}/.exec(span.html())[0]//得到年份
						                        , month = parseInt($(this).attr('abbr'), 10) + 1; //月份
						                        $('#J_MonBgDate').datebox('hidePanel')//隐藏日期对象
						                        .datebox('setValue', year + '-' + month ); //设置日期的值
						                    });
						                }, 0)
						            },
						            parser: function (s) {//配置parser，返回选择的日期
						                if (!s) return new Date();
						                var arr = s.split('-');
						                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
						            },
						            formatter: function (d) { //配置formatter，只返回年月
						            	var m = d.getMonth();
						                var y = d.getFullYear();
						                if(m == 0){
						                	m = '12';
						                	y = y-1;
						                }
						                return y + '-' + (m<10?('0'+m):m); 
						            }
						        });
						        var p = $('#J_MonBgDate').datebox('panel'), //日期选择对象
						            tds = false, //日期选择对象中月份
						            span = p.find('span.calendar-text'); //显示月份层的触发控件
						    });
						</script>
        		  	</td>
        		  	<th style="width:80px;text-align:right;">结束日期:</th>
        		  	<td>
        		  		<input id="J_MonEdDate"  style="width:180px"/>
						<script>
						    $(function () {
						        $('#J_MonEdDate').datebox({
						            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
						                span.trigger('click'); //触发click事件弹出月份层
						                if (!tds) setTimeout(function () {//延时触发获取月份对象，因为上面的事件触发和对象生成有时间间隔
						                    tds = p.find('div.calendar-menu-month-inner td');
						                    tds.click(function (e) {
						                        e.stopPropagation(); //禁止冒泡执行easyui给月份绑定的事件
						                        var year = /\d{4}/.exec(span.html())[0]//得到年份
						                        , month = parseInt($(this).attr('abbr'), 10) +1; //月份
						                        $('#J_MonEdDate').datebox('hidePanel')//隐藏日期对象
						                        .datebox('setValue', year + '-' + month); //设置日期的值
						                    });
						                }, 0)
						            },
						            parser: function (s) {//配置parser，返回选择的日期
						                if (!s) return new Date();
						                var arr = s.split('-');
						                //alert(arr);
						                return new Date(parseInt(arr[0], 10), parseInt(arr[1], 10) - 1, 1);
						            },
						            formatter: function (d) { //配置formatter，只返回年月
						            	var m = d.getMonth();
						                var y = d.getFullYear();
						                if(m == 0){
						                	m = '12';
						                	y = y-1;
						                }
						                return y + '-' + (m<10?('0'+m):m); 
						            }
						        });
						        var p = $('#J_MonEdDate').datebox('panel'), //日期选择对象
						            tds = false, //日期选择对象中月份
						            span = p.find('span.calendar-text'); //显示月份层的触发控件
						    });
						</script>
        		  	</td>
        		
        		
        					<th style="width:20px"></th>
        					
        					<th><a href="#" class="form_button3" iconCls="icon-search" id="J_MonSearch" >查询</a>
							</th>
						</table>
						<div id="detail2" style="margin:50px"></div>
		</div>
		<div title="年统计图" style="padding:20px">
			<table>
        			<th style="width:80px;text-align:right;">统计指标:</th>
        			
        			<td>
        						<select id="J_YearIndex" name="index"  class="easyui-combobox" style="width:100px;"	panelHeight="150px" onchange="indexchange(this.options[this.options.selectedIndex].value)">
											<option value="0">业务量</option>
											<option value="1">总金额</option>
											<option value="2">TPS值</option>
											<option value="3">平均响应时间</option>
											<option value="4">超时笔数</option>
											<option value="5">业务成功率</option>
											<option value="6">交易成功率</option>
									</select>
        			</td>
        		    <th style="width:20px"></th>
        				<th><a href="#" class="form_button3" iconCls="icon-search" id="J_YearSearch" >查询</a>
					</th>
				</table>
				<div id="detail3" style="margin:50px"></div>
	</div>

	<!-- 初始化组件 -->
	<script type="text/javascript">
		var timeData1=60000;//曲线图和柱状图的轮询时间  
		var timeData2=10000;//实时监控的的轮询时间003   
		$(function(){
			//RefreshMON026();
			RefreshMON030();
		});
		
		
		/**function:  RefreshData()
	    description:筛选
	    author:闫洁
	    Date:2014年6月12日 
	 	**/
	 	function RefreshData(){
			//str="{\"TranDate\"\:\""+jQueryDate+"\",\"Flag\":\""+jFlag+"\",\"Cot_CotNo\":\""+jCotNo+"\",\"Cot_BrchNo\":\""+jBrchNo+"\"}";
			str="{\"TranDate\"\:\""+jQueryDate+"\",\"Flag\":\""+jFlag+"\",\"Cot_BrchNo\":\""+jBrchNo+"\"}";
			dataGridTable.datagrid('load',{
				MONSTranNO:'INQ023',
	    		jsonStr:str
	    	});
		}
		
		function RefreshMON030(){
			var param = "";
			param = "MONSTranNO=MON030&jsonStr={\"AvgTm_ID\":\""+'${param.sysID}'+"\"}";
			$.ajax({ 
				type: "POST",
				url:'<%=basePath%>/MONSTran.action',
				data : param,
				dataType : "json",
				success : function(data) {
					if("4"==data.TotalRecords){
						var dataObj = data.Statis;//这个.后面的名字要和json返回数据匹配
						//document.getElementById("003").innerHTML=dataObj.Num;
						$("#minCount").text(dataObj[0].Count);
						$("#minAmount").text(dataObj[0].Amount);
						$("#minResp").text(dataObj[0].RespTime+" s");
						if(dataObj[0].Time==0){
							$("#minTime").text(dataObj[0].Time);
						}else{
							$("#minTime").text(dataObj[0].Time.substring(0,2)+":"+dataObj[0].Time.substring(2,4)+":"+dataObj[0].Time.substring(4,6));
						}
						$("#minValue").text(dataObj[0].TpsValue);
						$("#minOut").text(dataObj[0].TimeOut);
						$("#minOper").text(dataObj[0].OperRate);
						$("#minTran").text(dataObj[0].TranRate);
						$("#dayCount").text(dataObj[1].Count);
						$("#dayAmount").text(dataObj[1].Amount);
						$("#dayResp").text(dataObj[1].RespTime+" s");
						if(dataObj[1].Time==0){
							$("#dayTime").text(dataObj[1].Time);
						}else{
							$("#dayTime").text(dataObj[1].Time.substring(0,2)+":"+dataObj[1].Time.substring(2,4));
						}
						$("#dayValue").text(dataObj[1].TpsValue);
						$("#dayOut").text(dataObj[1].TimeOut);
						$("#dayOper").text(dataObj[1].OperRate);
						$("#dayTran").text(dataObj[1].TranRate);
						$("#monthCount").text(dataObj[2].Count);
						$("#monthAmount").text(dataObj[2].Amount);
						$("#monthResp").text(dataObj[2].RespTime+" s");
						$("#monthTime").text(dataObj[2].Time+"日");
						$("#monthValue").text(dataObj[2].TpsValue);
						$("#monthOut").text(dataObj[2].TimeOut);
						$("#monthOper").text(dataObj[2].OperRate);
						$("#monthTran").text(dataObj[2].TranRate);
						$("#yearCount").text(dataObj[3].Count);
						$("#yearAmount").text(dataObj[3].Amount);
						$("#yearResp").text(dataObj[3].RespTime+" s");
						$("#yearTime").text(dataObj[3].Time+"月");
						$("#yearValue").text(dataObj[3].TpsValue);
						$("#yearOut").text(dataObj[3].TimeOut);
						$("#yearOper").text(dataObj[3].OperRate);
						$("#yearTran").text(dataObj[3].TranRate);
						//alert(dataObj[3].Count+" "+dataObj[3].Amount +" "+ dataObj[3].TimeOut);
						//alert(dataObj[3].RespTime +" "+ dataObj[3].TranRate+" "+dataObj[3].OperRate);
						//alert(dataObj[3].Time+ " "+ dataObj[3].TpsValue);
					}
				  }
				});
			setTimeout(RefreshMON030,60000);
		}
		/* 筛选数据 */
		
	</script>
</body>
</html>
