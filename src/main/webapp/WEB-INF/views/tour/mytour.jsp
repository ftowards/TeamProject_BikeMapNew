<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/home/css/myTour.css" type="text/css"/>

<div id="page-wrapper">
  <!-- 사이드바 -->
	<div id="sidebar-wrapper">
		<input type="hidden" id="logId" value="${logId }"/>
    	<ul class="sidebar-nav">
			<li class="sidebar-brand"><label>여행 목록</label></li>
			<li><label for="tourOn">진행여행</label></li>
			<li><label for="tourClose">마감된 여행</label></li>
			<li><label for="tourComplete">완료된 여행</label></li>
	    </ul>
	</div>
  <!-- /사이드바 -->

  <!-- 본문 -->
	<div class="myTour">
    	<div class="container-fluid">
    		<!-- 탭 전환용 라디오 버튼 : 숨김 처리 -->
	    	<input type="radio" name="tourState" id="tourOn" value="1" checked/> 
	    	<input type="radio" name="tourState" id="tourClose" value="2" />
	    	<input type="radio" name="tourState" id="tourComplete" value="3"/>
			
			<!-- tourOn 시작 -->	
			<div class="titleMyTourDiv1 tab"><label>진행여행</label>
				<div class="myTourBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="tourOnListTitle">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>마감일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>잔&nbsp;여</li>
				     			<li>대&nbsp;기</li>
				     			<li>참가목록</li>
		     				</ul>
		     				<ul id="tourOnList"></ul>
						</div>
						<div id="paging"></div>
					</div>
				</div>
			</div>
			<!-- tourClose 시작 -->
			<div class="tab"> dafdafadfa</div>
			
			<!-- tourComplete 시작 -->
			<div class="tab"> dafdafdsafdafadsfadsfcompleteadfa</div>
			
		</div>
	</div>
</div>

<script>
var tourState = 1;

$(function(){
	// 1. 페이징	
	movePage(1);
	// 2. 리스트 불러오기
	
	

});

function movePage(page){
	tourState = $("input[name=tourState]").val();
	
	$.ajax({
		url : "/home/mytour/paging",
		data : "nowPage="+page+"&tourState="+tourState,
		success : function(result){
			if(result != null){
				setPaging(result);
			}
		},error : function(err){
			
		}			
	});
}

function setPaging(result){
	var tag = "<ul>";
	
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
	$("#paging").html(tag);
	
	getList(result.nowPage);
}

function getList(page){
	$.ajax({
		url : "/home/mytour/selectTourlist",
		data : "nowPage="+page+"&tourState="+tourState,
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
	
	if(tourState == '1'){
		// 표 내용
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.deadline+"</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li>"+val.room+"</li>";
			tag += "<li>"+val.que+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist("+val.noboard+")'>▼</a></li></tr></tbody>";
			
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourOnList").html(tag);
	}
	
	console.log(result);
}

function getTourComplist(noboard){
	if(tourState == '1'){
		$.ajax({
			url : "/home/selectComplist",
			data : "noboard="+noboard,
			success : function(result){
				setAcodianList(result, noboard);
			},error : function(err){
				Console.log(err);
			}
		});
	}
}

function setAcodianList(result, noboard){
	console.log(result);
	var $result = $(result);
	
	var tag =""
	if(tourState == '1'){
		tag += "<li>참가자</li><li>나이</li><li>모임횟수</li><li>좋아요</li><li>참가상태</li><li></li>";
		
		if(result == null){
			$("#complist"+noboard).html(tag);
			return false;
		}
		
		$result.each(function(idx, val){
			tag += "<li>"+val.userid+"</li>"
			tag += "<li>"+val.age+"대</li>"
			tag += "<li>"+val.tourcnt+"</li>";
			tag += "<li><img src='/home/img/img_myRoute/like.png'/>"+val.heart+"</li>";
			
			if(val.state == '1'){
				tag += "<li>승인 대기</li>";
				tag += "<li><button class='tourIn' onclick='confirmComplist(title)' title='"+noboard+"/"+val.userid+"'>승&nbsp;인</button></li>";
			}else if(val.state == '2'){
				tag += "<li>참가 중</li>";
				if(val.userid != $("#logId").val()){
					tag += "<li><button class='tourOut' onclick='cancelComplist(title)' title='"+noboard+"/"+val.userid+"'>취&nbsp;소</button></li>";
				}else{
					tag +="<li></li>";
				}
			}			
		});
		
		$("#complist"+noboard).html(tag);
	}	
}

function confirmComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	$.ajax({
		url : "/home/mytour/confirmComplist",
		data : data,
		success : function(result){
			if(result == 1){
				alert("참가 승인 완료되었습니다.");
				sendMsg(strs[0], strs[1], 1);
			}else{
				alert("승인 오류 입니다.");
			}
		},error : function(err){
			console.log(err);
		}
	});	
	getTourComplist(strs[0]);
}

function cancelComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	$.ajax({
		url : "/home/mytour/revertComplist",
		data : data,
		success : function(result){
			if(result == 5){
				alert("마감 시간이 지나 참가 취소 처리가 불가합니다.");
			}else if(result == 1){
				alert("참가 취소 처리 되었습니다.");
				sendMsg(strs[0], strs[1], 2);
			}else{
				alert("참가 취소 처리 오류입니다.");
			}
		},error : function(err){
			console.log(err);
		}
	});	
	getTourComplist(strs[0]);
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
		msg = "<a href='/home/tourView?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>";
		socketMsg = "confirmTour,"+receiver+","+sender+","+noboard;
	}else if(type == 2){
		msg = "<a href='/home/tourView?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소처리 하였습니다.</a>";
		socketMsg = "revertTour,"+receiver+","+sender+","+noboard;
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