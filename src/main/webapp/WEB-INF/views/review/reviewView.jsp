<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<script>


//글삭제 
$(function(){
		
	$("#reviewdel").click(function(){
		toastConfirm("후기를 삭제하시겠습니까?<br/>삭제 후 복구가 불가능합니다.", function(){
			$.ajax({
				url : "/home/reviewDel",
				data : "noboard="+$("#noboard").val(),
				success : function(result){
					if(result > 0){
						toast("후기를 삭제하였습니다.", 1500);
						setTimeout(function(){location.href="/home/reviewList";}, 1500);
					}else {
						toast("후기 삭제 오류 입니다. 다시 시도해주십시오.", 1500);
					}
				}, error : function(err){
					console.log(err);
				}
			});
		});
	});

	$("#reviewEdit").click(function(){
		location.href="/home/reviewEdit?noboard="+$("#noboard").val();	
	});
	
	// 이미 평가한 사람인 지 확인
	$("#upBtn").on('click', function(){
		chkAlread(1);
	});

	$("#downBtn").on('click', function(){
		chkAlread(2);
	});

});

//////추천 비추천

function chkAlread(type){
	// 로그인 상태가 아닐 때 로그인 팝업 띄우기
	var logId = $("#logId").val();
	
	// 로그인 상태일 경우 로그인 팝업 띄우기
	if(logId == ""){
	   window.open("/home/loginPopup","Bikemap Login","width=600px, height=200px, left =200px, top=200px");
	   return false;
	}
	
	// 자신이 작성한 글일 때는 평가 불가
	if(logId == $("#userid").text()){
	   toast("회원님이 작성한 루트는 평가할 수 없습니다.",1500);
	   return false;
	}
	
	var tag = "추천";
	if(type == 2){tag ="비추천";}
	
	
	var url = "/home/chkAlreadyReviewRate";
	var data = "noboard="+$("#noboard").val();
	     
	$.ajax({
	    url : url,
	    data : data,
	    success : function(result){
			if(result == 0){
				toastConfirm("후기에 대한 평가는 수정이 불가능합니다.<br/>후기를 "+tag+" 하시겠습니까?", function(){
					addThumb(type);
				});
	        }else {
	        	toast("이미 평가한 후기입니다.",1500);
	        }
		},error : function(err){
	        console.log(err);
		}
	});
}

function addThumb(type){
	var tag = "추천";
	if(type == 2){
		tag ="비추천";
	}
	
	$.ajax({
		url : "/home/setThumb",
		data : "noboard="+$("#noboard").val()+"&thumbType="+type,
		success : function(result){
			if(result >0){
				toast($("#noboard").val()+ "번 글을 " + tag + " 하셨습니다.",1500);
				setThumb();
			}else {
				toast("후기 평가 오류입니다.", 1500);
			}
		},error : function(err){
			console.log(err);
		}
	});
}

function goReviewView(noboard){
	console.log(noboard);
	
	$("#pagingVO").attr("action", "/home/reviewView");
	$("input[name=noboard]").val(noboard);
	$("#pagingVO").submit();
}

function goReviewList(){
	
	console.log($("#pagingVO").serialize());
	$("#pagingVO").submit();
}

function setThumb(){
	$.ajax({
		url : "/home/selectReviewThumb",
		data : "noboard="+$("#noboard").val(),
		success : function(result){
			$("#thumbup").text(result.thumbup);
			$("#thumbdown").text(result.thumbdown);
		},error : function(err){
			console.log(err);
		}
	});
}

function setScrap(){
	$.ajax({
		url : "/home/scrapReview",
		data : "noboard="+$("#noboard").val(),
		success : function(result){
			if(result >= 0){
				toast("스크랩 완료", 1500);
				leaveMessage();
			}else{
				toast("스크랩 오류", 1500);
			}
		},error : function(err){
			console.log(err);	
		}
	});
}

function releaseScrap(){
	$.ajax({
		url : "/home/releaseReview",
		data : "noboard="+$("#noboard").val(),
		success : function(result){
			if(result >= 0){
				toast("스크랩 해제", 1500);
				setTimeout(function(){location.reload(true)},1500);
			}else{
				toast("스크랩 해제 오류", 1500);
			}
		},error : function(err){
			console.log(err);	
		}
	});
}

