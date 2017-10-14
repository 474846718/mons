<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%
String webapp = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+webapp;
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
        <title>登录</title>
        <script type="text/javascript" src="<%=basePath%>/jslib/jquery-1.8.3.js" charset="utf-8"> </script>
        <script type="text/javascript" src="<%=basePath%>/jslib/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="<%=basePath%>/jslib/easyUI_validate.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/default/easyui.css" />
		<link rel="stylesheet" type="text/css" href="<%=basePath%>/jslib/jquery-easyui-1.3.3/themes/icon.css" />
        <link rel="stylesheet" href="<%=basePath%>/css/login_new.css" type="text/css" />
		<link rel="stylesheet" href="<%=basePath%>/css/keyboard.css" type="text/css"  />
		<script src="<%=basePath%>/js/login.js" type="text/javascript"></script>
        <script src="<%=basePath%>/js/keyboard.js" type="text/javascript"></script>
    </head>
<script type="text/javascript">

</script>
<body class="login_bg">
	<form id="J_edit_form_1">
		<!--1-->
		<table id="login_form_box1" class="login_form_box1" style="display:none;">
		  <tr>
		    <td class="login_form_box_td1_1"></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td2">
			<div class="form_error"></div>
			<table class="login_form">
		      <tr>
		        <td>原密码</td>
		        <td><input name="usrPwd" type="password" id="password"  class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>新密码</td>
		        <td><input name="newUsrPwdOne" type="password" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>新密码确认</td>
		        <td><input name="newUsrPwdTwo" type="password" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题1</td>
		        <td><input name="issueOne" type="text" class="text1" size="30" /></td>
			  </tr>
			  <tr>
		        <td>问题答案1</td>
		        <td><input name="answerOne" type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题2</td>
		        <td><input name="issueTwo" type="text" class="text1" size="30" /></td>
			  </tr>
			  <tr>
		        <td>问题答案2</td>
		        <td><input name="answerTwo" type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题3</td>
		        <td><input name="issueThree" type="text" class="text1" size="30" /></td>
			  </tr>
			  <tr>
		        <td>问题答案3</td>
		        <td><input name="answerThree" type="text" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><input id="J_button_1_confirm" type="button" name="Submit" value="确认" class="button1" />
		            <input id="J_button_1_cancel" type="button" name="Submit2" value="取消" class="button2" /></td>
		      </tr>
		    </table></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td3"></td>
		  </tr>
		</table>
	</form>	
		<!--2-->
	<form id="J_edit_form_2" method="post" action="Login_login.action">	
		<table id="login_form_box2" class="login_form_box2" style="display:;">
		  <tr>
		    <td class="login_form_box_td1_2"></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td2">
			<div class="form_error"></div>
			<table class="login_form">
		      <tr>
		        <td>用户名</td>
		        <td><input id="J_2_ccbEmpid" name="ccbEmpid" type="text" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>密码</td>
		        <td><input name="usrPwd" type="password" class="text1" size="30" /></td>
		      </tr>
			  
		      <tr>
		        <td>&nbsp;</td>
		        <td><input id="J_2_button_login" type="submit" name="Submit" value="登 录" class="button3" /></td>
		      </tr>
			  <tr>
		        <td>&nbsp;</td>
		        <td><a id="J_2_button_xgkl" href="#" class="a1">修改口令</a> <a id="J_2_button_mmzh" href="#" class="a2">密码找回</a></td>
		      </tr>
		    </table></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td3"></td>
		  </tr>
		</table>
	</form>		
	<form id="J_edit_form_3">	
		<!--3-->
		<table id="login_form_box3" class="login_form_box3" style="display:none;">
		  <tr>
		    <td class="login_form_box_td1_3"></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td2">
			<div class="form_error"></div>
			<table class="login_form"> 
			  <tr>
		        <td>用户名</td>
		        <td><input name="ccbEmpid" type="text" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>原密码</td>
		        <td><input name="usrPwd"  type="password" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>新密码</td>
		        <td><input name="newUsrPwdOne" type="password" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>新密码确认</td>
		        <td><input name="newUsrPwdTwo" type="password" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><input id="J_button_3_confirm" type="button" name="Submit" value="确定" class="button1" />
		            <input id="J_button_3_cancel" type="button" name="Submit2" value="取消" class="button2" /></td>
		      </tr>
		    </table></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td3"></td>
		  </tr>
		</table>
	</form>		
	<form id="J_edit_form_4">	
		<!--4-->
		<table id="login_form_box4" class="login_form_box4" style="display:none;">
		  <tr>
		    <td class="login_form_box_td1_4"></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td2">
			<div class="form_error"></div>
			<table class="login_form">
			  <tr>
		        <td>用户名</td>
		        <td><input name="ccbEmpid" type="text" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>安全问题1</td>
		        <td><input name="issueOne" type="text" class="text1" size="30" value="安全问题1" /></td>
			  </tr>
			  <tr>
		        <td>问题答案1</td>
		        <td><input name="answerOne"  type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题2</td>
		        <td><input name="issueTwo" type="text" class="text1" size="30" value="安全问题2" /></td>
			  </tr>
			  <tr>
		        <td>问题答案2</td>
		        <td><input name="answerTwo" type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题3</td>
		        <td><input name="issueThree" type="text" class="text1" size="30" value="安全问题3" /></td>
			  </tr>
			  <tr>
		        <td>问题答案3</td>
		        <td><input name="answerThree" type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>新密码</td>
		        <td><input name="newUsrPwdOne" type="password" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>新密码确认</td>
		        <td><input name="newUsrPwdTwo" type="password" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><input id="J_button_4_confirm" type="button" name="Submit" value="确定" class="button1" />
		            <input id="J_button_4_cancel" type="button" name="Submit2" value="取消" class="button2" /></td>
		      </tr>
		    </table></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td3"></td>
		  </tr>
		</table>
	</form>
	
	<form id="J_edit_form_5">
		<!--1-->
		<table id="login_form_box5" class="login_form_box1" style="display:none;">
		  <tr>
		    <td class="login_form_box_td1_1"></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td2">
			<div class="form_error"></div>
			<table class="login_form">
			  <tr>
		        <td>安全问题1</td>
		        <td><input name="issueOne" type="text" class="text1" size="30" /></td>
			  </tr>
			  <tr>
		        <td>问题答案1</td>
		        <td><input name="answerOne" type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题2</td>
		        <td><input name="issueTwo" type="text" class="text1" size="30" /></td>
			  </tr>
			  <tr>
		        <td>问题答案2</td>
		        <td><input name="answerTwo" type="text" class="text1" size="30" /></td>
		      </tr>
			  <tr>
		        <td>安全问题3</td>
		        <td><input name="issueThree" type="text" class="text1" size="30" /></td>
			  </tr>
			  <tr>
		        <td>问题答案3</td>
		        <td><input name="answerThree" type="text" class="text1" size="30" /></td>
		      </tr>
		      <tr>
		        <td>&nbsp;</td>
		        <td><input id="J_button_5_confirm" type="button" name="Submit" value="确认" class="button1" />
		            <input id="J_button_5_cancel" type="button" name="Submit2" value="取消" class="button2" /></td>
		      </tr>
		    </table></td>
		  </tr>
		  <tr>
		    <td class="login_form_box_td3"></td>
		  </tr>
		</table>
	</form>	
	
	<script type="text/javascript" >
		var J_edit_form_1 =$('#J_edit_form_1');
		var J_edit_form_2 =$('#J_edit_form_2');
		var J_edit_form_3 =$('#J_edit_form_3');
		var J_edit_form_4 =$('#J_edit_form_4');
		var J_edit_form_5 =$('#J_edit_form_5');
		
		var J_2_button_login = $('#J_2_button_login');
		var J_2_button_xgkl = $('#J_2_button_xgkl');
		var J_2_button_mmzh = $('#J_2_button_mmzh');
		
		var J_2_ccbEmpid =$('#J_2_ccbEmpid');
		
		var login_form_box1 =$('#login_form_box1');
		var login_form_box2 =$('#login_form_box2');
		var login_form_box3 =$('#login_form_box3');
		var login_form_box4 =$('#login_form_box4');
		var login_form_box5 =$('#login_form_box5');
		
		var J_button_1_confirm=$('#J_button_1_confirm');
		var J_button_1_cancel=$('#J_button_1_cancel');
		
		var J_button_5_confirm=$('#J_button_5_confirm');
		var J_button_5_cancel=$('#J_button_5_cancel');
		
		var J_button_3_confirm=$('#J_button_3_confirm');
		var J_button_3_cancel=$('#J_button_3_cancel');
		
		var J_button_4_confirm=$('#J_button_4_confirm');
		var J_button_4_cancel=$('#J_button_4_cancel');
		
		$(function(){
			var message = '${param.message}';
			if(message=='1060'){//用户是否存在
				$.messager.alert("提示信息","用户不存在!");
			}else if(message=='1100'){//密码是否正确
				$.messager.alert("提示信息","密码有误!");
			}else if(message=='1351'){//是否初始密码
				login_form_box2.attr({style:"display:none;"});
				login_form_box1.removeAttr("style");
			}else if(message=='1350'){//重复登录
				$.messager.alert("提示信息","该客户已登录!");
			}else if(message=='1349'){//uass cs登陆 成功 在北京分行还没有记录口令找回问题
				login_form_box2.attr({style:"display:none;"});
				login_form_box5.removeAttr("style");
			}else if(message=='1100'){//密码错误
				$.messager.alert("提示信息","密码有误!");
			}else if(message=='1352'){//密码错误
				$.messager.alert("提示信息","用户待激活!");
			}else if(message =='1353'){//用户密码过期，需要重新设置密码
				$.messager.alert("提示信息","用户密码过期!");
			    //TODO
				login_form_box2.attr({style:"display:none;"});
				login_form_box3.removeAttr("style");
			}else if(message=='1061'){//用户锁定
				$.messager.alert("提示信息","用户锁定!");
			}else if(message=='1062'){//用户已注销
				$.messager.alert("提示信息","用户已注销!");
			}else if(message=='1065'){//用户未生效
				$.messager.alert("提示信息","用户未生效!");
			}else if(message=='1066'){//用户已失效
				$.messager.alert("提示信息","用户已失效!");
			}else if(message=='1068'){//用户状态错
				$.messager.alert("提示信息","用户状态错!");
			}else if(message =='1354'){
				$.messager.alert("提示信息","用户重名!");
			}
			
			
		    J_2_button_xgkl.click(xgkl);
		    J_2_button_mmzh.click(mmzh);//密码找回
		    J_button_1_confirm.click(loginOneConfirm);
		    J_button_1_cancel.click(ddcdlqx);
		    
		    J_button_5_confirm.click(question);
		    
		    J_button_3_confirm.click(xgmm);//修改密码
		    J_button_3_cancel.click(xgmmqx);
		    
		    J_button_4_confirm.click(mmzhqd);//密码找回确定
		    J_button_4_cancel.click(mmzhqx);
		    

		});
		
		
		function init(){ 
			var formData=J_edit_form_2.serialize();
			console.info(formData);
			$.ajax({ 
				type: "POST",
				data:formData,
				url:'<%=basePath%>/Login_init.action', 
				dataType:"json",
				success: function(data){
					console.info(data);
				}
		    });
		}
		
		function xgkl(){ 
			login_form_box2.attr({style:"display:none;"});
			login_form_box3.removeAttr("style");
		}
		
		function mmzh(){ 
			login_form_box2.attr({style:"display:none;"});
			login_form_box4.removeAttr("style");
		}
		
		function mmzhqd(){ 
			var formData=J_edit_form_4.serialize();
			console.info(formData);
			
			$.ajax({
				type: "POST",
				data:formData,
				url:'<%=basePath%>/Login_mmzhqd.action',
				dataType:"json",
				success: function(data){
					console.info(data);
					var mes = data.obj;
					if(mes=='OK'){
						$.messager.alert("提示信息","密码更新成功!");
						login_form_box1.attr({style:"display:none;"});
						login_form_box2.removeAttr("style");
					}else{
						$.messager.alert("提示信息",mes);
					}
				}
		    });
			
		}
		
		function mmzhqx(){ 
			login_form_box4.attr({style:"display:none;"});
			login_form_box2.removeAttr("style");
		}
		
		function question(){ 
			var formData=J_edit_form_5.serialize();
			console.info(formData);
			$.ajax({ 
				type: "POST",
				data:formData,
				url:'<%=basePath%>/Login_question.action',
				dataType:"json",
				success: function(data){
					console.info(data);
					var mes = data.obj;
					if(mes=='OK'){
						$.messager.alert("提示信息","信息设置成功!");
						login_form_box5.attr({style:"display:none;"});
						login_form_box2.removeAttr("style");
					}else{
						$.messager.alert("提示信息",mes);
					}
				}
		    });
		}
		
		function loginOneConfirm(){ 
			var formData=J_edit_form_1.serialize();
			console.info(formData);
			$.ajax({ 
				type: "POST",
				data:formData,
				url:'<%=basePath%>/Login_loginOneConfirm.action',
				dataType:"json",
				success: function(data){
					console.info(data);
					var mes = data.obj;
					if(mes=='OK'){
						$.messager.alert("提示信息","密码更新成功!");
						login_form_box1.attr({style:"display:none;"});
						login_form_box2.removeAttr("style");
					}else{
						$.messager.alert("提示信息",mes);
					}
				}
		    });
		}
		
		function xgmm(){ 
			var formData=J_edit_form_3.serialize();
			console.info(formData);
			
			$.ajax({
				type: "POST",
				data:formData,
				url:'<%=basePath%>/Login_xgmm.action',
				dataType:"json",
				success: function(data){
					console.info(data);
					var mes = data.obj;
					if(mes=='OK'){
						$.messager.alert("提示信息","密码更新成功!");
						login_form_box1.attr({style:"display:none;"});
						login_form_box2.removeAttr("style");
					}else{
						$.messager.alert("提示信息",mes);
					}
				}
		    });
		}
		
		function xgmmqx(){ 
			login_form_box3.attr({style:"display:none;"});
			login_form_box2.removeAttr("style");
		}
		//第一次登录取消按钮
		function ddcdlqx(){ 
			login_form_box1.attr({style:"display:none;"});
			login_form_box2.removeAttr("style");
		}
		
		
		
		
		
	</script>
</body>
</html>
