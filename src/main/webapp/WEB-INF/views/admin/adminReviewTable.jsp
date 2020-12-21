<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
	<div class="adminContent">	
				<div id="adminTable">
				<h1 class="adminListHead">후기게시판</h1>
				<div class="orderRadio_review">
					<input type="radio" name="order" id="orderNoboard" value="noboard" checked><label for="orderNoboard" class="subTxt">최신순</label><span id="lBar"> | </span>
					<input type="radio" name="order" id="orderHit" value="thumb"><label for="orderHit" class="subTxt">추천순</label>
				</div>
				<ul id="reviewList">	
					
					<li><input type="checkbox" id="checkAll" /></li>	
					<li>번&nbsp;&nbsp;호</li>
					<li>제&nbsp;&nbsp;목</li>
					<li>작성자</li>
					<li>레퍼런스 번호</li>
					<li>조회수</li>
					<li>추천/비추천</li>
					<li>관리자추천</li>
					<!-- DB작업완료 후 for문 생성 -->
					<c:forEach items="${list}" var="vo" varStatus="status">
			
							<li><input type="checkbox" name="listChk" value="${vo.noboard }"/></li>
							<li> ${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/reviewView?noboard=${vo.noboard }">${vo.subject }</a></li>
							<li>${vo.userid}</li>
							<li>${vo.reference }</li>
							<li><input type="hidden" value="${vo.scrap }" />${vo.hit}회</li>
							<li style='letter-spacing:2px'><span style='color:#0000b5; font-size:19px'>${vo.thumbup} </span><span class='review_lBar'>/</span> <span style='color:#b30200; font-size:19px'>${vo.thumbdown} </span></li>
							<li>
								<c:if test="${vo.scrap==null||vo.scrap=='F'}">
									<label class="switch">
									  <input type="checkbox" name="adminReviewScrapBtn" value="${vo.noboard }">
									  <span class="slider round"></span>
									</label>		
									<input type="hidden" class="userid" value="${vo.userid }"/>				
								</c:if>
								<c:if test="${vo.scrap=='T'}">
									<label class="switch">
									  <input type="checkbox" name="adminReviewScrapBtn" value="${vo.noboard }" checked="checked" >
									  <span class="slider round"></span>
									</label>
									<input type="hidden" class="userid" value="${vo.userid }"/>
								</c:if>
							</li>
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
					
						<c:if test="${pagingVO.nowPage != pagingVO.totalPage }">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
			</div>			<!-- /paging -->
			<div id="reviewBtnDiv">
        <input type="button" id="partnerBtn1" name="adminReviewScrapAllBtn" value="관리자 추천" class="red_Btn"/>
        <input type="button" id="partnerBtn2" name="adminReviewReleaseAllBtn" value="관리자 추천 해제" class="mint_Btn"/>
        <input type="button" class="gray_Btn" onclick="deleteReview();" value="삭제" />
			</div><!-- btn -->

		</div><!-- adminContent -->
				
<!-- Page Content -->
</body>
</html>