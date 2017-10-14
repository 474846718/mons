/**
 * Author : 王帅
 * Version : 2012/12/21
 */



/*** 左侧菜单树展开关闭 ***/
$(document).ready(function(){
	$("#switchbtn").click(function(){
		$(this).toggleClass("down");
		$(this).toggleClass("up");
		$("#left").toggle();
	});
});



/*** 客户资料展开关闭 ***/
$(document).ready(function(){
	$("#switchbtn3").click(function(){
		$(this).toggleClass("down");
		$(this).toggleClass("up");
		$("#right_bottom").toggle();
		var h = $("#tabs").attr("height");
		var h1 = parseInt(h) - 110;
		var h2 = parseInt(h) + 110;
		if($("#right_bottom").is(":visible")){
			$("#tabs").attr("height",h1);
		}else{
			$("#tabs").attr("height",h2);
		}

	});
});

