<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/registerForm.css" type="text/css"/>
 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
 <script src="//code.jquery.com/jquery-1.12.4.js"></script>
 <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
	$(function(){	
		$("#domainSelect").on({'change' : function(){
			$("#email2").val($("#domainSelect").val());
		}});
			
		
		var regEmail1 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/i;
		var regEmail2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
		
		// 이메일 중복 검사 로직	
		$("#emailChk").click(function(){
			if($("#email1").val()=="" || $("#email2").val()=="" ){
				toast("이메일을 입력하세요.", 1500);
				return false;
			}
			
			if(!regEmail1.test($("#email1").val())){
				console.log($("#email1").val());
				toast("이메일 주소는 영문자와 숫자, 특수문자 _ 만 사용 가능합니다.",1500);
				return false;
			}
			
			if(!regEmail2.test($("#email2").val())){
				toast("이메일 도메인은 영문자와 숫자, 특수문자 _ 만 사용 가능합니다.",1500);
				return false;
			}
			
			var url = "/home/emailDoubleChk";
			var data = "email="+$("#email1").val()+"@"+$("#email2").val()
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					if(result == 0){
						emailChk = "Y";
						toast("사용 가능한 이메일입니다.", 1500);
					}else{
						toast("이미 등록된 메일 주소입니다.", 1500);
					}
				},error : function(){
					console.log("중복 체크 에러");
				}
			});
			return false;
		});
		
		// 이메일 입력 시 중복 체크 여부는 초기화
		$("#email1").keydown(function(){
			emailChk = "N";
		});		
		$("#email2").keydown(function(){
			emailChk = "N";
		});
		
		// 입력사항 체크
		$("#registerForm").submit(function(){
			
			if($("#userpwd").val() != null || $("#userpwdChk").val() != null){
				if($("#userpwd").val() != $("#userpwdChk").val()){
					alert("비밀번호가 일치하지 않습니다.");
					return false;
				}
			}
			
			if($("#email1").val()=="" || $("#email2").val=="" ){
				alert("이메일을 입력하세요.");
				return false;
			}
			
			var url = "/home/registerEditFormOk"
			var data = "userid=${user.userid}&email1="+$("#email1").val()+"&email2="+$("#email2").val();
			if($("#userpwd").val()!=""){
				data += "&userpwd="+$("#userpwd").val();
			}else{
				data += "&userpwd=${user.userpwd}";
			}
		
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					if(result > 0){
						toast("회원 정보 수정 완료",1500);
						setTimeout(function(){location.href="/home";},1500);
					} else{
						toast("회원 정보 수정에 실패하였습니다.");
					}
				},error: function(){
					console.log("회원 정보 수정 오류");
				}
			});
			return false;
		});
	});
	
	function resetEmail(){
		toastConfirm("이메일을 변경하실 경우 회원 인증이 취소되며,<br/>이메일을 다시 인증하실 때까지 서비스 이용이 불가합니다.<br/>진행하시겠습니까?", function(){
			$("#email1").prop("disabled", false).val("");
			$("#email2").prop("disabled", false).val("");
			$("#domainSelect").prop("disabled", false);
			
			$("#emailReset").css("display", "none");
			$("#emailChk").css("display", "block");
		});
	}
</script>
<div class="registerMainDiv" style='margin-bottom:150px'>
	<form id="registerForm" method="post" action="<%=request.getContextPath()%>/registerFormOk">
		<div class="registerTitle"><label class="registerTitleLbl">마이페이지</label><br/><br/></div>
		<div class="registerWriteForm" style='padding-top:20px'>	
			<div class = "registerFormLblDiv">
				<ul class="registerFormLbl">
					<li>아이디</li>
					<li>비밀번호</li>
					<li>비밀번호 확인</li>
					<li>이  름</li>
					<li>이메일</li>
					<li>성  별</li>
					<li>생년월일</li>
				</ul>
			</div>
		</div>		
		<div id="input" style='padding-top:20px'>
			<ul>
				<li><input type="text" name="userid" id="userid" class="i5 blocked_input" maxlength="12" size="12" value="${user.userid }" disabled/>
					<li><span class="reg">&ensp;</span></li>
				<li><input type="password" name="userpwd" id="userpwd" class="i4" maxlength="12" size="20" style='font-size: 43px; padding-bottom:10px;'/>
					<li><span class="reg">&ensp;</span></li>
				<li><input type="password" name="userpwdChk" id="userpwdChk" class="i4" maxlength="12" size="20" style='font-size: 43px; padding-bottom:10px;'/></li>
					<li><span class="reg">&ensp;</span></li>
				<li><input type="text" name="username" id="username" class="i5 blocked_input" maxlength="5" size="20" value="${user.username }" disabled/>
					<li><span class="reg">&ensp;</span></li>
				<li><input type="text" name="email1" id="email1" class="i3" size="6" value="${user.email1 }" disabled/><span class="tlbl"> @ </span><input type="text" id="email2" class="i3" name="email2" size="6" value="${user.email2 }"  disabled/>
					<select id="domainSelect"  disabled>
						<option value="" selected>직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="google.com">google.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hotmail.com">hotmail.com</option>
					</select>
					<input type="button" id="emailReset" value="변경" onclick="resetEmail();"/>
					<input type="image" id="emailChk" src="<%=request.getContextPath() %>/img/img_register/email_check6.png" style='box-shadow:none; height:35px'/>
				</li>
					<li><span class="reg">&ensp;</span></li>
				<li><input type="radio" name="gender" id="gender" value="1" disabled <c:if test="${user.gender == 1}">checked</c:if>/><span class="tlbl" style='margin-right:95px'>남 자</span>
					<input type="radio" name="gender" id="gender" value="2" disabled <c:if test="${user.gender == 2}">checked</c:if>/><span class="tlbl">여 자</span></li>
					<li><span class="reg">&ensp;</span></li>
				<li><input type="text" name="birth" id="datepicker" class='i5 blocked_input' maxlength="10" value="${user.birth }" disabled/>	
					<li><span class="reg">&ensp;</span></li>		
			</ul>
		</div>
		<hr id="hr3"/>
		<div id="bottons">
			<input type="submit" class="mint_Btn" value="수 정" style="width:120px; word-spacing:9px; box-shadow:2px 2px 5px #9c9b9b"/>
			<input type="button" class="red_Btn" value="회원탈퇴" style="width:120px; letter-spacing:2px; box-shadow:2px 2px 5px #9c9b9b" onclick="location.href='/home/registDel'"/>
		</div>
	</form>
</div> 