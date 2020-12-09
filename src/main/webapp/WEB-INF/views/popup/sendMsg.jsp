<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style2.css" type="text/css"/>
<title>쪽지 보내기</title>
<style>
	html{
		width : fit-content;
		height : fit-content;
	}
	body{
		width : 425px;
		height: 340px;
		margin : 0;
		padding : 0;
	}
	
	#msgContainer{
		text-align : center;
		margin : 10px;
	}
	
	#msgContainer>ul{
		width : 100%;
	}
	
	#msgContainer>ul>li{
		width : 100%;
		margin : 10px 0;
	}
	.receiverLbl{
		font-size : 15px;
		margin : 0 10px;
		width :20%;
		font-weight : bold;
		color: #222;		
	}
	#msgContainer input[type=text]{
		width : 85%;
		height : 20px;
	}
	
	#msgContainer textarea{
		font-size : 14px;
		font-family:'Noto Sans KR', sans-serif;
		border-radius: 8px 8px 0 0;
		border:1px solid gray;
	}
</style>
<script>
var socket = opener.socket;

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
		if(val != 'admin' && val != $("#logId", opener.document).val()){
			tag += "<li onclick='setUserid(title);' title='"+val+"'>"+val+"</li>"	
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
	var sender = $("#logId", opener.document).val();
	
	if(receiver == null || receiver ==""){
		toast("받을 사람을 입력하세요.",1500);
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
				socket.send(socketMsg);
				toast("쪽지가 발송되었습니다.",1500);
				$("#userid").val("");
				$("#message").val("");
			}
		},error : function(err){
			console.log(err);
		}
	});
}

function toast(msg, time) {
	var toast = $("#toast");
	toast.addClass("reveal");
	toast.html(msg);
	
	var click = '$("#toast").removeClass("reveal")';
	if(time == null || time == 'undefined'){
		var tag = "<br><input type='button' class='mintBtn' value='닫기' onclick='"+click+"'/>";
		toast.append(tag);
	}else {
		setTimeout(function(){
			toast.removeClass("reveal");
		}, time);
	}
}
</script>
</head>
<body>
<div id="msgContainer">
	<ul>
		<li><label class="receiverLbl">받는 사람</label></li>
		<li>
			<input type="text" name="userid" id="userid"/>
			<div id="searchIdList"></div>
		</li>
		<li>	
			<div>
				<textarea id="message" rows='10' cols='50' maxlength='200'style="resize:none" ></textarea>
				<div class="textCntDiv"><span id="cntSPAN" style="padding-right:10px;">0</span>&nbsp;/400</div>
			</div>
		</li>
		
		<li><input type="button" class="mintBtn" onclick="sendMsg();" value="보내기"/></li>
	</ul>
</div>
	<div id="toast" class="toast" style="top : 40px;">
		<div id="toastMsg" class="toastMsg"></div>
	</div>
</body>
</html>