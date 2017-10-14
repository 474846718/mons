function getDate(){
	var currDate=new Date();
	document.getElementById("t001").innerHTML=currDate.getFullYear();
	document.getElementById("t002").innerHTML=currDate.getMonth()+1;
	document.getElementById("t003").innerHTML=currDate.getDate();
	document.getElementById("t004").innerHTML=currDate.getHours();
	document.getElementById("t005").innerHTML=currDate.getMinutes();
	document.getElementById("t006").innerHTML=currDate.getSeconds();
	setTimeout(getDate,1000);
}

/**
$(document).ready(function(){
	var sysid=$('body').attr( 'value' );
	$(function(){
    	 MON016();
    	 function MON016(){
    		 var request ={
    				 'AvgTm_ID'    :       sysid
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
        			 $('#00001').text(data.Sumary.Num);
        			 $('#00002').text(data.Sumary.Avgtm+'s');
        			 $('#00003').text(data.Sumary.Percent);
    			 },
    			 error : function(xMLHttpRequest,textStatus,errorThrown) {
    				 //	alert(errorThrown);
    			 }
    		 });
    		 setTimeout(MON016,20000);
    	 }
	})
});

$(document).ready(function(){
	var sysid=$('body').attr( 'value' );
	$(function(){
    	 MON017();
    	 function MON017(){
    		 var m = new Date();
    		 $('#year').text(m.getFullYear());
    		 $('#month').text(m.getMonth()+1);
    		 $('#day').text(m.getDate());
    		 $('#hour').text(m.getHours());
    		 $('#min').text(m.getMinutes());
    		 var request ={
    				 'AvgTm_ID'    :       sysid
    		 }
    		 var encoded = $.toJSON( request );
    		 var jsonStr = encoded;
    		 jQuery.support.cors = true;
    		 $.ajax({
    			 url : 'http://12.0.98.43:5588/MON017',
    			 type : 'POST',
    			 data : jsonStr,
    			 dataType : 'json',
    			 success : function(data, textStatus, jqXHR) {
        			 $('#001').text(data.Sumary.Num);
        			 $('#002').text(data.Sumary.Avgtm+'s');
        			 $('#003').text(data.Sumary.Percent);
    			 },
    			 error : function(xMLHttpRequest,textStatus,errorThrown) {
    				 //	alert(errorThrown);
    			 }
    		 });
    		 setTimeout(MON017,20000);
    	 }
	})
});

$(document).ready(function(){

	var sysid=$('body').attr( 'value' );

	var ColorArr =['CCFF00','FF0000','FF6600','FFFF00','00FF00','00FFFF','FF33FF','0099FF','FF6666','FF0099','6666FF','66FF66','FFFF66','00CC99','CC99CC','00CC00','CC33CC','FF3366','FFCC00'];
	var temp="<OBJECT width='685' height='225' id='Column3D'>  <embed src='.\\FusionChartsSWF\\Column3D.swf' flashVars=\"&dataXML=<graph caption='交易量/分钟' xAxisName='分钟' outCnvBaseFontColor='ffffff' bgColor='0986c4,035785' useRoundEdges='0' yAxisName='交易量' showNames='1' decimalPrecision='4' formatNumberScale='0'>"
	$(function(){
		MON019();
		function MON019()
		{
			request ={
					'AvgTm_ID'    :      sysid
			}
        	var encoded = $.toJSON( request );
        	var jsonStr = encoded;
        	jQuery.support.cors = true;
        	$.ajax({
          		url : 'http://12.0.98.43:5588/MON019',
				type : 'POST',
				data : jsonStr,
				dataType : 'json',
				success : function(data, textStatus, jqXHR) {
						var coloum="";
						$.each(data.Num,function(i,item){
							coloum+="<set name='"+item.Time+"'  value='"+item.Count+"' color='"+ColorArr[i]+"'/>";
						});
						var end="</graph>\" quality='high' width='685'  height='258' name='Column3D' type='application/x-shockwave-flash'/> </OBJECT>";
						var object=temp+coloum+end;
						//alert(object);
						$("#map2").empty();
						$("#map2").prepend(object);

				},
				error : function(xMLHttpRequest,textStatus,errorThrown) {
						alert(errorThrown);
				}
        	});
        	setTimeout(MON019,30000);
		} 
	})  
});


$(document).ready(function(){
	var sysid=$('body').attr( 'value' );
	var temp="<OBJECT width='650' height='225' id='Column3D'> <embed src='.\\FusionChartsSWF\\MSLine.swf' flashVars=\"&dataXML=<graph caption='TPS值' xAxisName='分钟' outCnvBaseFontColor='000000' bgColor='0986c4,035785' showNames='1' decimalPrecision='4' formatNumberScale='0' drawAnchors ='1' lineThickness='2'> <categories>"; 
	$(function(){
		MON018();
		function MON018()
		{
			var request ={
					'AvgTm_ID'    :      sysid
			}
			var encoded = $.toJSON( request );
			var jsonStr = encoded;
			jQuery.support.cors = true;
			$.ajax({
				url : 'http://12.0.98.43:5588/MON018',
				type : 'POST',
				data : jsonStr,
				dataType : 'json',
				success : function(data, textStatus, jqXHR) {
					var coloum="";
					var isValue="";
					$.each(data.Num,function(i,item){
						coloum+="<category name='"+item.Time +"'/>";
						isValue+="<set value='"+item.Count+"'/>";
					});

					var bgValue="</categories> <dataset seriesName='TPS值' color='00ff00'>";
					var end="</dataset></graph>\" quality='high' width='650'  height='258' name='Column3D' type='application/x-shockwave-flash'/> </OBJECT>";
					var object=temp+coloum+bgValue+isValue+end;
					//alert(object);
					$("#map1").empty();
					$("#map1").prepend(object);
												
				},
				error : function(xMLHttpRequest,textStatus,errorThrown) {
					alert(errorThrown);
				}
			});
			setTimeout(MON018,30000);
		}
	})
});


$(document).ready(function(){
	var sysid=$('body').attr( 'value' );
	jQuery("#list1").jqGrid({
		jsonReader:{
			root:"Seq",
			page:"CurPage",
			total:"TotalPages",
			records:"TotalRecords",
			userdata:"UserData_CurID",
			repeatitems:false,
			id:"0"
		},
		datatype:"json",
		colNames:[' ','监控类型','渠道代码','机构代码','商户号','设备号','交易码','交易日期','设备交易序号','设备周期号','主机交易序号','交易起始时间','交易结束时间','交易类型','账户性质','交易账户1','交易账户2','交易金额','辅助交易金额','手续费','主机授权码','委托单位授权码','返回码','业务标识','交易标识','全局渠道流水号','前置平台流水号','物理时间戳','机器节点号','响应时间','组件名','渠道系统','响应信息','保留1','保留2','保留3'],
		colModel:[
		          {name:'Demo4',index:'Demo4', width:20},
		          {name:'MonType',index:'MonType',width:55},
		          {name:'ChannelID',index:'ChannelId',width:55},
		          {name:'BranchID',index:'BranchId',width:55},
		          {name:'MerchantID',index:'MerchantId',width:55},
		          {name:'EquipID',index:'EquipId',width:75},
		          {name:'Trans',index:'Transaction',width:55},
		          {name:'TranDate',index:'TranDate',width:95},
		          {name:'EquipSeq',index:'EquipSeq',width:55},
		          {name:'TranCycle',index:'TranCycle',width:55},
		          {name:'HostSeq',index:'HostSeq',width:55},
		          {name:'StartTime',index:'StartTime',width:75},
		          {name:'EndTime',index:'EndTime',width:75},
		          {name:'AcctType',index:'AcctType',width:55},
		          {name:'AcctKind',index:'AcctKind',width:55},
		          {name:'Account1',index:'Account1',width:130},
		          {name:'Account2',index:'Account2',width:130},
		          {name:'Amount',index:'Amount',width:55},
		          {name:'Amount1',index:'Amount1',width:55},
		          {name:'Fee',index:'Fee',width:55},
		          {name:'HostCode',index:'HostCode',width:55},
		          {name:'ActCode',index:'ActCode',width:55},
		          {name:'ReturnCode',index:'RetCode',width:55},
		          {name:'OperMark',index:'OperMark',width:55},
		          {name:'TranMark',index:'TranMark',width:55},
		          {name:'GolSeq',index:'GlobalSeq',width:55},
		          {name:'PlatSeq',index:'PlatSeq',width:55},
		          {name:'TimeStamp',index:'TimeStamp',width:55},
		          {name:'NodeNo',index:'NodeNo',width:55},
		          {name:'RespTime',index:'RespTime',width:55},
		          {name:'CompName',index:'CompName',width:55},
		          {name:'Channel',index:'SysName',width:55},
		          {name:'ReturnMsg',index:'RetMsg',width:55},
		          {name:'Demo1',index:'Demo1',width:55},
		          {name:'Demo2',index:'Demo2',width:55},
		          {name:'Demo3',index:'Demo3',width:55}
		          ],
		          rowNum:10,
		          rowList:[10,20,30],
		          pager:'#pager1',
		          //	sortname:'id',
		          altRows:true,
		          altclass:'altgrid',
		          viewrecords:true,
		          sortorder:"StartTime",
		          height:500,
		          width:1340,
		          shrinkToFit:false,
		          autoScroll:true,
		          autowidth:false,
		          onSelectRow:function(id){
		        //alert(id);
		        //	var m=$('#list1').delRowData(id)
		       },
		       caption:"交易列表"
		});
		jQuery("#list1").jqGrid('navGrid','#pager1',{edit:false,del:false});
		var ret;
		$(function(){
			var curId = 1;
			var mon_id=0;
			var pre_id=0;
			MON020();
			function MON020()
			{
				var request ={
						"AvgTm_ID"    :     sysid ,
						"Cur_ID"    :     curId 
				}
				var encoded = $.toJSON( request );   
				var jsonStr = encoded; 
				jQuery.support.cors = true;
				$.ajax({
					url : 'http://12.0.98.43:5588/MON020',
					type : 'POST',
					data : jsonStr,
					dataType : 'json',
					success : function(data, textStatus, jqXHR) {
						ret=data.Seq; 
						if(ret.length<=0)
							return;
						for(var i=ret.length;i>0;i--){
							var tt=$('#list1').getGridParam('reccount');
							if(tt>49)
							{
								var m=$('#list1').delRowData(pre_id);
								$("#list1").addRowData(pre_id,ret[i-1], "first");
								pre_id=pre_id+1;
								if(pre_id>49)
									pre_id = 0;
								else{
									$("#list1").addRowData(mon_id,ret[i-1], "first");
									mon_id=mon_id+1;
									}
								}
							curId=data.UserData_CurID;
							}
						},
						error : function(xMLHttpRequest,textStatus,errorThrown) {
							alert(errorThrown);
							}
						});
				setTimeout(MON020,2000);
				}
			})
});

*/