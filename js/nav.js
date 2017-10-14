/**
 * 浮动层
 * Author : 先进数通
 * Version : 2013/08/22
 */
 
jQuery(function(){   
           jQuery("#nav").find("td").hover(function() { 
                jQuery(this).find('a').addClass("selected").end().find("div").show(); 
           }, function() {
                jQuery(this).find('a').removeClass("selected").end().find("div").hide();  
           });
           
	}) 