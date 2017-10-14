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
<title><%=sysName %>实时交易统计</title>
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
<script src="../../js/mons/jquery.js" type="text/javascript"></script>
<script src="../../js/mons/jquery.table2.js" type="text/javascript"></script>
<script src="../../js/mons/grid.js" type="text/javascript"></script>
<script src="../../js/mons/mons.js" type="text/javascript"></script>
<jsp:include page="inc.jsp"></jsp:include>

</head>

<body>
<div class="nps_top">
	<div class="nps_top_left"><em><font class="logo_title1"><%=sysName %></font> <font class="logo_title2">实时交易统计</font></em></div>
	<div class="nps_top_right">交易日期：<span id="t001">2013</span> 年 <span  id="t002">2</span> 月 
			<span  id="t003">26</span> 日 <span id="t004">14</span> 时 <span  id="t005">35</span> 分
			<span  id="t006">35</span> 秒</div>
</div>
<div class="nps_content">
	<div class="nps_num">
		<ul>
			<li class="nps_num3">成功率 <span id="001"></span></li>
			<li class="nps_num2">平均响应时间 <span id="002"></span></li>
			<li class="nps_num1">交易笔数 <span id="003"></span></li>
		</ul>
	</div>
	<table class="nps_map">
      <tr>
			<td><a href="javascript:cutMenu()"><%=sysName %>交易曲线图</a></td> 
        	<td><a href="javascript:cutMenu()"><%=sysName %>交易笔数</a></td>
	  </tr>
      <tr id="Col_menu">
       
        <td>
				<div id="detail1"></div>
		</td>
	
		<td>
				<div id="detail2"></div>
		</td>
      </tr>
    </table>
    	
<!-----------------------------表格----------------------------->
		<div style="width: 96%; margin: 10px auto; padding-right: 1px">
			<div id="dataGrid" style="height: 500px" class="easyui-datagrid" title="交易统计"></div>
		<!--   ---   -->
		<div id="tb" style="padding: 5px; height: auto; border: none; background: url(../../images/50.png);">

			<table class="table_form3">
				<!-- tr:代表HTML表格中的一行 -->
				<!-- th:代表HTML表格中的表头 -->
				<!-- td: 代表HTML表格中的一个单元格 -->
				<!--  -->
				<tr>
					<th>交易日期：</th>
					<td><input name="tranDate" type="text" id="J_tranDate" class="easyui-datebox"/>
					</td>
					
					<th>交易时间段：</th>
					<td><input name="TimeBg" type="text" id="J_timeBg" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:true" /> -
						<input name="TimeEd" type="text" id="J_timeEd" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:true" /> 
					</td>
				    <th></th>
					</tr>
					<tr>
					<th>渠道代码：</th>
					<td><select id="J_channelID" name="channelID">
							<option value="">全部</option>
					</select>
					</td>
					
					<th>业务类型：</th>
					<td><select id="J_busiType" name="busiType">
							<option value="">全部</option>
					</select></td>
					
					<th><a href="#" class="form_button3" iconCls="icon-search"
						id="J_submit_search">查询</a></th>

				</tr>
			</table>
	</div>
</div>
<script type="text/javascript">
/*自定义设置 */
var timeData1=60000;//曲线图和柱状图的轮询时间

var jFlag=jChannelId=jBusiType=jTranDate=jTimeBg=jTimeEd="";
var J_channelID=$('#J_channelID'); //渠道代码
var J_busiType=$('#J_busiType'); //业务类型
var J_tranDate=$('#J_tranDate'); //交易日期
var J_timeBg=$('#J_timeBg'); //交易起始时间
var J_timeEd=$('#J_timeEd'); //交易结束时间

var J_submit_search = $('#J_submit_search');

$(function(){
	getDate();
	dataTimeSpinnerInit();
	
	RefreshMON017();
	
    initChannelID();
	initbusiType();
	
	initFusionCharts1();
    initFusionCharts2();
    
    dataGridInit();
    
    J_submit_search.click(searchFun);
});
function searchFun() { 
    
   	jChannelId=J_channelID.val();
   	jBusiType=J_busiType.val();
   	jTranDate=J_tranDate.datebox("getValue");
   	jTranDate=jTranDate.replace("-","").replace("-","");
   	jTimeBg=J_timeBg.timespinner('getValue');  
   	jTimeBg=jTimeBg.replace(":","").replace(":","");
   	jTimeEd=J_timeEd.timespinner('getValue'); 
   	jTimeEd=jTimeEd.replace(":","").replace(":",""); 
   	jFlag=getFlag();
   	
   	RefreshData();
}

function getFlag(){
	if(jChannelId==""&&jBusiType==""){
   		return 0;
   	}else if(jChannelId!=""&&jBusiType!=""){
   		return 3;
   	}else if(jChannelId!=""&&jBusiType==""){
   		return 1;
   	}else if(jBusiType!=""&&jChannelId==""){
   		return 2;
   	}
}

