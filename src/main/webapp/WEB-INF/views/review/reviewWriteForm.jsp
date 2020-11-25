<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>


<div class="container">
	<div class="mainDiv">


		<div class = "toplayout">
			<form role="form" id="writeform">
				<div class = "box-body">
					<div class = "reviewtitle">
						<span class="title">후기 글쓰기 게시판</span>
					</div>
	<!-- 			제목					 -->
					<label for ="title">제목</label>
					<input class="form-control" name="title" placeholder="제목을 입력해주세요." style="width:99%">
				</div>
	<!-- 			내용 					 -->
				<div class = "form-group">
					<label for ="content">내용</label>
					<textarea class ="form-control"  id ="content"name="content" rows="30"
							  placeholder="내용을 입력해주세요." style="resize: none; width:99%;">						  
					</textarea>
						<script>
					 	CKEDITOR.replace('content',{
					
							
					 	
						}); 
						</script>
				
				</div>
	<!-- 			작성자                                -->
				<div class ="form-group">
					<label for="writer">작성자</label>
					<input class="from-control" id="writer" name="write" style = "width :93.4%;">
				</div>	
			</form>
		</div>
		
		
	<%--첨부파일 영역 추가 --%>
		<div class= "form-group">
			<div class = "fileDrop">
				<br/>
				<br/>
				<br/>
				<br/>
				<p class = "text-center"><i class=""></i>첨부파일을 드래그해주세요.</p>			
			</div>
		</div>
	<%--첨부파일 영역 추가 --%>
	
	
		<div class = "box-footer">
			<ul class = "mailbox-attachments"></ul>
		</div>
		<div class = "box-footer">
			<button type="button" class=""><i class=""></i>목록</button>
			<div class = "pull-right">
				<button type ="reset" class=""><i class=""></i>초기화</button>
				<button type="submit" class=""><i class=""></i>저장</button>
				
				
			</div>
		</div>
	</div>
</div>




