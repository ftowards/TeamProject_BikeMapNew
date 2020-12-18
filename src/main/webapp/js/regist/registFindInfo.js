	$(function(){
		$("#findIdForm").submit(function(){
			if($("#findIdForm>input[type=text]").val() =="" ){
				toast("회원 정보를 입력하세요.",1500);
				return false;
			}
			
			var url="/home/registFindId";
			var data = $("#findIdForm").serialize();
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					console.log(result);
					toast(result);
				},error : function(){
					console.log("아이디 찾기 에러");
				}
			});
			return false;
		});
		
		$("#findPwdForm").submit(function(){
			var url = "/home/registFindPwd";
			var data = $("#findPwdForm").serialize();
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					if(result>0){
						toast("등록된 메일로 임시 비밀번호가 발송되었습니다.<br/>이메일 확인 후 로그인을 진행해주세요.",1500);						
					}else{
						toast("입력한 정보와 일치하는 회원 정보가 없습니다.",1500);
					}
				},error : function(){
					console.log("비밀번호 찾기 에러");
				}
			});
			return false;
		});
	});