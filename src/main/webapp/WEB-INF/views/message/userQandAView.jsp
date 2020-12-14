<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/home/css/userQandA.css" type="text/css"/>

<div id="page-wrapper">
  <!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	    	<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_admin/QnA.png"/></li>
				<li class="sidebar-brand"><label style="color:rgb(0,176,176)">1:1문의하기</label></li>
				<hr/>
				<li><label for="sendQna">문의하기</label></li>
				<li><label for="readQna">나의 문의사항</label></li>
		    </ul>
		</div>
	</div>
  <!-- /사이드바 -->

  <!-- 본문 -->
	<div class="my">
    	<div class="container-fluid">
    		<!-- 탭 전환용 라디오 버튼 : 숨김 처리 -->
	    	<input type="radio" name="messageBox" id="sendQna" value="1" checked/> 
	    	<input type="radio" name="messageBox" id="readQna" value="2" />
			<!-- 1:1문의하기 Form -->	
			<div class="titleMyDiv1 tab"><label>문의하기</label>
			<ul class="qAndALbl">
				<li>-문의하신 내용을 신속하고 정확하게 답변 드리겠습니다.</li>
				<li>-상담에 대한 답변은 1:1문의>나의 문의사항 에서 확인하실 수 있습니다.</li>
				<li>-1:1 문의글 작성 후에는 수정, 삭제가 되지 않습니다.</li>
			</ul>	
			<div class="qAndaTypeDiv">
				<ul>
					<li><div class="qAndaTypeLbl">문의유형</div></li>
					<li>
						<div class="qAndaTypeBox1">회원신고</div>
					</li>
				</ul>
			</div>	
			<div class="subjectQandADiv">	
			
				<ul>
					<li><div class="subjectQandALbl">제&nbsp;목</div></li>
					<li><div class="qAndaSubjectBoxView">제목제목</div></li>
				</ul>	
			</div>
			<div class="subjectQandADiv">	
				<ul>
					<li><div class="subjectQandALbl">내&nbsp;용</div></li>
					<li><div class="qAndaSubjectBoxView">내용~~불만불만어쩌구저쩌꾸내용~~불만불만어쩌구저쩌꾸내용~~불만불만어쩌구저쩌꾸</div></li>
				</ul>	
			</div>	
			<div class="subjectQandADiv">	
				<ul>
					<li><div class="subjectQandALbl">답&nbsp;변</div></li>
					<li><div class="qAndaSubjectBoxView">답변~~~~어쩌라고~~~답변~~~~어쩌라고~~~답변~~~~어쩌라고~~~답변~~~~어쩌라고~~~답변~~~~어쩌라고~~~답변~~~~어쩌라고~~~답변~~~~어쩌라고~~~ㅈㅅㅈㅅㅈㅅㅈㅅ</div></li>
				</ul>	
			</div>
	
			</div>
			<!-- 나의 문의사항 시작 -->
			<div class="titleMyDiv1 tab"><label>나의 문의사항</label>
				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="sendBoxTitle" class="listTitle">
		     					<li><input type="checkbox" id="chkAll2"/></li>
				     			<li>답변상태</li>
				     			<li>문의유형</li>
				     			<li>제목</li>
				     			<li>등록일</li>
		     				</ul>
		     				<ul id="messageList2" class="list"></ul>
						</div>
						<div id="paging2" class="paging"></div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>
<script>
var messageBox = 1;
var nowPage = 1;

$(function(){
	// 1. 페이징	
	movePage(nowPage);
	// 2. 리스트 불러오기
	$("input[name=messageBox]").on('change', function(){
		$("#read"+messageBox).prop("checked", false);
		messageBox = $("input[name=messageBox]:checked").val();
		
		if(messageBox != 4){
			movePage(1);
		}
	});
	
	$("input[name=read]").on('change', function(){
		movePage(1);
	});
	
	$("#chkAll"+messageBox).on('change', function(){
		if($(this).prop("checked")){
			$("#messageList"+messageBox+" input[type=checkbox]").prop("checked", true);
		}
		
		if(!($(this).prop("checked"))){
			$("#messageList"+messageBox+" input[type=checkbox]").prop("checked", false);
		}
	});
	
	$("input[name=deleteMsg]").on('click', function(){
		
		$("#messageList"+messageBox+" input[type=checkbox]").each(function(){
			if($(this).prop("checked")){
				deleteMsg($(this).val());				
			};
		});
	});
	
	$("input[name=readMsg]").on('click', function(){
		
		$("#messageList"+messageBox+" input[type=checkbox]").each(function(){
			if($(this).prop("checked")){
				readMsg($(this).val());				
			};
		});
	});
});

function movePage(page){
	
	nowPage = page;
	$("#chkAll"+messageBox).prop("checked", false);
	
	var data = "nowPage="+page+"&messageBox="+messageBox;
	if($("#read"+messageBox).prop("checked")){
		data+= "&read="+"F";
	}
	
	$.ajax({
		url : "/home/noticePaging",
		data : data,
		success : function(result){
			console.log(result);
			setPaging(result);
		},error : function(err){
			console.log(err);
		}			
	});
}

