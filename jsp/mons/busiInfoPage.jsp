<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<head>
	<title>业务类型信息</title>
	<jsp:include page="inc.jsp"></jsp:include>
</head>
 
<body onload="init();">
<!-----------------------------表格----------------------------->
	<div style="width:96%;margin:10px auto;padding-right: 1px">
		<div id="dataGrid"  style="height:350px"  title="查询结果"> </div>
	</div>
	<div id="tb" style="padding:5px;height:auto;border:none;background:none;">
	<form id="form1">
		<table class="table_form2">
		        <!-- tr:代表HTML表格中的一行 -->
        		<!-- th:代表HTML表格中的表头 -->
        		<!-- td: 代表HTML表格中的一个单元格 -->
		<tr>			
			<th>交易类型：</th>			
			<td><input name="busiType" type="text" id="J_busiType"/></td>
			<th>交易类型描述：</th>
			<td><input name="busiDesc" type="text" id="J_busiDesc"/></td>
		</tr>
		<tr>
		    <th>系统编号：</th>
			<td><select name="sysName" id="J_sysName">
				<option value="0" selected="selected">--请选择--</option></select>
			</td>
			<th></th>
			<td colspan="2" style="right: 5px"><a href="#" class="form_button3" iconCls="icon-search" id="J_submit_search">查询</a></td>
		</tr>
	    </table> 
	    </form>
	</div> 
