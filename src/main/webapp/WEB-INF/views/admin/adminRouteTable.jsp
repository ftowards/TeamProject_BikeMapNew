<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
	<!-- Page Content -->
	<div class="adminContent">	
				<div id="adminTable">
				<h1 class="adminListHead">루트게시판</h1>				
				<div class="orderRadio">
					<input type="radio" name="order" id="orderNoboard" value="noboard" checked="checked"><label for="orderNoboard" class="subTxt">최신순</label><span id="lBar"> | </span>
					<input type="radio" name="order" id="orderRating" value="rating"><label for="orderRating" class="subTxt">평점순</label>
				</div>
				<ul id="routeList">			
					<li><input type="checkbox" id="checkAll" /></li>		
					<li>번&nbsp;&nbsp;호</li>
					<li>제&nbsp;&nbsp;목</li>
					<li>작성자</li>
					<li>평&nbsp;&nbsp;점</li>
					<li>평가횟수</li>
					<li>지&nbsp;&nbsp;역</li>
					<li>비공개여부</li>
					<li>관리자추천</li>
					<!-- DB작업완료 후 for문 생성 -->
					<c:forEach items="${list}" var="vo" varStatus="status">
							<li><input type="checkbox" name="listChk" value="${vo.noboard}" /></li>
							<li>${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/routeSearchView?noboard=${vo.noboard }">${vo.title }</a></li>
							<li>${vo.userid}</li>
							<li>${vo.rating}</li>
							<li>${vo.ratecnt }</li>
							<li class='wordCut'>${vo.region}</li>
							<li>								
								<label class="switch">
								<c:if test="${vo.closed==null||vo.closed=='F'}">
									  <input type="checkbox" name="adminHideBtn" value="${vo.noboard }">				
								</c:if>
								<c:if test="${vo.closed=='T'}">
									  <input type="checkbox" name="adminHideBtn" value="${vo.noboard }" checked="checked" >							
								</c:if>
								 <span class="slider round"></span>
								</label>							
								<input type="hidden" class="userid" value="${vo.userid }"/>
							</li>
							<li>	
								<label class="switch">
								<c:if test="${vo.scrap==null||vo.scrap=='F'}">
									  <input type="checkbox" name="adminScrapBtn" value="${vo.noboard }">				
								</c:if>
								<c:if test="${vo.scrap=='T'}">
									  <input type="checkbox" name="adminScrapBtn" value="${vo.noboard }" checked="checked" >							
								</c:if>
								 <span class="slider round"></span>
								</label>							
								<input type="hidden" class="userid" value="${vo.userid }"/>
							</li>
					</c:forEach>
				</ul>
				</div>
				<!-- Page Content -->
				<!-- paging -->
			 
			<div id="paging">
					<ul>				
						<c:if test="${pagingVO.nowPage != 1 }">
							<li><a href="javascript:movePage(${pagingVO.nowPage-1 })"> Prev </a></li>
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
							<li style='margin-left:15px'><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
			</div><br/>
			<!-- /paging -->
			</div><!-- adminContent -->
				<div id="partnerBtn">
						<input type="button" id="partnerBtn1" name="adminScrapAllBtn" value="관리자 추천" class="red_Btn"/>
						<input type="button" id="partnerBtn2" name="adminReleaseAllBtn" value="관리자 추천 해제" class="gray_Btn"/>
				</div><!-- btn -->
<!-- Page Content -->
</body>
</html>