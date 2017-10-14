<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>柜员业务量统计</title>
<!--
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-1.8.3.js" charset="utf-8"> </script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/icon.css" />
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jslib/easyUI_validate.js"></script>
<script src="../../js/mons/mons.js" type="text/javascript"></script>
<script src="../../js/FusionCharts/FusionCharts.js" type="text/javascript"></script>
<script src="../../js/mons/grid.js" type="text/javascript"></script>
<script src="../../js/mons/jquery.js" type="text/javascript"></script>
<script src="../../js/mons/jquery.table2.js" type="text/javascript"></script>	
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/index2.css"  />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/form.css"  />
<script type="text/javascript" src="<%=basePath %>/js/ztree/jquery.ztree.all-3.5.min.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/ztree/zTreeStyle/zTreeStyle.css"/>	
-->	
	
<link rel="stylesheet" href="../../css/mons/index.css" type="text/css">
<script src="../../js/mons/jquery.js" type="text/javascript"></script>
<script src="../../js/mons/jquery.table2.js" type="text/javascript"></script>
<script src="../../js/mons/grid.js" type="text/javascript"></script>
<script src="../../js/mons/mons.js" type="text/javascript"></script>
<script src="../../js/FusionCharts/FusionCharts.js" type="text/javascript"></script>
<jsp:include page="inc.jsp"></jsp:include>
<!--
	<link rel="stylesheet" type="text/css	" href="./jquery-easyui-1.4.1/demo.css">
	<script type="text/javascript" src="./jquery-easyui-1.4.1/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="./jquery-easyui-1.4.1/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="./jquery-easyui-1.4.1/themes/icon.css">
    <script type="text/javascript" src="./jquery-easyui-1.4.1/jquery.easyui.min.js" ></script>
-->

	






<script type="text/javascript">
function onbeforeunload(){  
    var scrollPos;      
    if (typeof window.pageYOffset != 'undefined') {  
        scrollPos = window.pageYOffset;  
     }  
     else if (typeof document.compatMode != 'undefined' &&  
          document.compatMode != 'BackCompat') {  
        	scrollPos = document.documentElement.scrollTop;  
     }  
     else if (typeof document.body != 'undefined') {  
    	scrollPos = document.body.scrollTop;  
     }  
     document.cookie="scrollTop="+ scrollPos; //存储滚动条位置到cookies中  
}  

 function onload()  
{   
if(document.cookie.match(/scrollTop=([^;]+)(;|$)/)!=null){  
    var arr=document.cookie.match(/scrollTop=([^;]+)(;|$)/); //cookies中不为空，则读取滚动条位置  
     document.documentElement.scrollTop=parseInt(arr[1]);  
    document.body.scrollTop=parseInt(arr[1]);  
 }  
} 


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

$(function(){
	
	$('#J_tranDate').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return date<=d1;
		}
	});
	$('#J_QueryDate').datebox().datebox('calendar').calendar({
		validator: function(date){
			var now = new Date();
			var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return date<=d1;
		}
	});
	dataTimeSpinnerInit();
	
	
	

/*
	var $swap = $('#gsdemo');
	var movetotop;
	$swap.hover(function(){
		clearInterval(movetotop);
	},function(){
		movetotop = setInterval(function(){
				
						$swap.find("ul:first").animate({
							marginTop:"-25px"
						},1000,function(){
							$(this).css({marginTop:"0px"}).find("li:first").appendTo(this);
						
				});
		 },3000);
		}).trigger('mouseleave');
*/
});

