 
 /**
  *package: js/common/common_table_tab.js
  *function:  
  *params:  
  *description:   tab切换功能，适用于表格的tab切换
  *author:tianbin 
  *email:tianbin@adtec.com.cn
  *Date:2013年08月27日 14:19:25
 **/ 
;(function($) {  
    $.fn.extend({ 
        "tab" : function(options) {
            //设置默认值
            option = $.extend({
                selectClass : "select", //选中的样式 
                isOpen:'true'           //是否开启tab功能
            }, options);
           
		   if(option.isOpen){
		   	    //寻找table下的a元素
           var _child=$(this).find("tbody > tr >td  a");
           var _table=$(this).find("tbody > tr >td").children("table"); 
           _child.click(function (){
                $(this).addClass(option.selectClass).siblings().removeClass(option.selectClass);  
                _table.eq($(this).index()).show().siblings().hide();
           })
		   } 
        }
    });
})(jQuery);
