 /**
  *package: js.base.easyui-base.js
  *function:  
  *params:  
  *description:    验证两次输入的值是否一致
  *author:tianbin 
  *Date:2013年07月09日 14:19:25
 **/
 $.extend($.fn.validatebox.defaults.rules, {   
    eqPwd: {   
        validator: function(value,param){    
            return value == $(param[0]).val();   
        },   
        message: '两次输入的值不一致!'  
    }   
});  

  /** function:   
  *  description: 扩展datagrid，添加动态增加或删除Editor的方法 
  * 例子如下，第二个参数可以是数组 
  * 
  * datagrid.datagrid('removeEditor', 'cpwd'); 
  * datagrid.datagrid('addEditor', [ { field : 'ccreatedatetime', editor : { type : 'datetimebox', options : { editable : false } } }, { field : 'cmodifydatetime', editor : { type : 'datetimebox', options : { editable : false } } } ]);
  *  author:田斌
  *  Date:2013年5月26日 09:50:25
 **/ 
$.extend($.fn.datagrid.methods, {
	addEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item.field);
				e.editor = item.editor;
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param.field);
			e.editor = param.editor;
		}
	},
	removeEditor : function(jq, param) {
		if (param instanceof Array) {
			$.each(param, function(index, item) {
				var e = $(jq).datagrid('getColumnOption', item);
				e.editor = {};
			});
		} else {
			var e = $(jq).datagrid('getColumnOption', param);
			e.editor = {};
		}
	}
});

 /**
  *package: js.base.easyui-base.js
  *function:  
  *params:  
  *description:  扩展datimebox ,datetime不能选择时间
  *author:tianbin 
  *Date:2013年07月09日 14:19:25
 **/
 
    $.extend($.fn.datagrid.defaults.editors, {  
        datetimebox: {  
            init: function(container, options){  
                var editor = $('<input/>').appendTo(container);  
				options.editable=false;
				editor.datetimebox(options);
                return editor;  
            },  
            getValue: function(target){  
                return $(target).datetimebox('getValue');  
            },  
            setValue: function(target, value){  
              return $(target).datetimebox('setValue',value);  
            },  
            resize: function(target, width){  
                return $(target).datetimebox('resize',width);
            } ,
			destory: function(target){  
              return $(target).datetimebox('destory');  
            }
        }  
    });
