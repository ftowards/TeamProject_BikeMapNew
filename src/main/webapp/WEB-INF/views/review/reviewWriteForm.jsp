<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>


<div class="container">
<div class="mainDiv">
	
	<div class = "toplayout">
		<form role="form" id="writeform">
			<div class = "box-body">
				<div class = "reviewtitle">
					<span class="title">후기 글쓰기 게시판</span>
				</div>
								
				<label for ="title">제목</label>
				<input class="form-control" id="title" name="title" placeholder="제목을 입력해주세요.">
			</div>
			<div class = "form-group">
				<label for ="content">내용</label>
				<textarea class ="form-control" name="content" rows="30"
								placeholder="내용을 입력해주세요." style="resize: none;"></textarea>
			</div>
			<div class ="form-group">
				<label for="writer">작성자</label>
				<input class="from-control" id="writer" name="write">
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