function dataTimeSpinnerInit(){
	$('#J_timeBg').timespinner('setValue', '00:00:00');  
	$('#J_timeEd').timespinner('setValue', '23:59:59');
	var currDate=new Date();
	var str=FormatDate(currDate);
	$('#J_tranDate').datebox('setValue', str);
}

function FormatDate(date){
	var str=date.getFullYear()+'-';
	str+=(date.getMonth()+1)>=10?date.getMonth()+1:"0"+(date.getMonth()+1);
	str+="-";
	str+=date.getDate()>=10?date.getDate():"0"+date.getDate();
	return str;
}

function RefreshMON017(){
	var param = "";
	param = "MONSTranNO=MON017&jsonStr={\"AvgTm_ID\":\""+'${param.sysID}'+"\"}";
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data : param,
		dataType : "json",
		success : function(data) {
			if("0000"==data.RetCode){
				var dataObj = data.Sumary;//这个.后面的名字要和json返回数据匹配
				document.getElementById("001").innerHTML=dataObj.Percent;
				document.getElementById("002").innerHTML=dataObj.Avgtm;
				document.getElementById("003").innerHTML=dataObj.Num;
			}
		  }
		});
	setTimeout(RefreshMON017,10000);
}

function cutMenu()
{
	var menu=document.getElementById("Col_menu");

	if(menu.style.display=="")
	{
		menu.style.display="none";
	}
	else
	{
		menu.style.display="";
	}
}

/* 初始化交易曲线图*/
function initFusionCharts1(){
	var str="{\"AvgTm_ID\"\:\""+'${param.sysID}'+"\",\"Flag\":\""+
	"0"+"\",\"Para1\":\""+
	""+"\",\"Para2\":\""+""+"\"}";
	var param = "MONSTranNO=MON038&jsonStr="+str;
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data:param,
		dataType:"json",
		success: function(data){
			var dataObj=data.Rate;
			var begin="<OBJECT width='620' height='225' id='Column3D'>"
				+"<embed src='FusionChartsSWF/MSLine.swf' flashVars=\"&dataXML="
					+"<graph caption='' xAxisName='小时' rotateNames='1' yAxisName='成功率' numberSuffix='%25' outCnvBaseFontColor='000000'"
							+"bgColor='035785,0986c4' bgAlpha='100' showNames='1' decimalPrecision='2' formatNumberScale='0' "
							+" drawAnchors ='1' lineThickness='2' showLimots='2' labelDisplay='Rotate' slantLabels='1'>";
			var end="</graph>\" quality='high' width='600'  height='258' name='Column3D' type='application/x-shockwave-flash'/></OBJECT>";
			var coloum="<categories>";
            var isValue1="<dataset seriesName='交易成功率' color='FF6666'>";
            var isValue2="<dataset seriesName='业务成功率' color='0099FF'>";
			var len=dataObj.length;
			if(len>0){
				for(var i=len-1;i>=0;i--){
				  coloum+="<category name='"+dataObj[i].Time +"'/>";
				  isValue1+="<set value='"+dataObj[i].Tran +"'/>";
				  isValue2+="<set value='"+dataObj[i].Oper +"'/>";
			  }
			  coloum+="</categories>";
			  isValue1+="</dataset>";
			  isValue2+="</dataset>";
			}
			$('#detail1').html(begin+coloum+isValue1+isValue2+end);
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.Status);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
		setTimeout(initFusionCharts1,timeData1);
}

/* 初始化交易曲线图*/
function initFusionCharts2(){
	var str="{\"AvgTm_ID\"\:\""+'${param.sysID}'+"\",\"Flag\":\""+
	"0"+"\",\"Para1\":\""+
	""+"\",\"Para2\":\""+""+"\"}";
	var param = "MONSTranNO=MON029&jsonStr="+str;
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/MONSTran.action',
		data:param,
		dataType:"json",
		success: function(data){
			var dataObj=data.Num;
			var ColorArr =['CCFF00','FF0000','FF6600','FFFF00','00FF00','00FFFF','FF33FF','0099FF','FF6666','FF0099','6666FF','66FF66',
			                'FFFF66','00CC99','CC99CC','00CC00','CC33CC','FF3366','FFCC00','CCFF00','FF0000','FF6600','FFFF00','00FF00',
			                '00FFFF','FF33FF','0099FF','FF6666','FF0099','6666FF','66FF66','FFFF66','00CC99','CC99CC','00CC00','CC33CC',
			                'FF3366','FFCC00','CCFF00','FF0000','FF6600','FFFF00','00FF00','00FFFF','FF33FF','0099FF','FF6666','FF0099',
			                '6666FF','66FF66'];
			var begin="<OBJECT width='670' height='225' id='Column3D'>"
                +"<embed src='FusionChartsSWF/Column3D.swf' flashVars=\"&dataXML=<graph caption='交易量/小时' labelDisplay='Rotate' slantLabels='1' showValues='1' "
                +"xAxisName='小时' outCnvBaseFontColor='000000'  bgColor='0986c4,035785' yAxisName='交易量' showNames='1' rotateNames='1' decimalPrecision='4' formatNumberScale='0'>";
			var end="</graph>\" quality='high' width='654'  height='258' name='Column3D' type='application/x-shockwave-flash'/></OBJECT>";
			var coloum="";
			var len=dataObj.length;
			if(len>0){
			  for(var i=0;i<len;i++){
				  coloum+="<set name='"+dataObj[i].Time+"'  value='"+dataObj[i].Count+"' color='"+ColorArr[i]+"'/>";
			  }
			}
			$('#detail2').html(begin+coloum+end);
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.Status);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
		setTimeout(initFusionCharts2,timeData1);
}

