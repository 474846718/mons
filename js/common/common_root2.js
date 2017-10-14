 
  (function(window){
			var root={}; 
			root.admin={}; 
			root.user={};
			root.tab={};
			root.iframe={}; 
			window.sy=root;   
   })(window); 
 
/*function:sy.bp
  description:获取路径
  author:田斌
  Date:2013年4月23日 12:57:25
*/ 
	sy.bp=function(){
		var curwwPath=window.document.location.href;
		var pathname=window.document.location.pathname;
		var pos=curwwPath.indexOf(pathname);
		var localpath=curwwPath.substring(0,pos);
		var projectName=pathname.substring(0,pathname.substr(1).indexOf('/')+1); 
		return (localpath+projectName);
	}   
	
	
	sy.namespace= function(str){
        var attr = str.split("."), o = sy;
        for (i = (attr[0] = "sy") ? 1 : 0; i < attr.length; i++) {
            o[attr[i]] = o[attr[i]] ||
            {};
            o = o[attr[i]];
        }
    }
	
	
	/*function: 
	  description:取出空格
	  author:田斌
	  Date:2013年4月23日 12:57:25
	*/
    String.prototype.Trim = function(){
        return this.replace(/(^\s*)|(\s*$)/g, "");
    }
    String.prototype.LTrim = function(){
        return this.replace(/(^\s*)/g, "");
    }
    String.prototype.RTrim = function(){
        return this.replace(/(\s*$)/g, "");
    }
   
