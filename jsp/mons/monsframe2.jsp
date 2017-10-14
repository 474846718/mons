<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page isELIgnored="false"%> 
<html xmlns="http://www.w3.org/1999/xhtml">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!-- http://12.0.100.116:8080/mons/jsp/mons/uckframe.jsp -->
<head>
<title>监控平台系统</title>
<jsp:include page="inc.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="<%=basePath %>/js/menuTree.js" type="text/javascript"></script>
<script src="<%=basePath %>/js/firebugx.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/default/easyui.css" />
<style type="">


</style> 
 
</head>

<body>
<div id="wrap" class="easyui-layout" fit="true" style="height:100%;">
	<div data-options="region:'north'"  title="north" style="height:80px;background:url(images/20140728-1.jpg) left bottom repeat-x;">
	<div class="north_logo"></div>
	<div class="north_sys"><a href="#"  class="north_exit"></a><a href="<%=basePath %>/jsp/mons/monsframe.jsp" title="返回首页" class="north_home"></a></div>
	</div>
    <div data-options="region:'west'" title="west" style="width:220px; background:#272727;"> 
		<div id="menu_mons" style="z-index: 99999; position: absolute;" >
			<div class="favMenu" id="aMenu2">  
			</div>					  
		</div>
    </div>
    
    <div data-options="region:'center',fit:false,border:false"  >
		<div id="index_tabs" style="overflow: hidden;">			  		   
		</div>  
    </div>
    
	<div id="tab-tools" style="right: 20px; height: 25px;">
		<a href="javascript:void(0)" class="easyui-menubutton" menu="#mm" data-options="plain:true,iconCls:'icon-add'" onclick="addPanel()"></a>
	</div>
	
    <div id="mm" class="easyui-menu" style="width:150px;"  data-options="onClick:menuHandler">
		<div data-options="name:'delete_current'"  iconCls="icon-undo">关闭当前页</div>
		<div data-options="name:'delete_other'"  iconCls="icon-redo">关闭其它页</div>
		<div data-options="name:'delete_all'" > 关闭所有页</div>
		<div class="menu-sep"></div>
	</div>
</div>

<script type="text/javascript" >

	var index_layout;
	var index_tabs;
	$(document).ready(function(){
		initMenu();
		
		//index_layout初始化
		index_layout = $('#index_layout').layout({
			fit : true
		});
		index_layout.layout('resize');
		
		  //tab页面初始化
        index_tabs = $('#index_tabs').tabs({
			fit : true,
			border : false,
			tools:'#tab-tools',
			onAdd:function(title,index){
				$('#mm').menu('appendItem', {
					name: title,
					text: title,
					onclick: function(){
						$('#index_tabs').tabs('select',title);
					}
				});
			},
			onClose:function(title,index){
				var item = $('#mm').menu('findItem', title);
				$('#mm').menu('removeItem', item.target);
			}
		}); 
	});

   //事件绑定
	function aClassClick(){ 
		$(".J_aClass").click(function(){
        	var _aObj=$(this).find("a");
        	var _title=_aObj.text();
        	var _url=_aObj.attr("rel");

        //	console.info(_title);
        //	console.info(_url);
        	
        	addTab({
				url : _url,
				title : _title
			});
		});
	}
     /**
      * package:/layout/west.jsp
      *function: addTab
      *params: params:参数
      *description:  点击树节点菜单生成tab页
      *author:tianbin 
      *Date:2013年07月16日 09:38:25
     **/ 
     function addTab(params){
    	  var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:100%;"></iframe>';
		  var t = $('#index_tabs');
          var opts={
             title:params.title,   
             content:iframe,   
             closable:true,
             iconCls : params.iconCls,
             fit:true 
          };
	        if (t.tabs('exists', opts.title)) {
				t.tabs('select', opts.title);
				parent.$.messager.progress('close');
			} else {
				t.tabs('add', opts);
			}
      }	
	
     function menuHandler(item){
      	var name = item.name;
      	if(name == 'delete_current'){
     			var tab = $('#index_tabs').tabs('getSelected');
   			if (tab){
   				var index = $('#index_tabs').tabs('getTabIndex', tab);
   				$('#index_tabs').tabs('close', index);
   			}
      	 }else if(name =='delete_other'){
      		delother();
      	 }else if(name == 'delete_all'){
      	 	delall();
      	 }
  	 }
       
       function delother(){
      	 var tabSel = index_tabs.tabs('getSelected');
      	 var indexSel = index_tabs.tabs('getTabIndex', tabSel);
      	 
      	 var tabs = index_tabs.tabs('tabs');
      	 var len = tabs.length;
      	 for(var i=len-1;i>=0;i--){
      		if(i!=indexSel){
  			 	index_tabs.tabs('close', i);
      		} 
   		 }
       }
       /*
       function delother(){
      	 var tabs = $('#index_tabs').tabs('tabs');
      	 var len = tabs.length;
      	 //var tabSel = $('#index_tabs').tabs('getSelected');
      	 //var indexSel = $('#index_tabs').tabs('getTabIndex', tabSel);
      	 for(var i=0;i<len;i++){
  				var index = $('#index_tabs').tabs('getTabIndex', tabs[i]);
  				if(tabSel&&indexSel!=index){
  					$('#index_tabs').tabs('close', index);
  				}
   		 }
      	 var len = tabs.length;
      	 if(tabSel){
          	 if(len!=1){
          		 delall();
          	 }
      	 }else{
          	 if(len!=0){
          		 delall();
          	 }
      	 }

       }
       */
       function delall(){
      	 var tabs = index_tabs.tabs('tabs');
      	 var len = tabs.length;
      	 for(var i=len-1;i>=0;i--){
  				index_tabs.tabs('close', i);
   		 }
       }
       
