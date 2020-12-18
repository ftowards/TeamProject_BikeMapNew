	$(function(){
		$("#pwdChk").submit(function(){
			if($("#userpwd").val()==""){
				toast("비밀번호를 입력하세요.",1500);
				return false;
			}
			
			var url = "/home/registPwdChk";
			var data = $("#pwdChk").serialize();
			
			console.log(data);
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					if(result >0 ){
						location.href="/home/registEditForm";
					}else{
						toast("비밀번호가 틀립니다.");
					}
				},error : function(){
					console.log("비밀번호 확인 오류");
				}
			});
			return false;
		});

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
					if(result == 1){
						toast("회원 정보 수정 완료",1500);
						setTimeout(function(){location.href="/home";},1500);
					}else if(result == 2){
						toast("회원 정보 수정 완료<br/>이메일 인증 비활성화로 로그아웃 됩니다.", 1500);
						setTimeout(function(){
							sessionStorage.removeItem('key');
							location.href="<%=request.getContextPath()%>/logout";
						}, 1500);
					}else{
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