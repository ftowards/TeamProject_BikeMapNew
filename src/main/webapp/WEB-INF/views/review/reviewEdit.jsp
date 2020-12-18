<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/review/reviewEdit.js"></script>
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