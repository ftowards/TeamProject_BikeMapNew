<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/home/css/registerForm.css" type="text/css"/>
<script src="//code.jquery.com/jquery-1.12.4.js"></script>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/regist/registForm.js"></script>
<div class="registerMainDiv" style='margin-bottom:150px'>
	<form id="registerForm" method="post" action="<%=request.getContextPath()%>/registerFormOk">
		<ul>
			<li class="registerFormTitle"><label class="registerTitleLbl">회원가입</label></li>
			<li class="registerWriteForm">	
				<div class = "registerFormLblDiv2">
					<ul>
						<li>아이디</li>
						<li>비밀번호</li>
						<li>비밀번호 확인</li>
						<li>이  름</li>
						<li>이메일</li>
						<li>성  별</li>
						<li style='margin-top:-16px'>생년월일</li>
					</ul>
				</div>
			</li>	
			<li id="input">
				<ul class='input_ul'>
					<li><input type="text" name="userid" id="userid" class="i5" maxlength="12" size="12" autocomplete="off"/> <input type="button" class="gray_Btn" id="idChk" style='font-size:15px' value="중복검사"/></li>
						<li><span class="reg">&ensp;※ 8~12자 영문(시작)/숫자/_ 사용</span></li>
					<li><input type="password" name="userpwd" id="userpwd" class="i4" maxlength="12" size="20" style='font-size:40px; padding-bottom:10px'/></li>
						<li><span class="reg">&ensp;※ 8~12자리 영문/숫자/특수문자 사용</span></li>
					<li><input type="password" name="userpwdChk" id="userpwdChk" class="i4" maxlength="12" size="20" style='font-size:40px; padding-bottom:10px'/></li>
						<li><span class="reg">&ensp;</span></li>
					<li><input type="text" name="username" id="username" class="i5" maxlength="5" size="20" autocomplete="off"/></li>
						<li><span class="reg">&ensp;※ 한글로 최대 5자까지 입력</span></li>
					<li><input type="text" name="email1" id="email1" class="i3" size="6" autocomplete="off" style='font-size:16px'/><span class="tlbl"> @ </span><input type="text" id="email2" class="i3" name="email2" size="6" autocomplete="off" style='font-size:16px'/>
					<select id="domainSelect">
						<option value="" selected>직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="google.com">google.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hotmail.com">hotmail.com</option>
					</select>
					<input type="button" class="gray_Btn" id="emailChk" style='font-size:15px' value="중복검사"/></li>
					<li><span class="reg">&ensp;※ 이메일은 계정 활성화 및 아이디&비밀번호 찾기 인증 수단으로 사용됩니다.</span></li>
					
					<li style='margin-top:52px'><input type="radio"name="gender" id="male" value="1"/><label for="male" class="tlbl2" style='margin-right:80px'>남 자</label>
						<input type="radio" name="gender" id="female" value="2" checked/><label for="female" class="tlbl2">여 자</label></li>
						<li><span class="reg">&ensp;</span></li>
					<li style='margin-top:-9px; position:relative; bottom:4px;'><input type="text" name="birth" id="datepicker" class="i2" maxlength="10" autocomplete="off" style='position:relative; bottom:20px;'></li>	
						<li><span class="reg" style='position:relative; bottom:20px;'>&ensp;※ ex)1980-12-03</span></li>	
				</ul>
			</li>
			<li id="registerBtn">
				<input type="submit" class="mint_Btn" value="회원가입" style='margin:10px 15px 10px 120px'/>
				<input type="reset" class="WMint_Btn" value="다시쓰기" style='margin-left:15px'/>
			</li>
		</ul>
	</form>
</div>