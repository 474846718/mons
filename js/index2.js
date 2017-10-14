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
    var $index_menuListUL_Obj=jQuery("#index_menuList>ul,#J_bottom_right"); //获取UL菜单列表
    var $index_menuList_Obj=jQuery("#index_menuList>ul>li"); //获取菜单列表
    var $index_topTag_Container=jQuery("#index_topTag");//获取div容器
    var $index_topTag_li=$index_topTag_Container.find("ul li");
    var $index_topTag_a_Container=$index_topTag_Container.find("a");//获取div容器下的a标签
    var $index_topTag_a=$index_topTag_Container.find("a");
     
    var $J_bottom_right_Obj=jQuery('#J_bottom_right').find('.J_clickClass'); //获取div容器
    var $J_bottom_right_a=$J_bottom_right_Obj.find('a'); //获取div下的a标签
    
    
    
    
    doTabClose();
    openNewTab(); 
    topTagClick(); 
    addQuanSys();
    deleteMySys();
    /*divSortAble();*/
    
    
 /**
  *package:web
  *function: openNewTab()
  *params:  
  *description: 顶部菜单绑定点击事件
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 
 function openNewTab(){ 
        $index_menuListUL_Obj.delegate("a","click",function(event){   
           // var a_href=jQuery.trim($(this).attr('href')),a_obj=$index_topTag_Container.find("a[href='"+a_href+"']");
        	var a_sysno=jQuery.trim($(this).attr('sysno')),a_obj=$index_topTag_Container.find("a[sysno='"+a_sysno+"']");  
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
      $index_topTag_Container.delegate('.imageClose','click',function(event){
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
      })  
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
      $index_topTag_Container.delegate('a','click',function(){  
          clearTopTagStyle();
          jQuery(this).addClass('tab_selected'); 
      }) 
  } 
  
  
  
 /**
  *package:web
  *function: addQuanSys
  *params:  
  *description:  全部系统的添加功能
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 function addQuanSys(){
    jQuery(document).find('#J_index_quan_add').on('click','span',function(){
                     var $quanSysLi=$(this).parent("li");
                     var $quanSysLiClone=$quanSysLi.clone();
                     var $span=$quanSysLiClone.find('span').removeClass("add").addClass("delete"); 
                     $("#J_index_quan_delete").find("li").last().after($quanSysLiClone);
                     $quanSysLi.remove(); 
                     return false;
     }); 
 }
  
  /**
  *package:web
  *function: deleteMySys
  *params:  
  *description:  我的系统的删除功能
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/  
  
   function deleteMySys(){ 
     var $index_my_deleteObj=jQuery("#J_index_quan_delete").find('li');//全部系统的添加按钮对象  
      jQuery(document).find('#J_index_quan_delete').on('click','li span',function(){
                     var $mySysLi=$(this).parent("li");
                     var $mySysLiClone=$mySysLi.clone();
                     var $span=$mySysLiClone.find('span').removeClass("delete").addClass("add"); 
                     jQuery("#J_index_quan_add").find("li").last().after($mySysLiClone);
                     $mySysLi.remove(); 
                     return false;
     }); 
   } 
})
  /**
  *package:web
  *function: openSysEditDiv
  *params:  
  *description:  弹出弹出框
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
 function openSysEditDiv(){
      $("#J_sys_editDiv").OpenDiv(); 
 }
 /**
  *package:web
  *function: openSysEditDiv
  *params:  
  *description:  关闭弹出框
  *author:田斌
  *Date:2013年10月13日 10:46:25
 **/ 
  function closeSysEditDiv(){
      $("#J_sys_editDiv").CloseDiv(); 
 }
  /**
   *package:web
   *function: openSysEditDiv
   *params:  
   *description:  弹出弹出框
   */
  function openImgEditDiv(){
       $("#J_img_editDiv").OpenDiv(); 
  }
  function openImgEditDiv1(){
      $("#J_img_editDiv1").OpenDiv(); 
 }
  /**
   *package:web
   *function: closeImgEditDiv
   *params:  
   *description:  关闭弹出框
  **/ 
   function closeImgEditDiv(){
       $("#J_img_editDiv").CloseDiv(); 
  }