</script>

<script type="text/javascript" >
    /* 按照数据库数据生成菜单 */
   	function initMenu(){ 
		var divstr="";
		$.ajax({ 
			type: "POST",
			url:'<%=basePath%>/SysInfoInit.action', 
			dataType:"json",
			success: function(data){
				var dataObj=data.obj;
				SysdataObj=dataObj;
				var len=dataObj.length;
				if(len>0){
				  /*  
				  <div class="subFolder" OnClick="MenuImageOnClickEvent(this,'V','subFolder','folder');"><a>分行前置</a></div>
					<div class="sub" >
						<div class="subItem J_aClass" ><a href="javascript:void(0);" rel="jsp/mons/systemPage.jsp?sysID=000003&sysName=分行前置">分行前置-首页</a></div>
						<div class="subItem J_aClass" ><a href="javascript:void(0);" rel="jsp/mons/ChannelPage.jsp?sysID=000003&sysName=分行前置">分行前置-实时交易监控</a></div>
						<div class="subItem J_aClass" ><a href="javascript:void(0);" rel="jsp/mons/StatisPage.jsp?sysID=000003&sysName=分行前置">分行前置-实时交易统计</a></div>
						<div class="subItem J_aClass" ><a href="javascript:void(0);" rel="jsp/mons/SearchPage.jsp?sysID=000003&sysName=分行前置">分行前置-历史交易查询</a></div>
					</div>
				*/	
					/*  for(var i=0;i<len;i++){
						  divstr+="<div class=\"topFolder\" OnClick=\"MenuImageOnClickEvent(this,'V','subFolder','top');\"><a class='m2'>"+dataObj[i].sysName+"</a></div>";
						  divstr+="<div class=\"sub\" >";
						  divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"jsp/mons/systemPage.jsp?sysID="+dataObj[i].sysId+"&sysName="+dataObj[i].sysName+"\">"+dataObj[i].sysName+"-首页</a></div>";
						  divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"jsp/mons/ChannelPage.jsp?sysID="+dataObj[i].sysId+"&sysName="+dataObj[i].sysName+"\">"+dataObj[i].sysName+"-实时交易监控</a></div>";
						  divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"jsp/mons/StatisPage.jsp?sysID="+dataObj[i].sysId+"&sysName="+dataObj[i].sysName+"\">"+dataObj[i].sysName+"-实时交易统计</a></div>";
						  divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"jsp/mons/SearchPage.jsp?sysID="+dataObj[i].sysId+"&sysName="+dataObj[i].sysName+"\">"+dataObj[i].sysName+"-历史交易查询</a></div>";
						  divstr+="</div>";
			 		  }
				*/
					
					divstr+="<div class=\"topFolder J_aClass\" ><a href=\"javascript:void(0);\" class=\"m2\" rel=\"<%=basePath %>/jsp/mons/ReportPage.jsp\">监控报表</a></div>";
					
					divstr+="<div class=\"topFolder\" OnClick=\"MenuImageOnClickEvent(this,'V','subFolder','top');\"><a class='m2'>参数管理</a></div>";
					divstr+="<div class=\"sub\" >";
					divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"<%=basePath %>/jsp/mons/sysInfoPage.jsp\">系统信息维护</a></div>";
					divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"<%=basePath %>/jsp/mons/channelInfoPage.jsp\">渠道信息维护</a></div>";
					divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"<%=basePath %>/jsp/mons/busiInfoPage.jsp\">业务类型信息维护</a></div>";
					divstr+="<div class=\"subFolder J_aClass\" ><a href=\"javascript:void(0);\" rel=\"<%=basePath %>/jsp/mons/trancodeInfoPage.jsp?\">交易码信息维护</a></div>";
					
					divstr+="</div>";
					
					
					$('#aMenu2').html(divstr);
				}
				
				aClassClick();
			},
			error: function(XMLHttpRequest,textStatus,errorThown){
				alert(XMLHttpRequest.Status);
				alert(XMLHttpRequest.readyState);
				alert(XMLHttpRequest.textStatus);
			}
		});
	}
</script>


</body>
</html>
