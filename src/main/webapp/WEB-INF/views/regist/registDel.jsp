<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/register.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/regist/registDel.js"></script>

<div class="registerMainDiv">
	<div class="registerDelContentBox" style='height:270px; margin-top:100px; padding-top:40px;'>
		<div>
			<img id="chkImg" src="<%=request.getContextPath()%>/img/img_register/check.png"/>
			<p id="contentLbl1">회원탈퇴 신청 전에 반드시 <span class="orangeTxt">확인</span>해주세요.</p>
			<b id="contentLbl2">탈퇴 후에는 모든 회원 정보가 삭제되오니 신중하게 결정해 주시기 바랍니다.</b>
		</div>
	</div>
	<p class="contentText" style='margin-top:30px'>
		- 탈퇴 후에는 <span class="orangeTxt">아이디와 데이터 복구가 불가능합니다.</span><br/>
		- 내 정보 및 서비스 이용 기록이 모두 삭제되며, 삭제된 데이터는 복구되지 않습니다.<br/>
		- 게시판에 등록된 게시물은 자동 삭제 처리가 되지 않습니다.<br/>
		- 삭제를 원하시는 게시물이 있다면 <span class="orangeTxt">반드시 탈퇴 전에 삭제 하시기 바랍니다.</span><br/>
		<div id="checkDiv">
			<input type="checkbox" id="caution"/><label id="contentLbl3" for="caution"> 안내사항을 모두 확인하였으며, 이에 동의합니다.</label>
		</div>
	</p>
	<hr/>
	<div id="btnBox">
		<input type="button" value="탈퇴신청" class="red_Btn" style="width:115px; height:43px" onclick="location.href='<%=request.getContextPath()%>/registDelChk'"/>
		<input type="button" value="홈으로" class="gray_Btn" style="width:115px; height:43px" onclick="location.href='<%=request.getContextPath()%>'"/>
	</div>
</div> 