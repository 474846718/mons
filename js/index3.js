/**
 * @author Tianhan
 */


 /**
  *package:web
  *function: 
  *params:  
  *description: 
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 

$(function(){
    var $index_menuListUL_Obj2=jQuery("#index_menuList>ul"); //获取UL菜单列表
    var $index_menuList_Obj2=jQuery("#index_menuList>ul>li"); //获取菜单列表
    var $index_topTag_Container2=jQuery("#index_topTag");//获取div容器
    var $index_topTag_li=$index_topTag_Container2.find("ul li");
    var $index_topTag_a_Container2=$index_topTag_Container2.find("a");//获取div容器下的a标签
    var $index_topTag_a2=$index_topTag_Container2.find("a");
     
    var $J_bottom_right_Obj=jQuery('#J_bottom_right').find('.J_clickClass'); //获取div容器
    var $J_bottom_right_a=$J_bottom_right_Obj.find('a'); //获取div下的a标签
    
    
    
    
    doTabClose();
    openNewTab(); 
    topTagClick(); 
   
  
    
    
 /**
  *package:web
  *function: openNewTab()
  *params:  
  *description: 顶部菜单绑定点击事件
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 
 function openNewTab(){ 
        $J_bottom_right_Obj.delegate("a","click",function(event){   
            var a_href=jQuery.trim($(this).attr('href'));
            var a_obj=$index_topTag_Container2.find("a[href='"+a_href+"']"); 
            
            if(a_obj.length>0){
                a_obj.trigger("click"); 
            }else{
                createNewTag($(this).attr("href"),$(this).text()); 
            } 
       }); 
 } 
  /**
  *package:web
  *function: createNewTag
  *params:  $href:；链接,$text:文本
  *description: 创建新的tag
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 
function createNewTag($href,$text){
      var _aStr='<li><a target="mainFrame" class="tab_selected"  href="'+$href+'">'+$text+'</a><img src="images/image_close.png" class="imageClose"/></li>'; 
      clearTopTagStyle();
      jQuery("#index_topTag").find("li").last().after(_aStr); 
 }  
 /**
  *package:web
  *function: doTabClose
  *params:   
  *description: 关闭按钮绑定事件
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 function doTabClose(){ 
      $index_topTag_Container2.delegate('.imageClose','click',function(event){
      	
      	  //console.info($(this));
          var liObj=$(this).parent("li"); 
          var aObj=$(this).prev("a");  
          var preLiObj=liObj.prev(); 
          var preLi_aObj=preLiObj.find("a"); 
          if(aObj.hasClass('tab_selected')){
            liObj.remove();    
            clearTopTagStyle();
            preLiObj.find('a').addClass('tab_selected'); 
            $("#mainFrame").attr('src',preLi_aObj.attr("href"));
          }else{  
            liObj.remove();  
          } 
           return false;
      });  
 }
 
 
 
 
 
 
 
 
 /**
  *package:web
  *function: clearTopTagStyle
  *params:  
  *description:  清除TopTag选中样式
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 
 function clearTopTagStyle(){
     var $obj=jQuery("#index_topTag").find("a");
     for(i=0;i<$obj.length;i++){
           $($obj[i]).removeClass('tab_selected');
      }
 }
 

  /**
  *package:web
  *function: topTagClick
  *params:  
  *description:   给动态生成的tab添加点击事件,改变内容显示
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 function topTagClick(){  
      $index_topTag_Container2.delegate('a','click',function(){  
          clearTopTagStyle();
          jQuery(this).addClass('tab_selected'); 
      });
   }  
});
 

