<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<link rel="stylesheet" href="/home/css/login.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup/login.js"></script>
<style>
	body{
		width : fit-content;
		height : fit-content;
		margin : 0 auto;
	}
	.registerMainDiv{
		margin: 15px auto 5px;
		width : 100%;
		overflow : auto;
	}
	.loginPopupForm{
		width: 550px;
    	height: 120px;
    	background-color: #eee;
	}
	
	.centerBar{
		margin : 0 10px;	
	}	
	ul,li{
		list-style-type : none;
	 	margin:0;
	 	padding:0;
	 	}
	ul>li{float:left; line-height: 40px; padding-top : 20px;}
	ul>li:last{line-height:120px;}
	
	a:link, a:visited, a:hover{
		text-decoration: none;
		font-size:12px;
		color:	#353535;
	}
	
.toast{
    position: fixed;
    top: 50px;
    width : fit-content;
    height : fit-content;
    left: 50%;
    padding: 10px;
    transform: translate(-50%, 10px);
    border-radius: 8px;
    visibility: hidden;
    transition: opacity .5s, visibility .5s, transform .5s;
    background: rgba(0, 0, 0, .35);
    color: white;
    z-index: 10000;
    box-shadow: 3px 3px 3px rgb(130,130,130);
}


.toastMsg{
    width : fit-content;
    height : fit-content;
    line-height : 30px;
    font-size: 16px;
    padding : 15px;
	
}


.toast.reveal, .toastChristmas.reveal {
    opacity: 1;
    visibility: visible;
    transform: translate(-50%, 0)
}

.toast .mintBtn,.toast .btn{	
	font-weight: bold;
    border-radius: 10px;
    text-decoration: none;
    font-size:15px;
    width:70px;
	height:30px;
    text-align: center;
    padding: 3px 6px;
    margin : 5px 8px 0 0;
    color: white;
    border:none;
    background-color: #00B0B0;  
    float: right;
    line-height :20px;
    box-shadow: 3px 3px 3px rgb(84,84,84);
}

.toast .btn{	
	color: #00B0B0;
    border: 1px solid #00B0B0;
    background-color: white;
}
</style>

<title>바이크맵 로그인</title>
</head>
<body>
	<div class="registerMainDiv">
		<div id="bikeDiv" style="height:150px; width:750px">
			<div id="bikeDiv3">
				<a href="<%=request.getContextPath()%>/">
					<img src="<%=request.getContextPath() %>/img/img_logo/bikemapLogo12.png"/>
				</a>
			</div>
		</div>
		<form id="loginForm">
		<div id="loginDiv4">
			<div id="useridDiv" style="padding:0 0 0 20px">
				<span class="loginLabel">ID</span>
				<input type="text" name="userid" id="userid"/></div>
	
					<div id="loginBtnDiv" style="margin:-30px 0 0 380px">
						<input type="submit" class="RegisterMint_Btn" value="로그인"/>
					</div>
			<div id="userPwdDiv" style="padding:20px 0 0 20px">
				<span class="loginLabel" style='margin-right:30px'>PASSWORD</span>
				<input type="password" name="userpwd" id="userpwd"/>
			</div>
		</div>	
		</form>
		
		<div id="find_Info" style="margin:100px 0 0 -20px;">
			아이디, 비밀번호를 잊어버리셨나요?&nbsp;
			<input type="button" value="아이디/비밀번호 찾기" onclick="location.href='/home/registFindInfo'" class="RegisterWhite_Btn"/>
			<span id="text1">|</span>
			아직 회원이 아니신가요?&nbsp;
			<input type="button" value="회원가입" onclick="location.href='/home/registerForm'" class="RegisterWhite_Btn"/>
		</div>
			<!-- 알림 창 -->
		<div id="toast" class="toast">
			<div id="toastMsg" class="toastMsg"></div>
		</div>
		<div id="toastConfirm" class="toast">
			<div id="toastConfirmMsg" class="toastMsg"></div>
			<input type="button" class="mintBtn" value="닫기" onclick="$('#toastConfirm').removeClass('reveal');"/>
			<input type="button" class="btn" value="확인" />
		</div>
	</div> 
</body>
</html>