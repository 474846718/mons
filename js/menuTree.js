
/**
 * 三级菜单树
 * Author : 王帅
 * 2013/01/15
 */
function MenuImageOnClickEvent(obj,a,clazz,b){
			var parentobj = $(obj).parent();
			if(clazz == "subItem"){
				$(obj).siblings(".subItem").removeClass("open");
				$(obj).addClass("open");
				
			}else{
				if(!$(obj).hasClass("open")){
					$(obj).siblings(".sub").slideUp(800);
					$(obj).siblings(".topFolder").removeClass("open");
					$(obj).next(".sub").slideDown(800);
					$(obj).addClass("open");
				}else{
					$(obj).next(".sub").slideUp(800);
					$(obj).removeClass("open");
				}
			}
		}
		$(document).ready(function(){
			$(".topFolder,.subFolder,.subItem").mouseover(function(){
				if(!$(this).hasClass("open")){
					$(this).stop();
					$(this).fadeTo("fast",0.33);
					$(this).addClass("over");
					$(this).fadeTo("fast",1);
				}
			});
			$(".topFolder,.subFolder,.subItem").mouseout(function(){
				$(this).removeClass("over");
			});
			$(".topFolder,.subFolder,.subItem").each(function(){
				var text = $(this).text();
				if(text.length > 16){
					$(this).text(text.substring(0, 16) + '...');
				}
			});
		});
