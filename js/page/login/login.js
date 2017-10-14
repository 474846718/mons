
 
/**
  *package: js/page/login.js
  *function:  
  *params:  
  *description:   tab切换功能,和后台交互
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 

;(function($) {  
    $.fn.extend({ 
        "tab" : function(options) {
            //设置默认值
            option = $.extend({
                selectClass : "select", //选中的样式 
                isOpen:'true' ,           //是否开启tab功能
                selectIndex:'' ,          //根据索引控制tab切换
                IsVerifyCode:''           //是否需要验证码,  1：是 0：否
            }, options);
           
		   if(option.isOpen){
		   	    //寻找table下的a元素
           var _childA=$(this).find("tbody > tr >td  a.J_aClass");  //可以点击的tab
           var _childB=$(this).find("tbody > tr >td  a"); 
		   var _childC=$(this).find("tbody > tr >td  a.select");
	       var _childCIdnex=_childC.index();  
           var _form=$(this).find("tbody > tr >td").children("form"); 
			_childA.live("click",function(){
				 $(this).addClass(option.selectClass).siblings().removeClass(option.selectClass);   
                 _form.eq($(this).index()).show().siblings().hide();
			}) 
		 //去除两个数组中的重复项
		 function cutRepeat(arry1,arry2){
		 	var tempArray1 = []; //临时数组1   
            var tempArray2 = []; //临时数组2  
             for (var i = 0; i < arry2.length; i++) {    
                      tempArray1[arry2[i]] = true;//巧妙地方：把数组B的值当成临时数组1的键并赋值为真    
              }; 
			 for (var i = 0; i < arry1.length; i++) {   
                if (!tempArray1[arry1[i]]) {   
                     tempArray2.push(arry1[i]);//巧妙地方：同时把数组A的值当成临时数组1的键并判断是否为真，如果不为真说明没重复，就合并到一个新数组里，这样就可以得到一个全新并无重复的数组  
               } ;    
           };   
		   return tempArray2;
	   }
	 
			 
		   //根据索引进行控制tab的功能
		   if(option.selectIndex!=null && option.selectIndex.length>0){ 
		        if(option.selectIndex.indexOf(",")>0){
					//判断是否为多种签证方式
					$(option.selectIndex.split(",")).each(function(i,value){ 
						//因为默认为密码登录,当输入完用户名之后如果改用户没有密码登录的签证方式，则默认使用数据库存储的第一个签证方式 
						if(option.selectIndex.indexOf("1")>-1  ){  //如果存在密码登录的话     
						         if(option.selectIndex.indexOf(_childCIdnex+1)>-1){  //如果签证方式中含有当前登录的方式  (在有三种签证登录的用户，登录人只有两种登录的)			                 
									if(_childA.length>2 && option.selectIndex.split(",").length<3){   
										 _childB.eq(cutRepeat("1,2,3",option.selectIndex)-1).removeClass("J_aClass");  //移除当前签证方式的tab
									}else{
										if( _childB.eq(value-1).hasClass("J_aClass")){ 
                                        }else{  
										_childB.eq(value-1).addClass("J_aClass");
										} 
									} 
								 }else{  //如果签证方式中没有当前登录的方式  
								 	_childB.eq(_childCIdnex).removeClass("select").removeClass("J_aClass");  //移除当前签证方式的tab  
								 	_form.eq(_childCIdnex).hide();  //移除密码登录的form
									_childB.eq(option.selectIndex.split(",")[0]-1).addClass("select").addClass("J_aClass");
									_form.eq(option.selectIndex.split(",")[0]-1).show();  
							        _childB.eq(value-1).addClass("J_aClass");    
								 } 
						 }else{    
								_childB.eq(0).removeClass("select").removeClass("J_aClass");  //移除密码登录的tab
	 						    _form.eq(0).hide();  //移除密码登录的form
	 						    _childB.eq(option.selectIndex.split(",")[0]-1).addClass("select").addClass("J_aClass");
							    _childB.eq(value-1).addClass("J_aClass");
	 				            _form.eq(option.selectIndex.split(",")[0]-1).show();    
						}  
				   }) 
				    
					 //如果当前签证方式是密码登录方式 并且有第指纹签证方式,密码登录的值复制到指纹登录
					 if(_childCIdnex==0 && option.selectIndex.indexOf("2")>-1 ){ 
					      var uValue=_form.eq(0).find("input[name=username]").val();
					      if(uValue!=""){
					 	     _form.eq(1).find("input[name=username]").val(uValue);
					      }    
				       //如果当前签证方式是密码登录方式 没有第指纹签证方式,清空指纹登录的用户名值
					  }else if(_childCIdnex==0  && option.selectIndex.indexOf("2")<0){
					  	    _form.eq(1).find("input[name=username]").val('');   
					  //如果当前签证方式是指纹登录方式 并且有密码登录方式,指纹登录的值复制到密码登录
					  }else if(_childCIdnex==1 && option.selectIndex.indexOf("1")>-1 ){   
						  var uValue=_form.eq(1).find("input[name=username]").val();
					      if(uValue!=""){
					 	     _form.eq(0).find("input[name=username]").val(uValue);
					      }        
					  //如果当前签证方式是指纹登录方式 没有密码签证方式,清空密码登录的用户名值
					  }else if(_childCIdnex==1 && option.selectIndex.indexOf("1")<0){ 
					  	   _form.eq(0).find("input[name=username]").val(''); 
						   //如果当前签证方式是UKey
					  }else if(_childCIdnex==2){
					  	  _form.find("input[name=username]").val('');
					  }  
				}else{
					  _childB.eq(option.selectIndex-1).addClass("J_aClass").addClass(option.selectClass).siblings().removeClass(option.selectClass).removeClass("J_aClass"); ;
				      _form.eq(option.selectIndex-1).show().siblings().hide(); 
				 } 
		      }  
			  
			  if( _form.eq(0).find("input[name=username]").val()==""){
			  	_form.eq(0).find("input[name=username]").focus();
			  }else{
			  	_form.eq(0).find("input[name=password]").focus();
			  }  
			  if( _form.eq(1).find("input[name=username]").val()==""){
			  	_form.eq(1).find("input[name=username]").focus();
			  }else{
			  	_form.eq(1).find("input[name=zhiwen]").focus();
			  } 
			  if( _form.eq(2).find("input[name=uknum]").val()==""){
			  	_form.eq(2).find("input[name=uknum]").focus();
			  }else{
			  	_form.eq(2).find("input[name=password]").focus();
			  }  
			 if(option.IsVerifyCode>0){ 
				//显示相应form下的验证码
				  $(".J_trCode").show();  
			    }    
		   } 
        }
    });
})(jQuery); 
/**
  *package: js/page/login.js
  *function:  adtec.login.login.changeImage()
  *params:  
  *description:   验证码刷新
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/  
// adtec.login.login.changeImage= function (){  
//		document.getElementById('codesrc').src=adtec.bp()+"/vlidatecode?actionType=validateMa&cc="+Math.random();
//  } 
  
 /**
  *package: js/page/login.js
  *function:  adtec.login.login.keyEnter
  *params:  
  *description:   回车提交表单
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:14:25
 **/ 
