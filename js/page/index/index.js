/*  
 Example:
 $(".productshow").xslider({//.productshow是要移动对象的外框;
 unitdisplayed:3,//可视的单位个数   必需项;
 movelength:1,//要移动的单位个数    必需项;
 maxlength:null,//可视宽度或高度    默认查找要移动对象外层的宽或高度;
 scrollobj:null,//要移动的对象     默认查找productshow下的ul;
 unitlen:null,//移动的单位宽或高度     默认查找li的尺寸;
 nowlength:null,//移动最长宽或高（要移动对象的宽度或高度）   默认由li个数乘以unitlen所得的积;
 dir:"H",//水平移动还是垂直移动，默认H为水平移动，传入V或其他字符则表示垂直移动;
 autoscroll:1000//自动移动间隔时间     默认null不自动移动;
 });
 */
jQuery.extend(jQuery.easing, {
    easeInSine: function(x, t, b, c, d){
        return -c * Math.cos(t / d * (Math.PI / 2)) + c + b;
    }
});
 


(function($){
    $.fn.xslider = function(settings){
        settings = $.extend({}, $.fn.xslider.defaults, settings);
        this.each(function(){  
            adtec.index.index.obj = $(this);
            adtec.index.index.scrollobj = scrollobj = settings.scrollobj || $(this).find("ul");
            adtec.index.index.maxlength = maxlength = settings.maxlength || scrollobj.parent().width();//length of the wrapper visible;
            adtec.index.index.scrollunits = scrollobj.find("li");//units to move; 
            adtec.index.index.unitlen = settings.unitlen || scrollunits.eq(0).outerWidth();
            adtec.index.index.unitdisplayed = settings.unitdisplayed;//units num displayed; 
            adtec.index.index.nowlength = settings.nowlength || adtec.index.index.scrollunits.length * adtec.index.index.unitlen;
            adtec.index.index.offset = 0;
            adtec.index.index.sn = 0;
            adtec.index.index.movelength = adtec.index.index.unitlen * settings.movelength; 
            adtec.index.index.moving = false;
            adtec.index.index.btnright = $("#" + settings.tabRight_Id);
            adtec.index.index.btnleft = $("#" + settings.tabLeft_Id);
            
            if (settings.dir == "H") {
                adtec.index.index.scrollobj.css("left", "0px");
            }else {
                adtec.index.index.scrollobj.css("top", "0px");
            }
            
            if (adtec.index.index.nowlength > adtec.index.index.maxlength) {
                adtec.index.index.btnleft.addClass("agrayleft");
                adtec.index.index.btnright.removeClass("agrayright");
                adtec.index.index.offset = adtec.index.index.nowlength - adtec.index.index.maxlength;
            }else {
                adtec.index.index.btnleft.addClass("agrayleft");
                adtec.index.index.btnright.addClass("agrayright");
            }
            
            if (settings.autoscroll) {
                jQuery.fn.xslider.autoscroll($(this), settings.autoscroll);
            } 
        })
    }
})(jQuery);


$("#tab_left").live("click", function(){  
    if ($(this).is("[class*='agrayleft']")) {
        return false;
    } 
	 
    if (!adtec.index.index.moving) {
        adtec.index.index.moving = true; 
        adtec.index.index.sn -= adtec.index.index.movelength;
        if (adtec.index.index.sn > adtec.index.index.unitlen * adtec.index.index.unitdisplayed - adtec.index.index.maxlength) {
            jQuery.fn.xslider.scroll(scrollobj, -adtec.index.index.sn, function(){
                adtec.index.index.moving = false;
            });
        }
        else {
            jQuery.fn.xslider.scroll(scrollobj, 0, function(){
                adtec.index.index.moving = false;
            });
            adtec.index.index.sn = 0;
            $(this).addClass("agrayleft");
        }
        adtec.index.index.btnright.removeClass("agrayright");
    }
    return false;
});





$("#tab_right").live("click", function(){     
    if ($(this).is("[class*='agrayright']")) {
        return false;
    }
    if (!adtec.index.index.moving) {
        adtec.index.index.moving = true;
        adtec.index.index.sn += adtec.index.index.movelength;
        if (adtec.index.index.sn < adtec.index.index.offset - (adtec.index.index.unitlen * adtec.index.index.unitdisplayed - adtec.index.index.maxlength)) { 
            jQuery.fn.xslider.scroll(adtec.index.index.scrollobj, -adtec.index.index.sn, function(){
                adtec.index.index.moving = false;
            });
        }
        else { 
            jQuery.fn.xslider.scroll(adtec.index.index.scrollobj, -adtec.index.index.offset, function(){
                adtec.index.index.moving = false;
            });//滚动到最后一个位置;
            adtec.index.index.sn = adtec.index.index.offset;
            $(this).addClass("agrayright");
        }
        adtec.index.index.btnleft.removeClass("agrayleft");
    } 
    return false; 
})




