/**
 * @author Tianhan
 */
;(function($) {  
    $.fn.extend({ 
        "tab" : function(options) {
            //����Ĭ��ֵ
            option = $.extend({
                selectClass : "select" //ѡ�е���ʽ 
            }, options);
           
           //Ѱ��table�µ�aԪ��
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
