<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<script>

// //추천 & 비추천




//글삭제 
	$(function(){
		$("#reviewdel").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href="/home/reviewDel?noboard=${vo.noboard}";	
			}
		});
		
		$("#upBtn").on('click', function(){
			// 이미 평가한 사람인 지 확인
			chkAlread(1);
		});

		$("#downBtn").on('click', function(){
			// 이미 평가한 사람인 지 확인
			chkAlread(2);
		});
	});
	

//////평점 주기

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
	
	var url = "/home/chkAlreadyReviewRate";
	var data = "noboard="+$("#noboard").val();
	     
	$.ajax({
	    url : url,
	    data : data,
	    success : function(result){
			if(result == 0){
				addThumb(type);				
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
				toast($("#noboard").val()+ "번 글을 " + tag + " 하셨습니다.",1500)
			}else {
				toast("후기 평가 오류입니다.", 1500);
			}
		},error : function(err){
			console.log(err);
		}
	});
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
								<li><label class="labelClass">작성자</label><span>${vo.userid }</span></li>
								<li><label class="labelClass">작성일</label>${vo.writedate }</li>
								<li><label class="labelClass">조회수</label>${vo.hit }</li>
							</ul>
						</li>
						<li class="btnGroup">
							<input type="button" value="삭제" id="reviewdel" class="gray_Btn"/>
							<input type="submit" value="수정" id="revsaveBtn" class="gray_Btn"/>
							<input type="submit" value="목록" id="revsaveBtn" class="mint_Btn"/>
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
							<b>추천 : ${vo.thumbUp }</b>
							<b>비추천 : ${vo.thumbDown }</b>
						</li>
						<li>
							<button type ="button" class ="WMint_Btn" id="upBtn">추천</button>
							<button type ="button" class ="mint_Btn" id="downBtn">비추천</button>
						</li>
					</ul>
				</div>
			</div>
		</div>
		
		
	<!--댓글-->
		<input type='hidden' id="noboard" value="${vo.noboard }"/>
		<%@ include file="../inc/reply.jspf"%>
	</div>
	
	
<!-- 	테스트 중 -->
</div>