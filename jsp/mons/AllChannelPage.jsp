﻿<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>全系统综合实时交易监控</title>
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
	<script src="../../js/mons/jquery.js" type="text/javascript"></script>
	<script src="../../js/mons/jquery.table2.js" type="text/javascript"></script>
	<script src="../../js/mons/grid.js" type="text/javascript"></script>
	<script src="../../js/mons/mons.js" type="text/javascript"></script>
	<script src="../../js/FusionCharts/FusionCharts.js" type="text/javascript"></script>
	<jsp:include page="inc.jsp"></jsp:include>
<script type="text/javascript">
function cutMenu()
{
	var menu=document.getElementById("Col_menu");

	if(menu.style.display=="")
	{
		menu.style.display="none";
		$('#dataGrid').datagrid('resize',{width:'96%',height:1000});
	}
	else
	{
		menu.style.display="";
		$('#dataGrid').datagrid('resize',{width:'96%',height:500});
	}
}

</script>
</head>

<body>
	<div class="nps_top">
		<div class="nps_top_left">
			<em><font class="logo_title1">全系统</font> <font
				class="logo_title2">综合实时交易监控</font></em>
		</div>
		<div class="nps_top_right">
			交易日期：<span id="t001">2013</span> 年 <span  id="t002">2</span> 月 
			<span  id="t003">26</span> 日 <span id="t004">14</span> 时 <span  id="t005">35</span> 分
			<span  id="t006">35</span> 秒
		</div>
	</div>
	<div class="nps_content">
		<div class="nps_num">
			<ul>
				<li class="nps_num3">成功率 <span id="001"></span></li>
				<li class="nps_num2">平均响应时间 <span id="002">s</span></li>
				<li class="nps_num1">交易笔数 <span id="003"></span></li>
			</ul>
		</div>
		<table class="nps_map">
			<tr>
				<td><a href="javascript:cutMenu()">全系统综合交易曲线图</a></td>
        		<td><a href="javascript:cutMenu()">全系统综合交易笔数</a></td>
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
			<div id="dataGrid" style="height: 500px" class="easyui-datagrid"
				title="实时交易监控">
		</div>
		<!--   ---   -->
		<div id="tb"
			style="padding: 5px; height: auto; border: none; background: url(../../images/50.png);">

			<table class="table_form3">
				<!-- tr:代表HTML表格中的一行 -->
				<!-- th:代表HTML表格中的表头 -->
				<!-- td: 代表HTML表格中的一个单元格 -->
				<!--  -->
				<tr>
					<th>交易状态：</th>
					<td><select id="J_Flag" name="flag" class="">
							<option value="0">全部交易</option>
							<option value="1">成功交易</option>
							<option value="2">业务失败</option>
							<option value="3">交易失败</option>
					</select>
					</td>

					<th><a href="#" class="form_button3" iconCls="icon-search"
						id="J_submit_search">筛选</a></th>
					<td><a href="#" class="form_button4" iconCls="icon-search"
						id="J_button_lock">锁屏</a></td>
				</tr>
			</table>
		</div>



		<table class="table_list">
	
		</table>
	</div>


	<!-- 初始化组件 -->
	<script type="text/javascript">
	
		/*自定义设置 */
		var timeData1=30000;//曲线图和柱状图的轮询时间
		var timeData2=10000;//实时监控的的轮询时间
		
		/*实时监控定时器*/
		var timer=null;
	    
		/*table表单 */
		var dataGridTable;
		var indexMax=50;
		var flag;
		var max=1;
		var indexData=0;
		var indexAddID=1;
	    var lockFlag=false;
		/*查询表单*/
		var J_Flag=$('#J_Flag');//交易状态
		var jFlag;
		
		var J_submit_search = $('#J_submit_search');
		var J_button_lock = $('#J_button_lock');
		
		var ChartLine = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "600", "258");
        var ChartColumn3D = new FusionCharts("FusionChartsSWF/Column3D.swf", "Column3D", "600", "258");
		
		$(function(){
			
			/*JQuery 限制文本框只能输入数字和小数点*/  
            $(".Numtext").keyup(function(){    
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));    
                }).bind("paste",function(){  //CTR+V事件处理    
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));     
                }).css("ime-mode", "disabled"); //CSS设置输入法不可用    
                
            dataGridInit();
              
            getDate();
			RefreshMON017();
            
			J_submit_search.click(searchFun);
			J_button_lock.click(lockFun);
	        flag=false;
	               
	        initFusionCharts1();
	        initFusionCharts2();
			init();
		});
		
		/**
		锁屏方法
		**/
		function lockFun(){
			var btn=document.getElementById("J_button_lock");
			if(lockFlag==false){
				btn.innerHTML="取消锁屏";
				lockFlag=true;
			}else{
				btn.innerHTML="锁屏";
				lockFlag=false;
				init();
			}
		}
		
		/**function:  searchFun()
	    description:筛选
	    author:闫洁
	    Date:2014年6月12日 
	 	**/
		function searchFun() { 
	    if(lockFlag==false){
		   	
		    $('#dataGrid').datagrid('loadData',{total:0,rows:[]});
		    max=1;
		    indexData=0;
		    flag=true;
		    
		    jFlag=J_Flag.val();
		   	
		   	init();
	    }else{
	    	alert("已锁屏,请先取消锁屏!!!");
	    }
	}
		
		
		function RefreshMON017(){
			var param = "";
			param = "MONSTranNO=MON017&jsonStr={\"AvgTm_ID\":\"100000\"}";
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
		/* 筛选数据 */
		function init(){
			var str="";
			if(flag){
				str="{\"AvgTm_ID\"\:\"100000\",\"Cur_ID\":\""+
				1+"\",\"Flag\":\""+jFlag+"\",\"Busitype\":\""+"\",\"TranCode\":\""+
				"\",\"TimeBg\":\""+"\",\"TimeEd\":\""+"\"}";
			}else{
				str="{\"AvgTm_ID\"\:\"100000\",\"Cur_ID\":\""+
				1+"\",\"Flag\":\""+0+"\",\"Busitype\":\""+"\",\"TranCode\":\""+
				"\",\"TimeBg\":\""+"\",\"TimeEd\":\""+"\"}";
			}
			
			var param = "MONSTranNO=MON020&jsonStr="+str;
			$.ajax({ 
				type: "POST",
				url:'<%=basePath%>/MONSTran.action',
				data:param,
				dataType:"json",
				success: function(data){
					var dataObj=data.Seq;
					max=data.CurID;
					var len=dataObj.length;

					$('#dataGrid').datagrid('loadData',{total:0,rows:[]});
					$('#dataGrid').datagrid('loadData',{total:len,rows:dataObj});
				},
				error: function(XMLHttpRequest,textStatus,errorThown){
					alert(XMLHttpRequest.Status);
					alert(XMLHttpRequest.readyState);
					alert(XMLHttpRequest.textStatus);
				}
				
			});
			
			if(lockFlag==false)
				timer = setTimeout(init,timeData2);
		}
	</script>

	<!-- 表单操作 -->
	<script type="text/javascript">
	
	/* 初始化交易曲线图*/
	function initFusionCharts1(){
		var str="{\"AvgTm_ID\"\:\"100000\",\"Flag\":\""+
		"0"+"\",\"Para1\":\""+
		""+"\",\"Para2\":\""+""+"\"}";
		var param = "MONSTranNO=MON018&jsonStr="+str;
		
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data:param,
			dataType:"json",
			success: function(data){
				var dataObj=data.Rate;
				
				FusionCharts("MSLine").dispose();
				ChartLine = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "600", "258");
				
				var begin="<graph caption='' xAxisName='分钟' rotateNames='1' yAxisName='成功率' numberSuffix='%25' outCnvBaseFontColor='000000'"
								+"bgColor='0986c4,035785' showNames='1' decimalPrecision='2' formatNumberScale='0' "
								+" drawAnchors ='1' lineThickness='2' showLimits='2'>";
				var end="</graph>";
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
				ChartLine.setDataXML(begin+coloum+isValue1+isValue2+end);
				ChartLine.render("detail1");
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
		var str="{\"AvgTm_ID\"\:\"100000\",\"Flag\":\""+
		"0"+"\",\"Para1\":\""+
		""+"\",\"Para2\":\""+""+"\"}";
		var param = "MONSTranNO=MON019&jsonStr="+str;
		
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data:param,
			dataType:"json",
			success: function(data){
				var dataObj=data.Num;
				
				FusionCharts("Column3D").dispose();
				ChartColumn3D = new FusionCharts("FusionChartsSWF/Column3D.swf", "Column3D", "600", "258");
				
				var ColorArr =['CCFF00','FF0000','FF6600','FFFF00','00FF00','00FFFF','FF33FF','0099FF','FF6666','FF0099','6666FF','66FF66',
				                'FFFF66','00CC99','CC99CC','00CC00','CC33CC','FF3366','FFCC00'];
				var begin="<graph caption='交易量/分钟' xAxisName='分钟'  rotateNames='1'  outCnvBaseFontColor='ffffff'  bgColor='0986c4,035785' yAxisName='交易量' "
					+"showNames='1' decimalPrecision='4' formatNumberScale='0' labelDisplay='WRAP'>";
				var end="</graph>";
				var coloum="";
				var len=dataObj.length;
				if(len>0){
				  for(var i=0;i<len;i++){
					  coloum+="<set name='"+dataObj[i].Time+"'  value='"+dataObj[i].Count+"' color='"+ColorArr[i]+"'/>";
				  }
				}
				
				ChartColumn3D.setDataXML(begin+coloum+end);
				ChartColumn3D.render("detail2");
			},
			error: function(XMLHttpRequest,textStatus,errorThown){
				alert(XMLHttpRequest.Status);
				alert(XMLHttpRequest.readyState);
				alert(XMLHttpRequest.textStatus);
			}
		});
			setTimeout(initFusionCharts2,timeData1);
	}

	function dataGridInit(){ 
		dataGridTable=$('#dataGrid').datagrid({//实例化table表单
			//pagination: true,//设置true将在数据表格底部显示分页工具栏。
			collapsible:true,  //折叠按钮
			rownumbers: false,//设置为true将显示行数。
			//pageList: [5,10,15],
			//pageSize:10,
			//fitColumns:true,
			striped:true,//设置为true将交替显示行背景
			iconCls:'icon-ok',
			toolbar:'#tb',
			singleSelect:true,
			loadMsg:'正在装载,请稍候...',
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
			columns:[[ //数据表格列配置对象
				{field:'Demo4',title:'', width:20,sortable: true},
				{field:'MonType',title:'系统编号',width:70},
				{field:'GolSeq',title:'全局流水号',width:180},
				{field:'TimeStamp',title:'',width:110,hidden:true},
				{field:'RespTime',title:'交易耗时',width:50},
				{field:'NodeNo',title:'节点号',width:70},
				{field:'HostCode',title:'主机授权码',width:120},
				{field:'ActCode',title:'客户号',width:100},
				{field:'Demo1',title:'备用1',width:65},
				{field:'StartTime',title:'开始时间',width:100},
		        {field:'EndTime',title:'结束时间',width:100},
				{field:'Trans',title:'交易码',width:200},
				{field:'ReturnCode',title:'错误码',width:70},
				{field:'ReturnMsg',title:'错误描述',width:150},			
				{field:'BranchID',title:'机构编码',width:70},
				{field:'PlatSeq',title:'平台流水',width:250},
				{field:'Account1',title:'卡号',width:120},
				{field:'TranCycle',title:'业务类型',width:65},
				{field:'Amount',title:'交易金额',width:100},	
				{field:'MerchantID',title:'网点号',width:150},
				{field:'TranDate',title:'交易日期',width:70},  
				{field:'CompName',title:'插件名',width:85},
		        {field:'ChannelID',title:'渠道号',width:70},
		        {field:'HostSeq',title:'主机交易序号',width:75},
		        {field:'EquipSeq',title:'柜员号',width:70},
		        {field:'Channel',title:'渠道名',width:250},
		        {field:'EquipID',title:'凭证',width:100},
		        {field:'Demo3',title:'备用3',width:65},
		        {field:'Account2',title:'账号2',width:80},
		        {field:'Demo2',title:'备用2',width:65},              
		        {field:'AcctType',title:'',width:70,hidden:true},
		        {field:'AcctKind',title:'',width:70,hidden:true},	    		        
		        {field:'Amount1',title:'交易金额1',width:100,hidden:true},
                {field:'Fee',title:'手续费',width:75,hidden:true},
		        {field:'OperMark',title:'业务标识',width:70,hidden:true},
		        {field:'TranMark',title:'交易标识',width:70,hidden:true}
			    ]]
		});
	}
    </script>
</body>
</html>