function leaveMessage(){
	
	//데이터 구하기
	var data = "reply="+"해당 루트가 추천 루트로 게시됩니다. 게시를 원치 않으실 경우 관리자 문의 부탁드립니다.";
		data += "&noboard="+$("#noboard").val();
		
	$.ajax({
		url:"/home/replyWriteOk"
		,data: data
		,success:function(result){
			if(result == 1){
				sendMsg(noboard, $("#userid").text(), 1);
			}
		},error:function(){
			console.log("댓글쓰기 에러 발생..");
		}
	});
}
  
  //메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(noboard, receiver, type){
	var receiver = receiver;
	var sender = $("#logId").val();
	
	var noboard = $("#noboard").val();;
	var msg ="";
	var socketMsg = "";
	
	if(type == 1){
		msg = "<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+noboard+ "번 후기가 추천 후기로 등록되었습니다.</a>";
		socketMsg = "scrapReview,"+receiver+","+sender+","+noboard;
	}

	var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
	console.log(data);

	$.ajax({
		type : 'POST',
		url : "/home/insertNotice",
		data : data,
		success : function(result){
			if(result == 1){
				socket.send(socketMsg);
				setTimeout(function(){location.reload(true)},1500);
			}else{
				toast("알림 남기기 실패", 1500);
			}
		},error : function(err){
			console.log(err);
		}
	})
}
  
//쪽지창 열기
function popMsgSend(userid){
	if(userid == 'admin' || userid == $("logId").val()){
		return false
	}
	window.open('/home/sendMsg?userid='+userid, 'msg', 'width=425px, height=360px, left =200px, top=200px, resizable=0');	
}
</script>

<!-- 후기게시판 제목 -->
<div class = "mainDiv">

	<!-- 후기 게시판 내용 -->
	<div class="reviewBody" >	
		<div class="reviewList-type1">
				
			<div class ="contentList">
				<div class="contentUpper">
					<ul>
						<li id="conttitle">${vo.subject }</li>
						<li>
							<ul class="reviewInfo">
								<li><label class="labelClass">작성자</label><span id="userid" onclick="popMsgSend(title)" title="${vo.userid }">${vo.userid }</span></li>
								<li><label class="labelClass">작성일</label>${vo.writedate }</li>
								<li><label class="labelClass">조회수</label>${vo.hit }</li>
							</ul>
						</li>
						<li class="btnGroup">
							<c:if test="${logStatus == 'Y' && logId== vo.userid }">
								<input type="button" value="삭제" id="reviewdel" class="gray_Btn"/>
								<input type="submit" value="수정" id="reviewEdit" class="gray_Btn"/>
							</c:if>
							<c:if test="${logStatus == 'Y' && logId =='admin' }">
								<c:if test="${vo.scrap == 'T' }"><input type="button" value="추천 해제" onclick="releaseScrap();" style="font-size:smaller" class="mint_Btn"/></c:if>
								<c:if test="${vo.scrap == 'F' }"><input type="button" value="추천" onclick="setScrap();" class="mint_Btn"/></c:if>							
								<input type="button" value="삭제" id="reviewdel" class="gray_Btn"/>
							</c:if>
							<input type="submit" value="목록" id="reviewList" class="mint_Btn" onclick="goReviewList()"/>
						</li>
						
					</ul>	
				</div>
				<div class="review-content2">
					<ul>
						<li>${vo.content }</li>
					</ul>
				</div>
<!-- 추천&비추천 -->
				<div id ="thumb">
					<ul>
						<li>
							<img src="<%=request.getContextPath() %>/img/img_Review/good2.png"/>
							<span id='thumbup'>${vo.thumbup }</span>
							<img src="<%=request.getContextPath() %>/img/img_Review/bad2.png"/>
							<span id='thumbdown'>${vo.thumbdown }</span>
						</li>
						<li class="btnGroup2">
							<input type ="button" class ="WMint_Btn" id="upBtn" value="추천"/>
							<input type ="button" class ="mint_Btn" id="downBtn" value="비추천"/>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div>
			<form id="pagingVO" method="post" action="/home/reviewList" style="diplay:none">
				<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
				<input type="hidden" name="searchType" value="${pagingVO.searchType }"/>
				<input type="hidden" name="searchWord" value="${pagingVO.searchWord }"/>
				<input type="hidden" name="order" value="${pagingVO.order }"/>
				<input type="hidden" name="noboard" value="0"/>
			</form>
			<ul>
				<li>
					<hr/>
				</li>
				<c:if test="${next != null }">
					<li class="prevTxt">
						다음글<span class="prev_next">▲</span><a href="javascript:goReviewView(${next.noboard})">${next.subject }</a>
					</li>
					<li>
						<hr>
					</li>
				</c:if>
				<c:if test="${prev != null }">
					<li class="prevTxt">
						이전글<span class="prev_next">▼</span><a href="javascript:goReviewView(${prev.noboard})">${prev.subject }</a>
					</li>
					<li>
						<hr/>
					</li>
				</c:if>
				<li class="listBtn">
					<input type="button" onclick="goReviewList()" value="목록"/>
				</li>
				
			</ul>
			<a id="back-to-top" href="#"><i class="fa fa-angle-up"></i></a>
		</div>
	<!--댓글-->
		<input type='hidden' id="noboard" value="${vo.noboard }"/>
		<%@ include file="../inc/reply.jspf"%>
	</div>
<!-- 	테스트 중 -->
</div>