function dataTimeSpinnerInit(){
	$('#J_timeBg').timespinner('setValue', '00:00');  
	$('#J_timeEd').timespinner('setValue', '23:59');
    var currDate=new Date();
	var str=FormatDate(currDate);
	$('#J_tranDate').datebox('setValue', str);
	$('#J_QueryDate').datebox('setValue', str);
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
function topchange(s){
	topNum = s;
	clearTimeout(topTimer);
	
	initFusionCharts0();
	/*
	var chartRef = FusionCharts("detail0");
	var date="&name=12&value=22&name=13&value=44";
	chartRef.feedData(date);
	*/
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
  




</script>

</head>
<body>
	
	<div class="nps_top">
		<div class="nps_top_left">
			<em><font class="logo_title1">${param.sysName}</font> <font
				class="logo_title2">柜员业务量统计</font></em>
		</div>
		<div class="nps_top_right">
			交易日期：<span id="t001">2014</span> 年 <span  id="t002">2</span> 月 
			<span  id="t003">26</span> 日 <span id="t004">14</span> 时 <span  id="t005">35</span> 分
			<span  id="t006">35</span> 秒
		</div>
	</div>
	<div class="nps_content">
		<div class="nps_num">
			<ul>
				<li class="nps_num2">交易笔数 <span id="003">0</span></li>
			</ul>
		</div>
		
		<table class="nps_map">
			<tr>
			    <td><a href="javascript:cutMenu()">柜员实时交易量排名 </a></td>
        		<td><a href="javascript:cutMenu()">柜员交易笔数</a></td>
			</tr>
			<tr id="Col_menu">
				<td>
					<div align="left" class="hotsys_sdbox_r">TOP
						<select id="J_TopFlag" name="flag"   onchange="topchange(this.options[this.options.selectedIndex].value)">
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
						</select>
					</div>
					<!--  
					<div class="hotsys_sdbox_r" >
						          <div id="gsdemo"  class="gsdemo">
										      <ul id="gsdemo1" >
										      </ul> 
						          </div>
						     
					</div>
					-->
					<div id="detail0" style="margin:0 auto"></div>
				</td>
				<td>
					<table>
        				<tr>
        					<th>日期:</th>
        					<td >
        		        	<!--  	
        		        		<input name="tranDate" type="text" id="J_tranDate" class="easyui-datebox" style="width:100px;"/>
        		        	-->
        		        		<input name="tranDate" class="easyui-datebox" id="J_tranDate" data-options="formatter:myformatter,parser:myparser" style="width:100px;"></input>
        		        		
        		        	</td>
        		        	<th>时间段:</th>
        		        	<td >
        		        		<input name="TimeBg" type="text" id="J_timeBg" class="easyui-timespinner"  style="width:60px;"  
        data-options="min:'0:00',showSeconds:false"  editable="true" />-
								<input name="TimeEd" type="text" id="J_timeEd" class="easyui-timespinner"  style="width:60px;"  
        data-options="min:'0:01',showSeconds:false" editable="true" />
        					</td>
        					<th></th>
        					<td></td>
        				</tr>
        			    <tr>
        			    	<th>机构:</th>
        			    	<td >
        	            		 <select id="J_brchCode" class="easyui-combobox" data-options="valueField:'brchNo',textField:'brchDesc'" name="brchNo" style="width:180px">
								</select>
							</td>
							<th>柜员:</th>
        			    	<td >
        	            		<select id="J_cotCode" class="easyui-combobox" data-options="valueField:'cntNo',textField:'cntDesc'" name="cotNo" style="width:100px">
								</select>	
        	            	</td>	
        	            		 <!--
        	            		 <input name="cotCode" type="text" id="J_cotCode" style="width:100px;"/>
        	            		 <select id="cc" class="easyui-combo" style="width:150px"></select>
        	            		 	 -->	

        	            	<th>
        	            		<a href="#" class="form_button2" iconCls="icon-search" id="J_submit_query">确定</a>
        	            	</th>
        	            	<th >
        	            		<a href="#" class="form_button2" iconCls="icon-search" id="J_submit_cancel">清除</a>
        	            	</th>
        	            </tr>
        			</table>
					<div id="detail1" ></div>
				</td>
			</tr>
		</table>

	   
		<!-----------------------------表格----------------------------->
		<div style="width: 95%; margin: 10px auto; padding-right: 1px">
			<div id="dataGrid" style="height: 500px" class="easyui-datagrid"
				title="柜员统计列表">
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
					<th>排序方式：</th>
					<td><select id="J_Flag" name="flag" class="">
							<option value="1">降序</option>
							<option value="0">升序</option>
					</select>
					</td>
					<th>交易日期：</th>
					<td><input name="queryDate" type="text" id="J_QueryDate" class="easyui-datebox"/>
					</td>
					<th>机构：</th>
					<td>
						<select id="J_BrchNo" class="easyui-combobox" data-options="multiple:true,multiline:false,valueField:'brchNo',textField:'brchDesc'" name="brchNo" style="width:150px">
						</select>
					</td>
					<!--  
					<th>柜员：</th>
					<td>
						<select id="J_CotNo" class="easyui-combobox" data-options="multiple:true,multiline:false,valueField:'cntNo',textField:'cntDesc'" name="cotNo" style="width:150px">
						</select>
					</td>
					-->
					<td>
					</td>
					<th><a href="#" class="form_button3" iconCls="icon-search"
						id="J_submit_search">查询</a>
					</th>
					<th><a href="#" class="form_button3" iconCls="icon-search"
						id="J_submit_clear">清除</a>
					</th>
				</tr>

			</table>
		</div>
		
		</div>
	 </div>


	<!-- 初始化组件 -->
	<script type="text/javascript">
	
		/*自定义设置 */
		var timeData1=60000;//曲线图和柱状图的轮询时间
		var timeData2=10000;//实时监控的的轮询时间
		var topNum = 10;
		var topTimer;
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
		var jTranDate=jTimeBg=jTimeEd=jCotcode=jFlag=jQueryDate=jCotNo=jBrchNo="";
 	
 		var J_tranDate=$('#J_tranDate'); //交易日期
 		var J_timeBg=$('#J_timeBg'); //交易起始时间
		var J_timeEd=$('#J_timeEd'); //交易结束时间
		var J_cotCode =$('#J_cotCode');//柜员号
		var J_submit_query = $('#J_submit_query');
		var J_submit_cancel = $('#J_submit_cancel');
		
		var J_Flag = $('#J_Flag');
		var J_QueryDate = $('#J_QueryDate');
		var J_CotNo = $('#J_CotNo');
		var J_BrchNo = $('#J_BrchNo');
		var J_submit_search = $('#J_submit_search');
		var J_submit_clear = $('#J_submit_clear');
		
		$("#J_timeBg").timespinner({
			onSpinUp : function(){
				//alert("111");
			}
		});
		$("#J_timeBg").timespinner({
			onSpinDown : function(){
				//alert("111");
			}
		});
		$("#J_timeEd").timespinner({
			onSpinUp : function(){
				//alert("111");
			}
		});
		$("#J_timeEd").timespinner({
			onSpinDown : function(){
				//alert("111");
			}
		});
		
		
		var ChartLine = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "600", "258");
        var ChartColumn3D = new FusionCharts("FusionChartsSWF/Column3D.swf", "Column3D", "670", "315");
		
		$(function(){
			
			/*JQuery 限制文本框只能输入数字和小数点*/  
            $(".Numtext").keyup(function(){    
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));    
                }).bind("paste",function(){  //CTR+V事件处理    
                    $(this).val($(this).val().replace(/[^0-9.]/g,''));     
                }).css("ime-mode", "disabled"); //CSS设置输入法不可用    
                     
                
                
               //////////////////////////
               
               
               var _cnt = $('#J_CotNo').combobox({
                disabled: true,
                valueField: 'cntNo',
                textField: 'cntDesc'
            	});
				var _brch = $('#J_BrchNo').combobox({
                	url: '<%=basePath%>/BrchInfoInit.action',
                	editable: false,
                	valueField: 'brchNo',
                	textField: 'brchDesc',
                	onSelect: function (record) {
                    		_cnt.combobox({
                        		disabled: false,
                        		url: '<%=basePath%>/CntInfoInit.action?selectMenus=' + record.brchNo,
                        		valueField: 'cntNo',
                        		textField: 'cntDesc'
                    		}).combobox('clear');
                		
                	}
            	});
				
				var _cot = $('#J_cotCode').combobox({
	                disabled: true,
	                valueField: 'cntNo',
	                textField: 'cntDesc'
	            	});
					var _bh = $('#J_brchCode').combobox({
	                	url: '<%=basePath%>/BrchInfoInit.action',
	                	editable: false,
	                	valueField: 'brchNo',
	                	textField: 'brchDesc',
	                	onSelect: function (record) {
	                    		_cot.combobox({
	                        		disabled: false,
	                        		url: '<%=basePath%>/CntInfoInit.action?selectMenus=' + record.brchNo,
	                        		valueField: 'cntNo',
	                        		textField: 'cntDesc'
	                    		}).combobox('clear');
	                		
	                	}
	            	});
				
               ////////////////////////////
                
            getDate();
			
            
			J_submit_search.click(searchData);
			
			J_submit_query.click(searchFun);
			J_submit_clear.click(clearData);
			J_submit_cancel.click(cancelData);
	        flag=false;
	               
	        //initFusionCharts1();
	        //initTop();
			init();
			/*曲线图*/
			searchFun();
			dataGridInit();
			initBrch();
			//initCot();
			RefreshMON026();
		});
		function initBrch(){   
		}
		
		function initCot(){
			
			var str="";
			str = "<option disabled=\"true\" selected=\"true\">==可选择多项==</option>";
			str += "<option  value=\"0001230\"  >零</option>";
			str +="<option value=\"0001231\">一</option>";
			str +="<option value=\"0001232\">二</option>";
			str +="<option value=\"0001233\">三</option>";
			str +="<option value=\"0001234\">四</option>";
			str +="<option value=\"0001235\">五</option>";
			str +="<option value=\"0001236\">六</option>";
			str +="<option value=\"0001237\">七</option>";
			str +="<option value=\"0001238\">八</option>";
			str +="<option value=\"0001239\">九</option>";
			str +="<option value=\"0001210\">十</option>";
			str +="<option value=\"0001300\">百</option>";
			str +="<option value=\"0001000\">千</option>";
			$("#J_CotNo").html(str);
			$("#J_CotNo").selectedIndex = -1;
			//转换为EasyUI的combobox
			$("#J_CotNo").combobox({});
			
			 
		}
		function clearData(){
			$("#J_CotNo").combobox('clear');
			$("#J_BrchNo").combobox('clear');
		
		}
		function cancelData(){
			$("#J_cotCode").combobox('clear');
			$("#J_brchCode").combobox('clear');
		}
		function searchFun() { 
		   	jTranDate=J_tranDate.datebox("getValue");
		   	jTranDate=jTranDate.replace("-","").replace("-","");
		   	jTimeBg=J_timeBg.timespinner('getValue');  
		   	jTimeBg=jTimeBg.replace(":","").replace(":","");
		   	jTimeEd=J_timeEd.timespinner('getValue'); 
		   	jTimeEd=jTimeEd.replace(":","").replace(":",""); 
			jCotcode=J_cotCode.combobox('getValue');
			if(jTimeBg >=jTimeEd)
			{
				alert("请选择正确的时间段");
				return;
			}
			initFusionCharts1();
			
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
				//sortName:'StartTime',
				//sortOrder:'asc',
				singleSelect:true,
				method:'post',
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
							rows:data.Cot,
					};
					return value;
				},
				columns:[[ //数据表格列配置对象
				           {field:'Date',title:'日期',width:200,
								formatter:function(value,row,index){
									value = J_QueryDate.datebox("getValue");
									return value;
								}	
							},
							{field:'Time',title:'时间',width:200,
								formatter:function(value,row,index){
								
									value = value.substring(0,2)+":"+value.substring(2,4);
									return value;
								}
							}, 
							{field:'BrchNo',title:'机构号',width:200},
							{field:'BrchDes',title:'机构名',width:200,},
							{field:'CotNo',title:'柜员号',width:200},
							{field:'CotDes',title:'柜员名',width:200,},
					        {field:'Count',title:'业务量',width:200}
						    ]]
			});
		}
		
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
		
		/*柜员业务量查询*/
		function searchData() { 
			    jFlag=J_Flag.val();
			   	jQueryDate=J_QueryDate.datebox("getValue");
			   	jQueryDate=jQueryDate.replace("-","").replace("-","");
			   	//jCotNo=J_CotNo.val();
			   	/*
			   	jCotNo=J_CotNo.combobox('getValues');
			   	*/
			   	jBrchNo=J_BrchNo.combobox('getValues');
			   	//alert(jCotNo);
			   		//jCotNo = "";
			   	RefreshData();
		}
		function RefreshMON026(){
			var param = "";
			param = "MONSTranNO=MON026&jsonStr={\"AvgTm_ID\":\""+'0'+"\"}";
			$.ajax({ 
				type: "POST",
				url:'<%=basePath%>/MONSTran.action',
				data : param,
				dataType : "json",
				success : function(data) {
					if("0000"==data.RetCode){
						var dataObj = data.Sumary;//这个.后面的名字要和json返回数据匹配
						document.getElementById("003").innerHTML=dataObj.Num;
					}
				  }
				});
			setTimeout(RefreshMON026,60000);
		}
		/* 筛选数据 */
		function init(){
			initFusionCharts0();
		}
		
	</script>

	<!-- 表单操作 -->
	<script type="text/javascript">
	
	function initFusionCharts0(){
		/*
		var str="{\"AvgTm_ID\"\:\""+'${param.sysID}'+"\",\"Flag\":\""+
		"0"+"\",\"Para1\":\""+
		""+"\",\"Para2\":\""+""+"\"}";
		var param = "MONSTranNO=MON019&jsonStr="+str;
		*/
		
		var str="{\"Top\"\:\""+topNum+"\"}";
		var param = "MONSTranNO=MON024&jsonStr="+str;
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data:param,
			dataType:"json",
			success: function(data){
				var dataObj=data.Cot;
				var ColorArr =['CCFF00','FF0000','FF6600','FFFF00','00FF00','00FFFF','FF33FF','0099FF','FF6666','FF0099','6666FF','66FF66',
				                'FFFF66','00CC99','CC99CC','00CC00','CC33CC','FF3366','FFCC00'];
				var begin="<graph caption='业务量/柜员号' xAxisName='柜员号' outCnvBaseFontColor='000000'  rotateNames='1'   bgColor='0986c4,035785' yAxisName='交易量' "
					+" showNames='1' showValues='1'   decimalPrecision='4' formatNumberScale='0' labelDisplay='Rotate' slantLabels='1'>";
				var end="</graph>";
				var coloum="";
				var len=dataObj.length;
				if(len>0){
				  for(var i=0;i<len;i++){
					  coloum+="<set name='"+dataObj[i].CotNo+"'  value='"+dataObj[i].Count+"' color='"+ColorArr[i%19]+"'/>";
				  }
				}
				
				FusionCharts("Column3D").dispose();
				ChartColumn3D = new FusionCharts("FusionChartsSWF/Column3D.swf", "Column3D", "700", "315");
				ChartColumn3D.setDataXML(begin+coloum+end);
				ChartColumn3D.render("detail0");
				
				
			},
			error: function(XMLHttpRequest,textStatus,errorThown){
				alert(XMLHttpRequest.Status);
				alert(XMLHttpRequest.readyState);
				alert(XMLHttpRequest.textStatus);
			}
		});
		topTimer=setTimeout(initFusionCharts0,timeData1);
	}

	
	/* 初始化交易曲线图*/
	function initFusionCharts1(){
		var str="{\"TranDate\"\:\""+jTranDate+"\",\"TimeBg\":\""+
		jTimeBg+"\",\"TimeEd\":\""+jTimeEd+"\",\"Cot_CotNo\":\""+jCotcode+"\"}";
		var param = "MONSTranNO=MON025&jsonStr="+str;
		//alert(param);
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data:param,
			dataType:"json",
			success: function(data){
				var dataObj=data.Cot;
				var len=dataObj.length;
				var lip;
				var all = 0;
			
				var isValue1="<dataset seriesName='业务量' color='0000c7'>";
				var end="</graph>";
				var coloum="<categories>";
				if(len>0){
					  for(var i=len-1;i>=0;i--){
						  var time = dataObj[i].Time.substring(0,2)+":"+dataObj[i].Time.substring(2,4);
						  coloum+="<category name='"+time +"'/>";
						  isValue1+="<set value='"+dataObj[i].Count +"'/>";
						  all ++;
						  if(i>=1){
							  	var tmp = (dataObj[i-1].Time.substring(0,2) - dataObj[i].Time.substring(0,2))*60;
							  	var secTmp = dataObj[i-1].Time.substring(2,4)-dataObj[i].Time.substring(2,4)-1;
							  	tmp = tmp*1 +secTmp*1;//tmp 相差分钟数 ，转换成数值型
							 	for(var j = 0;j<tmp;j++)
							  	{
									  var hTime = dataObj[i].Time.substring(0,2);
									  var mTime = dataObj[i].Time.substring(2,4)*1 +j+1;
									  if(mTime >=60){
										  var n = parseInt(mTime/60);
										  mTime = mTime*1 -60*n;
										  if(mTime < 10){
										  	mTime = "0" + (mTime);//转换成字符串类型
										  }
									  	  hTime = hTime*1 + n*1;
									  }else{
										  	if(mTime < 10){
										  		mTime = "0" + (mTime);//转换成字符串类型
										  	}
									  }
									  var tmpTime = hTime+":"+mTime;
									  coloum+="<category name='"+tmpTime +"'/>";
									  isValue1+="<set value='0'/>";
									  all ++;
							   	}
							}
					  }
					  coloum+="</categories>";
					  isValue1+="</dataset>";
					}
				    lip = all/15;
				    if(lip < 1)
				    	lip = 1;
				   // alert(lip+"    "+len+"    "+all);
				
				
				var begin="<graph caption='' xAxisName='分钟' rotateNames='1' yAxisName='业务量'  outCnvBaseFontColor='000000' labelDisplay='Rotate' slantLabels='1'  labelStep='"+lip+"' showValues='0'"
								+"  bgColor='035785,0986c4' bgAlpha='100' canvasBorderColor='ffffff' showNames='1' decimalPrecision='2' formatNumberScale='0' "
								+" drawAnchors ='1' baseFontColor='000000' anchorRadius='1' lineThickness='1' showLimits='2' animation='1'>";
				
			
				FusionCharts("MSLine").dispose();
				ChartLine = new FusionCharts("FusionChartsSWF/MSLine.swf", "MSLine", "600", "258");
				ChartLine.setDataXML(begin+coloum+isValue1+end);
				ChartLine.render("detail1");
				
				
				
			},
			error: function(XMLHttpRequest,textStatus,errorThown){
				alert(XMLHttpRequest.Status);
				alert(XMLHttpRequest.readyState);
				alert(XMLHttpRequest.textStatus);
			}
		});
			//setTimeout(initFusionCharts1,timeData1);
	}
	
	/* 初始化柜员排名*/
	
	function initTop(){
		var str="{\"Top\"\:\""+topNum+"\"}";
		var param = "MONSTranNO=MON024&jsonStr="+str;
		//alert(param+topTimer);
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/MONSTran.action',
			data:param,
			dataType:"json",
			success: function(data){
				 var dataObj = data.Cot;
				 var len = dataObj.length;
				 if (len > 0) {
						var str="";
						for(var i=0;i<len;i++){
							var time = dataObj[i].Time.substring(0,2)+":"+dataObj[i].Time.substring(2,4);
							
							var msg = i+1+"--"+"&nbsp;时间:"+time+"&nbsp;&nbsp;柜员号:"+dataObj[i].CotNo+"业务量:&nbsp;"+dataObj[i].Count;
							
							str+="<li>"+msg+"</li>";
						}
						$('#gsdemo1').html(str);
				}
			},
			error: function(XMLHttpRequest,textStatus,errorThown){
				alert(XMLHttpRequest.Status);
				alert(XMLHttpRequest.readyState);
				alert(XMLHttpRequest.textStatus);
			}
		});
		topTimer=setTimeout(initTop,timeData1);
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
