<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>监控报表导出</title>
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
<script src="../../js/mons/jquery.js" type="text/javascript"></script>
<script src="../../js/mons/jquery.table2.js" type="text/javascript"></script>
<script src="../../js/mons/grid.js" type="text/javascript"></script>
<script src="../../js/mons/mons.js" type="text/javascript"></script>
<jsp:include page="inc.jsp"></jsp:include>
</head>

<body>
<div class="nps_top">
	<div class="nps_top_left"><em><font class="logo_title1"></font> <font class="logo_title1">监控报表导出</font></em></div>
	<div class="nps_top_right">当前时间：<span id="t001"></span> 年 <span  id="t002"></span> 月 <span  id="t003"></span> 日 
		<span id="t004"></span> 时 <span  id="t005"></span> 分<span  id="t006"></span> 秒</div>
</div>
<div class="nps_content">
		
		<div id="tb"
			style="padding: 5px; height: auto; border: none; background: url(../../images/50.png);">
			<table class="table_form3">
			  <tr>
					<th>时间段：</th>
					<td><input name="TimeBg" type="text" id="J_timeBg" class="easyui-datebox"/> -
						<input name="TimeEd" type="text" id="J_timeEd" class="easyui-datebox"/> </td>
        			<th></th>
        			<td><a href="#" class="form_button3" iconCls="icon-search"  id="J_submit_search">导出</a></td>
					<td></td>
					<td></td>
			   </tr>
		    </table>
    	</div>
</div>

<div id = "Process"></div>


<!-- 初始化组件 -->
<script type="text/javascript">
	
	/*查询表单*/
	var J_timeBg=$('#J_timeBg'); //起始时间
	var J_timeEd=$('#J_timeEd'); //结束时间
	
	var J_submit_search = $('#J_submit_search');
	
	function dataBoxInit(){
		var currDate=new Date();
		var str=FormatDate(currDate);
		
		$('#J_timeBg').datebox('setValue', str);  
		$('#J_timeEd').datebox('setValue', str);
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
		
		dataBoxInit();
	    
		J_submit_search.click(searchFun);
	});
	
	function searchFun() { 
   	
		   	jTimeBg=J_timeBg.datebox('getValue');  
		   	jTimeBg=jTimeBg.replace("-","").replace("-","");
		   	jTimeEd=J_timeEd.datebox('getValue'); 
		   	jTimeEd=jTimeEd.replace("-","").replace("-",""); 
		   	
		   	$('#J_submit_search').attr("readOnly","readyonly");

		   	$.messager.progress({title:'请稍候',msg:'正在生成报表数据,请稍候...',text:''});
		   	
		   	ReoprtExport();
	}
	
	function ReoprtExport(){

		var param = "";
		param = "MONSTranNO=MON023&jsonStr={\"Start_Day\":\""+
				jTimeBg+"\",\"End_Day\":\""+jTimeEd+"\"}";
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data : param,
			dataType : "json",
			success : function(data) {
				
				if("0000"==data.RetCode){
					var dataObj = data.RPT_URL;//这个.后面的名字要和json返回数据匹配
					
					$.messager.progress('close');
					
					window.location.href=dataObj;
				}
			  }
			});	
	}

</script>
</body>
</html>
