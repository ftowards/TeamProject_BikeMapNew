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
	body{
		width : 400px;
		height: 300px;
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
		width :74%;
	}
	
	#msgContainer textarea{
		font-size : 14px;
		font-family:'Noto Sans KR', sans-serif;
		border-radius: 8px 8px 0 0;
		border:1px solid gray;
	}
</style>
<script>
$(function(){
	//===============댓글쓰기 200자 제한================
	$("#message").keyup(function(){
		console.log(11);
		var commentBox = $(this).val();
	    $('#cntSPAN').text(getBytes(commentBox)); 
	});
});

function getBytes(str){
    var cnt = 0;
    for(var i =0; i<str.length;i++) {
        cnt += (str.charCodeAt(i) >128) ? 2 : 1;
    }
    return cnt;
}


</script>
</head>
<body>
<div id="msgContainer">
	<ul>
		<li><label class="receiverLbl">받는 사람</label><input type="text" name="userid" id="userid"/></li>
		<li>	
			<div>
				<textarea id="message" rows='10' cols='50' maxlength='200'style="resize:none" ></textarea>
				<div class="textCntDiv"><span id="cntSPAN" style="padding-right:10px;">0</span>&nbsp;/400</div>
			</div>
		</li>
		
		<li><input type="button" class="mintBtn" value="보내기"/></li>
	</ul>
</div>

</body>
</html>