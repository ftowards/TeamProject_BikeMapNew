<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style2.css" type="text/css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/popup/sendMsg.js"></script>
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
		text-align:center;
		border:none;
		border-radius:10px;
		font-size:15px;
		width:65%;
		margin-left:10px;
		height:30px;
		line-height:30px;
		font-weight:bold;
		color:#fff;
		background-color:rgb(64,64,64);
		box-shadow: 3px 3px 5px 3px rgb(230,230,230);
				
	}
	.sendMintBtn{
					text-align:center;
					border:none;
					border-radius:10px;
					font-size:15px;
					width:65%;
					margin-left:10px;
					height:30px;
					line-height:30px;
					font-weight:bold;
					color:#fff;
					background-color:rgb(0,176,176);
					box-shadow: 3px 3px 5px 3px rgb(230,230,230);
				
	
	}
	#msgContainer input[type=text]{
		width : 85%;
		height : 20px;
		border-radius: 5px;	
		border:1px solid gray;
	
	}
	
	#msgContainer textarea{
		font-size : 14px;
		font-family:'Noto Sans KR', sans-serif;
		border-radius: 8px 8px 0 0;
		border:1px solid gray;
		
	}
	input:focus {outline:none;}
	textarea:focus {outline:none;}

</style>
</head>
<body>
<div id="msgContainer">
	<input type="hidden" id="logId" value="${logId }">
	<ul>	
		<li><div class="receiverLbl">받는 사람</div></li>
		<li>
			<input type="text" name="userid" id="userid" <c:if test="${userid != null }">value="${userid }"</c:if>autocomplete="off"/>
			<div id="searchIdList"></div>
		</li>
	
		<li>	
			<div>
				<textarea id="message" rows='10' cols='50' style="resize:none" ></textarea>
				<div class="textCntDiv"><span id="cntSPAN" style="padding-right:10px;">0</span>&nbsp;/250</div>
			</div>
		</li>
		
		<li><input type="button" class="sendMintBtn" onclick="sendMsg();" value="보내기"/></li>
	</ul>
</div>
<div class="noticeBoard">
	<div id="toast" class="toast">
		<div id="toastMsg" class="toastMsg"></div>
	</div>
</div>
</body>
</html>