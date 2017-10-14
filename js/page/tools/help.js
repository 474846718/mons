
$(function(){
    $("#tableContainer").tab(); 
})

/**
  *package: js/page/tools/help.js
  *function:   
  *params:   
  *description:  动态改变监控对象后面的值 
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/ 
 
function showObj(obj,b){
	if(b!='top'){
	    $("#objValue").text(obj.text());
	} 
}
		
