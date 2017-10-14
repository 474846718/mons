var adtec = $.extend({}, adtec); //全局对象   
 
 /**
  *package: js/common/common_root.js
  *function: adtec.namespace()
  *params: str:命名空间名字
  *description:   生成命名空间
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 14:19:25
 **/ 
adtec.namespace = function(str){
    var attr = str.split("."), o = adtec;
    for (i = (attr[0] = "adtec") ? 1 : 0; i < attr.length; i++) {
        o[attr[i]] = o[attr[i]] || {};
        o = o[attr[i]];
    }
};
 /**
  *package: js/common/common_root.js
  *function: adtec.bp()
  *params:  
  *description: 获取项目根路径,用法如:url=adtec.bp()+"testAction.action";
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 14:21:25
 **/ 
adtec.bp = function(){
    var curwwPath = window.document.location.href;
    var pathname = window.document.location.pathname;
    var pos = curwwPath.indexOf(pathname);
    var localpath = curwwPath.substring(0, pos);
    var projectName = pathname.substring(0, pathname.substr(1).indexOf('/') + 1);
    return (localpath + projectName);
};

/**********************************************************************************************************
 * 以下为目录名
 * base: 为common层和page层提供接口，一般情况是存放jquery,如jquery-1.10.1.min.js
 * common:为page层提供组件,一般存放jQuery UI等组件
 * page:完成页面的功能需求
 * 页面中调用的方法都是在page目录下的方法，如需调用common层的方法，需要在page层进行封装，然后调用
 * 命名空间命名方法如下:
 *  adtec.包名.js名
 *  示例: 
 *  JS存放路径：test/test.js  
 *  adtec.namespace("adtec.test.test");  
 * ********************************************************************************************************/
 
 /**
  *package: js/common/common_root.js
  *function:  
  *params:  
  *description:  用户登录页面的JS
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 
 adtec.namespace("adtec.login.login");
  /**
  *package: js/common/common_root.js
  *function:  
  *params:  
  *description:  main.jsp页面的JS
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:12:25
 **/ 
 adtec.namespace("adtec.index.index");
 
   /**
  *package: js/common/common_root.js
  *function:  
  *params:  
  *description:  welcome.jsp页面的JS
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月28日 09:12:25
 **/
 adtec.namespace("adtec.index.welcome");
  /**
  *package: js/common/common_root.js
  *function:  
  *params:  
  *description:用户
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 15:02:25
 **/ 
 adtec.namespace("adtec.im.custom");
 
 
 
 
