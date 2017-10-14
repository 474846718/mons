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
<title><%=sysName %>历史交易查询</title>
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
<script src="../../js/mons/jquery.js" type="text/javascript"></script>
<script src="../../js/mons/jquery.table2.js" type="text/javascript"></script>
<script src="../../js/mons/grid.js" type="text/javascript"></script>
<script src="../../js/mons/mons.js" type="text/javascript"></script>
<jsp:include page="inc.jsp"></jsp:include>
</head>

<body>
<div class="nps_top">
	<div class="nps_top_left"><em><font class="logo_title1"><%=sysName %></font> <font class="logo_title2">历史交易查询</font></em></div>
	<div class="nps_top_right">交易日期：<span id="t001"></span> 年 <span  id="t002"></span> 月 <span  id="t003"></span> 日 
		<span id="t004"></span> 时 <span  id="t005"></span> 分<span  id="t006"></span> 秒</div>
</div>
<div class="nps_content">
	<div class="nps_num">
		<ul>
			<li class="nps_num3">成功率 <span  id="001">0%</span></li>
			<li class="nps_num2">平均响应时间 <span id="002">0.00s</span></li>
			<li class="nps_num1">交易笔数 <span  id="003">0</span></li>
		</ul>
	</div>
	
	
	<!-----------------------------表格----------------------------->
		<div style="width: 96%; margin: 10px auto; padding-right: 1px">
			<div id="dataGrid" style="height: 670px" class="easyui-datagrid" title="查询结果"></div>
		
		<!--   ---   -->
		<div id="tb"
			style="padding: 5px; height: auto; border: none; background: url(../../images/50.png);">
			<table class="table_form3">
		      <tr>
					<th>交易状态：</th>
					<td><select id="J_Flag" name="flag" class="">
							<option value="0">全部交易</option>
							<option value="1">成功交易</option>
							<option value="2">业务失败</option>
							<option value="3">交易失败</option>
					</select>
					</td>
					
					<th>渠道代码：</th>
					<td><select id="J_channelID" name="channelID">
							<option value="">全部</option>
					</select>
					</td>
					
					<th>业务类型：</th>
					<td><select id="J_busiType" name="busiType">
							<option value="">全部</option>
					</select></td>
			  </tr>
			  <tr>
					<th>交易时间段：</th>
					<td><input name="TimeBg" type="text" id="J_timeBg" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:true" /> -
						<input name="TimeEd" type="text" id="J_timeEd" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:true" /> </td>
					
					<th>流水号：</th>
					<td><input name="serialNum" type="text" id="J_serialNum" />
					</td>
					
					<th>交易码：</th>
					<td><input name="tranCode" type="text" id="J_tranCode" />
					</td>
			   </tr>
					
			   <tr>
					<th>交易日期：</th>
					<td><input name="tranDate" type="text" id="J_tranDate" class="easyui-datebox"/>
					</td>
					<th></th>
					<td><a href="#" class="form_button3" iconCls="icon-search"
						id="J_submit_search">查询</a></td>
					<td></td>
					<td></td>
				</tr>
		    </table>
    	</div>
    
</div>


