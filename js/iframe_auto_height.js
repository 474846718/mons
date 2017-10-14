/**

 * iframe楂樺害鑷�搴斿睆骞曞ぇ灏�

 * Author : 鐜嬪竻

 * Version : 2012/12/21

 */

 

var iframeids=["menu_tree","mainFrame"]; 

 

itproot.iframes.dyniframesize = function() { 

	var dyniframe=new Array() 

	for (i=0; i<iframeids.length; i++) { 

		if (document.getElementById) { 

			//远iframe叨 

			dyniframe[dyniframe.length] = document.getElementById(iframeids[i]); 

			if (dyniframe[i] && !window.opera) { 

				dyniframe[i].style.display="block"; 

				//alert(document.documentElement.clientHeight);

				//alert(window.screen.availHeight);

				if(dyniframe[i].id == "menu_tree"){

					dyniframe[i].height = document.documentElement.clientHeight - 266;

					//dyniframe[i].height = window.screen.availHeight - 165;//dyniframe[i].contentDocument.body.offsetHeight; 

					

				}else if(dyniframe[i].id == "mainFrame"){

					dyniframe[i].height = document.documentElement.clientHeight - 155;

					//dyniframe[i].height = window.screen.availHeight -272;

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





