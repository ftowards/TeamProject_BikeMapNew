<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<title>루트 저장히기</title>
<link rel="stylesheet" href="/home/css/routeCollect.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup/routeCollect.js"></script>
</head>
<body>
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
		<div class="noticeBoard">
		<div id="toast" class="toast">
			<div id="toastMsg" class="toastMsg"></div>
		</div>
	</div>
</body>
</html>