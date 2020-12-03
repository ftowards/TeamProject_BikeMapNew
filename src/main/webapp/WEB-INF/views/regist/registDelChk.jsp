<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/register.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script>
	$(function(){
		$("#pwdChk").submit(function(){
			if($("#userpwd").val()==""){
				alert("비밀번호를 입력하세요.");
				return false;
			}
			
			var url = "/home/registDelPwdChk";
			var data = $("#pwdChk").serialize();
			
			console.log(data);
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					if(result >0 ){
						location.href="/home/registDelMessage";
					}else{
						alert("비밀번호가 틀렸습니다.");
					}
				},error : function(){
					console.log("비밀번호 확인 오류");
				}
			});
			return false;
		});
	});
</script>
<div class="registerMainDiv">
	<div class="contentBox2">
		<div style='height:245px'>
			<img id="LockImg" src="<%=request.getContextPath()%>/img/img_register/lock.png"/>
			<p id="contentTxt1">비밀번호 재확인</p>
			<p id="contentTxt2"><b class="mintTxt" style='font-size:18px; margin-right:3px; letter-spacing:1px'>${logName}</b>님의 회원정보를 안전하게 보호하기 위해<br/>비밀번호를 한번 더 입력해주세요.</p>
		</div>
		<form id="pwdChk">
			<input type="hidden" name="userid" value="${logId}"/>
			<b class="grayTxt" style='font-size:17px; margin-right:12px; letter-spacing:3px'>> 비밀번호</b>&ensp;<input type="password" name="userpwd" id="userpwd" style='height:40px; width:240px; margin-top:20px;'/><br/>
			<input type="submit" value="확 인" class="gray_Btn" style='width:130px; height:47px; margin-top:24px'/>
		</form>
	</div>
</div> 