function RefreshData(){
	var str="{\"AvgTm_ID\":\""+'${param.sysID}'+"\",\"Flag\":\""+
	jFlag+"\",\"Channel\":\""+
	jChannelId+"\",\"Busitype\":\""+
	jBusiType+"\",\"TranDate\":\""+
	jTranDate+"\",\"TimeBg\":\""+
	jTimeBg+"\",\"TimeEd\":\""+jTimeEd+"\"}";
	
	dataGridTable.datagrid('load',{
		MONSTranNO:'INQ022',
		jsonStr:str,
	});
}
/* 初始化渠道代码下拉列表*/
function initChannelID(){
	var channel=document.getElementById("J_channelID");
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/ChannelInfoInit.action',
		data:"selectSysID="+'${param.sysID}',
		dataType:"json",
		success: function(data){
			//console.info(data);
			var dataObj=data.obj;
			var len=dataObj.length;
			if(len>0){
			  for(var i=0;i<len;i++){
				  channel.add(new Option(dataObj[i].channelDesc, dataObj[i].channelId));
			  }
			}
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.Status);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
}
/* 初始化业务类型下拉列表*/
function initbusiType(){
	var busiType=document.getElementById("J_busiType");
	$.ajax({ 
		type: "POST",
		url:'<%=basePath%>/BusiInfoInit.action', 
		data:"selectSysID="+'${param.sysID}',
		dataType:"json",
		success: function(data){

			var dataObj=data.obj;
			var len=dataObj.length;
			if(len>0){
			  for(var i=0;i<len;i++){
				  busiType.add(new Option(dataObj[i].busiDesc, dataObj[i].busiType));
			  }
			}
		},
		error: function(XMLHttpRequest,textStatus,errorThown){
			alert(XMLHttpRequest.responseText);
			alert(XMLHttpRequest.readyState);
			alert(XMLHttpRequest.textStatus);
		}
	});
}

function dataGridInit(){ 
	dataGridTable=$('#dataGrid').datagrid({//实例化table表单
		url:'<%=basePath%>/MONSTran.action',
		pagination: true,//设置true将在数据表格底部显示分页工具栏。
		collapsible:true,  //折叠按钮
		rownumbers: true,//设置为true将显示行数。
		pageSize:20,
		pageList: [20,40,60],
		//fitColumns:true,
		striped:true,//设置为true将交替显示行背景
		iconCls:'icon-ok',
		toolbar:'#tb',
		sortName:'StartTime',
		sortOrder:'asc',
		loadMsg:'正在装载,请稍候...',
		singleSelect:true,
		//method:'post',
		rowStyler: function(index,row){
			if (row.OperMark==1&&row.TranMark==1){
				return 'background-color:#ff0000;color:black;';
			}
			if (row.OperMark==1&&row.TranMark==0){
				return 'background-color:yellow;color:black;';
			}
			if(index%2==0){
				return 'background-color:#d9d9c2;color:black;';
			}else{
				return 'background-color:#FFFFFF;color:black;';
			}
		},
		loadFilter: function(data){
			if(data==null)
				return null;
			//$('#dataGrid').datagrid('loadData',{total:0,rows:[]});
			var value={
					total:data.TotalRecords,
					rows:data.Statis,
			};
			return value;
		},
		columns:[[ //数据表格列配置对象
		    {field:'Time',title:'时间',width:200,sortable: true,
		    	formatter:function(value,row,index){
					value = value.substring(0,2)+":"+value.substring(2,4);
					return value;
				}
		    },
	        {field:'Count',title:'交易总笔数',width:200,sortable: true},
	        {field:'Amount',title:'交易总金额',width:200,sortable: true},
	        {field:'TimeOut',title:'超时笔数',width:200,sortable: true},
	        {field:'RespTime',title:'平均响应时间',width:200,sortable: true},
	        {field:'TranRate',title:'交易成功率',width:200,sortable: true},
	        {field:'OperRate',title:'业务成功率',width:200,sortable: true}
		    ]],
	});
}
</script>
</body>
</html>
