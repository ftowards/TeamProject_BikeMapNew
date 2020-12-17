<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<script>

$(function(){
	CKEDITOR.replace('content',{
		height:600 ,
		extraPlugins: 'easyimage',
	    cloudServices_tokenUrl: 'https://76760.cke-cs.com/token/dev/fb98221c99f6d4fccf45b51c839a7d022ad90ab2f9dfbc25f02ecdc03d98',
	    cloudServices_uploadUrl: 'https://76760.cke-cs.com/easyimage/upload/'
	});
	
	$("#writeform").submit(function(){
		CKEDITOR.instances.content.updateElement();
		
		if($("input[name=subject]").val() == ""){
			toast("제목을 입력하세요.",1500);
			return false
		}
		
		if(CKEDITOR.instances.content.getData()==""){
			toast("글내용을 입력하세요.",1500);
			return false;
		}
		
		$.ajax({
			type : 'post',
			url : '/home/reviewEditOk',
			data : $("#writeform").serialize(),
			success : function(result){
				if(result > 0){
					toast("수정 완료되었습니다.", 1500);
					setTimeout(function(){location.href="/home/reviewView?noboard="+$("#noboard").val();},1500);
				}else{
					toast("후기 수정 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
		});
		
		return false;
	});
});

</script>
<div class = "container">
	<div class = "mainDiv" style="max-width : 1000px">
		<div class = "reviewtitle">
			<span class="title">후기 수정</span>
		</div>				
		<form id="writeform">
			<input class="form-control" type ="text" name="subject" value="${vo.subject}" style="width:99%"><br/>
			<input type="hidden" id="noboard" name="noboard" value="${vo.noboard}">
			<textarea class="form-control" id ="content" name="content" rows="30" style ="resize: none; width:99%">${vo.content}</textarea>
			<div class = "box-footer">
				<div class = "pull-right">
					<input type="submit" class="mint_Btn" id="inputBtn" value="수 정">
					<input type ="reset" class="gray_Btn" value="다시 쓰기">
				</div>
			</div>
		</form>
	</div>
</div>

