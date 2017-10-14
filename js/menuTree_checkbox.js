
		$(document).ready(function(){
			/**
			 * 无尽树
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
			 *背景图片
			 */
			$(".tree").children("li:first").children("a:first").children("span").addClass("first");
			$("#outside ul").each(function(){
				$(this).children("li:last").children("a:first").children("span").addClass("last");
			})
			/**
			 * 复选框
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
			 * 搜索功能
			 */
			//接收的应为对象，names,ids为对象的属性；objs=...;
			var names = ['节点一','节点二','节点三','节点一一','节点一二','节点一三','节点二一','节点二二','节点二三','节点一一一','节点一一二','节点一一三','节点一二一','节点一二二','节点一二三','节点二一一','节点二一二','节点二一三'];
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
					alert("内容为空！");
					return false;
				}
				var searchName = $(".searchName");
				if(searchName.length == 0){
					alert("您搜素内容不存在");
					return false;
				}else if(searchName.length == 1){
					$("#search").val($(".searchName").text());
				}else if(searchName.length > 1){
					var val = $("#search").val();
					var count = 0;
					var index = -1;
					//如果是对相集合，则在相应位置代入对象的属性；
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
						alert("您搜索的内容不存在");
					}else if(count > 1){
						alert("您搜索的内容存在多个，请选择");
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
					alert("请输入正确内容！");
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
