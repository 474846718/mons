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
	<title>应用系统信息维护</title>
	<jsp:include page="inc.jsp"></jsp:include>
</head>
 
<body>
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
			<th>系统编码：</th>
			<td><input name="sysId" type="text" id="J_sysId"/></td>
			<th>系统名：</th>
			<td><input name="sysName" type="text" id="J_sysName"/></td>			
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
				<!-- <option value="2">删除</option> -->
				<option value="3" selected="selected">修改</option>
				</select>
				<span style="color:#ff9900">*</span>
            </td>
            <th>&nbsp;</th>
            <td>&nbsp;</td>
		</tr>
		<tr>
			<th>系统编号：</th>
			<td><input name="sysId" type="text" id="l_sysId"  class="easyui-validatebox" data-options="required:true" validType="ccbinsId" maxlength="6"/>
				<span style="color:#ff9900">*</span>
            </td>
            <th>系统名：</th>
            <td><input name="sysName" type="text" id="l_sysName"  class="easyui-validatebox" data-options="required:true" validType="ccbinsId" maxlength="32"/>
				<span style="color:#ff9900">*</span></td>
</tr>
	   		<tr>
			<th>是否监控系统状态：</th>
			<td><select name="monsSysFlag" id="l_monsSysFlag">
				<option value="">--请选择--</option>
				<option value="1">监控</option>
				<option value="2">不监控</option>
				</select>
            </td>
            <th>响应超时时间(分钟)：</th>
            <td><input name="monsSysCycle" type="text" id="l_monsSysCycle" maxlength="4"/></td>
</tr>
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
		var l_sysId=$('#l_sysId');
		var l_sysName=$('#l_sysName'); 
	    
		/*table表单 */
		var dataGridTable;
        var J_edit_form =$('#J_edit_form');
        var J_operSign =$('#J_operSign');
        
        var J_sysName = $('#J_sysName');
        var J_sysId = $('#J_sysId');
        var J_submit_search = $('#J_submit_search');
        var J_button_cancel = $('#J_button_cancel');
        var J_button_confirm = $('#J_button_confirm');
        var J_button_submit = $('#J_button_submit');//提交
		/*查询表单*/
		var J_submit_search = $('#J_submit_search');
		        
		$(function(){
			
			$('input[type=text]').validatebox();
			//J_edit_form.form("clear");
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
			url:'<%=basePath%>/SysInfoQuery.action',
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
			sortName:'sysId',//初始化时以那一列来排序
			sortOrder:'asc',//设置排序顺序asc或者desc（正序或者倒序）
			method:'post',
			columns:[[ //数据表格列配置对象
	            {field:'checkbox',checkbox:true}, 
				{field:'sysId',title:'系统编号',width:250,sortable: true}, 
				{field:'sysName',title:'系统名',width:250},
				{field:'monsSysFlag',title:'是否监控系统状态',width:250,
					formatter : function(value){
					if(value == "1"){
						return "监控";
					}else if(value == "2"){
						return "不监控";
					}else{
						return value;
					}
				}},
				{field:'monsSysCycle',title:'响应超时时间(分钟)',width:250}
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
					var rowData = dataGridTable.datagrid('getSelected');
					if(rowData==null){
						$.messager.alert("info","请选择一行后进行操作.");
						return;
					}
					dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板 
					J_operSign.val('3');
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
						primRows = rowDatas[i].sysId+",";
					}
					ids="ids="+primRows+"&operSign=2";
					//console.info(ids);
			    	$.ajax({ 
						type: "POST",
						data:ids,
						url:'<%=basePath%>/SysInfoConfirm.action', 
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
		dataGridTable.datagrid('load',{
			sysName:J_sysName.val(),
		    sysId:J_sysId.val()
		});
		J_sysName.val("");
		J_sysId.val("");
	}

	function confirmClick() { 
		  var isValid = $("#J_edit_form").form('validate');
			if (!isValid){
				alert("输入信息不合法，请重新填写");
				return false;
		    }
	    var formData=J_edit_form.serialize();
			//console.info(formData);	
    	$.ajax({ 
			type: "POST",
			data:formData,
			url:'<%=basePath%>/SysInfoConfirm.action', 
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

		$('#l_sysName').val(rowData.sysName);
		$('#l_sysId').val(rowData.sysId);
		$('#l_monsSysFlag').val(rowData.monsSysFlag);
		$('#l_monsSysCycle').val(rowData.monsSysCycle);
	}
	
    </script>
</body>
</html>
