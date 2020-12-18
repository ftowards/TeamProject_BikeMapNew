$(function(){
	
	$("#pwdChk").submit(function(){
		if($("#userpwd").val()==""){
			toast("비밀번호를 입력하세요.",1500);
			return false;
		}
		
		var url = "/home/registDelPwdChk";
		var data = $("#pwdChk").serialize();
		
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				if(result >0 ){
					location.href="/home/registDelMessage";
				}else{
					toast("비밀번호가 틀렸습니다.",1500);
				}
			},error : function(){
				console.log("비밀번호 확인 오류");
			}
		});
		return false;
	});
	
});

