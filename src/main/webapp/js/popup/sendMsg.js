var socketP = parent.socket;

if(parent.socket == null){
	socketP = opener.socket;
}

$(function(){
	
	//===============댓글쓰기 200자 제한================
	$("#message").keyup(function(){
		var commentBox = $(this).val();
	    $('#cntSPAN').text(getBytes(commentBox)); 
	});
	
	console.log(111);
	$("#userid").keyup(function(){
		var data = "keyword="+$("#userid").val();
		console.log(data);
		
		if($("#userid").val() ==""){
			$("#searchIdList").css("display","none");
			return false;
		}
		
		$.ajax({
			url : "/home/searchId",
			data : data,
			success : function(result){
				if(result.length > 0 ){
					setIdlist(result);
				}
			}, error : function(err){
				console.log(err);
			}
		});
	});
	
});

function setIdlist(result){
	var tag = "<ul>";
	
	var $result = $(result);
	
	$result.each(function(i, val){
		if(val != 'admin' && val != $("#logId").val()){
			tag += "<li onclick='setUserid(title);' title='"+val+"'>"+"@"+val+"</li>"	
		}
	});
	
	tag+="</ul>";
	$("#searchIdList").html(tag);
	$("#searchIdList").css("display","block");
}

function setUserid(title){
	var userid = title;
	
	$("#userid").val(userid);
	$("#searchIdList").css("display","none");
}
function getBytes(str){
    var cnt = 0;
    for(var i =0; i<str.length;i++) {
        cnt += (str.charCodeAt(i) >128) ? 2 : 1;
    }
    return cnt;
}

//메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(){
	var receiver = $("#userid").val();
	var sender = $("#logId").val();
	
	if(receiver == null || receiver ==""){
		toast("받을 사람을 입력하세요.",1500);
		return false;
	}else if(receiver == 'admin'){
		toast("관리자에게 쪽지를 보낼 수 없습니다.</br/>1:1 문의사항을 이용해주세요.",1500);
		return false;
	}else if(receiver == sender){
		toast("본인에게 쪽지를 보낼 수 없습니다.", 1500);
		return false;
	}
	
	if($("#message").val() == ""){
		toast("메세지를 입력하세요.",1500);
		return false;
	}
	
	var msg = $("#message").val();
	var socketMsg = "sendMsg,"+receiver+","+sender+","+msg;

	var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg+"&type=M";
	
	$.ajax({
		url : "/home/insertNotice",
		data : data,
		success : function(result){
			if(result == 1){
				socketP.send(socketMsg);
				toast("쪽지가 발송되었습니다.",1500);
				$("#userid").val("");
				$("#message").val("");
			}else{
				toast("쪽지 발송 실패입니다.<br/>받는 사람 아이디를 확인하세요.",1500);				
			}
		},error : function(err){
			console.log(err);
		}
	});
}

function toast(msg, time) {
	var y = 50 + "px";
	$(".noticeBoard").css("top",y);
	
	var toast = $("#toast");
	toast.addClass("reveal");
	$("#toastMsg").html(msg);
	
	var click = '$("#toast").removeClass("reveal")';
	if(time == null || time == 'undefined'){
		var tag = "<br><input type='button' class='mintBtn' value='닫기' onclick='"+click+"'/>";
		$("#toastMsg").append(tag);
	}else {
		setTimeout(function(){
			toast.removeClass("reveal");
		}, time);
	}
}