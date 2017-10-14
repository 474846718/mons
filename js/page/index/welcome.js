 /**
  *package: js/page/index/welcome.js
  *function:  adtec.index.welcome.sysClassInit
  *params:  
  *description:  初始化用户的系统列表tab
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/  
     adtec.index.welcome.sysClassInit=function(id,selectId){
             if($("#tab"+id).hasClass("tabClass")){ 
             }else{
                $("#tab"+id).addClass("tabClass");
             }
               $("#tab"+selectId).addClass("select");
               $("#tab"+id).show();
               $($("#tab"+selectId).attr("href")).show();
       }
   
/**
  *package: js/page/index/welcome.js
  *function:  adtec.index.welcome.sysTypeInit
  *params:  rowslist:集合,sysType:系统类型
  *description:  根据系统架构类型匹配URL
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/  
	adtec.index.welcome.sysTypeInit=function(rowslist,sysType){ 
	  var url='';
	  if(sysType==1){
	      url=rowslist.sysUrl ;
	  }else if(sysType==2){
	      url='';
	  }else if(sysType==3){ 
	      url='Integrate.action?SysId='+rowslist.sysId+'&sysType='+rowslist.sysType+'&integrateType='+rowslist.integrateType+'';
	  }  
	  return url;
	}
 
/**
  *package: js/page/index/welcome.js
  *function:  adtec.index.welcome.appendToUL
  *params:  id:插入的目标容器,liStr:被插入的字符串,type:插入的类型; 1:append,2:after
  *description:  li内容插入到Ul中 
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/ 
	adtec.index.welcome.appendToUL =function(id,liStr,type){
		if(type==1){
		    $("#"+id).append(liStr);
		}else if(type==2){
		    $("#"+id).after(liStr);
		 } else if(type==3){
		 	$("#"+id).before(liStr);
		 }  
  }
     
/**
  *package: js/page/index/welcome.js
  *function: adtec.index.welcome.tabClick
  *params:  
  *description:  tab的点击事件
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/ 
	adtec.index.welcome.tabClick=function(){  
	  $("#tbContainer").find("a.tabClass").click(function(){  
	        $(this).addClass("select").siblings(".tabClass").removeClass("select"); 
	        $($(this).attr("href")).show().siblings().hide();
	  }) 
	}
	 
/**
  *package: js/page/index/welcome.js
  *function: adtec.index.welcome.deleteCommon
  *params:  sysId:系统ID,this：当前的a对象
  *description:  常用系统列表删除(物理删除)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/ 
	adtec.index.welcome.deleteLi=function(obj,sysId,operId,employeeId){   
	    $(obj).parent("td").parent("tr").parent("tbody").parent("table").parent("li").remove();
	    adtec.index.welcome.deleteCommon(sysId,operId,employeeId);
	}
 /**
  *package: js/page/index/welcome.js
  *function: adtec.index.welcome.liIdToStr
  *params:   
  *description: 整形转换为字符串
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/  
adtec.index.welcome.liIdToStr=function(id,str){ 
	  if(str!=null && str.length>0){
	    return ''+id+''+str+'';
	  }else{
	    return id;
	  }
	 }  
/**
  *package: js/page/index/welcome.js
  *function:adtec.index.welcome.addLi
  *params:   
  *description:  插入Li
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/  
 adtec.index.welcome.addLi=function(obj,sysId,operId,employeeId){ 
	 var objParent=$(obj).parent("td").parent("tr").parent("tbody").parent("table").parent("li");
	 var addId=objParent.attr("id");//当前li的ID 
	 //判断常用系统是否已经存在添加的系统
	 var flag=false;  
	 if($("#commonlist").find("li").length>0){ 
	     $("#commonlist").find("li").each(function(i,value){ 
	        if(adtec.index.welcome.liIdToStr(addId,"c")== $(this).attr("id")){
	          alert($(this).text()+"已存在!"); 
	          flag=true;
	        } 
	     })
	  }
	   
	  
	  //如果不存在的话
       if(!flag){
         var objClone=objParent.clone(); 
	     $("#commonlist").find("li:first").before(objClone);   
	     $("#commonlist").find("li table tbody tr td.sys_add").removeClass("sys_add").addClass("sys_delete"); 
	     //需要改变事件  
	     var $a=$("#commonlist").find("li table tbody tr td.sys_delete a");  
	     var onclickStr=$a.attr('onclick'); 
	     $a.attr('onclick','');  //兼容IE10以下的版本  如果不清空，会默认执行第一个事件   在该实例中默认执行adtec.index.welcome.addLi();   
	     if(onclickStr.indexOf('addLi')>-1){
	       var newStr=onclickStr.replace("addLi","deleteLi");  
	            $a.attr("onclick",newStr);
	      }    
	      $("#commonlist").find("li").eq(0).attr("id",$("#commonlist").find("li").eq(0).attr("id")+"c"); 
	      adtec.index.welcome.addCommon(sysId,operId,employeeId); 
       } 
	}
	 
 
/**
  *package: js/page/index/welcome.js
  *function:adtec.index.welcome.deleteCommon
  *params:   sysId:系统ID
  *description:  常用系统列表删除(数据库中删除)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/  
	adtec.index.welcome.deleteCommon=function(sysId,operId,employeeId){  
	   if(sysId){
	      $.post(adtec.bp()+"/deleteu.action", { SysId:sysId,OperId:operId,EmployeeId:employeeId,type:2},
           function(data){
        });
	  } 
	}
 
/**
  *package: js/page/index/welcome.js
  *function:adtec.index.welcome.deleteCommon
  *params:  sysId:系统ID
  *description:  常用系统添加(数据库添加)
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/
	adtec.index.welcome.addCommon=function(sysId,operId,employeeId){  
	   if(sysId){
	      $.post(adtec.bp()+"/deleteu.action", { SysId:sysId,OperId:operId,EmployeeId:employeeId,type:1},
           function(data){
              // console.info("添加成功!");
        });
	  } 
	} 

/**
  *package: js/page/index/welcome.js
  *function:adtec.index.welcome.createId
  *params:  sysId:系统ID
  *description: 生成唯一的ID
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/
	adtec.index.welcome.createId=function(sysId,operId,employeeId){
	    var id=sysId+operId+employeeId; 
	    return id;
	}

	
 /**
  *package: js/page/index/welcome.js
  *function:adtec.index.welcome.sysInit
  *params:   
  *description: 初始化用户的系统列表
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:32:25
 **/ 
    adtec.index.welcome.sysInit=function(){
         $.post(adtec.bp()+"/query.action", "",
			   function(data){
				   var len=data.rows.length; 
				   var liStr1='';  var liStr2=''; var liStr3=''; var liStr4='';
			   if(data!=null){
			       for(i=0;i<len;i++){ 
			          adtec.index.welcome.sysClassInit(data.rows[i].sysInfo.sysSort,data.rows[0].sysInfo.sysSort);  
			          //操作类业务系统  
			          if(data.rows[i].sysInfo.sysSort==1){
			                   liStr1+='<li  id="'+data.rows[i].sysId+data.rows[i].operId+data.rows[i].employeeId+'"><table class="systerm_photo"> <tr> <td><img src="../images/sys_icon1.jpg" /></td>' ;
			                   liStr1+='<td><a class="nameclass" href="#" rel="'+adtec.index.welcome.sysTypeInit(data.rows[i].sysInfo,data.rows[i].sysInfo.sysType)+'">'+data.rows[i].sysCName+'</a></td>';
			                   liStr1+='<td class="sys_add"><a href="#" onclick="adtec.index.welcome.addLi(this,\''+data.rows[i].sysId+'\',\''+data.rows[i].operId+'\',\''+data.rows[i].employeeId+'\')"></a></td></tr></table></li>'; 
			           //管理信息类系统 
			          }else if(data.rows[i].sysInfo.sysSort==2){
			                   liStr2+='<li id="'+data.rows[i].sysId+data.rows[i].operId+data.rows[i].employeeId+'"><table class="systerm_photo"> <tr> <td><img src="../images/sys_icon2.jpg" /></td>' ;
			                   liStr2+='<td><a class="nameclass" href="#" rel="'+adtec.index.welcome.sysTypeInit(data.rows[i].sysInfo,data.rows[i].sysInfo.sysType)+'">'+data.rows[i].sysInfo.sysCName+'</a></td>';
			                   liStr2+='<td class="sys_add"><a href="#" onclick="adtec.index.welcome.addLi(this,\''+data.rows[i].sysId+'\',\''+data.rows[i].operId+'\',\''+data.rows[i].employeeId+'\')"></a></td></tr></table></li>'; 
			          //渠道类系统 
			          }else if(data.rows[i].sysInfo.sysSort==3){
			                   liStr3+='<li id="'+data.rows[i].sysId+data.rows[i].operId+data.rows[i].employeeId+'"><table class="systerm_photo"> <tr> <td><img src="../images/sys_icon3.jpg" /></td>' ;
			                   liStr3+='<td><a class="nameclass" href="#" rel="'+adtec.index.welcome.sysTypeInit(data.rows[i].sysInfo,data.rows[i].sysInfo.sysType)+'">'+data.rows[i].sysInfo.sysCName+'</a></td>';
			                   liStr3+='<td class="sys_add"><a href="#" onclick="adtec.index.welcome.addLi(this,\''+data.rows[i].sysId+'\',\''+data.rows[i].operId+'\',\''+data.rows[i].employeeId+'\')"></a></td></tr></table></li>'; 
			          } 
			          //常用系统
			          if(data.rows[i].isCommonUsed==1){
			                   liStr4+='<li id="'+data.rows[i].sysId+data.rows[i].operId+data.rows[i].employeeId+'c"><table class="systerm_photo"> <tr> <td><img src="../images/sys_icon4.jpg" /></td>' ;
			                   liStr4+='<td><a class="nameclass" href="#" rel="'+adtec.index.welcome.sysTypeInit(data.rows[i].sysInfo,data.rows[i].sysInfo.sysType)+'">'+data.rows[i].sysInfo.sysCName+'</a></td>';
			                   liStr4+='<td class="sys_delete"><a href="#" onclick="adtec.index.welcome.deleteLi(this,\''+data.rows[i].sysId+'\',\''+data.rows[i].operId+'\',\''+data.rows[i].employeeId+'\')"></a></td></tr></table></li>';   
			          }
			       } 
			      adtec.index.welcome.tabClick(); 
			      adtec.index.welcome.appendToUL("tab-content2",liStr2,1);
			      adtec.index.welcome.appendToUL("tab-content3",liStr3,1);  
			      adtec.index.welcome.appendToUL("noneId",liStr4,3); 
			    } 
			}, "json");  
       } 

      $(function(){  
            adtec.index.welcome.sysInit(); 
        })  