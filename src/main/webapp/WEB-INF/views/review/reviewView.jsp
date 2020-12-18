<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/review/reviewView.js"></script>
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
								<li><label class="labelClass">작성자</label><span id="userid" onclick="popMsgSend(title)" title="${vo.userid }">${vo.userid }</span></li>
								<li><label class="labelClass">작성일</label>${vo.writedate }</li>
								<li><label class="labelClass">조회수</label>${vo.hit }</li>
							</ul>
						</li>
						<li class="btnGroup">
							<c:if test="${logStatus == 'Y' && logId== vo.userid }">
								<input type="button" value="삭제" id="reviewdel" class="gray_Btn"/>
								<input type="submit" value="수정" id="reviewEdit" class="gray_Btn"/>
							</c:if>
							<c:if test="${logStatus == 'Y' && logId =='admin' }">
								<c:if test="${vo.scrap == 'T' }"><input type="button" value="추천 해제" onclick="releaseScrap();" style="font-size:smaller" class="mint_Btn"/></c:if>
								<c:if test="${vo.scrap == 'F' }"><input type="button" value="추천" onclick="setScrap();" class="mint_Btn"/></c:if>							
								<input type="button" value="삭제" id="reviewdel" class="gray_Btn"/>
							</c:if>
							<input type="submit" value="목록" id="reviewList" class="mint_Btn" onclick="goReviewList()"/>
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
							<img src="<%=request.getContextPath() %>/img/img_Review/good2.png"/>
							<span id='thumbup'>${vo.thumbup }</span>
							<img src="<%=request.getContextPath() %>/img/img_Review/bad2.png"/>
							<span id='thumbdown'>${vo.thumbdown }</span>
						</li>
						<li class="btnGroup2">
							<input type ="button" class ="WMint_Btn" id="upBtn" value="추천"/>
							<input type ="button" class ="mint_Btn" id="downBtn" value="비추천"/>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div>
			<form id="pagingVO" method="post" action="/home/reviewList" style="diplay:none">
				<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
				<input type="hidden" name="searchType" value="${pagingVO.searchType }"/>
				<input type="hidden" name="searchWord" value="${pagingVO.searchWord }"/>
				<input type="hidden" name="order" value="${pagingVO.order }"/>
				<input type="hidden" name="noboard" value="0"/>
			</form>
			<ul>
				<li>
					<hr/>
				</li>
				<c:if test="${next != null }">
					<li class="prevTxt">
						다음글<span class="prev_next">▲</span><a href="javascript:goReviewView(${next.noboard})">${next.subject }</a>
					</li>
					<li>
						<hr>
					</li>
				</c:if>
				<c:if test="${prev != null }">
					<li class="prevTxt">
						이전글<span class="prev_next">▼</span><a href="javascript:goReviewView(${prev.noboard})">${prev.subject }</a>
					</li>
					<li>
						<hr/>
					</li>
				</c:if>
				<li class="listBtn">
					<input type="button" onclick="goReviewList()" value="목록"/>
				</li>
				
			</ul>
			<a id="back-to-top" href="#"><i class="fa fa-angle-up"></i></a>
		</div>
	<!--댓글-->
		<input type='hidden' id="noboard" value="${vo.noboard }"/>
		<%@ include file="../inc/reply.jspf"%>
	</div>
<!-- 	테스트 중 -->
</div>