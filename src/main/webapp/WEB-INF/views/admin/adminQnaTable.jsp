<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
	<div class="adminContent">
		<div id="adminTable">
			<h1 class=adminListHead>1:1 문의사항</h1>
				<div class="answerAlready">
					<input type="checkbox" id="answer" name="answer" value="N" />
					<span>대기중인 답변만 보기</span>
				</div>
			<ul id="questionList"></ul>			
		</div>
				
		<!-- paging -->
		<div id="paging">
			<ul>					
				<c:if test="${pagingVO.nowPage != 1 }">
					<li><a href="javascript:">Prev</a></li>
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
				<c:if test="${pagingVO.nowPage != pagingVO.totalPage }">
					<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
				</c:if>
			</ul>
		</div>
		<!-- /paging -->
		<div id="partnerBtn">
			<input type="button" id="partnerBtn1" name="partnerDeleteBtn" onclick="deleteQna();" value="삭제하기" class="gray_Btn" style='position: relative; bottom: 17px; right: 65px;'/>
		</div><!-- btn -->
	</div><!-- adminContent -->
			
<!-- Page Content -->
</div><!--  adminBottom -->
</body>
</html>