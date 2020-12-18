<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<!-- Page Content -->
<script>
$(function(){
	movePage(1);
	$("input[name=state]").on('change', function(){
		movePage(1);
	});

});

function getTourComplist(noboard ){
     url = "/home/selectComplist";
	   
   $.ajax({
      url : url,
      data : "noboard="+noboard,
      success : function(result){
         setAcodianList(result, noboard);
      },error : function(err){
         console.log(err);
      }
   });
}

// 참가자 목록 만들기
function setAcodianList(result, noboard){
   console.log(result);
   var $result = $(result);
   
   var tag =""
     tag += "<li><b>참가자</b></li><li><b>나이</b></li><li><b>성별</b></li><li><b>모임횟수</b></li><li><b>좋아요</b></li><li><b>참가상태</b></li>";
      
     $result.each(function(idx, val){
        if(val.state == '2'){
           tag += "<li><span onclick='popMsgSend(title)' title='"+val.userid+"'>"+val.userid+"</span></li>";
           tag += "<li>"+val.age+"대</li>";
           
           if(val.gender == '1'){
              tag += "<li>남</li>";
           }else{ 
              tag += "<li>여</li>";
           }
           
           tag += "<li>"+val.tourcnt+"</li>";
           tag += "<li><img src='/home/img/img_myRoute/like3.png'/>"+"<span style='color:#cc113c'>"+val.heart+"</span>"+"</li>";
           tag += "<li><button class='tourOk'>참가 중</button></li>";
        }
     });
     
     $("#complist"+noboard).html(tag);
}

function makeTourTable(result){
	
	
	var listTag = "";
	for(var i = 0; i < result.length ; i++){

		//list안에 데이터 추가
		listTag += "<li><input type='checkbox' name='listChk' value='"+result[i].noboard+"'/>";
		listTag += "<li>"+result[i].noboard+"</li>";
		listTag += "<li class='wordCut'><a href = '<%=request.getContextPath()%>/tourView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
		listTag += "<li>"+result[i].userid+"</li>";
		listTag += "<li>"+result[i].party+"</li>";
		listTag += "<li><a data-toggle='collapse' href='#viewAcodian"+result[i].noboard+"' onclick='getTourComplist("+result[i].noboard+")'>▼</a></li>";
		listTag += "<li>";
		if(result[i].state=='1'||result[i].state==null){
			listTag +="<span class='complete'>미완료</span>";
		}else if(result[i].state=='2'){
			listTag +="<span class='imperfect'>완료</span>";
		}
		listTag += "</li>";
		listTag += "<div id='viewAcodian"+result[i].noboard+"' class='panel-collapse collapse'><ul id='complist"+result[i].noboard+"' class='acodianList'></ul></div>";
		
		}$("#tourList").html(listTag);
}

function deleteTour(){
	var cnt = 0;
	$("input[name=listChk]").each(function(i, val){
		if($(this).prop("checked")){
			cnt ++;
		}
	});
	
	if(cnt > 1){
		toast("투어 삭제는 하나씩 진행해주십시오.", 1500);
		return false;
	}
	
	var noboard =$("input[name=listChk]:checked").val(); 
	
	var url ="/home/tourViewDeleteChk";
	var data = "noboard="+noboard;
	
	$.ajax({
		url: url,
		data : data,
		success: function(result){
			if(result == 1){
				toast("완료된 여행은 삭제가 불가능합니다.",1500);
			}else if(result == 2){
				selectTourCompList(noboard);
			}else if(result == 3){
				toastConfirm("삭제된 글은 복구가 불가능합니다.<br/>그래도 삭제하시겠습니까?",function(){
					deleteTourView(noboard);
				});
		}else{
				toast("글삭제에 실패하였습니다.",1500);
				}
			},error:function(){
				console.log("글삭제 조건 에러");
			}
	});
}

