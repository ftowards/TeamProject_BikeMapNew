<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script type="text/javascript" src="<%=request.getContextPath() %>/js/review/reviewList.js"></script>

<!-- 후기보기메인 -->
<div class="container">
	<div class="reviewBody">	
		<form class = "search" id="searchReview" name="searchReview">
			<select name="searchTypeReview" id="searchTypeReview">
				<option value="subject" <c:if test="${pagingVO.searchType != null && pagingVO.searchType == 'subject' }">selected</c:if>>글제목</option>
				<option value="userid" <c:if test="${pagingVO.searchType != null && pagingVO.searchType == 'userid' }">selected</c:if>>작성자</option>
				<option value="content" <c:if test="${pagingVO.searchType != null && pagingVO.searchType == 'content' }">selected</c:if>>내용</option>				
			</select>
			<input type="text" id="searchBarReview" name="searchWordReview"<c:if test="${pagingVO.searchWord != null}">value='${pagingVO.searchWord }'</c:if>/>
			<input type="submit" class="mint_Btn" style="vertical-align:bottom; margin-left : 10px;"value="검 색"/>
		</form>
		<form id="pagingVO" method="post" action="/home/reviewView" style="diplay:none">
			<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
			<input type="hidden" name="searchType" value="${pagingVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchWord }"/>
			<input type="hidden" name="order" value="${pagingVO.order }"/>
			<input type="hidden" name="noboard" value=""/>
		</form>

<!--후기 제목 -->
		<div class= "reviewtitle">
			<ul>
				<li class="title">후기 게시판</li>
				<li class="orderRadio">
				<input type="radio"  name="orderReview" id="orderDesc" value="noboard" <c:if test="${pagingVO.order == 'noboard' }">checked</c:if>/>
					<label for="orderDesc" class="orderBtn">최신순</label>&ensp;|&ensp;
				<input type="radio" name="orderReview" id="orderAsc" value="thumb" <c:if test="${pagingVO.order == 'thumb' }">checked</c:if>/>
					<label for="orderAsc" class="orderBtn">추천순</label></li>
				<li>
				<input type="button" class="gray_Btn" name="reviewWriteBoard" value="글쓰기" onclick="goWriteForm()"></li>
			</ul>
		</div>

<!-- 후기창 게시판 -->
		<hr style='border:1.5px solid black; margin-bottom:0; background-color:black'/>
		<div id="reviewBoard">
			<ul class ="boardlist">
				<c:forEach var="vo" items="${list }">
					<li class="reviewContents">
		<!-- 						후기창 왼쪽 면 -->
						<div class ="left">
							<img src="${vo.thumbnailImg }" onclick="goReviewView(title);" title = "${vo.noboard }"/>
						</div>
		<!-- 						후기창 오른쪽 면 -->
						<div class="right">
							<ul onclick="goReviewView(title);" title = "${vo.noboard }">
								<li id="subtitle" class="wordCut subject_title">${vo.subject }</li>
								<li class="subject_Hitcount">Hit ${vo.hit} / 추천 ${vo.thumbup } / 비추천 ${vo.thumbdown }</li>
								<li class="wordCut" id="reviewtext">${vo.content }</li>
								<li class="userid">
									<img src="<%=request.getContextPath() %>/img/img_Review/review.png"/>
									${vo.userid }님의 생생한 후기
								</li>
								<li class="writedate">${vo.writedate }</li>
							</ul>
						</div>
		 			</li>
		 		</c:forEach>
			</ul>
		</div>
			
<!-- 		=============================페이징============================= -->
		<div id="paging" style='margin:35px auto 120px'>
			<ul>
			<!-- 이전 페이지 -->
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
			<!-- 다음 페이지 -->
				<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
					<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>