function setPaging(result){
	var tag = "<ul>";
	
	if(result.totalRecord != 0){
		if(result.nowPage != 1){
			tag += "<li onclick='movePage("+(result.nowPage-1)+")'>Prev</li>";
		}
		
		for (var i = result.startPageNum ; i < result.startPageNum + result.onePageNumCount ; i++){
			if(i > result.totalPage){
				break;
			}else if(i == result.nowPage){
				tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
			}else{
				tag += "<li onclick='movePage("+i+");'>"+i+"</li>";
			}
		}
		if(result.nowPage != result.totalPage){
			tag += "<li onclick='movePage("+(result.nowPage+1)+")'>Next</li>";
		}
		
		getList(result.nowPage);
	}else {
		tag +="<li>검색 결과가 없습니다.</li></ul>";
		$("#messageList"+messageBox).children().remove();
	}
	
	$("#paging"+messageBox).html(tag);
}

function getList(page){
	
	var data = "nowPage="+page+"&messageBox="+messageBox;
	if($("#read"+messageBox).prop("checked")){
		data+= "&read="+"F";
	}
	
	$.ajax({
		url : "/home/selectMessage",
		data : data,
		success : function(result){
			if(result != null){
				setList(result);
			}
		},error : function(err){
			
		}			
	});
}

function setList(result){
	var tag ="";
	var $result = $(result);
	
	// 표 내용
	$result.each(function(idx, val){			
		tag += "<li><input type='checkbox' value='"+val.nonotice+"'/></li>";
		
		if(messageBox == 2){
			if(val.read == 'T' ){
				tag += "<li>"+val.userid+"</a></li>";
				tag += "<li class='workcut'>"+val.msg+"</li>";
				tag += "<li>"+val.writedate+"</li>";
			}else if(val.read =='F'){
				tag += "<li class='readYet'>"+val.userid+"</a></li>";
				tag += "<li class='workcut readYet'>"+val.msg+"</li>";
				tag += "<li class='readYet'>"+val.writedate+"</li>";
			}
		}else{
			if(val.read == 'T' ){
				tag += "<li>"+val.idsend+"</a></li>";
				tag += "<li class='workcut'>"+val.msg+"</li>";
				tag += "<li>"+val.writedate+"</li>";
			}else if(val.read =='F'){
				tag += "<li onclick='readMsg(title);' class='readYet' title='"+val.nonotice+"'>"+val.idsend+"</a></li>";
				tag += "<li onclick='readMsg(title);' class='workcut readYet' title='"+val.nonotice+"'>"+val.msg+"</li>";
				tag += "<li onclick='readMsg(title);' class='readYet' title='"+val.nonotice+"'>"+val.writedate+"</li>";
			}
		}
	});
	$("#messageList"+messageBox).html(tag);
}

function readMsg(title){
	var nonotice = title;
	
	$.ajax({
		url : "/home/messageRead",
		data : "nonotice="+nonotice,
		success : function(result){
			if(result == 1){
				$("#messageList"+messageBox+">li").each(function(){
					if(this.getAttribute('title') == nonotice){
						$(this).removeClass('readYet');
					}
				});
			}
		}, error : function(err){
			console.log(err);
		}
	});
}

function deleteMsg(nonotice){
	$.ajax({
		url : "/home/deleteMsg",
		data : "nonotice="+nonotice,
		success : function(result){
			if(result == 1){
				movePage(nowPage);
			}
		}, error : function(err){
			console.log(err);
		}
	});
}
// 메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(noboard, receiver, type){
	var receiver = receiver;
	var sender = $("#logId").val();
	
	console.log(receiver);
	console.log(sender);
	console.log(type);
	
	var noboard = noboard;
	var msg ="";
	var socketMsg = "";
	if(type == 1){
		msg = "<a href='/home/View?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>";
		socketMsg = "confirm,"+receiver+","+sender+","+noboard;
	}else if(type == 2){
		msg = "<a href='/home/View?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소처리 하였습니다.</a>";
		socketMsg = "revert,"+receiver+","+sender+","+noboard;
	}else if(type == 3){
		msg = "<a href='/home/View?noboard="+noboard+"'>" + noboard + "번 투어가 불참 처리되었습니다.</a>";
		socketMsg = "absent,"+receiver+","+sender+","+noboard;
	}else if(type == 4){
		msg = "<a href='/home/View?noboard="+noboard+"'>"+ noboard + "번 투어가 완료되었습니다.</a>";
		socketMsg = "complete,"+receiver+","+sender+","+noboard;
	}
	
	var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
	
	$.ajax({
		url : "/home/insertNotice",
		data : data,
		success : function(result){
			if(result == 1){
				socket.send(socketMsg);
			}
		},error : function(err){
			console.log(err);
		}
	})
}
</script>