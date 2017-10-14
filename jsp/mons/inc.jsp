<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()+ path;
%>
<!-- jQuery引入 -->
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-1.8.3.js" charset="utf-8"> </script>
<!-- easyUI引入 -->
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/jslib/easyUI_validate.js"></script>
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/icon.css" />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/index2.css"  />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/form.css"  />
<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/default/easyui.css" />
<script type="text/javascript" src="<%=basePath %>/js/ztree/jquery.ztree.all-3.5.min.js" ></script>
<link rel="stylesheet" type="text/css" href="<%=basePath %>/css/ztree/zTreeStyle/zTreeStyle.css"/>
<script src="<%=basePath%>/js/backspace.js" type="text/javascript"></script>

<!--  
black||bootstrap||cupertino||dark-hive||default||gray||icons||metro||metro-orange||sunny||frame
-->
