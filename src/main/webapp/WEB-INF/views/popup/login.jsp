<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/login.css" type="text/css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<html>
<head>
<style>
	body{
		width : 800px;
		height : 300px;
	}
	.registerMainDiv{
		width : 100%;
		overflow : auto;
	}
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
					var logChk = result.loginResult;
					console.log(result.loginResult);
					
					if(logChk == 0){
						toast("로그인 실패.<br/>로그인 정보를 확인해주세요.",1500);
					}else if(logChk == 1){
						toast("로그인 하였습니다.", 1500);
						setTimeout(function(){location.href="/home";},1500);
					}else if(logChk == 2){
						toast("메일 인증이 되지 않은 아이디 입니다.<br/>가입 시 입력한 이메일에서 인증 절차를 진행해주십시오.");	
					}else if(logChk == 3){
						var tag = "활동이 정지된 회원입니다.<br/><br/>";
							tag +="정지 기간 : "+result.endday +" 까지<br/>";
							tag +="정지 사유 : " +result.cause+"<br/>";
							tag +="문의 사항은 bikemap@google.com 으로 연락바랍니다.";
						toast(tag);
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
	</body>
</html>