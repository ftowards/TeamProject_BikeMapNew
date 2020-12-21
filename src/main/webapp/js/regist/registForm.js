	$(function(){
		$("#datepicker").datepicker({
			changeYear : true,
			changeMonth : true,
			dateFormat : "yy-mm-dd",
			dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dayNamesMin : ['일','월','화','수','목','금','토'],
			monthNamesShort : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			yearRange : "1950:2010",
			defaultDate : '-25y'
		});
		
		var idChk = "N";
		var emailChk = "N";
		var regId = /^[A-Za-z]{1}\w{7,11}$/ ;
		var regEmail1 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/i;
		var regEmail2 = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*[.]{1}[a-zA-Z]{2,3}$/i;
		var regName = /^[가-힣]{2,5}$/ ;
		
		
		// 아이디 중복 검사 로직
		// 아이디 정규식 체크	
		$("#idChk").click(function(){
			if($("#userid").val()==""){
				toast("아이디를 입력하세요.",1500);
				return false;
			} 
			if(!regId.test($("#userid").val())){
				toast("아이디는 8~12자리, 영문자로 시작하여야 하고, 숫자와 특수문자 _ 만 사용 가능합니다.",1500);
				return false;
			}
			
			var url = "/home/idDoubleChk";
			var data = "userid="+$("#userid").val();
			$.ajax({
				url : url,
				data : data,
				success : function(result){
					if(result == 0){
						idChk = "Y";
						toast("사용 가능한 아이디 입니다.",1500);
					}else{
						toast("이미 사용 중인 아이디입니다.",1500);
					}
				},error : function(){
					console.log("중복 체크 에러");
				}
			});
			return false;
		});
		
		// 아이디 칸 입력 시 중복 체크 여부는 초기화
		$("#userid").keydown(function(){
			idChk = "N";
		});
		
		$("#domainSelect").on({'change' : function(){
			$("#email2").val($("#domainSelect").val());
			emailChk = "N";
		}});
		
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
			if(idChk != "Y"){
				toast("아이디 중복 검사를 하세요.", 1500);
				return false;
			}
			
			if($("#userpwd").val()==""){
				toast("비밀번호를 입력하세요.", 1500);
				return false;
			}
			
			if($("#userpwd").val().length < 8 || $("#userpwd").val().length > 12){
				toast("비밀번호는 8 ~ 12자 입력하세요.",1500);
				return false;
			}
			
			if($("#userpwdChk").val()==""){
				toast("비밀번호 확인을 입력하세요.", 1500);
				return false;
			}else if($("#userpwd").val() != $("#userpwdChk").val()){
				toast("비밀번호가 일치하지 않습니다.", 1500);
				return false;
			}
			
			if($("#username").val()==""){
				toast("이름을 입력하세요.", 1500);
				return false;
			}else if(!regName.test($("#username").val())){
				toast("이름은 한글로 2~5자 사이로 입력해주세요.", 1500);
				return false;
			}
			
			if(emailChk != "Y"){
				toast("이메일 중복 검사를 하세요.", 1500);
				return false;
			}
			
			if($("#datepicker").val()==""){
				toast("생일을 선택하세요.", 1500);
				return false;
			}
			
			var url = "/home/registerFormOk"
			var data = $("#registerForm").serialize();
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					if(result > 0){
						toast("회원 가입 완료", 1500)
						setTimeout(function(){location.href="/home/registWelcome";},1500);
					} else{
						toast("회원가입에 실패하였습니다.", 1500);
					}
				},error: function(){
					console.log("회원 가입 오류");
				}
			});
			return false;
		});
	});