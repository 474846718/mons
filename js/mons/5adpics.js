//slideimages����Ϊ�任��ͼ
var slideimages=new Array();
slideimages[0]="images/ad-01.png";
slideimages[1]="images/ad-01.png";
slideimages[2]="images/ad-01.png";


//slidetext����Ϊ�任������
var slidetext=new Array();
slidetext[0]="����ͼ01";
slidetext[1]="����ͼ02";
slidetext[2]="����ͼ03";


//slidetext����Ϊ�����ͼ�������ĵ�ַ
var slidelinks=new Array();
slidelinks[0]="http://www.divcss5.com";
slidelinks[1]="http://www.divcss5.com";
slidelinks[2]="http://www.divcss5.com";


//����ͼ��ʼ���ݣ���start
var slidespeed=3000

var slidesanjiaoimages=new Array("images/bian2.gif","images/bian1.gif");
var slidesanjiaoimagesname=new Array("xiaosan1","xiaosan2","xiaosan3");

var filterArray=new Array();
filterArray[0]="progid:DXImageTransform.Microsoft.Fade ( duration=1,overlap=0.25 )";
filterArray[1]="progid:DXImageTransform.Microsoft.Fade ( duration=1,overlap=0.25 )";
filterArray[2]="progid:DXImageTransform.Microsoft.Fade ( duration=1,overlap=0.25 )";


var imageholder=new Array()
var ie55=window.createPopup
for (i=0;i<slideimages.length;i++){
imageholder[i]=new Image()
imageholder[i].src=slideimages[i]
}

function tu_ove(){clearTimeout(setID)}
function ou(){slideit()}

				var whichlink=0
				var whichimage=0
				
				function gotoshow(){
						window.open(slidelinks[whichlink]);
				}
				
				function slideit(){
				
				document.images.slide.style.filter=filterArray[whichimage];
				//alert(document.images.slide.style.filter);
				pixeldelay=(ie55)? (document.images.slide.filters[0].duration*1000) : 0
				//alert(pixeldelay);
				if (!document.images) return
				
				if (ie55) {
						document.images.slide.filters[0].apply();
						document.images.slide.filters[0].play();
						
				}
				document.images.slide.src=imageholder[whichimage].src
				
				document.getElementById("textslide").innerText=slidetext[whichimage];
				
				document.getElementById("xiaosan1").src=slidesanjiaoimages[0];
				document.getElementById("xiaosan2").src=slidesanjiaoimages[0];
				document.getElementById("xiaosan3").src=slidesanjiaoimages[0];
				
				
				document.getElementById(slidesanjiaoimagesname[whichimage]).src=slidesanjiaoimages[1];
				
				
				
				if (ie55) document.images.slide.filters[0].play()
				whichlink=whichimage
				whichimage=(whichimage<slideimages.length-1)? whichimage+1 : 0
				setID=setTimeout("slideit()",slidespeed+pixeldelay)
				}
				slideit()
				function ove(n){
					clearTimeout(setID)
					whichimage=n;
					document.images.slide.src=imageholder[whichimage].src
						
					document.getElementById("textslide").innerText=slidetext[whichimage];
					document.getElementById("xiaosan1").src=slidesanjiaoimages[0];
					document.getElementById("xiaosan2").src=slidesanjiaoimages[0];
					document.getElementById("xiaosan3").src=slidesanjiaoimages[0];
					
					document.getElementById(slidesanjiaoimagesname[whichimage]).src=slidesanjiaoimages[1];
				}
		