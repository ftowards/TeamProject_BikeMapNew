<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
	<div class="adminContent">
		<div id="adminTable">
		
		<h1 class="adminListHead">동행모집게시판</h1>
		<!-- 모집중인게시판만보기 -->
		<div class="answerAlready" style='padding-left:95px'>
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
			<input type="button" id="partnerBtn1" name="partnerDeleteBtn" onclick="deleteTour();" value="삭제하기" class="gray_Btn deleteBtn"/>
		</div><!-- btn -->
	</div><!-- adminContent -->
		
<!-- Page Content -->
</body>
</html>