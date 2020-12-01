<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script>

$(function(){
		CKEDITOR.replace('content',{
			height:600
		});
		
		
		
		$("#inputBtn").submit(function(){
			CKEDITOR.instances.content.updateElement();
			console.log("서브밋 클릭함.");
			var url ="/reviewWriteFormOk";
			var params = $("#reviewWriteForm").serialize();
			
			
			$ajax({
				type : "POST",
				url : url,
				data : params,
				success : function (result){
					if(result>0){
						alert("글이 등록되었습니다.")
						location.href="/home/reivewList";
					}else{
						alert("글등록이 실패하였습니다.")
					}
					
				},error : function() {
					console.log("글쓰기 오류");
					
				}
			});
			return false;
		});
	});
	
	
</script>
<div class="container">
	<div class="mainDiv">
		<form id="writeform" action="/home/reviewWriteFormOk" method="POST">
			<input type="hidden" >
			<div class = "toplayout">
					<div class = "box-body">
						<div class = "reviewtitle">
							<span class="title">후기 글쓰기 게시판</span>
						</div>
		<!-- 			제목					 -->
						<input class="form-control" name="subject" placeholder="제목을 입력해주세요." style="width:99%">
					</div>
		<!-- 			내용 					 -->
					<div class = "form-group">
						<textarea class ="form-control"  id ="content" name="content" rows="30"
								  placeholder="내용을 입력해주세요." style="resize: none; width:99%;">						  
						</textarea>
					</div>
			</div>
			
				<div class = "box-footer">
					<div class = "pull-right">
						<button type="submit" class="mint_Btn" id="inputBtn">등 록</button>
						<button type ="reset" class="gray_Btn" style = "width:80px;">다시 쓰기</button>
					</div>
				</div>
		</form>
	</div>
</div>