<!--------------------------录入--------------------------- --> 
    <table class="table_form_title">
		<tr>
			<td><p>录入</p></td>
		</tr>
	</table>
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
			<td><select name="operSign" class="easyui-validatebox" data-options="required:true" id="J_operSign">
				<option value="1">新增</option>
				<option value="3" selected="selected">修改</option>
				</select>
				<span style="color:#ff9900">*</span>
            </td>
            <th>&nbsp;</th>
            <td>&nbsp;</td>
		</tr>
		<tr>			
			<th>交易类型：</th>			
			<td><input name="busiType" type="text" id="l_busiType" class="easyui-validatebox" data-options="required:true" validType="ccbinsId" maxlength="6"/>
			<span style="color:#ff9900">*</span>
			</td>
			<th>交易类型描述：</th>
			<td><input name="busiDesc" type="text" id="l_busiDesc" class="easyui-validatebox" data-options="required:true" maxlength="32"/>
			<span style="color:#ff9900">*</span>
			</td>
		</tr>
		<tr>
		    <th>系统编号：</th>
			<td><select name="sysId" id="l_sysId" class="easyui-validatebox" data-options="required:true">
				<option value="0" selected="selected">--请选择--</option></select>
				<span style="color:#ff9900">*</span>
			</td>
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
		var J_busiType = $('#J_busiType');
        var J_busiDesc = $('#J_busiDesc');
        var J_sysName = $('#J_sysName');
		
	    
		/*table表单 */
		var dataGridTable;
		var J_operSign = $('#J_operSign');
        var J_edit_form =$('#J_edit_form');//录入表单 
        
        var J_submit_search = $('#J_submit_search');//查询按钮 
        var J_button_confirm = $('#J_button_confirm');//确定按钮
        var J_button_cancel = $('#J_button_cancel');//取消按钮 

	    
		/*表单操作*/
		$(function(){
			$('input[type=text]').validatebox();
			
			$.extend($.fn.validatebox.defaults.rules,{
		    	ccbinsId:{
					   validator:function(value){
						   return /^[0-9]{6}$/.test(value);
				   		},
				   	message:'必输项，请输入完整6位数字编号'
			 	  }
		    });
			
			J_submit_search.click(searchFun);//查询操作
	        
			J_button_confirm.click(confirmClick);//数据保存、修改
	        
			J_button_cancel.click( function () {//取消操作
				cancelClick();
			});
			
			dataGridInit();
			addDelete();
			
		});
	</script>   
     
	<!-- 表单操作 -->
	<script type="text/javascript">
	    //初始化表单数据 
	    function dataGridInit(){
	    	dataGridTable = $('#dataGrid').datagrid({//实例化table表单
				url:'<%=basePath%>/BusiInfoQuery.action',
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
				singleSelect:false,//只允许选择一行
				selectOnCheck:true,
				sortName:'busiType',//初始化时以那一列来排序
				sortOrder:'asc',//设置排序顺序asc或者desc（正序或者倒序）
				method:'post',
				columns:[[ //数据表格列配置对象
		            {field:'checkbox',checkbox:true}, 
					{field:'busiType',title:'交易类型',width:100,sortable: true}, 
					{field:'busiDesc',title:'交易类型描述',width:100},
					{field:'sysName',title:'系统名',width:100}
				    ]],  
				onDblClickRow:function(rowIndex,rowData){//当用户双击一行时触发
						dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板
		 				J_operSign.val('3');
		 				initform(rowData);
		 				$('#l_busiType').attr("readonly","readonly"); 
    					$('#l_sysId').attr("disabled","disabled"); 
		 			}   
			});
	    }
	</script>
	
    <script type="text/javascript">
        //查询操作
	    function searchFun(){
	    	var isValid = $("#form1").form('validate');
			if (!isValid){
				alert("输入信息不合法，请重新填写");
				return ;
		    }
			dataGridTable.datagrid('load',{
				busiType:J_busiType.val(),
				busiDesc:J_busiDesc.val(),
				sysName:J_sysName.val()
			});
			J_busiType.val('');
			J_busiDesc.val('');
			J_sysName.val('0');
	    }
        
        //新增、修改操作
        function confirmClick(){
        	$('#l_busiType').removeAttr("readonly");
        	$('#l_sysId').removeAttr("disabled");
        	
        	var busitype = $('#l_busiType').val();
        	var busidesc = $('#l_busiDesc').val();
        	var sysid = $('#l_sysId').val();
        	if(busitype == '' || busitype == null){
        		$.messager.alert("提示信息","请输入交易类型！");
        		return;
        	}
        	if(busidesc == '' || busidesc == null){
        		$.messager.alert("提示信息","请输入交易类型描述！");
        		return;
        	}
        	if(sysid == '0' || sysid == null){
        		$.messager.alert("提示信息","请选择系统编号！");
        		return;
        	}
        	var formData = J_edit_form.serialize();
        	$.ajax({ 
        		type: "POST",
    			data:formData,
    			url:'<%=basePath%>/BusiInfoConfirm.action', 
    			dataType:"json",
    			success: function(data){
    			   searchFun();
    			   $.messager.alert("提示信息",data.obj);
    			}
        	});
        	J_edit_form.form("clear");
    	    dataGridTable.datagrid('getPanel').panel('expand');//扩张控制面板
        }
        
        //取消操作
        function cancelClick(){
        	J_edit_form.form("clear");
    		dataGridTable.datagrid('getPanel').panel('expand');//扩张控制面板
    		$('#l_busiType').removeAttr("readonly");
        	$('#l_sysId').removeAttr("disabled");
        }
        
        //增、改、删
        function addDelete(){
    		var pager = dataGridTable.datagrid('getPager');
    		pager.pagination({
    			buttons:[{
    				iconCls:'icon-add',
    				text:'新增',
    				handler:function(){
    					dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板  
    					J_operSign.val('1');//add  
    					$('#l_sysId').val('0');
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
    					if(dataGridTable.datagrid('getSelections').length > 1){
    						$.messager.alert("info","请选择一行后进行操作.");
    						return;
    					}
    					dataGridTable.datagrid('getPanel').panel('collapse');//折叠控制面板 
    					J_operSign.val('3');//mod
    					initform(rowData);
    					$('#l_busiType').attr("readonly","readonly"); 
    					$('#l_sysId').attr("disabled","disabled"); 
    				}
    			},{
    				iconCls:'icon-remove',
    				text:'删除',
    				handler:function(){
    				    //添加删除逻辑
    					J_operSign.val('2');//delete
    					var rowDatas = dataGridTable.datagrid('getSelections');
    					if(rowDatas.length==0){
    						$.messager.alert("info","请至少选择一行后进行操作.");
    						return;
    					}
    					var ids;
    					var primRows="";
    					for(var i in rowDatas){
    						primRows = rowDatas[i].busiType+","+rowDatas[i].sysId+"|"+primRows;
    					}
    					ids="ids="+primRows+"&operSign=2";
    			    	$.ajax({ 
    						type: "POST",
    						data:ids,
    						url:'<%=basePath%>/BusiInfoConfirm.action', 
    						dataType:"json",
    						success: function(data){
    						   searchFun();
    						   $.messager.alert("提示信息",data.obj);
    						   //清空预
    						}
    				    });
    				}
    			}]
    		});	
    	}
    </script>


    <script type="text/javascript">
	    function init(){
	    	$('#J_sysName').empty();
	    	$('#l_sysId').empty();
	    	jQuery('#J_sysName').append("<option value='0'>--请选择--</option>");
	    	jQuery('#l_sysId').append("<option value='0'>--请选择--</option>");
	    	$.ajax({ 
				url:'<%=basePath%>/SysInfoQueryAll.action', 
				dataType:"json",
				success:function(data){
					for(var prop in data.obj){
						jQuery('#J_sysName').append("<option value="
								+data.obj[prop].sysName+">"
								+data.obj[prop].sysName+"</option>");
						jQuery('#l_sysId').append("<option value="
								+data.obj[prop].sysId+">"
								+data.obj[prop].sysName+"</option>");
					}
				}
		    });
	    }
        function initform(rowData){
        	$('#l_busiType').val(rowData.busiType);
    		$('#l_busiDesc').val(rowData.busiDesc);
    		$('#l_sysId').val(rowData.sysId);    
        }
        
    </script>
</body>
</html>