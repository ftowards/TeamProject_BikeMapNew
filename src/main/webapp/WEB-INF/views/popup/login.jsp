<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/login.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<html>
<head>
<style>
	body{
		width : 780px;
		height : 400px;
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
</style>
<script>
	$(function(){
		console.log(11);
		$("#loginForm").submit(function(){
			if($("#userid").val()==""){
				alert("아이디를 입력하세요.");
				return false;
			}
			if($("#userpwd").val()==""){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			
			var url = "/home/loginOk";
			var data = $("#loginForm").serialize();
			$.ajax({
				
				url : url,
				data : data,
				success : function(result){
					if(result == 1){
						alert("로그인 되었습니다.");
						opener.location.reload();
						window.close();
					}else if(result == 2){
						alert("메일 인증이 되지 않은 아이디 입니다.\n가입 시 입력한 이메일에서 인증 절차를 진행해주십시오.");					
					}else{
						alert("로그인 실패하였습니다.\n로그인 정보를 확인해주세요.");
					}
				},error : function(){
					console.log("로그인 에러");
				}
			});
			
			return false;
		});
	
		autoSizePopup();
		
		function autoSizePopup(){
			console.log(11111231);
			
		    var winResizeW=0;
		    var winResizeH=0;

		    //크롬, 사파리일때
	        if (navigator.userAgent.indexOf('Chrome')>-1 || navigator.userAgent.indexOf('Safari')>-1){
                if(winResizeW==0 && winResizeH==0)
                {
        			console.log(11111231);
                    resizeWin();
                }
	        }else{       //크롬, 사파리말고 모두
	            resizeWin();
	        }
		   
		    function resizeWin(){
		    	
		    	console.log(152352531);
		        var conW = $("body").innerWidth(); //컨텐트 사이즈
		        var conH = $("body").innerHeight();
		   
		        var winOuterW = window.outerWidth; //브라우저 전체 사이즈
		        var winOuterH = window.outerHeight;
		       
		        var winInnerW = window.innerWidth; //스크롤 포함한 body영역
		        var winInnerH = window.innerHeight;
		       
		        var winOffSetW = window.document.body.offsetWidth; //스크롤 제외한 body영역
		        var winOffSetH = window.document.body.offsetHeight;
		       
		        var borderW = winOuterW - winInnerW;
		        var borderH = winOuterH - winInnerH;
		       
		        //var scrollW = winInnerW - winOffSetW;
		        //var scrollH = winInnerH - winOffSetH;
		       
		        winResizeW = conW + borderW;
		        winResizeH = conH + borderH;
		       
		        window.resizeTo(winResizeW,winResizeH);
		    }
		}
	});
</script>
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
</div> 
	</body>
</html>