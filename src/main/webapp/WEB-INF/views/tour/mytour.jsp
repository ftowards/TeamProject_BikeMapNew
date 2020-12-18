<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/home/css/myTour.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/tour/myTour.js"></script>
<div id="page-wrapper">
  <!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	    	<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_myRoute/bike4.png"/></li>
				<li class="sidebar-brand"><label style="color:rgb(0,176,176)">여행 목록</label></li>
				<hr/>
				<li><label for="tourOn">진행여행</label></li>
				<li><label for="tourClose">마감된 여행</label></li>
				<li style="margin-bottom:30px"><label for="tourComplete">완료된 여행</label></li>
		    </ul>
		</div>
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
		     				<ul id="tourOnListTitle" class="tourlistTitle" style="font-weight:bold;">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>마감일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>잔&nbsp;여</li>
				     			<li>대&nbsp;기</li>
				     			<li>참가목록</li>
		     				</ul>
		     				<ul id="tourOnList" class="tourlist"></ul>
						</div>
						<div id="paging1" class="paging"></div>
					</div>
				</div>
			</div>
			<!-- tourClose 시작 -->
			<div class="titleMyTourDiv1 tab"><label>마감된 여행</label>
				<div class="myTourBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="tourCloseListTitle" class="tourlistTitle2" style="font-weight:bold;">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>출발일시</li>
				     			<li>종료일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>참가목록</li>
				     			<li>완료</li>
		     				</ul>
		     				<ul id="tourCloseList" class="tourlist2"></ul>
						</div>
						<div id="paging2" class="paging"></div>
					</div>
				</div>
			</div>
			
			<!-- tourComplete 시작 -->
			<div class="titleMyTourDiv1 tab"><label>마감된 여행</label>
				<div class="myTourBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="tourCompleteListTitle" class="tourlistTitle3" style="font-weight:bold;">
		     					<li>번&nbsp;호</li>
				     			<li>제&nbsp;목</li>
				     			<li>출발일시</li>
				     			<li>종료일시</li>
				     			<li>참&nbsp;가</li>
				     			<li>참가목록</li>
		     				</ul>
		     				<ul id="tourCompleteList" class="tourlist3"></ul>
						</div>
						<div id="paging3" class="paging"></div>
					</div>
				</div>
			</div>
						
		</div>
	</div>
</div>