var mysky = $.extend({}, mysky); //全局对象  


 /**
  *package: js.base.root-js
  *function:  
  *params:  
  *description:   命名空间规范:mysky.包名.方法名
  *author:tianbin 
  *Date:2013年07月09日 09:56:25
 **/ 

 /**
  *package: js.base.root-js
  *function: mysky.namespace
  *params: str:命名空间名字
  *description:   生成命名空间
  *author:tianbin 
  *Date:2013年07月09日 09:16:25
 **/ 
mysky.namespace = function(str){
    var attr = str.split("."), o = mysky;
    for (i = (attr[0] = "mysky") ? 1 : 0; i < attr.length; i++) {
        o[attr[i]] = o[attr[i]] || {};
        o = o[attr[i]];
    }
};
 /**
  *package: js.base.root-js
  *function: mysky.bp
  *params:  
  *description:   获取项目根路径
  *author:tianbin 
  *Date:2013年07月09日 09:56:25
 **/ 
mysky.bp = function(){
    var curwwPath = window.document.location.href;
    var pathname = window.document.location.pathname;
    var pos = curwwPath.indexOf(pathname);
    var localpath = curwwPath.substring(0, pos);
    var projectName = pathname.substring(0, pathname.substr(1).indexOf('/') + 1);
    return (localpath + projectName);
};


 /**
  *package: js.base.easyui-base.js
  *function:  mysky.serializeObject()
  *params:  
  *description:   将form元素的值序列化成对象
  *author:tianbin 
  *Date:2013年07月09日 14:19:25
 **/ 
mysky.serializeObject=function(form){  
	var o={};
	$.each(form.serializeArray(),function(index){
		if(o[this['name']]){
			o[this['name']]=o[this['name']]+","+this['value']; 
		}else{
		    o[this['name']]=this['value'];
		} 
	}) ;
	return o;
};
mysky.namespace("mysky.page.login"); 
mysky.namespace("mysky.page.reg"); 
mysky.namespace("mysky.card.jieji"); 
mysky.namespace("mysky.card.jiejiStatistic"); 
mysky.namespace("mysky.card.xinyong"); 
mysky.namespace("mysky.consume.consume"); 

