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
    	<ul class="sidebar-nav">
			<li class="sidebar-brand"><label>참여 목록</label></li>
			<li><label for="tourApply">승인 대기</label></li>
			<li><label for="tourPartin">참여 중</label></li>
			<li><label for="tourEnd">완&nbsp;료</label></li>
	    </ul>
	</div>
  <!-- /사이드바 -->

  <!-- 본문 -->
  	<div class="myTour">
    	<div class="container-fluid">
    		<!-- 탭 전환용 라디오 버튼 : 숨김 처리 -->
	    	<input type="radio" name="applyState" id="tourApply" value="1" checked/> 
	    	<input type="radio" name="applyState" id="tourPartin" value="2" />
	    	<input type="radio" name="applyState" id="tourEnd" value="3"/>
			
			<!-- tourApply 시작 -->	
			<div class="titleMyTourDiv1 tab">
				<label>승인 대기</label>
				<div class="myTourBoardMainDiv">
		     		<div>
		     			<div>
		     				<ul id="tourApplyListTitle" class="tourlistTitle">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>마감일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>잔&nbsp;여</li>
				     			<li>대&nbsp;기</li>
				     			<li>참가목록</li>
		     				</ul>
		     				<ul id="tourApplyList" class="tourlist"></ul>
						</div>
						<div id="paging1" class="paging"></div>
					</div>
				</div>
			</div>
			<!-- tourPartin 시작 -->
			<div class="titleMyTourDiv1 tab">
				<label>참여 여행</label>
				<div class="myTourBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="tourPartinListTitle" class="tourlistTitle2">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>출발일시</li>
				     			<li>종료일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>참가목록</li>
				     			<li>마&nbsp;감</li>
		     				</ul>
		     				<ul id="tourPartinList" class="tourlist2"></ul>
						</div>
						<div id="paging2" class="paging"></div>
					</div>
				</div>
			</div>
			
			<!-- tourEnd 시작 -->
			<div class="titleMyTourDiv1 tab"><label>완료 여행</label>
				<div class="myTourBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="tourEndListTitle" class="tourlistTitle3">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>출발일시</li>
				     			<li>종료일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>참가목록</li>
		     				</ul>
		     				<ul id="tourEndList" class="tourlist3"></ul>
						</div>
						<div id="paging3" class="paging"></div>
					</div>
				</div>
			</div>
						
		</div>
	</div>
</div>
<script>
var applyState = 1;
$(function(){
	// 1. 페이징
	movePage(1);
	// 2. 리스트 불러오기
	$("input[name=applyState]").on('change', function(){
		applyState = $("input[name=applyState]:checked").val();
		console.log(applyState);
		movePage(1);
	});
})

