//用户退出
function logout2(tellerno){
	$.ajax({
	   type: "POST",
	   url: adtec.bp()+"/logout.action",
	   data: "tellerNo="+tellerno,
	   success: function(data){ 
		console.info(data);
		var _url=data.obj;
	   	window.location.href=_url;		
	   }
  });  
}