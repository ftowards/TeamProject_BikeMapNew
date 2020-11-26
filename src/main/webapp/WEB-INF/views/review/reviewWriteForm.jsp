<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script>
	$(function(){
		$("#inputBtn").click(function(){
			if(confirm("등록하시겠습니까?")) {
				location.href="/home/reviewList";
			}
		});
	});

</script>
<div class="container">
	<div class="mainDiv">
		<form role="form" id="writeform">
			<div class = "toplayout">
					<div class = "box-body">
						<div class = "reviewtitle">
							<span class="title">후기 글쓰기 게시판</span>
						</div>
		<!-- 			제목					 -->
						<input class="form-control" name="title" placeholder="제목을 입력해주세요." style="width:99%">
					</div>
		<!-- 			내용 					 -->
					<div class = "form-group">
						<textarea class ="form-control"  id ="content"name="content" rows="30"
								  placeholder="내용을 입력해주세요." style="resize: none; width:99%;">						  
						</textarea>
							<script>
						 	CKEDITOR.replace('content',
						 		{ height : 800
							}); 
							</script>
					</div>
			</div>
				<div class = "box-footer">
					<div class = "pull-right">
						<button type="submit" class="mint_Btn" id="inputBtn">등 록</button>
						<button type ="reset" class="mint_Btn" style = "width:80px;">다시 쓰기</button>
					</div>
				</div>
		</form>
	</div>
</div>




