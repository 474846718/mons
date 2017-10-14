/**
  *package:web
  *function: 重写orgInfo表单验证，重写tellerinfo表单验证
  *params:  
  *description: 重写机构编号验证，，该编号是由2-8为数字组成；
  *				重写邮政编码，该编号是由1-9中的任何五位数字组成吗；
  *				重写号码，验证手机号码和电话号码；
  *				重写身份证号码验证，，该编号是由17+字母或18位数字组成；
  *author:贠炳森
  *Date:2013年12月25日 
 **/ 

$.extend($.fn.validatebox.defaults.rules, {   
    length: { //验证机构编号
        	validator: function(value){  
            return  /^\d{2,8}$/i.test(value);   
        	},   
        	message: '请输入2-8位由数字组成的编码!'  
    	},
     zipCode:  {// 验证邮政编码
             validator: function (value) {
                 return /^[1-9]\d{5}$/i.test(value);
             },
             message: '邮政编码格式不正确!'
         },
     mobile: {// 验证手机号码和电话号码
             validator: function (value) {
                 return /^((0\d{2,3}-\d{7,8})|((13|15|18|14)\d{9}))$/i.test(value);
             },
             message: '号码格式不正确!'
         },
     idcard: {// 验证身份证
             validator: function (value) {
                 return /^\d{15}(\d{2}[A-Za-z0-9])?$/i.test(value);
             },
             message: '身份证号码格式不正确'
         }
});

/**
 *package:web
 *function: 重写resource表单验证
 *params:  
 *description: 重写交易分类编号验证，该编号是由2-8为数字组成；
 *			   重写六码交易验证，该交易码是由6位数字组成
 *author:贠炳森
 *Date:2013年12月26日 
**/ 
$.extend($.fn.validatebox.defaults.rules, {   
    length: { //验证交易分类编号
        	validator: function(value){  
            return  /^\d{2,8}$/i.test(value);   
        	},   
        	message: '请输入2-8位由数字组成的编码!'
    	},
    sixlength: { //验证六码交易
        	validator: function(value){  
            return  /^\d{6}$/i.test(value);   
        	},   
        	message: '请输入6位由数字组成的六码交易!'
    	}
});