function movePage(page){
	
	$.ajax({
		url : "/home/mytour/paging",
		data : "nowPage="+page+"&applyState="+applyState,
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
	}

	if(applyState == 1){
		$("#paging1").html(tag);
	}else if(applyState == 2){
		$("#paging2").html(tag);
	}else if(applyState == 3	){
		$("#paging3").html(tag);
	}
}

function getList(page){
	$.ajax({
		url : "/home/mytour/selectTourlist",
		data : "nowPage="+page+"&applyState="+applyState,
		success : function(result){
			setList(result);
		},error : function(err){
			console.log(err);
		}			
	});
}

function setList(result){
	var tag ="";
	var $result = $(result);
	
	if(applyState == '1'){
		// 표 내용
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.deadline+":00</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li>"+val.margin+"</li>";
			tag += "<li>"+val.que+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist(title)' title='"+val.noboard+"/"+val.userid+"'>▼</a></li>";
			
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourApplyList").html(tag);
	
	}else if(applyState == '2'){ // 참여 중 여행
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.departure+":00</li>";
			tag += "<li>"+val.arrive+":00</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist(title)' title='"+val.noboard+"/"+val.userid+"'>▼</a></li>";
			
			if(chkDeadline(val.deadline)){
				tag += "<li>마감 표시</li>"
			}else{
				tag += "<li></li>";
			}
						
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourPartinList").html(tag);
	}else if(applyState == '3'){ // 완료된 여행
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.departure+":00</li>";
			tag += "<li>"+val.arrive+":00</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist(title)' title='"+val.noboard+"/"+val.userid+"'>▼</a></li>";
			
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourEndList").html(tag);
	}
}

// 참가 목록 불러오기
function getTourComplist(title){
	var strs = title.split("/");

	var url = "/home/tour/selectEvallist";
	if(applyState == '1' || applyState == '2'){
		url = "/home/selectComplist";
	}
	
	$.ajax({
		url : url,
		data : "noboard="+strs[0],
		success : function(result){
			console.log(strs[1]);
			setAcodianList(result, strs[0], strs[1]);
		},error : function(err){
			console.log(err);
		}
	});
}

//참가자 목록 만들기
function setAcodianList(result, noboard, userid){
	var $result = $(result);
	
	var tag =""
	if(applyState == '1'){
		tag += "<li>참가자</li><li>나이</li><li>성별</li><li>모임횟수</li><li>좋아요</li><li>참가상태</li><li></li>";
		
		$result.each(function(idx, val){
			tag += "<li>"+val.userid+"</li>"
			tag += "<li>"+val.age+"대</li>"
			
			if(val.gender == '1'){
				tag += "<li>남</li>";
			}else{ 
				tag += "<li>여</li>";
			}
			
			tag += "<li>"+val.tourcnt+"</li>";
			tag += "<li><img src='/home/img/img_myRoute/like.png'/>"+val.heart+"</li>";
			
			if(val.state == '1'){
				tag += "<li>승인 대기</li>";
			}else if(val.state == '2'){
				tag += "<li>참가 중</li>";
			}
			
			if(val.userid == $("#logId").val()){
				tag += "<li><button class='tourOut' onclick='cancelApply(title)' title='"+noboard+"/"+userid+"'>취&nbsp;소</button></li>";
			}else{
				tag +="<li></li>";
			}		
		});
		
		$("#complist"+noboard).html(tag);
	}else if(applyState == '2'){
		tag += "<li>참가자</li><li>나이</li><li>성별</li><li>모임횟수</li><li>좋아요</li><li>참가상태</li><li></li>";
		
		$result.each(function(idx, val){
			tag += "<li>"+val.userid+"</li>"
			tag += "<li>"+val.age+"대</li>"
			
			if(val.gender == '1'){
				tag += "<li>남</li>";
			}else{ 
				tag += "<li>여</li>";
			}
			
			tag += "<li>"+val.tourcnt+"</li>";
			tag += "<li><img src='/home/img/img_myRoute/like.png'/>"+val.heart+"</li>";
			
			if(val.state == '3'){
				tag += "<li>불참</li>";
			}else if(val.state == '2'){
				tag += "<li>참가 중</li>";
			}
			
			if(val.userid == $("#logId").val()){
				tag += "<li><button class='tourOut' onclick='cancelApply(title)' title='"+noboard+"/"+userid+"'>취&nbsp;소</button></li>";
			}else{
				tag +="<li></li>";
			}
		});
		
		$("#complist"+noboard).html(tag);
	}else if(applyState == '3'){
		tag += "<li>참가자</li><li>나이</li><li>성별</li><li>모임횟수</li><li>좋아요</li><li>평가 여부</li><li></li>";
		
		$result.each(function(idx, val){			
			tag += "<li>"+val.objid+"</li>"
			tag += "<li>"+val.age+"대</li>"
			
			if(val.gender == '1'){
				tag += "<li>남</li>";
			}else if(val.gender == '2'){ 
				tag += "<li>여</li>";
			}
			
			tag += "<li>"+val.tourcnt+"</li>";
			tag += "<li><img src='/home/img/img_myRoute/like.png'/>"+val.heart+"</li>";
			
			if(val.eval == 'N'){
				tag += "<li>미평가</li>";
				tag += "<li><button class='tourOut' onclick='addLike(title)' title='"+noboard+"/"+val.objid+"'>좋아요</button></li>";
			}else if(val.eval == 'Y'){
				tag += "<li>완료</li>";
				tag +="<li></li>";
			}
		});
		
		$("#complist"+noboard).html(tag);
	}
}

//마감 여부 표시 체크 / 마감 시간과 현재 시간 비교
function chkDeadline(deadline){
	var times = deadline.replace(" ", "-").split("-")

	var arriveDate = new Date(2000+Number(times[0]), Number(times[1])-1, times[2], times[3], 0, 0, 0);
	var date = new Date();
	
	if(date.getTime() - arriveDate.getTime() > 0){
		return true; // 완료 표시 해야 함
	}else{
		return false; // 완료 표시 안 함
	}
}

function cancelApply(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	var msg = "참가를";
	
	if(applyState== 1){
		msg = "참가 신청을";
	}
	
	if(confirm(strs[0] + "번 투어 "+msg+" 취소하시겠습니까?")){
		$.ajax({
			url : "/home/cancelTour",
			data : data,
			success : function(result){
				if(result == 1){
					alert(strs[0] +"번 투어 "+msg+ "취소하였습니다.");
					sendMsg(strs[0], strs[1], 1);
				}else if(result == 5){
					alert("마감시간이 지났습니다.\n주최자에게 불참을 알려주세요.");
				}else{
					alert("처리 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
		});	
		getTourComplist(strs[0]);
	}
}

function addLike(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&objid="+strs[1];
	
	if(confirm("좋아요 평가는 취소할 수 없으며, 평가 여부를 상대방이 알 수 없습니다.\n"+strs[1]+" 님에게 좋아요를 보내시겠습니까?")){
		
		$.ajax({
			url : "/home/mytour/addHeart",
			data : data,
			success : function(result){
				if(result == 1){
					alert("좋아요 하셨습니다..");
				}else{
					alert("좋아요 처리 처리 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
		});	
		getTourComplist(strs[0]);
	}
}

//메세지 저장하기 ++ 통신으로 메세지 보내기
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
		msg = "<a href='/home/tourView?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소하였습니다.</a>";
		socketMsg = "cancelTour,"+receiver+","+sender+","+noboard;
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
