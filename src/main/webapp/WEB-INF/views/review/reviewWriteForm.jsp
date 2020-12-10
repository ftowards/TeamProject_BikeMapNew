<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script>

$(function(){
		CKEDITOR.replace('content',{
			height:600,
			extraPlugins: 'easyimage',
		    cloudServices_tokenUrl: 'https://76760.cke-cs.com/token/dev/fb98221c99f6d4fccf45b51c839a7d022ad90ab2f9dfbc25f02ecdc03d98',
		    cloudServices_uploadUrl: 'https://76760.cke-cs.com/easyimage/upload/',
		    
		
		});
	
	$("#writeform").submit(function(){
		CKEDITOR.instances.content.updateElement();
		
		if($("#subject").val()==""){
			toast("제목을 입력하세요.",1500);
			return false;		
		}
		
		if(CKEDITOR.instances.content.getData()==""){
			toast("글내용을 입력하세요.",1500);
			return false;
		}

		var url = "/home/reviewWriteFormOk";
		var params = $("#writeform").serialize();
		

		$.ajax({
			type : 'POST',
			url : url,
			data : params,
			success : function(result) {
				console.log(result);
				if(result>0){
					toast("글이 등록되었습니다.",1500)
					setTimeout(function(){location.href="/home/reviewList";},1500);
				}else{
					toast("글등록이 실패하였습니다.");
					}
				},error:function(){
					console.log("글쓰기 오류");
				}
			});
			return false;	
		});
	});
</script>

<div class="container">
	<div class="mainDiv">
		<form id="writeform">
			<input type="hidden" >
			<div class = "toplayout">
					<div class = "box-body">
						<div class = "reviewtitle">
							<span class="title">후기 글쓰기 게시판</span>
						</div>
		<!-- 			제목					 -->
						<input class="form-control" id ="subject" name="subject" placeholder="제목을 입력해주세요." style="width:99%">
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