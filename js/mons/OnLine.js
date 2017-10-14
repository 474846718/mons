$(document).ready(function(){
/*
    var $url1=$(".hotsys_1");
    $url1.click(function(){
      		window.open('ChannelAtm.html','000001');
    });
    var $url2=$(".hotsys_2");
    $url2.click(function(){
      		window.open('ChannelOnLine.html','000003');
    });
    var $url3=$(".hotsys_3");
    $url3.click(function(){
      		window.open('ChannelCounter.html','000004');
    });
*/
    $.extend({
       show:function(){
	 var request ={
    			'Sys':{
    					'ID'	:	'000003'
    			      }
    	}	
     	var encoded = $.toJSON( request );  
     	var jsonStr = encoded; 
    	jQuery.support.cors = true;
    	$.ajax({  
        	url : 'http://172.16.5.234:5588/MON017',  
        	type : 'POST',  
        	data : jsonStr,  
        	dataType : 'json',  
        	success : function(data, textStatus, jqXHR) {  
			$.each(data.ret.Sumary,function(i,item){
				$('#00001').text(item.Num);
                                $('#00002').text(item.AvgTm+"s");
                                $('#00003').text(item.Percent+"%");
			});
        	},
        	error : function(xMLHttpRequest,textStatus,errorThrown) {      
            		alert(errorThrown);  
        	}  
    	});  
       }
    });
    setInterval("$.show()",60000);
});
