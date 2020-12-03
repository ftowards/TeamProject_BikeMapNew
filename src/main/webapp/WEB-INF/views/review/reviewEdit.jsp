<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>

$(function(){
	CKEDITOR.replace('content',{
		height:600
	});

	$("writeform").submit(function(){
		CKEDITOR.instances.content.updateElement();
		
		
	var url = "/home/reviewEditOk";
	var params = $("#wrtieform")
	
	$.ajax({
		type : 'POST',
		url : url,
		data : params,
		success : function(result){
			console.log(result);
			if(result>0){
				alert("글이 수정되었습니다.")
				location.href="/home/reviewList";
			}else{
				alert("글수정 실패하였습니다.");
				}
			},error:function(){
				console.log("글 수정 오류");
				
				}
		});
		return false;
	});
	
});




</script>



<div class = "container">
	<div class = "mainDiv">
		<form id="writeform">
			<div class = "toplayout">
				<div class = "box-body">
					<div class = "reviewtitle">
						<span class="title">후기 글쓰기 수정</span>
					</div>
						<input class="form-control" type ="text" name="subject" value="${vo.subject}" style="width:99%"><br/>
					</div>
					
<!-- 				<form method="post" action="/home/reviewEditOk">  -->
						<input type="hidden" name="no" value="${vo.noboard}">
						<textarea class="form-control" id ="content" name="content" row="30" style ="resize: none; width:99%"> ${vo.content}</textarea>
				
<!-- 				</form> -->
					<div class = "box-footer">
						<div class = "pull-right">
							<button type="submit" class="mint_Btn" id="inputBtn">수 정</button>
							<button type ="reset" class="gray_Btn" style = "width:80px;">다시 쓰기</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>

