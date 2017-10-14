/**

 * iframe妤傛ê瀹抽懛顏堬拷鎼存柨鐫嗛獮鏇炪亣鐏忥拷

 * Author : 閻滃绔�

 * Version : 2012/12/21

 */

 

var iframeids=["sys_indexmainframe"]; 

 

itproot.iframes.dyniframesize = function() { 

	var dyniframe=new Array() 

	for (i=0; i<iframeids.length; i++) { 

		if (document.getElementById) { 

			//杩渋frame鍙�

			dyniframe[dyniframe.length] = document.getElementById(iframeids[i]); 

			if (dyniframe[i] && !window.opera) { 

				dyniframe[i].style.display="block"; 

				//alert(document.documentElement.clientHeight);

				//alert(window.screen.availHeight);

				if(dyniframe[i].id == "sys1_mainFrame"){

					dyniframe[i].height = document.documentElement.clientHeight-12;
					//dyniframe[i].height = window.screen.availHeight - 165;//dyniframe[i].contentDocument.body.offsetHeight; 
 
				}else if(dyniframe[i].id == "sys_indexmainframe"){ 
					dyniframe[i].height = document.documentElement.clientHeight-12; 

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





