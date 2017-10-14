<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="com.adtec.framework.common.util.ParamUtil" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String webapp = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webapp;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<jsp:include page="inc.jsp"></jsp:include>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<!-- gridSter引入  -->
	<script  type="text/javascript" src="<%=basePath%>/js/gridster/dist/jquery.gridster.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/gridster/dist/jquery.gridster.css"/>
 	
	<style type="">
	.img_class{
	     width: 100%;
	     height: 100%;
	     border: 1px solid gray;
	     -moz-border-radius:10px;
	     -webkit-border-radius:10px;
	     -khtml-border-radius:10px;
	     border-radius:10px;
	}
	.table_class{
	}
	
	</style> 
</head>
 
<body class="easyui-layout">
	<div data-options="region:'west',split:true,border:false" style="width:120px;padding:10px;">
		<img class="img_class" src="49046.png" id="tabsExchangewest" width="50px" height="50px"/>
	</div>
	<div data-options="region:'east',split:true,border:false" style="width:120px;padding:10px;">
		<img class="img_class" src="49046.png" id="tabsExchange" width="50px" height="50px"/>
	</div>
	<div data-options="region:'south',border:false" style="height:40px;padding:10px;"></div>
	<div data-options="region:'center',border:false">
		<div id="index_tabs" style=""> 
		   <div class="gridster" title="adfadf">
		      <ul>
		        <li data-row="1" data-col="1" data-sizex="1" data-sizey="1"><img class="img_class" src="../../images/mons/3-1.jpg"/></li>
		        <li data-row="1" data-col="2" data-sizex="1" data-sizey="1"><img class="img_class" src="../../images/mons/3-1.jpg"/></li>
		        <li data-row="1" data-col="3" data-sizex="1" data-sizey="1"> <img class="img_class" src="../../images/mons/3-2.jpg"/></li>
		
		        <li data-row="2" data-col="1" data-sizex="1" data-sizey="1"><img class="img_class" src="../../images/mons/3-4.jpg"/></li>
		        <li data-row="2" data-col="2" data-sizex="1" data-sizey="1"><img class="img_class" src="../../images/mons/4-1.jpg"/></li>
		        <li data-row="2" data-col="3" data-sizex="1" data-sizey="1"> <img class="img_class" src=""/></li>
		        
		        <li data-row="3" data-col="1" data-sizex="1" data-sizey="1"><img class="img_class" src=""/></li>
		        <li data-row="3" data-col="2" data-sizex="1" data-sizey="1"><img class="img_class" src=""/></li>
		        <li data-row="3" data-col="3" data-sizex="1" data-sizey="1"> <img class="img_class" src=""/></li>	
		      </ul>
		   </div>
		   
		   <div class="gridster" title="cccd">
		      <ul>
		        <li data-row="1" data-col="1" data-sizex="1" data-sizey="1"></li>
		        <li data-row="1" data-col="1" data-sizex="1" data-sizey="1"></li>
		        <li data-row="1" data-col="1" data-sizex="1" data-sizey="1"></li>
		        <li data-row="1" data-col="1" data-sizex="1" data-sizey="1"><img class="img_class" src=""/></li>	
		      </ul>
		   </div>
		   
		</div>

	</div>
	<script type="text/javascript">
	
		$(function(){
			var tabsExchange = $('#tabsExchange');
			tabsExchange.click(tabsExchangeClick);
			
			var tabsExchangewest = $('#tabsExchangewest');
			tabsExchangewest.click(tabsExchangewestClick);

		 /*   index_tabs = $('#index_tabs').tabs({
				fit : true,
				border : false,
				onSelect:function(title){   
				        var J_sysListObj=$('#J_sysList');
				        J_sysListObj.find('li').removeClass('aselected');
				        J_sysListObj.find('li[param="'+title+'"]').addClass('aselected'); 
				 }
			}); */
		});
		
		function tabsExchangewestClick(){
			var tab = $('#index_tabs').tabs('getSelected');
			var index  = $('#index_tabs').tabs('getTabIndex',tab);
			$('#index_tabs').tabs('select',index-1);
		}
		
		function tabsExchangeClick(){
			var tab = $('#index_tabs').tabs('getSelected');
			var index  = $('#index_tabs').tabs('getTabIndex',tab);
			$('#index_tabs').tabs('select',index+1);
		}
	
		$(".gridster ul").gridster({
			 widget_margins: [20, 20],
			 extra_rows: 6,
			 extra_cols: 6,
			 min_cols: 2,
			 min_rows: 2,
			 max_cols: 5,
			 max_size_x: false,
			 autogenerate_stylesheet: true,
			 avoid_overlapped_widgets: false,
			 widget_base_dimensions: [230, 125]
		});
	   var gridster = $(".gridster ul").gridster().data('gridster');
	   //gridster.disable();
	   
	/*
	这里是通过创建的属性来设定每一个区域的大小及定位,所涉及的属性如下：
	data-row:数据行，元素所存在的行数。
	data-col:数据列，元素所存在的列数。
	data-sizex:元素块的宽（以个为单位，每个元素块的宽度为widget_base_dimensions所设定的值）
	data-sizey:元素块的高（以个为单位，每个元素块的高度为widget_base_dimensions所设定的值）
	例：widget_base_dimensions: [150, 150]
	那么每个元素块的宽/高分别为150px/150px
	注：元素块合并时的宽度并不只是两个元素块之和
	即宽度={data-sizex=”2″}=元素块X2+右侧的边距==150*2+4=304px
	高度={data-sizey=”1″}=元素块X1==150*1=150px
	
	这里我们只需要设定两个数值，宽高/边距；如
	widget_margins:
	设置网格之间的外边距；所传的数值是实际像素的2倍，如[2,2]==[4px,4px]=[右边距，下边距]。
	widget_base_dimensions:
	设置网格的宽高；所传的数值=实际像素，如[150,150]==[150px,150px]=[width,height]。
	*/
	</script>
	
</body>
</html>