adtec.login.login.keyEnter=function(){
 	 if (document.addEventListener)  {
 	    //Firefox   
        document.addEventListener("keypress", fireFoxHandler, true);   
    }else{
    	//IE
        document.attachEvent("onkeypress", ieHandler);   
    }   
    function fireFoxHandler(evt){   
        if (evt.which== 13){   
            var formIndex=$("#tableContainer").find("tbody tr td").find("a.select").index();
            adtec.login.login.isEmpty(formIndex);
        }   
    }   
    function ieHandler(evt){    
        if (evt.keyCode == 13)  {   
            var formIndex=$("#tableContainer").find("tbody tr td").find("a.select").index();
            adtec.login.login.isEmpty(formIndex);
       }    
     } 
 } 
    
 /**
  *package: js/page/login.js
  *function:  adtec.login.login.vlidateCode()
  *params:  
  *description:   验证码验证
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 
adtec.login.login.vlidateCode=function(num){ 
 	//获取用户输入的验证码的值 ,获取不同顺序的值   
	var _form=$("form").eq(num);
	var _action=$("form").eq(num).attr("action"); 
	var _code=_form.find("input[name=verifyCode]");
	var param="verifyCode="+_code.val(); 
         $.ajax({  
            type: 'GET', 
            async:false,
            url: adtec.login.login.validateCodeUrl,  // 跨域URL  
            dataType: 'jsonp', 
            jsonp: 'jsoncallback', //默认callback
            jsonpCallback:"success_jsonpCallback",//callback的function名称
            data: param, 
            timeout: 5000, 
            beforeSend: function(){  //jsonp 方式此方法不被触发。原因可能是dataType如果指定为jsonp的话，就已经不是ajax事件了
            },
            success: function (json) { //客户端jquery预先定义好的callback函数，成功获取跨域服务器上的json数据后，会动态执行这个callback函数 
                 if(json.flag){
                      _form.submit();
                 }else{
                     $("#J_error"+num).html("验证码输入错误!");
                     _code.val('');
                 }
            }, 
            complete: function(XMLHttpRequest, textStatus){ 
                 
            }, 
            error: function(xhr){ 
                //jsonp 方式此方法不被触发
                //请求出错处理 
                alert("服务器出现异常!"); 
              } 
            }); 
 
 } 
  /**
  *package: js/page/login.js
  *function:  adtec.login.login.trim()
  *params:  
  *description:   去掉输入字符串两边的空格
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 
 adtec.login.login.trim=function(s) {     
      var count = s.length;     
      var st    = 0;       // start     
      var end   = count-1; // end      
      if (s == "") return s;     
      while (st < count) {     
        if (s.charAt(st) == " ")     
          st ++;     
        else    
          break;     
      }     
      while (count > st) {     
        if (s.charAt(end) == " ")     
          end --;     
        else    
          break;     
      }     
      return s.substring(st,end + 1);     
    }
  
 /**
  *package: js/page/login.js
  *function:  adtec.login.login.isEmpty()
  *params:  
  *description:   判断是否为空  
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 
adtec.login.login.isEmpty=function(formIndex){ 
 	adtec.login.login.index=formIndex;
 	var _form = document.forms[formIndex];  
	if(formIndex==0){  
	  if( $.trim(_form.username.value)==""){  
			$("#J_error"+formIndex).html("用户名不能为空!");            
	        return false;     
	    }else  if ( $.trim(_form.password.value) == "") {
			$("#J_error" + formIndex).html("密码不能为空!");
			return false;
		}else if( $.trim(_form.username.value)!="" &&$.trim(_form.password.value) != "" ){
			 adtec.login.login.vlidatEisEmpty(formIndex); 
		}  
    }else if(formIndex==1){
		if( $.trim(_form.username.value)==""){    
			$("#J_error"+formIndex).html("用户名不能为空!");            
	        return false;     
	    }else if ( $.trim(_form.zhiwen.value) == "") { 
			$("#J_error" + formIndex).html("指纹不能为空!");
			return false;
		}else if( $.trim(_form.username.value)!="" &&$.trim(_form.zhiwen.value) != "" ){
		    adtec.login.login.vlidatEisEmpty(formIndex); 
		}  
	}else{
  	 if( $.trim(_form.uknum.value)==""){    
			$("#J_error"+formIndex).html("UK号不能为空!");            
	        return false;     
	   }else if ( $.trim(_form.password.value) == "") { 
			$("#J_error" + formIndex).html("密码不能为空!");
			return false;
	  }else if( $.trim(_form.uknum.value)!="" &&$.trim(_form.password.value) != "" ){
		   adtec.login.login.vlidatEisEmpty(formIndex); 
		}  
  }  

 }
   /**
  *package: js/page/login.js
  *function:  adtec.login.login.vlidatEisEmpty ()
  *params:  formIndex:form的index
  *description:   验证码是否为空验证
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 
 adtec.login.login.vlidatEisEmpty=function(formIndex){
 	var _form = document.forms[formIndex];  
      //有验证码
		 if($("form").eq(formIndex).find("tr.trCode:visible").length>0){ 
		       if ( $.trim(_form.verifyCode.value) == "") { 
			       $("#J_error" + formIndex).html("验证码不能为空!");
			       return false;
		       }else{
		          adtec.login.login.vlidateCode(formIndex); 
		       } 
		 }
 
 }
  /**
  *package: js/page/login.js
  *function:  dtec.login.login.formSubmit ()
  *params:  formIndex:form的index
  *description:   form提交 
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/  
adtec.login.login.formSubmit=function(formIndex){
    $("form").eq(formIndex).submit();
 }
  
 
 $(function (){   
     //进入初始化时默认为密码登录     
 	  $("#tableContainer").tab();
      adtec.login.login.keyEnter();   
      adtec.login.login.loginCookie();   
      adtec.login.login.blur();      
 })
 /**
  *package: js/page/login.js
  *function:  dtec.login.login.loginCookie()
  *params:   
  *description:   比较判断用户访问IP和cookie中的IP
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 		 
 adtec.login.login.loginCookie=function(){   
  	  $.post(adtec.bp()+"/loginServlet?actionType=loginCookie","",
			function(data){   
			   if(data!=null ){ 
			   	if(data.obj!=null){
			   	     $("#tableContainer").tab({selectIndex:data.obj['loginType'],IsVerifyCode:data.obj["verifyCode"]});  
			   	   } 
				 } 
			 }, "json");     
  }  
   /**
  *package: js/page/login.js
  *function:  adtec.login.login.userListener ()
  *params:   
  *description:   通过用户名查询相关信息
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/   
 adtec.login.login.userListener =function(){ 
		   //获取当前tab的索引
		    var index=$("#tableContainer").find("tbody > tr >td  a.select ").index(); 
			var value=$("form").eq(index).find("input[name=username]").val();
			var param="tellerNo="+value;  
		  $.post(adtec.bp()+"/loginServlet?actionType=loginType",param,
				   function(data){ 
				     if(data.flag){
						 //判断用户的签证方式   1：密码认证 2：指纹认证 3：Ukey认证
						var loginType=$.trim(data.obj["login_type"]); 
						$("#tableContainer").tab({selectIndex:loginType,IsVerifyCode:data.obj["verify_code"]});  
                        $(".error").html('');
					 }else{
					 	$(".error").html("用户不存在");
					 } 
			 }, "json");    
	  }  
 
 
 /**
  *package: js/page/login.js
  *function:  
  *params:  
  *description:   用户名绑定焦点事件
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/  
	  adtec.login.login.blur=function(){
			   $("input[name=username]").on("blur",function(){  
			    var index=$("#tableContainer").find("tbody > tr >td  a.select ").index(); 
				var nameValue=$("form").eq(index).find("input[name=username]").val();  
			   	 if(nameValue!=null && nameValue.length>0 && nameValue!=adtec.login.login.historyValue){  
				  	adtec.login.login.userListener();
			 		adtec.login.login.historyValue=nameValue;
			 	  } 
			  }) 
	  }
 
 