jQuery.fn.xslider.defaults = {
    maxlength: 0,
    scrollobj: null,
    unitlen: 0,
    nowlength: 0,
    autoscroll: null,
    tabLeft_Id: '',
    tabRight_Id: ''
};
jQuery.fn.xslider.scroll = function(obj, w, callback){
    obj.animate({
        left: w
    }, 500, "easeInSine", callback);
    
}
jQuery.fn.xslider.autoscroll = function(obj, time){
    var vane = "tab_right";
    function autoscrolling(){
        if (vane == "tab_right") {
            if (!obj.find("a.agrayright").length) {
                adtec.index.index.btnright.trigger("click");
            }
            else {
                vane = "tab_left";
            }
        }
        if (vane == "tab_left") {
            if (!obj.find("a.agrayleft").length) {
                adtec.index.index.btnleft.trigger("click");
            }
            else {
                vane = "tab_right";
            }
        }
    }
    var scrollTimmer = setInterval(autoscrolling, time);
    obj.hover(function(){
        clearInterval(scrollTimmer);
    }, function(){
        scrollTimmer = setInterval(autoscrolling, time);
    });
}





/**
 * @author TianHan
 * 2013-03-28
 */
String.prototype.subStrs = function(_begin, _length, _title) {
	return (this.isEmpty) ? "" : this.substr(_begin, _length);
}
 
 
			
