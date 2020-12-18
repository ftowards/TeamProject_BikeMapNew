<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/registerForm.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<div class="registerMainDiv2">
	<p id="welcome">환영합니다!</p>
	<div id="box">
		<div>
			<img id="welcomeImg" src="<%=request.getContextPath() %>/img/img_register/welcome.png"/>
			<h2 style='font-size:35px'><span class="mintTxt">회원가입</span>이 완료되었습니다.</h2>
			<div class="contentText">
				입력하신 이메일로 인증 메일이 발송되었습니다.<br/>
				이메일 인증 이후 서비스 이용이 가능합니다.
			</div>
		</div>
	</div>
	<div id="welcomtBtns">
		<input type="button" class="btn" id="gray_Btn" value="메인으로 이동하기" onclick="location.href='/home'"/>
		<input type="button" class="btn" id="mint_Btn" value="로그인하기" onclick="location.href='/home/login'"/>
	</div>
</div> 