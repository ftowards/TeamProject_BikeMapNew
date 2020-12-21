	$(function(){
		// 카테고리 추가
			$("#catename").on('change',function(){
				if($(this).val() == 'addCategory'){
					var catename = prompt("새 카테고리 이름을 입력하세요.", "새 코스");
					var overlap = 0;
					
					// 카테고리 추가 시 중복 확인
					$("#catename").children("option").each(function(){
						var names = $(this).attr("title");
						if(names == catename){
							toast("이미 등록된 이름입니다.");
							overlap++;
							return false;
						}
					});
					
					// 중복이 없다면 비동기식으로 새로운 카테고리 추가
					if(overlap ==0){
						var url = "/home/insertCategory";
						var data = "catename="+catename;
			
						$.ajax({
							type : 'POST',
							url : url,
							data : data,
							success : function(result){
								if(result == 1){
									toast("새로운 카테고리가 추가되었습니다.", 1500);
									selectCategory();
								}else{
									toast("카테고리 추가 에러", 1500);
								}
							}, error : function(){
								console.log("카테고리 새로 추가 에러");
							}
						});
					}			
				}else{
					return false;
				}
			});

		// 카테고리 새로 설정하기
			function selectCategory(){
				var url = "/home/selectCategory";
				var tag = "";
				
				$.ajax({
					url : url,
					success : function(result){
						var cnt = 0;
						// 카테고리 리스트 추가
						$.each(result, function(index, value){
							tag += "<option value='"+value.noroutecate+"' title='"+ value.catename+"'>"+value.catename+"</option>";
							cnt++;
						});
						
						// 카테고리 5개 미만일 시 추가하는 옵션 추가
						if(cnt<5){
							tag+= "<option value='addCategory'>카테고리 추가</option>";
						}
						
						$("#catename").html(tag);
					},error : function(){
						toast("카테고리 호출 에러", 1500);
					}
				});
			}
			
		$("#routeCollect").submit(function(){
			var noboard = opener.document.getElementById("noboard").value;
			var cate = $("#catename").val();
			
			var url = "/home/insertRouteList";
			var data = "noboard="+noboard+"&noroutecate="+cate;
			
			$.ajax({
				url : url,
				data : data,
				success: function(result){
					if(result == 2){
						toast("이미 내 목록에 가지고 있는 루트 입니다.", 1500);
						setTimeout(function(){window.close();},1500);
					}else if(result == 1){
						toast(noboard +"번 루트를 추가하였습니다.", 1500);
						setTimeout(function(){window.close();},1500);
					}else{
						toast("루트 저장 오류입니다.",1500);
					}
				},error : function(err){
					console.log("루트 저장 오류");
				}
			});
			
			return false;
		});
	});
	
	function toast(msg, time) {
		var y = window.scrollY + 30 + "px";
		$(".noticeBoard").css("top",y);
		
		var toast = $("#toast");
    	toast.addClass("reveal");
    	$("#toastMsg").html(msg);
    	
    	var click = '$("#toast").removeClass("reveal")';
    	if(time == null || time == 'undefined'){
    		var tag = "<br><input type='button' class='mintBtn' value='닫기' onclick='"+click+"'/>";
    		$("#toastMsg").append(tag);
		}else {
			setTimeout(function(){
				toast.removeClass("reveal");
			}, time);
		}
	}