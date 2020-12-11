<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/home/css/messageBox.css" type="text/css"/>

<div id="page-wrapper">
  <!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	    	<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_tour/messge.png"/></li>
				<li class="sidebar-brand"><label style="color:rgb(0,176,176)">쪽지함</label></li>
				<hr/>
				<li><label for="receiveBox">받은 쪽지</label></li>
				<li><label for="sendBox">보낸 쪽지</label></li>
				<li><label for="noticeBox">알림</label></li>
				<li><label for="sendMessage">쪽지 보내기</label></li>
		    </ul>
		</div>
	</div>
	<div class="modal modal-sm modalPosition" id="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header" style="border:none">
					<label><img src="<%=request.getContextPath()%>/img/img_tour/messge.png" style="width:30px">&ensp;<span id="msgId"></span></label>
					<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
				</div>
				<!-- body -->
				<div id="msgView" class="modal-body">
				</div>
				<!-- footer -->
				<div class="modal-footer" style="border:none">
					
				</div>
			</div>
		</div>
	</div>	
  <!-- /사이드바 -->

  <!-- 본문 -->
	<div class="my">
    	<div class="container-fluid">
    		<!-- 탭 전환용 라디오 버튼 : 숨김 처리 -->
	    	<input type="radio" name="messageBox" id="receiveBox" value="1" checked/> 
	    	<input type="radio" name="messageBox" id="sendBox" value="2" />
	    	<input type="radio" name="messageBox" id="noticeBox" value="3" />
	    	<input type="radio" name="messageBox" id="sendMessage" value="4" />
			<!-- On 시작 -->	
			<div class="titleMyDiv1 tab"><label>받은 쪽지함</label>
				<span class="readYetChk">
					<input type="checkbox" id="read1" name="read" value="F" />
					<span>안 읽은 쪽지만 보기</span>
				</span>
				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<input type="button" name="readMsg" value="읽음" class="btn"/>
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="receiveBoxTitle" class="listTitle">
		     					<li><input type="checkbox" id="chkAll1"/></li>
				     			<li>보낸회원</li>
				     			<li>내용</li>
				     			<li>날짜</li>
		     				</ul>
		     				<ul id="messageList1" class="list"></ul>
						</div>
						<div id="paging1" class="paging"></div>
					</div>
				</div>
			</div>
			<!-- 보낸 쪽지함 시작 -->
			<div class="titleMyDiv1 tab"><label>보낸 쪽지함</label>
				<span class="readYetChk">
					<input type="checkbox" id="read2" name="read" value="F" />
					<span>안 읽은 쪽지만 보기</span>
				</span>				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<input type="button" name="readMsg" value="읽음" class="btn"/>
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="sendBoxTitle" class="listTitle">
		     					<li><input type="checkbox" id="chkAll2"/></li>
				     			<li>받은회원</li>
				     			<li>내용</li>
				     			<li>날짜</li>
		     				</ul>
		     				<ul id="messageList2" class="list"></ul>
						</div>
						<div id="paging2" class="paging"></div>
					</div>
				</div>
			</div>
			<!-- Close 시작 -->
			<div class="titleMyDiv1 tab"><label>알림</label>
				<span class="readYetChk">
					<input type="checkbox" id="read3" name="read" value="F" />
					<span>안 읽은 쪽지만 보기</span>
				</span>				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<input type="button" name="readMsg" value="읽음" class="btn" />
				
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="noticeBoxTitle" class="listTitle">
		     					<li><input type="checkbox" id="chkAll3"/></li>
				     			<li>보낸회원</li>
				     			<li>내용</li>
				     			<li>날짜</li>
		     				</ul>
		     				<ul id="messageList3" class="list"></ul>
						</div>
						<div id="paging3" class="paging"></div>
					</div>
				</div>
			</div>
			<div class="titleMyDiv1 tab"><label>쪽지 보내기</label>
				<br/>
				<iframe src="/home/sendMsg" ></iframe>
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
	
	$(".wordcut").on('mouseenter',function(){
		console.log(1111);
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
				tag += "<li class='wordcut' onclick='veiwMsg(title)' data-target='#dialog' data-toggle='modal'  title='"+val.nonotice+"' >"+val.msg+"</li>";
				tag += "<li>"+val.writedate+"</li>";
			}else if(val.read =='F'){
				tag += "<li class='readYet'>"+val.userid+"</a></li>";
				tag += "<li class='wordcut readYet' onclick='veiwMsg(title)' data-target='#dialog' data-toggle='modal'  title='"+val.nonotice+"'>"+val.msg+"</li>";
				tag += "<li class='readYet'>"+val.writedate+"</li>";
			}
		}else{
			if(val.read == 'T' ){
				tag += "<li>"+val.idsend+"</a></li>";
				tag += "<li class='wordcut' onclick='veiwMsg(title)' data-target='#dialog' data-toggle='modal'  title='"+val.nonotice+"'>"+val.msg+"</li>";
				tag += "<li>"+val.writedate+"</li>";
			}else if(val.read =='F'){
				tag += "<li onclick='readMsg(title);' class='readYet' title='"+val.nonotice+"'>"+val.idsend+"</a></li>";
				tag += "<li onclick='readMsg(title);' onclick='veiwMsg(title)' data-target='#dialog' data-toggle='modal'  class='wordcut readYet' title='"+val.nonotice+"'>"+val.msg+"</li>";
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

function veiwMsg(title){
	var nonotice = title;
	
	var x = event.pageX + 'px';
	var y = event.pageY + 'px';
	
	$(".modal").css({
		top : y,
		left : x
	});
	
	$.ajax({
		url : "/home/messageView",
		data : "nonotice="+nonotice,
		success : function(result){
			if(result != null){
				console.log(result);
				if(messageBox == 1 || messageBox == 3){
					$("#msgId").text(result.idsend);
				}else{
					$("#msgId").text(result.userid);
				}
				
				$("#msgView").html(result.msg);
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