<!-- 初始化组件 -->
<script type="text/javascript">
	/*table表单 */
	var dataGridTable;
	var jFlag=jChannelId=jBusiType=jTranCode=jTranDate=jTimeBg=jTimeEd="";
	var jSerialNum="";
	
	/*查询表单*/
	var J_Flag=$('#J_Flag');//交易状态
	var J_channelID=$('#J_channelID'); //渠道代码
	var J_busiType=$('#J_busiType'); //业务类型
	var J_serialNum=$('#J_serialNum');//流水号
	var J_tranCode=$('#J_tranCode'); //交易码
	var J_tranDate=$('#J_tranDate'); //交易日期
	var J_timeBg=$('#J_timeBg'); //交易起始时间
	var J_timeEd=$('#J_timeEd'); //交易结束时间
	
	var J_submit_search = $('#J_submit_search');
	
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
	
	$(function(){
		getDate();
		
		dataTimeSpinnerInit();
		
		initChannelID();
		initbusiType();
		RefreshMON017();
	        
	    dataGridInit();
	    
		J_submit_search.click(searchFun);
	});
	
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
	
	function RefreshData(){
		str="{\"AvgTm_ID\":\""+'${param.sysID}'+"\",\"Flag\":\""+
		jFlag+"\",\"Channel\":\""+
		jChannelId+"\",\"Busitype\":\""+
		jBusiType+"\",\"TranCode\":\""+
		jTranCode+"\",\"SerialNum\":\""+
		jSerialNum+"\",\"TranDate\":\""+
		jTranDate+"\",\"TimeBg\":\""+
		jTimeBg+"\",\"TimeEd\":\""+jTimeEd+"\"}";
		dataGridTable.datagrid('load',{
			MONSTranNO:'INQ020',
    		jsonStr:str,
    	});
	}
	
	function dataGridInit(){ 
		dataGridTable=$('#dataGrid').datagrid({//实例化table表单
			url:'<%=basePath%>/MONSTran.action',
			pagination: true,//设置true将在数据表格底部显示分页工具栏。
			collapsible:true,  //折叠按钮
			rownumbers: true,//设置为true将显示行数。
			pageSize:10,
			pageList: [20,40,60],
			//fitColumns:true,
			striped:true,//设置为true将交替显示行背景
			iconCls:'icon-ok',
			toolbar:'#tb',
			sortName:'StartTime',
			sortOrder:'asc',
			singleSelect:true,
			method:'post',
			rowStyler: function(index,row){
				if (row.OperMark==1&&row.TranMark==1){
					return 'background-color:#ff0000;color:black;';
				}
				if (row.OperMark==1&&row.TranMark==0){
					return 'background-color:yellow;color:black;';
				}
				if(row.AcctKind == 1){
					return 'background-color:pink;color:black;';
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
						rows:data.Seq,
				};
				return value;
			},
			columns:[[ //数据表格列配置对象
			           {field:'Demo4',title:'', width:20,sortable: true},
						{field:'MonType',title:'系统编号',width:70},
						{field:'BranchID',title:'机构编码',width:70},
						{field:'TranCycle',title:'业务类型',width:100},
						{field:'ChannelID',title:'渠道',width:70},
				<!--		{field:'Channel',title:'渠道名',width:100},-->
						{field:'Trans',title:'交易码',width:100},
						{field:'Demo3',title:'交易描述',width:200},
						{field:'ReturnCode',title:'错误码',width:70},
						{field:'ReturnMsg',title:'错误描述',width:150},
						{field:'EquipSeq',title:'柜员号',width:70},
						{field:'GolSeq',title:'全局流水号',width:180},	
						{field:'RespTime',title:'交易耗时',width:50},
						{field:'NodeNo',title:'节点号',width:70},
						{field:'HostCode',title:'主机授权码',width:120},
						{field:'ActCode',title:'客户号',width:100},	
						{field:'StartTime',title:'开始时间',width:100},
				        {field:'EndTime',title:'结束时间',width:100},
						{field:'PlatSeq',title:'平台流水',width:250},
						{field:'Account1',title:'卡号',width:120},
						{field:'Amount',title:'交易金额',width:100},	
						{field:'TranDate',title:'交易日期',width:70},  
						{field:'CompName',title:'插件名',width:85},		        
				        {field:'HostSeq',title:'主机交易序号',width:75},	        		       
				        {field:'EquipID',title:'凭证',width:100},
				        {field:'Account2',title:'账号2',width:80},
				        {field:'Amount1',title:'交易金额1',width:100},
		                {field:'Fee',title:'手续费',width:75},
		                {field:'MerchantID',title:'商户号',width:65},
		                {field:'TimeStamp',title:'物理时间戳',width:110},
				        {field:'Demo1',title:'备用1',width:65},
				        {field:'Demo2',title:'备用2',width:65},              
				        {field:'AcctType',title:'',width:70,hidden:true},
				        {field:'AcctKind',title:'',width:70,hidden:true},    
				        {field:'OperMark',title:'业务标识',width:70,hidden:true},
				        {field:'TranMark',title:'交易标识',width:70,hidden:true}
					    ]]
		});
	}
	function searchFun() { 
		    
		    jFlag=J_Flag.val();
		   	jChannelId=J_channelID.val();
		   	jBusiType=J_busiType.val();
		   	jTranCode=J_tranCode.val();
		   	jSerialNum=J_serialNum.val();
		   	jTranDate=J_tranDate.datebox("getValue");
		   	jTranDate=jTranDate.replace("-","").replace("-","");
		   	jTimeBg=J_timeBg.timespinner('getValue');  
		   	jTimeBg=jTimeBg.replace(":","").replace(":","");
		   	jTimeEd=J_timeEd.timespinner('getValue'); 
		   	jTimeEd=jTimeEd.replace(":","").replace(":",""); 
			
		   	RefreshData();
	}

</script>

<!-- 表单操作 -->
	<script type="text/javascript">
	
	
	/* 初始化渠道代码下拉列表*/
	function initChannelID(){
		var channel=document.getElementById("J_channelID");
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/ChannelInfoInit.action',
			data:"selectSysID="+'${param.sysID}',
			dataType:"json",
			success: function(data){
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
	
 </script>

</body>
</html>