//글삭제하기
function deleteTourView(noboard){
	
	var url = "/home/deleteTourView";
	var data = "noboard="+noboard;
	
	$.ajax({
		url:url
		,data:data
		,success:function(result){
			if(result == 1){
				toast("게시글이 삭제되었습니다.",1500);
				setTimeout(function(){movePage($("#nowPage").val());}, 1500);
			}else{
				toast("글삭제에 실패하였습니다.",1500);
			}
		},error:function(){
			console.log("글삭제 에러");
		}
	});
}	

// 참여인원 리스트 구하기
function selectTourCompList(noboard){
	var url = "/home/selectTourCompList";
	var data ="noboard="+noboard;
	
	$.ajax({
		url:url
		,data:data
		,success : function(result){
			if(result.length>0){
				toastConfirm("현재 "+result.length+"명의 참여인원이 있습니다.<br/>그래도 삭제하시겠습니까?",function(){
					selectTourCompReceiver(result, noboard);
				});	
			}else{
				toast("참여인원 리스트불러오기에 실패하였습니다.",1500);	
			}
		},error:function(){
			console.log("동행찾기 참여리스트 불러오기 에러");
		}
	});
}

// 참여인원
function selectTourCompReceiver(result, noboard){
	var $result = $(result);
	
	$result.each(function(i,val){
		setTimeout(sendTourDeleteMsg(val, noboard), 1500);
	});
	
	deleteTourView(noboard);
}	
// 게시글 삭제 메세지 보내기
function sendTourDeleteMsg(receiver, noboard){
	var receiver = receiver;
	var sender = $("#logId").val();
		
	var msg = sender + "님이 " + noboard + "번 투어를 취소하였습니다.";
	var socketMsg = "cancelTourAdmin,"+receiver+","+sender+","+noboard; 
	
	var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
	
	$.ajax({
		url: "/home/insertNotice",
		data: data,
		success : function(result){
		},error:function(err){
			console.log(err);
		}
	});
}
</script>
	<!-- /Page Sidebar -->
	<!-- 미완료된 리스트보기추가 -->
	<!-- Page Content -->
	<div class="adminContent">
		<div id="adminTable">
		
		<h1 class="adminListHead">동행모집게시판</h1>
		<!-- 모집중인게시판만보기 -->
		<div class="answerAlready">
					<input type="checkbox" id="state" name="state" value="1" />
					<span> 모집 게시글만 검색</span>
		</div>
			<ul id="tourListTitle">
				<li><input type="checkbox" id="checkAll" /></li>
				<li>번&nbsp;&nbsp;호</li>
				<li>제&nbsp;&nbsp;목</li>
				<li>작성자</li>
				<li>참가인원</li>
				<li>참가목록</li>
				<li>완료여부</li>
			</ul>
			<ul id="tourList"></ul>
		</div>
		<!-- Page Content -->
		<!-- paging -->
		
		<div id="paging">
				<ul>
					<c:if test="${pagingVO.nowPage != 1 }">
						<li><a href="#">Prev</a></li>
					</c:if>
					<c:forEach var="page" begin="${pagingVO.startPageNum }" end="${pagingVO.startPageNum + pagingVO.onePageNumCount -1}">
						<c:if test="${pagingVO.totalPage >= page }">
							<c:if test="${pagingVO.nowPage == page }">
								<li style='color:#00B0B0; font-weight:600;'>${page }</li>
							</c:if>
							<c:if test="${pagingVO.nowPage != page }">
								<li><a href="javascript:movePage(${page })" style='color:black; font-weight:600;'>${page }</a></li>
							</c:if>
						</c:if>
					</c:forEach>					
					<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
						<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
					</c:if>
				</ul>
		</div> 
		<!-- /paging -->
		<div id="partnerBtn">
			<input type="button" id="partnerBtn1" name="partnerDeleteBtn" onclick="deleteTour();" value="삭제하기" class="mint_Btn deleteBtn"/>
		</div><!-- btn -->
	</div><!-- adminContent -->
		
<!-- Page Content -->
</body>
</html>