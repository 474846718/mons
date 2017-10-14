<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!-- http://localhost:8080/bomp/jsp/bomp/t107.jsp -->
<head>
	<title>扩展指标阀值</title>
	<jsp:include page="inc.jsp"></jsp:include>
</head>
 
<body onload="init();">
<!-----------------------------表格----------------------------->
	<div style="width:96%;margin:10px auto;padding-right: 1px">
		<div id="dataGrid"  style="height:350px"  title="查询结果"> </div>
	</div>
	  <!--   ---   -->
	<div id="tb" style="padding:5px;height:auto;border:none;background:none;">
		<table class="table_form2">
                <!-- tr:代表HTML表格中的一行 -->
        		<!-- th:代表HTML表格中的表头 -->
        		<!-- td: 代表HTML表格中的一个单元格 -->	
		<tr>	
		    <th>系统编号：</th>
			<td><select name="sysName" id="J_sysName">
				<option value="" selected="selected">--请选择--</option></select>
			</td>					
		</tr>						
	  	<tr>
	  	<th></th>
	  	<td></td>
			<th></th>
			<td><a href="#" class="form_button3" iconCls="icon-search" id="J_submit_search">查询</a>
			</td>
		</tr>		
		
	    </table> 
	
	</div>

	<!-- ------------------------录入--------------------------- -->      
	<table class="table_form_title">
		<tr>
			<td><p>录入</p></td>
		</tr>
	</table>
      
      <!-- form: 表单标记中可以定义处理表单数据程序的URL地址等信息 -->
      <table class="table_form_box">
  <tr>
    <td>
	<form id="J_edit_form">
      
        <!-- table:把数据放在表格中 -->
        <table class="table_form" >
	        <!-- tr:代表HTML表格中的一行 -->
	        <!-- th:代表HTML表格中的表头 -->
	        <!-- td: 代表HTML表格中的一个单元格 -->
	<tr>
			<th>操作标识：</th>
			<td><select name="operSign" class="easyui-validatebox" data-options="required:true" validType="ccbinsId" id="J_operSign">
				<option value="">--请选择--</option> 
				<option value="1">新增</option>
				<option value="3" selected="selected">修改</option>
				</select>
				<span style="color:#ff9900">*</span>
            </td>
            <th>&nbsp;</th>
            <td>&nbsp;</td>
		</tr>
		<tr>
		    <th>系统编号：</th>
			<td><select name="channeId" id="l_channelId" class="easyui-validatebox" data-options="required:true"  validType="ccbinsId">
				<option value="" selected="selected">--请选择--</option></select>
				<span style="color:#ff9900">*</span>
			</td>
            <th>交易时间段：</th>
					<td><input name="begTime" type="text" id="l_begTime" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:true" />-
						<input name="endTime" type="text" id="l_endTime" class="easyui-timespinner"  style="width:80px;"  
        data-options="min:'0:00',showSeconds:true" /> </td>
			<th>阀值：</th>
            <td><input name="para0" type="text" id="l_para0"  maxlength="50" class="easyui-validatebox" data-options="required:true"/>
            <span style="color:#ff9900">*</span></td>
		</tr>
		<th>是否生效：</th>
			<td><select name="enable" id="l_enable">
				<option value="">--请选择--</option>
				<option value="0">是</option>
				<option value="1">否</option>
				</select>
            </td>
	</table>
		<table class="sys1_button">
		<tr>
			<td>
			<a href="#" class="form_button2" iconCls="icon-search" id="J_button_confirm">确 定</a>
			<a href="#" class="form_button2" iconCls="icon-search" id="J_button_cancel">取 消</a>			
			</td>
		</tr>
		</table>
	</form>
	</td>
  </tr>
