/**
 * @author TianHan
 */

  /*
	str:需要截取的字符串,start 
       必选项。所需的子字符串的起始位置。字符串中的第一个字符的索引为 0。
       可选项。在返回的子字符串中应包括的字符个数。
       当menu的标题为空时所定义的新标题名称
  */ 
  
  	String.prototype.subStrs=function(_begin,_length,_title){  
		return (this.isEmpty)?"":this.substr(_begin,_length); 
	}
	// 判断字符串是否以指定的字符串开始
	String.prototype.startsWith = function(str) {
	    return this.substr(0, str.length) == str;
	}
	//判断字符串是否为空
	String.prototype.isEmpty=function(){
		return (""==this.trim() || this.length<=0)?false:true;
	}
	//删除字符串的空格
	String.prototype.trim=function(){
		return this.replace(/(^\s*)|(\s*$)/g,"");
	}
	//删除字符串右边的空格
	String.prototype.rstrim=function(){
	    return this.replace(/(\s*$)/g,"");
	}
	//删除字符串左边的空格
	String.prototype.lstrim=function(){
	   return this.replace(/(^\s*)/g,"");
	}
	
	 
   
    
  	 
      
    
  