<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<title>루트 저장히기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
	body{
		background-color:rgba(255,201,14,0.08);
	}
	.form{
		margin:40px auto;
		width : 400px;
		text-align : center;
		line-height: 60px;
	}
.toast{
    position: fixed;
    top: 50px;
    width : fit-content;
    height : fit-content;
    left: 50%;
    padding: 10px;
    transform: translate(-50%, 10px);
    border-radius: 8px;
    visibility: hidden;
    transition: opacity .5s, visibility .5s, transform .5s;
    background: rgba(0, 0, 0, .35);
    color: white;
    z-index: 10000;
    box-shadow: 3px 3px 3px rgb(130,130,130);
}


.toastMsg{
    width : fit-content;
    height : fit-content;
    line-height : 30px;
    font-size: 16px;
    padding : 15px;
	
}


.toast.reveal, .toastChristmas.reveal {
    opacity: 1;
    visibility: visible;
    transform: translate(-50%, 0)
}

.toast .mintBtn,.toast .btn{	
	font-weight: bold;
    border-radius: 10px;
    text-decoration: none;
    font-size:15px;
    width:70px;
	height:30px;
    text-align: center;
    padding: 3px 6px;
    margin : 5px 8px 0 0;
    color: white;
    border:none;
    background-color: #00B0B0;  
    float: right;
    line-height :20px;
    box-shadow: 3px 3px 3px rgb(84,84,84);
}

.toast .btn{	
	color: #00B0B0;
    border: 1px solid #00B0B0;
    background-color: white;
}

.blue_Btn{
	font-weight:bold;
	border-radius: 10px;
	text-decoration: none;
	text-align : center;
	padding:3px 6px;
	color : white;
	background-color:rgb(0,176,176);
	border: 0;
	width:auto;
	height:30px;
	font-size : 18px;
	box-shadow: 3px 3px 5px 3px rgb(180,180,180);
}
</style>
<script>
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
							alert("이미 등록된 이름입니다.");
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
</script> 
</head>
<body>
	<div class="registerMainDiv">
		<form id="routeCollect" class="form">
			<select id="catename" class="selectBox" style='width:300px; height:30px; font-size:15px;'>
				<c:forEach var="list" items="${category }">
					<option value="${list.noroutecate }" title="${list.catename }">${list.catename}</option>
				</c:forEach>
				<c:if test="${fn:length(category) < 5}">
					<option value="addCategory">카테고리 추가</option>
				</c:if>
			</select><br/>
			<input type="submit" value="저장하기" class="blue_Btn"/>
		</form>
	</div>
	<div id="toast" class="toast">
		<div id="toastMsg" class="toastMsg"></div>
	</div>
</body>
</html>