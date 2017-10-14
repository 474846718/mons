/**
 * @author Tianhan
 */
;(function($) {  
    $.fn.extend({ 
        "tab" : function(options) {
            //设置默认值
            option = $.extend({
                selectClass : "select" //选中的样式 
            }, options);
           
           //寻找table下的a元素
           var _child=$(this).find("tbody > tr >td  a");
           var _table=$(this).find("tbody > tr >td").children("table");
           //console.info(_child);
           //console.info(_table);
           _child.click(function (){
                $(this).addClass(option.selectClass).siblings().removeClass(option.selectClass);  
               // console.info($(this).index());
                _table.eq($(this).index()).show().siblings().hide();
           })
        }
    });
})(jQuery);
