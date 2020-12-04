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
		     			<table id="tourOnList" class="table table-striped table-hover">
		     				<thead>
			     				<tr>
					     			<th>번&nbsp;호</th>
					     			<th>제&nbsp;목</th>
					     			<th>마감일시</th>
					     			<th>참&nbsp;가</th>
					     			<th>잔&nbsp;여</th>
					     			<th>대&nbsp;기</th>
					     			<th>참가목록</th>
				     			</tr>
							</thead>
				     		<tbody>
		     				<!-- =====================db작업======================== -->
			     				<tr>
				     				<td>900</td>
					     			<td><a href="#">소라네 코스</a></td>
					     			<td><a data-toggle="collapse" href="#viewAcodian">20-12-01 15:00</a></td>
					     			<td><a data-toggle="collapse" href="#viewAcodian">3</a></td>
					     			<td><a data-toggle="collapse" href="#viewAcodian">2</a></td>
					     			<td><a data-toggle="collapse" href="#viewAcodian">1</a></td>
				     			</tr>
			    	 		</tbody>
						</table>
			   	 		<div id="viewAcodian" class="panel-collapse collapse">
			     			<table class="table">
			     				<thead>
				     				<tr>
						     			<th>참가자</th>
						     			<th>나이대</th>
						     			<th>모임횟수</th>
						     			<th>좋아요</th>
						     			<th>참가상태</th>
						     			<th>관&nbsp;리</th>
					     			</tr>
			    	 			</thead>
			  					<tbody>
								<!-- =====================db작업(아코디언)======================== -->
					     			<tr>
					     				<td>권세란</td>
						     			<td>20대</td>
						     			<td>5회</td>
						     			<td><img src="<%=request.getContextPath()%>/img/img_myRoute/like.png">5</td>
						     			<td><button type="submit" class="tourIn">참가중</button></td>
						     			<td><button type="submit" class="tourOut">추&nbsp;방</button></td>
					     			</tr>
								</tbody>
								<tbody>
									<!-- =====================(임시 데이터)======================== -->
				    	 			<tr>
					     				<td>박소라</td>
						     			<td>20대</td>
						     			<td>3회</td>
						     			<td><img src="<%=request.getContextPath()%>/img/img_myRoute/like.png">20</td>
						     			<td><button type="submit" class="tourOk">승&nbsp;인</button></td>
						     			<td><button type="submit" class="tourNo">거&nbsp;절</button></td>
				     				</tr>
								</tbody>
			    	 		</table>
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
		// 표 타이틀
		tag += "<thead><tr><th>번&nbsp;호</th><th>제&nbsp;목</th><th>마감일시</th><th>참&nbsp;가</th><th>잔&nbsp;여</th><th>대&nbsp;기</th><th>참가목록</th></tr></thead>";
		
		// 표 내용
		$result.each(function(idx, val){			
			tag += "<tbody><tr>";
			tag += "<td>"+val.noboard+"</td>";
			tag += "<td><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></td>";
			tag += "<td>"+val.deadline+"</td>";
			tag += "<td>"+val.party+"</td>";
			tag += "<td>"+val.room+"</td>";
			tag += "<td>"+val.que+"</td>";
			tag += "<td><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"'>▼</a></td></tr></tbody>";
			tag += "<tbody id='viewAcodian"+val.noboard+"' onclick='getTourComplist("+val.noboard+")' class='panel-collapse collapse'>ㅁㄹㅇㅁㄻㄻㅇㄹ</tbody>";
		});
		$("#tourOnList").html(tag);
	}
	
	console.log(result);
}
</script>