jQuery.fn.tab = function(options) {
	var settings = {
		topTagsDivId : '', //tags展示区域的id
		tabCurrentClass : '', //tab选中的样式
		eventType : 'click', //事件类型，默认为点击事件
		imgClose : 'images/close.gif', //关闭按钮的默认
		iframeId : '', //iframe所在的Div的ID
		topFlag:false             //区分列表和顶部
		// tabTitle:"未命名的标题'     //当menu的名称为空时的默认标签名); 
	};
	jQuery.extend(settings, options);

	//tab绑定事件
	$("#" + settings.topTagsDivId).find("li").live(settings.eventType, function() {
		clearTagBac();
		$(this).addClass(settings.tabCurrentClass);
		cleariframe();
		$("#" + $.trim($(this).attr("iframeId"))).fadeIn("slow");
		return false;
	})
	//我的桌面单独绑定事件
	$("#indexFrame1").live(settings.eventType,function(){
	       cleariframe();
	       $("#indexFrame").fadeIn("slow"); 
	       return false;
	})
		
/*
	function tabListener(){
		$("#tabs_titleId").xslider({
			unitdisplayed:3,
			movelength:1,
			unitlen:93, 
			tabLeft_Id:'tab_left',
	        tabRight_Id:'tab_right'
		     });  
		}
*/
	
	//关闭按钮事件  关闭之后默认前面菜单打开  以后优化的地方，出现了重复搜索的现象 ,可以用数组，目前用初始化
	
	$('#tabs_titleId').find('ul>li .img_close ').live("click", function(event) {  
	var e = (event) ? event : window.event;
		if (window.event) {//IE
		e.cancelBubble=true;
		} else { //火狐
		e.stopPropagation();
      };
		var _parent_li=$(this).parent("li");
		//tab之前的对象
		var  _prev_obj=_parent_li.prev("li").eq(0);  //应该在关闭之前获取到prevTag的对象，否则获取不到
		var  _prev_objLength=_prev_obj.length;    
		var  _prev_ld=_prev_obj.attr("id");  
		var  _prev_iframeId=_prev_obj.attr("iframeid");   
		//tab之后的对象
		var  _next_obj=_parent_li.next("li").eq(0);  //应该在关闭之前获取到prevTag的对象，否则获取不到
 		var  _next_objLength=_prev_obj.length;    
		var  _next_ld=_prev_obj.attr("id");   
		var  _next_iframeId=_next_obj.attr("iframeid"); 
		$("#"+_parent_li.attr("iframeid")).remove(); 
		var _allLi_Length=$("#tabs_titleId").find('ul >li').length;
		 if(_allLi_Length>0){
	            if(_prev_objLength>0){
									   	if(_parent_li.hasClass(settings.tabCurrentClass)){
											//当前li 
											_parent_li.fadeOut("slow").remove();  
											//前面的tag 
											$("#"+_prev_ld).addClass("select");  
											$("#"+_prev_iframeId).show();   
											adtec.index.index.sliderInt();
											return false;   
										 }else{ 
											 _parent_li.fadeOut("slow").remove(); 
											 adtec.index.index.sliderInt();
								 			 return false;    //防止事件冒泡
									 }   
	           } else{
	           	   _parent_li.remove();   
	           	   if(_next_objLength>0 ){ 
	           	     	 _next_obj.addClass("select");  
	           	   	     $("#"+_next_iframeId).show();  
	           	   	     adtec.index.index.sliderInt(); 
				     	 return false;
	           	   }else{ 
	           	   	adtec.index.index.sliderInt();
					return false;
	           	   }  
			   }
		 }else{ 
			    $("#indexFrame").fadeIn("slow").siblings().hide();
				adtec.index.index.sliderInt();
				return false;  
		 } 
	})
  
		var _menu_li_a1 = $(this).find("tbody >tr >td >ul >li>table.systerm_photo").find("tbody > tr > td >a.nameclass");
		var _menu_li_a2 = $(this); 
		if(!settings.topFlag){
             systemClick();
		}else{ 
			 videoClick();
		}
		
//列表的事件绑定
		function systemClick(){
				$(_menu_li_a1).live(settings.eventType, function() {
				//获取当前的href
				var _href = $(this).attr("rel");
				//获取当前点击li的索引
				//var _menu_li_index = $(this).parent("td").parent("tr").parent("tbody").parent("table.systerm_photo").parent("li").index();
				//获取当前点击li的ID 
				var _menu_li_id = $(this).parent("td").parent("tr").parent("tbody").parent("table.systerm_photo").parent("li").attr("id"); 
				//判断是否为在常用系统打开的tab页
				if(liIdToStr(_menu_li_id).indexOf("c")>-1){ 
					_menu_li_id=$.trim(liIdToStr(_menu_li_id).replace("c","").replace('"','').replace('"','')); 
				} 
				
				//获取tab集合
				var _tab_li = $("#" + settings.topTagsDivId).find("li");
				//顶部菜单的最后一个li
				var _tag_li_last = _tab_li.last();
				//获取点击当前的menu文本
				var _tab_text = $(this).text();  
				var _iframeId = "iframeid" + _menu_li_id; 
				//点击菜单时判断是否已经打开    不用考虑我的桌面 
				var _tab_li_id=_tab_li.attr("id"); 
				 
				 function replaceStr(str){
				    	return str.replace("toptag","");
				 }
				   
				  
			   if(!$("#toptag" + _menu_li_id).length > 0){
					clearTagBac();
					openNewTags();
					//显示当前iframe
					openNewIframe();
					iframeFit(_iframeId);
				} else{
					clearTagBac();
					$("#toptag"+_menu_li_id).addClass(settings.tabCurrentClass);  
					cleariframe();
		            $("#"+_iframeId).fadeIn("slow");  
					iframeFit(_iframeId);
				} 
				
				//li的ID转换为字符串
				function liIdToStr(id){
					return '"'+id+'"';
				} 
				
				
				//增加tab
				function openNewTags() {
					var htmlStr = '<li iframeid="' + _iframeId + '"   class="' + settings.tabCurrentClass + '" id="toptag' + _menu_li_id + '"><a href="javascript:void(0);" title="'+_tab_text+'">' + _tab_text.subStrs(0, 5, settings.tabTitle) + '</a><img class="img_close" src="' + settings.imgClose + '" style="vertical-align:middle;cursor:pointer;"/>';
					htmlStr += '</li>'; 
					if (_tag_li_last.length == 0) {
						$("#" + settings.topTagsDivId).find("ul").html(htmlStr);
					} else {
						_tag_li_last.after(htmlStr);
					}
					 adtec.index.index.sliderInt();
				}
		
				//创建iframe
				function openNewIframe() {
					//获取高度 
					var _iframeName = '_iframeName' + _menu_li_id;
					var iframeStr = '<iframe name="' + _iframeName + '" align=""  width="100%"  height="100%" marginwidth="0" marginheight="0" ';
					iframeStr += 'allowtransparency="true" id="' + _iframeId + '" frameborder="0"  src="' + _href + '">';
					cleariframe();    
					$("#" + settings.iframeId).append(iframeStr);  
				}

	      })  
		}
		
//监控，视频的事件绑定
		
		function videoClick(){
		    	$(_menu_li_a2).live(settings.eventType, function() {
				//获取当前的href
				var _href = $(this).attr("rel");
//				console.info("_href="+_href);
				//获取当前点击li的ID 
				var _menu_li_id = $(this).attr("id"); 
//				console.info("_menu_li_id="+_menu_li_id);
				//判断是否为在常用系统打开的tab页
				if(liIdToStr(_menu_li_id).indexOf("c")>-1){ 
					_menu_li_id=$.trim(liIdToStr(_menu_li_id).replace("c","").replace('"','').replace('"','')); 
				} 
				
				//获取tab集合
				var _tab_li = $("#" + settings.topTagsDivId).find("li");
				//顶部菜单的最后一个li
				var _tag_li_last = _tab_li.last();
				//获取点击当前的menu文本
				var _tab_text = $(this).attr('title');  
				var _iframeId = "iframeid" + _menu_li_id; 
				//点击菜单时判断是否已经打开    不用考虑我的桌面 
				var _tab_li_id=_tab_li.attr("id"); 
				 
				 function replaceStr(str){
				    	return str.replace("toptag","");
				 }
				   
				  
			   if(!$("#toptag" + _menu_li_id).length > 0){
					clearTagBac();
					openNewTags();
					//显示当前iframe
					openNewIframe();
					iframeFit(_iframeId);
				} else{
					clearTagBac();
					$("#toptag"+_menu_li_id).addClass(settings.tabCurrentClass);  
					cleariframe();
		            $("#"+_iframeId).fadeIn("slow");  
					iframeFit(_iframeId);
				} 
				
				//li的ID转换为字符串
				function liIdToStr(id){
					return '"'+id+'"';
				} 
				
				
				//增加tab
				function openNewTags() {
					var htmlStr = '<li iframeid="' + _iframeId + '"   class="' + settings.tabCurrentClass + '" id="toptag' + _menu_li_id + '"><a href="javascript:void(0);" title="'+_tab_text+'">' + _tab_text.subStrs(0, 5, settings.tabTitle) + '</a><img class="img_close" src="' + settings.imgClose + '" style="vertical-align:middle;cursor:pointer;"/>';
					htmlStr += '</li>'; 
					if (_tag_li_last.length == 0) {
						$("#" + settings.topTagsDivId).find("ul").html(htmlStr);
					} else {
						_tag_li_last.after(htmlStr);
					}
					 adtec.index.index.sliderInt();
				}
		
				//创建iframe
				function openNewIframe() {
					//获取高度 
					var _iframeName = '_iframeName' + _menu_li_id;
					var iframeStr = '<iframe name="' + _iframeName + '" align=""  width="100%"  height="100%" marginwidth="0" marginheight="0" ';
					iframeStr += 'allowtransparency="true" id="' + _iframeId + '" frameborder="0"  src="' + _href + '">';
					cleariframe();    
					$("#" + settings.iframeId).append(iframeStr);  
				}

	      })  
			
			
			
			
		
		}
	//清除menu
	function clearTagBac() {
		$("#" + settings.topTagsDivId).find("li").removeClass("select");
	}

	//清除iframe
	function cleariframe() {
		//$("iframe").fadeOut("slow");
		$("iframe").hide();
	}

	//iframe自适应高度
	function iframeFit(iframeids) {
		var _thisIframeId;
		if (document.getElementById) {
			_thisIframeId = document.getElementById(iframeids);
			if (_thisIframeId && !window.opera) {
				_thisIframeId.style.display = "block";
				_thisIframeId.height = document.documentElement.clientHeight-35;
			}
		}
	} 
}  
 
  /**
  *package: js/page/index/index.js
  *function: window.onload
  *params:  
  *description: 获取iframe的元素
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
window.onload = function(){
    //获取iframe元素的ID
    var iframe_menuId = document.getElementById("indexFrame").contentWindow.document.getElementById("systerm_list_id");
    var common_list_id = document.getElementById("indexFrame").contentWindow.document.getElementById("common_list_id");
    var video_id = document.getElementById("video");
    var jiankong_id = document.getElementById("jiankong"); 
    $(iframe_menuId).tab({
        topTagsDivId: 'tabs_titleId',
        tabCurrentClass: 'select',
        iframeId: 'iframeContainerId'
    })
	
	$(common_list_id).tab({
        topTagsDivId: 'tabs_titleId',
        tabCurrentClass: 'select',
        iframeId: 'iframeContainerId'
    })
    $(video_id).tab({
        topTagsDivId: 'tabs_titleId',
        tabCurrentClass: 'select',
        iframeId: 'iframeContainerId',
        topFlag:true
    })
    $(jiankong_id).tab({
        topTagsDivId: 'tabs_titleId',
        tabCurrentClass: 'select',
        iframeId: 'iframeContainerId',
        topFlag:true
    })
}

/*function:sy.user.focus
 description:获取焦点
 author:田斌
 Date:2013年4月23日 12:57:25
 */
 /**
  *package: js/page/index/index.js
  *function: window.onload
  *params:  
  *description: 获取焦点
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
adtec.index.index.focus = function(){
    $("table.login_form").find("input[type!=button]").focusin(function(){
        $(this).addClass("focus")
    }).focusout(function(){
        $(this).removeClass("focus")
    });
}
 
 /**
  *package: js/page/index/index.js
  *function: adtec.index.index.Ahove
  *params:  
  *description: 登录页面展示
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
adtec.index.index.Ahover = function(){
    $("a.login").hover(function(){
        $("#tan_loginId").slideDown("slow");
    })
}
 
 /**
  *package: js/page/index/index.js
  *function: adtec.index.index.cancleClick
  *params:  
  *description: 登录菜单取消
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
adtec.index.index.cancleClick = function(){
    $("#cancelId").click(function(){
        $("#tan_loginId").slideUp("slow");
    })
}
 
 /**
  *package: js/page/index/index.js
  *function: adtec.index.index.hover
  *params:  
  *description: 鼠标hover效果
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
adtec.index.index.hover = function(){
    $("#menberDialog").hover(function(){
        $(this).next().fadeIn("slow");
    }, function(){
        $(this).next().fadeOut("slow");
    })
} 
 
 /**
  *package: js/page/index/index.js
  *function: adtec.index.index.sliderInt
  *params:  
  *description: tab菜单按钮轮换的初始化
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
adtec.index.index.sliderInt = function(){
    $("#tabs_titleId").xslider({
        unitdisplayed: 2,
        movelength: 1,
        unitlen: 99,
        tabLeft_Id: 'tab_left',
        tabRight_Id: 'tab_right'
    });
}

$(function(){
    adtec.index.index.focus();
    adtec.index.index.Ahover();
    adtec.index.index.cancleClick();
    adtec.index.index.hover();
    adtec.index.index.sliderInt(); 
})
 
 
$(function(){   
      $("#commonButton").live("click",function(){ 
          $(this).addClass("button_bg3_gray");   
          jQuery('body').showLoading( { 
                    'afterShow': 
                    function() {
                        setTimeout("jQuery('body').hideLoading()", 1500); 
                        setTimeout('checkForm();',1505);
                    }   
                 }
            )  
      }) 
  });  
  
 function checkForm(){
       if(checkMoney()) return; 
       $("#commonButton").parent("td").parent("tr").parent("tbody").parent("table").parent("form").submit(); 
 } 
 
function checkMoney(){
     var trademoney=$("#trademoney").val();
     if(trademoney>100){
                   showWindow(); 
                   $("#commonButton").removeClass("button_bg3_gray");   
                   return true;
       }else{
           return false;
       }
}

// 
function showWindow(){ 
    var $div_obj=$("#sq_box");
    var windowWidth=document.documentElement.clientWidth;
    var windowHeight=document.documentElement.clientHeight;
    var proupWidth=$div_obj.width();
    var proupHeight=$div_obj.height();  
    $div_obj.css("position","absolute").animate({left:windowWidth/2-proupWidth/2,top:windowHeight/2-proupHeight/2}, "slow").show(); 
}


 /**
  *package: js/page/index/index.js
  *function: windowClose
  *params:  
  *description:  窗口隐藏
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
function windowClose(){
        $("#sq_box").hide(); 
} 
 /**
  *package: js/page/index/index.js
  *function: windowClose
  *params:  
  *description:  窗口隐藏
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
function dialogShow(){  
    $("#sq_box").hide(); 
    openDialogWin('../template/sq_khd.html',null,1050,560,0,0);
}  

/**
  *package: js/page/index/index.js
  *function: dialogShow2
  *params:  
  *description:  窗口打开
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
function dialogShow2(){   
    $("#commonButton2").removeClass("button_bg3_gray");   
    openDialogWin('ycjk.html',null,1000,600,0,0);
} 


 /**
  *package: js/page/index/index.js
  *function: dialogShow3
  *params:  
  *description:  窗口打开
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
function dialogShow3(){   
    $("#commonButton2").removeClass("button_bg3_gray");   
    openDialogWin('jsp/tools/jiankong.jsp',null,740,570,0,0);
}
 /**
  *package: js/page/index/index.js
  *function: dialogShow4
  *params:  
  *description:  窗口打开
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:21:25
 **/ 
function dialogShow4(){   
    $("#commonButton2").removeClass("button_bg3_gray");   
    openDialogWin('jsp/tools/video.jsp',null,700,538,0,0);
}
 












