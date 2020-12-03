var socket = null;

$(function(){

	if($("#logId").val() != null && $("#logId").val() !=""){
		sock = new SockJS('/home/echo');
		socket = sock;		

	}

	sock.onopen = function(){
		console.log("통신 연결 완료");
	}

	sock.onmessage = function(event){
		var data = event.data;
		console.log("받은 데이터 : " + data + "\n");
		/////////////// 팝업창 추가하기
		alert(data);
	}
	
	sock.onclose = function(){
		console.log("연결 종료");
	}

	sock.onerror = function(err){
		console.log("통신 장애 " + err);
	}

});