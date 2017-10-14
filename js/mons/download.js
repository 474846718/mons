$(document).ready(function(){
    var $url1=$(".hotsys_1");
    $url1.click(function(){
      //	window.open('ChannelAtm.html','000004');
		window.location.href='ChannelAtm.html';
    });
    var $url2=$(".hotsys_2");
    $url2.click(function(){
      	//	window.open('ChannelOnLine.html','000003');
		window.location.href='ChannelOnLine.html';
    });
    var $url3=$(".hotsys_3");
    $url3.click(function(){
      	//	window.open('ChannelCounter.html','000001');
		window.location.href='ChannelCounter.html';
    });
	
    $(function(){
	MON016();
        function MON016()
        {
		var request ={
                                        'TxnNo' :       'MON016'
        	}       
        	var encoded = $.toJSON( request );   
        	var jsonStr = encoded; 
        	jQuery.support.cors = true;
        	$.ajax({  
                	url : 'http://12.0.98.43:5588/MON016',
                	type : 'POST',
                	data : jsonStr,  
                	dataType : 'json',
                	success : function(data, textStatus, jqXHR) {
                        	$.each(data.AvgTm,function(i,item){
                                	$('#'+item.ID).text(item.Time+"s");
                       		 });
                	},
               		 error : function(xMLHttpRequest,textStatus,errorThrown) {
        //                	alert(errorThrown);
                	}
        	});		
		setTimeout(MON016,30000);
	}

   })
});
