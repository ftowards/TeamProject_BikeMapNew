$(function(){
		$("#loginForm").submit(function(){
			if($("#userid").val()==""){
				toast("아이디를 입력하세요.", 1500);
				return false;
			}
			if($("#userpwd").val()==""){
				toast("비밀번호를 입력하세요.", 1500);
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
});
