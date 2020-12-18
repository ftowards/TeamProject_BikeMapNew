<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/login.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/regist/login.js"></script>
<div class="registerMainDiv">
	<div id="bikeDiv">
		<div id="bikeDiv1">
			<a href="<%=request.getContextPath()%>/">
				<img src="<%=request.getContextPath() %>/img/img_logo/bikemapLogo12.png"/>
			</a>
		</div>
	</div>
	<form id="loginForm">
	<div id="loginDiv2">
		<div id="useridDiv">
			<span class="loginLabel">ID</span>
			<input type="text" name="userid" id="userid"/></div>

				<div id="loginBtnDiv">
					<input type="submit" class="RegisterMint_Btn" value="로그인"/>
				</div>
		<div id="userPwdDiv">
			<span class="loginLabel" style='margin-right:30px'>PASSWORD</span>
			<input type="password" name="userpwd" id="userpwd"/>
		</div>
	</div>	
	</form>
	<p class="contentText" style='margin-top:20px'>
			- 아이디 및 비밀번호는 영문 대소문자를 구별하오니 입력 시 주의하시기 바랍니다.<br/>
			- 비밀번호는 주기적으로 변경, 관리하시기 바라며 타인에게 노출되지 않도록 주의하시기 바랍니다.<br/>
			- 비회원일 경우, 일부 서비스가 제한됩니다.
		</p>
	<div id="find_Info">
		아이디, 비밀번호를 잊어버리셨나요?&nbsp;
		<input type="button" value="아이디/비밀번호 찾기" onclick="location.href='/home/registFindInfo'" class="RegisterWhite_Btn"/>
		<span id="text1">|</span>
		아직 회원이 아니신가요?&nbsp;
		<input type="button" value="회원가입" onclick="location.href='/home/registerForm'" class="RegisterWhite_Btn"/>
	</div>
</div> 