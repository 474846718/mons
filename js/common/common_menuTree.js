
/**
 * 三级菜单树
 * Author : 王帅
 * 2013/01/15
 */
function MenuImageOnClickEvent(obj,a,clazz,b){ 
	     showObj($(obj).find("a"),b);
			var parentobj = $(obj).parent();
			if(clazz == "subItem"){
				$(obj).siblings(".subItem").removeClass("subItemOpen");
				$(obj).addClass("subItemOpen"); 
			}else{
			    //没有打开的
				if(!$(obj).hasClass("subFolderOpen")){ 
					$(obj).siblings(".sub").slideUp(600);
					$(obj).siblings("div").removeClass("subFolderOpen");
					$(obj).next(".sub").slideDown(600);
					if(clazz!='topFolder'){
					    $(obj).addClass("subFolderOpen");
					} 
				}else{ 
				    
				    $(obj).removeClass("subFolderOpen");
					$(obj).next(".sub").slideUp(600); 
				}
			}
		}
		$(document).ready(function(){
			$("#aMenu a").mouseover(function(){
				if(!$(this).parent().hasClass("open")){
					$(this).stop();
					$(this).fadeTo("fast",0.33);
					$(this).addClass("over");
					$(this).fadeTo("fast",1);
				}
			});
			$("#aMenu a").mouseout(function(){
				$(this).removeClass("over");
			});
			$("#aMenu a").each(function(){
				var text = $(this).text();
				if(text.length > 12){
					$(this).text(text.substring(0, 12) + '...');
				}
			});
		});
		
		
		
		

		
