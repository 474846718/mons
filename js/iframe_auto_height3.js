/**

 * iframe濡ゅ倹锚鐎规娊鎳涢鍫嫹閹煎瓨鏌ㄩ惈鍡涚嵁閺囩偑浜ｉ悘蹇ユ嫹

 * Author : 闁绘粌顑呯粩锟�
 * Version : 2012/12/21

 */

 

var iframeids=["sys1_mainFrame","sys1_menutree"]; 

 var rightHeight;

itproot.iframes.dyniframesize = function() { 

	var dyniframe=new Array() 

	for (i=0; i<iframeids.length; i++) { 

		if (document.getElementById) { 

			//鏉╂笅frame閸欙拷

			dyniframe[dyniframe.length] = document.getElementById(iframeids[i]); 

			if (dyniframe[i] && !window.opera) { 

				dyniframe[i].style.display="block"; 

				//alert(document.documentElement.clientHeight);

				//alert(window.screen.availHeight);

				if(dyniframe[i].id == "sys1_mainFrame"){ 
					 rightHeight=dyniframe[i].height = document.documentElement.clientHeight-50;
					//dyniframe[i].height = window.screen.availHeight - 165;//dyniframe[i].contentDocument.body.offsetHeight; 
 
				}else if(dyniframe[i].id == "sys1_menutree"){ 
					//dyniframe[i].height = document.documentElement.clientHeight-50; 
                    dyniframe[i].height=rightHeight-30;
				}

			} 

		}  

	} 

} 

if (window.addEventListener) 

window.addEventListener("load", itproot.iframes.dyniframesize, false); 

else if (window.attachEvent) 

window.attachEvent("onload", itproot.iframes.dyniframesize); 

else 

window.onload=itproot.iframes.dyniframesize; 