</table>
	


    
    <!-- 初始化组件 -->
	<script type="text/javascript">
        /* 编辑表单 */
		//var l_sysId=$('#l_sysId');
		var l_channelId=$('#l_channelId'); 
	    
		/*table表单 */
		var dataGridTable;
        var J_edit_form =$('#J_edit_form');
        var J_operSign =$('#J_operSign');
        
       
        var J_sysName = $('#J_sysName');
       
        var J_button_cancel = $('#J_button_cancel');//取消
        var J_button_confirm = $('#J_button_confirm');//确定
		var J_submit_search = $('#J_submit_search');//查询
		        
		$(function(){
			
			$('input[type=text]').validatebox();
		    $.extend($.fn.validatebox.defaults.rules,{
		    	ccbinsId:{
				/* 	   validator:function(value){
						   return /^[0-9]{6}$/.test(value);
				   		},
				   	message:'必输项，请输入完整6位数字编号' */
		    		 validator:function(value){
						   if(value=="" || value==null)
						   return false;
						   else return true;
				   		},
				   	message:'必输项'
			 	  },ccbinsIN:{
					   validator:function(value){
						   return /^[0-9]{32}$/.test(value);
				   		},
				   	message:'必输项，请输入完整32位数字编号'
			 	  }
		    });
        
			//J_edit_form.form("clear");           
			J_submit_search.click(searchFun);
			J_button_confirm.click(confirmClick);	        
			J_button_cancel.click( function () {
				cancelClick();
			});

			dataGridInit();
			addDelete();
		});
        
	</script>   
     
	<!-- 表单操作 -->
	<script type="text/javascript">


	function dataGridInit(){ 
		dataGridTable=$('#dataGrid').datagrid({//实例化table表单
			url:'<%=basePath%>/MonsAvgParaInit.action',
			pagination: true,//设置true将在数据表格底部显示分页工具栏。
			collapsible:true,  //折叠按钮
			rownumbers: true,//设置为true将显示行数。
			striped:true,
			pageList: [10,20,30,50,100,200],
			pageSize:10,
			fitColumns:true,
			striped:true,//设置为true将交替显示行背景
			iconCls:'icon-ok',
			toolbar:'#tb',
			singleSelect:false,//之允许选择一行
			//checkOnSelect:true,
			selectOnCheck:true,
			//sortName:'monType',//初始化时以那一列来排序
			//sortOrder:'asc',//设置排序顺序asc或者desc（正序或者倒序）
			method:'post',
			columns:[[ //数据表格列配置对象
	            {field:'checkbox',checkbox:true}, 
				{field:'channelDesc',title:'系统名',width:200}, 
				{field:'begTime',title:'开始时间',width:200},
				{field:'endTime',title:'开始时间',width:200},
				{field:'para0',title:'阀值',width:200},
				{field:'enable',title:'是否生效',width:200,
					formatter : function(value){
						if(value == "0"){
							return "是";
						}else if(value == "1"){
							return "否";
						}else{
							return value;
						}
				}}
			    ]],
 			onDblClickRow:function(rowIndex,rowData){//当用户双击一行时触发
 				dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板
 				J_operSign.val('3');
 				initform(rowData);
 			}   
		});
	}
		
	function addDelete(){
		
	    //增、改、删
		var pager = dataGridTable.datagrid('getPager');	// get the pager of datagrid
		pager.pagination({
			buttons:[{
				iconCls:'icon-add',
				text:'新增',
				handler:function(){
					dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板  
					J_operSign.val('1');
						    
					var rowData = dataGridTable.datagrid('getSelected');
					initform(rowData);
				}
			},{
				iconCls:'icon-edit',
				text:'修改',
				handler:function(){
					var rowDatas = dataGridTable.datagrid('getSelections');
   					if(rowDatas.length!=1){
   						$.messager.alert("info","请选择一行后进行操作.");
   						return false;
   					}
   					dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板 
   					J_operSign.val('3');
   					var rowData = dataGridTable.datagrid('getSelected');
   					initform(rowData);
				}
			},{
				iconCls:'icon-remove',
				text:'删除',
				handler:function(){
					//dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板 
						    //添加删除逻辑
					J_operSign.val('2');
					var rowDatas = dataGridTable.datagrid('getSelections');
					
					if(rowDatas.length==0){
						$.messager.alert("info","请至少选择一行后进行操作.");
						return;
					}
					var ids;
					var primRows="";
					for(var i in rowDatas){
						//console.info(rowDatas[i]);
						primRows = rowDatas[i].channelId+","+rowDatas[i].begTime+","+rowDatas[i].endTime+"|"+primRows;
					}
					ids="ids="+primRows+"&operSign=2";
					//console.info(ids);
			    	$.ajax({ 
						type: "POST",
						data:ids,
						url:'<%=basePath%>/AvgParaConfirm.action', 
						dataType:"json",
						success: function(data){
						$.messager.alert("提示信息",data.obj);
						   searchFun();
						 
						   //清空预
						}
				    });
					//confirmClick();
				}
			}]
		});	
	}
		
	 /**function:  searchFun()
	    description:搜索功能
	    author:庞哲
	    Date:2013年6月27日 14:13:25
	 **/
	function searchFun() {
	    	var sysId=$("#J_sysName").val();
		dataGridTable.datagrid('load',{
		    channelId:sysId
		});	
		//J_sysName.val("");
	}

	function confirmClick() { 
		if(J_operSign.val() == 3){ 
			var rowDatas = dataGridTable.datagrid('getSelections');
			if(rowDatas.length!=1){
				$.messager.alert("info","请选择一行后进行操作.");
				return false;
			}
		}
		  var isValid = $("#J_edit_form").form('validate');
			if (!isValid){
				alert("输入信息不合法，请重新填写");
				return false;
		    }
	    //var formData=J_edit_form.serialize();
	    var bg = $("#l_begTime").timespinner('getValue').replace(":","").replace(":","");
	    var ed = $("#l_endTime").timespinner('getValue').replace(":","").replace(":","");
	    var formData = 	'operSign='+$("#J_operSign").val()+
	    				'&channelId='+$("#l_channelId").val()+
	    				'&channelDesc='+$("#l_channelId").find("option:selected").text()+
	    				'&begTime='+bg +
	    				'&endTime='+ed+
	    				'&para0='+$("#l_para0").val()+
	    				'&enable='+$("#l_enable").val();
	    if(J_operSign.val() == 3){ 
	    	var rowData = dataGridTable.datagrid('getSelections');
	    	formData = formData + '&preChannelId='+ rowData[0].channelId+
	    						  '&preBegTime=' + rowData[0].begTime +
	    						  '&preEndTime=' + rowData[0].endTime;
	    }
	   // alert(formData);
    	$.ajax({ 
			type: "POST",
			data:formData,
			url:'<%=basePath%>/AvgParaConfirm.action', 
			dataType:"json",
			success: function(data){
				  $.messager.alert("提示信息",data.obj);
			   searchFun();
			 
			   //清空预
			}
	    });
	    J_edit_form.form("clear");
	    dataGridTable.datagrid('getPanel').panel('expand');//扩张控制面板
	}
		
	function cancelClick() { 
		J_edit_form.form("clear");
		dataGridTable.datagrid('getPanel').panel('expand');//扩张控制面板
	}
    </script>
    
    <script type="text/javascript">
	function initform(rowData) { 
		$('#l_channelId').val(rowData.channelId);
		var bg = rowData.begTime;
		$('#l_begTime').val(bg.substring(0,2)+':'+bg.substring(2,4)+':'+bg.substring(4,6));
		var ed = rowData.endTime;
		$('#l_endTime').val(ed.substring(0,2)+':'+ed.substring(2,4)+':'+ed.substring(4,6));
		$('#l_para0').val(rowData.para0);
		$('#l_enable').val(rowData.enable);
		
	/*	var begTime = $('l_begTime');
		var endTime = $('l_endTime');
		var jbegTime=begTime.timespinner('getValue'); 
		var jendTime=endTime.timespinner('getValue');
	   	jbegTime=jbegTime.replace(":","").replace(":","");
	   	jendTime=J_endTime.timespinner('getValue'); 
	   	jendTime=jendTime.replace(":","").replace(":",""); */
	}
	
	function init(){
    	$('#J_sysName').empty();
    	$('#l_channelId').empty();
    	jQuery('#J_sysName').append("<option value=''>--请选择--</option>");
    	jQuery('#l_channelId').append("<option value=''>--请选择--</option>");
    	$('#l_begTime').timespinner('setValue', '00:00:00');  
		$('#l_endTime').timespinner('setValue', '23:59:59');
    	$.ajax({ 
			url:'<%=basePath%>/SysInfoQueryAll.action', 
			dataType:"json",
			success:function(data){
				for(var prop in data.obj){
					jQuery('#J_sysName').append("<option value="
							+data.obj[prop].sysId+">"
							+data.obj[prop].sysName+"</option>");
					jQuery('#l_channelId').append("<option value="
							+data.obj[prop].sysId+">"
							+data.obj[prop].sysName+"</option>");
				}
			}
	    });
    }
	    
	  
    </script>
    
  
</body>
</html>
