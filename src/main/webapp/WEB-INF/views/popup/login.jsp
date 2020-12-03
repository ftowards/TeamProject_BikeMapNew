<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/login.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style>
	.loginPopupForm{
		width: 550px;
    	margin: 15px auto 5px;
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
		

		
	});
</script> 
<div class="registerMainDiv">
	<form id="loginForm" class='loginPopupForm'>
		<ul>
			<li style="height:100px;width:20%; padding-left:25px;">
				ID<br/>
				PASSWORD	
			</li>
			<li style='height:100px; width : 45%;'>
				<input type="text" name="userid" id="userid" style='width:200px; height:25px;'/>
				<input type="password" name="userpwd" id="userpwd" style='width:200px; height:25px;'/>
			</li>
			<li style='height:100px; width : 20%;'>
				<input type="submit" class="mint_Btn" value="로그인"/>
			</li>
		</ul>	
	</form>
	<div style="text-align:center; margin : 15px;">
		<span  class="white_Btn"><a href='/home/registFindInfo' target="_blank">아이디/비밀번호 찾기</a></span>
		<span class='centerBar'>|</span>
		<span  class="white_Btn"><a href='/home/registerForm' target="_blank">회원가입</a></span>
	</div>
</div>