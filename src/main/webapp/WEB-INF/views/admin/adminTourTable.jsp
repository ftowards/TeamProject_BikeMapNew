<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->

	<!-- /Page Sidebar -->
	
	<!-- Page Content -->
	<div class="adminContent">
			
				<div id="adminTable">
				<h1 class="adminListHead">동행모집게시판</h1>
					<ul id="partnerList">
						<li><input type="checkbox" id="checkAll" />번호</li>
						<li>제목</li>
						<li>작성자</li>
						<li>추천</li>
						<li>비추천</li>
						<li>조회수</li>
						<li>등록일</li>
					
						<!-- DB작업완료 후 for문 생성 -->
						
						<c:forEach items="${list}" var="vo" varStatus="status">
							<li> <input type="checkbox" />&nbsp&nbsp${vo.noboard}</li>
							<li><a href = "<%=request.getContextPath()%>/tourView?noboard=${vo.noboard }">${vo.title }</a></li>
							<li>${vo.userid}</li>
							<li>3회 수정</li>
							<li>3회 수정</li>
							<li>3회 수정</li>
							<li>${vo.writedate}</li>
					</c:forEach>
					</ul>
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
							<li><a href="#">Next</a></li>
						</c:if>
					</ul>
			</div><br/> 
			<!-- /paging -->
			<div id="partnerBtn">
					<input type="button" id="partnerBtn1" name="partnerDeleteBtn" value="삭제하기" class="mint_Btn"/><input type="button" id="partnerBtn2" name="partnerHideBtn" value="비공개"/>
			</div><!-- btn -->
			</div><!-- adminContent -->
<!-- Page Content -->
</body>
</html>