<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="/home/css/routeMap.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
	body{
		background-color:rgba(255,201,14,0.08);
	}
	.form{
		margin:50px auto;
		width : 500px;
		text-align : center;
		line-height: 180px;
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
						console.log(names);
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
			
						console.log(111);
						$.ajax({
							type : 'POST',
							url : url,
							data : data,
							success : function(result){
								if(result == 1){
									alert("새로운 카테고리가 추가되었습니다.");
									selectCategory();
								}else{
									alert("카테고리 추가 에러");
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
						alert("카테고리 호출 에러");
					}
				});
			}
		
		$("#routeCollect").submit(function(){
			var noboard = opener.document.getElementById("noboard").value;
			var cate = $("#catename").val();
			
			var url = "/home/insertRouteList";
			var data = "noboard="+noboard+"&noroutecate="+cate;
			
			console.log(data);
			
			
			$.ajax({
				url : url,
				data : data,
				success: function(result){
					if(result == 2){
						alert("이미 내 목록에 가지고 있는 루트 입니다.");
						window.close();
					}else if(result == 1){
						alert(noboard +"번 루트를 추가하였습니다.");
						window.close();
					}else{
						alert("루트 저장 오류입니다.");
					}
				},error : function(){
					console.log("루트 저장 오류");
				}
			});
			
			return false;
		});
	});
</script> 
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