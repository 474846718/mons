
		$(document).ready(function(){
			/**
			 * �޾���
			 */
			$(".tree a").click(function(){
				if(!$(this).parent("li").children("a:first").children("span").hasClass("open")){
					$(this).parent("li").siblings("li").children("ul").hide(500);
					$(this).parent("li").siblings("li").children("a:first").children("span").removeClass("open");
					$(this).siblings("ul").show(500);
					$(this).parent("li").children("a:first").children("span").addClass("open");
				}else{
					if(!$(this).parent("li").hasClass("file")){
						$(this).siblings("ul").hide(500);
						$(this).parent("li").children("a:first").children("span").removeClass("open");
					}
				}
			});
			/**
			 *����ͼƬ
			 */
			$(".tree").children("li:first").children("a:first").children("span").addClass("first");
			$("#outside ul").each(function(){
				$(this).children("li:last").children("a:first").children("span").addClass("last");
			})
			/**
			 * ��ѡ��
			 */
			$(".tree input:checkbox").click(function(){
				var check = this.checked;
				$(this).next("a").next("ul").find("input:checkbox").each(function(){
					this.checked = check;
				});
				$("input:checkbox").each(function(){
					if(this.checked){
						$(this).css("background-image","url(../images/check_2.png)");
					}else{
						$(this).css("background-image","url(../images/check_0.png)");
					}
				});
				$("#outside ul").each(function(){
					var sons = $(this).find(".file input:checkbox");
					var parent = $(this).siblings(".tree input:checkbox");
					var flag1 = false;
					for(var i=0; i<sons.length; i++){
						if(sons[i].checked){
							flag1 = true;
						}
					}
					var flag2 = false;
					for(var i=0; i<sons.length; i++){
						if(!sons[i].checked){
							flag2 = true;
						}
					}
					if(flag1){
						parent.attr("checked",true);
						if(flag2){
							parent.css("background-image","url(../images/check_1.png)");
						}else{
							parent.css("background-image","url(../images/check_2.png)");
						}
					}else{
						parent.attr("checked",false);
						parent.css("background-image","url(../images/check_0.png)");
					}
				});
			});
			/*function judge(){
				$(".tree input:checkbox").each(function(){
					var sons = $(this).parent().parent().children("li").children("input:checkbox");
					var parent = $(this).parent().parent().parent().children("input:checkbox");
					var flag = false;
					for(var i=0; i<sons.length; i++){
						if(sons[i].checked){
							flag = true;
						}
					}
					parent.attr("checked",flag?true:false);
				});
			}*/
			/**
			 * ��������
			 */
			//���յ�ӦΪ����names,idsΪ��������ԣ�objs=...;
			var names = ['�ڵ�һ','�ڵ��','�ڵ���','�ڵ�һһ','�ڵ�һ��','�ڵ�һ��','�ڵ��һ','�ڵ����','�ڵ����','�ڵ�һһһ','�ڵ�һһ��','�ڵ�һһ��','�ڵ�һ��һ','�ڵ�һ����','�ڵ�һ����','�ڵ��һһ','�ڵ��һ��','�ڵ��һ��'];
			var ids = ['10001','10002','10003','100011','100012','100013','100021','100022','100023','1000111','1000112','1000113','1000121','1000122','1000123','1000211','1000212','1000213'];
			var val;
			$("#search").focus(function(){
				val = $(this).val();
			});
			$("#search").keyup(function(){
				if($(this).val().length == 0){
					$("#downBox a").remove();
					$("#downBox").hide();
				}else{
					if(val != $(this).val()){
						$("#downBox").show();
						val = $(this).val();
						var flag = true;
						$("#downBox a").remove();
						/*for(var i=0; i<objs.length; i++){
							var info = objs[i].name + obj[i].id;
							if(info.indexOf(val) >= 0){
								
							}
						}*/
						for(var i=0; i<names.length; i++){
							var info1 = names[i] + ids[i];
							var info2 = names[i] + '|ID:' + ids[i];
							/* if(info.indexOf(val) >= 0){
								$("#downBox").append('<a href="javascript:void(0);" class="searchName">' + names[i] + '|ID:' + ids[i] + '</a>');
								flag = false;
							} */
							if(names[i].indexOf(val) >= 0){
								$("#downBox").append('<a href="javascript:void(0);" class="searchName">' + names[i] + '|ID:' + ids[i] + '</a>');
								flag = false;
							}else{
								if(ids[i].indexOf(val) >= 0){
									$("#downBox").append('<a href="javascript:void(0);" class="searchName">' + names[i] + '|ID:' + ids[i] + '</a>');
									flag = false;
								}else{
									if(info1.indexOf(val) >= 0){
										$("#downBox").append('<a href="javascript:void(0);" class="searchName">' + names[i] + '|ID:' + ids[i] + '</a>');
										flag = false;
									}else{
										if(info2.indexOf(val) >= 0){
											$("#downBox").append('<a href="javascript:void(0);" class="searchName">' + names[i] + '|ID:' + ids[i] + '</a>');
											flag = false;
										}
									}
								}
							}
						}
						if(flag){
							$("#downBox").hide();
						}
					}
				}
				$(".searchName").click(function(){
					$("#search").val($(this).text());
					search();
				});
			});
			$("#searchBtn").click(function(){
				String.prototype.trim=function(){return this.replace(/(^\s*)|(\s*$)/g,"");}
				if($("#search").val().trim() == ""){
					alert("����Ϊ�գ�");
					return false;
				}
				var searchName = $(".searchName");
				if(searchName.length == 0){
					alert("���������ݲ�����");
					return false;
				}else if(searchName.length == 1){
					$("#search").val($(".searchName").text());
				}else if(searchName.length > 1){
					var val = $("#search").val();
					var count = 0;
					var index = -1;
					//����Ƕ��༯�ϣ�������Ӧλ�ô����������ԣ�
					for(var i=0; i<names.length; i++){
						if(names[i] == val){
							count++;
							index = i;
						}else{
							if(ids[i] == val){
								count++;
								index = i;
							}else{
								var info1 = name[i] + ids[i];
								if(info1 == val){
									count++;
									index = i;
								}else{
									var info2 = names[i] + '|ID:' + ids[i];
									if(info2 == val){
										count++;
										index = i;
									}
								}
							}
						}
					}
					if(count == 0){
						alert("�����������ݲ�����");
					}else if(count > 1){
						alert("�����������ݴ��ڶ������ѡ��");
						$("#downBox").show();
						return false;
					}else if(count == 1){
						$("#search").val(names[index] + '|ID:' + ids[index]);
					}
				}
				search();
			});
			function search(){
				var text = $("#search").val();
				var id = text.substr(text.indexOf("|ID:")+4);
				$("#downBox").hide();
				$(".tree ul").hide();
				$(".tree a").children("span").removeClass("open");
				$("#"+id).parents("#outside ul").siblings(".tree a:first").children("span").addClass("open");
				$("#"+id).parents("#outside ul").show();
				/*var flag = false;
				for(var i=0; i<names.length; i++){
					if(text == names[i]){
						flag = true;
					}
				}
				if(!flag){
					alert("��������ȷ���ݣ�");
					return false;
				}else{
					$("#downBox").hide();
					$(".tree ul").hide();
					$(".tree a").removeClass("open");
					$(".tree a:contains(" + text + ")").each(function(){
						if(text == $(this).text()){
							$(this).parents().siblings(".tree a").addClass("open");
							$(this).parents().show();
						}
					});
				}*/
			}
			$("#search").blur(function(){
				if(!$("#downBox").is(":focus") && !$("#downBox a").is(":focus")){
					$("#downBox").hide();
				}
			});
			$("#downBox").blur(function(){
				if(!$("#search").is(":focus")){
					$("#downBox").hide();
				}
			});
			
		});
