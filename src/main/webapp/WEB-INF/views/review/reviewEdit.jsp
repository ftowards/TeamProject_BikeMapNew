<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>

<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<body>


	<h1>글쓰기 폼</h1>
	<form method="post" action="/home/reviewEditOk"> 
		<input type="hidden" name="no" value="${vo.noboard}">
		제목: <input type ="text" name="subject" value="${vo.subject}"><br/>
		글내용 : <textarea name = "content" style ="width:70%;height:100px">${vo.content }</textarea><br/> 
		<input type="submit" value="수정하기"/>
	</form>

	
</body>
</html>