
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->
<script>
function makeReviewTable(result){
	$("#reviewList").children().remove();
	var listTag = "";
	for(var i = 0; i < result.length ; i++){
		
		if(i==0){
			listTag +=  "<li><input type='checkbox' id='checkAll' />번호</li> <li>제목</li> <li>작성자</li> <li>레퍼런스번호</li><li>조회수</li><li>추천/비추천</li>"	;
		}			
		//list안에 데이터 추가
		listTag += "<li><input type='checkbox' />&nbsp&nbsp"+result[i].noboard+"</li>";
		listTag += "<li class='wordCut'><a href = '<%=request.getContextPath()%>/reviewList?noboard="+result[i].noboard+"'>"+result[i].subject+"</a></li>";
		listTag += "<li>"+result[i].userid+"</li>";
		listTag += "<li>"+result[i].reference+"</li>";
		listTag += "<li><input type='hidden' value='"+result[i].scrap+"' />"+result[i].hit+"회</li>";
		listTag += "<li>";
		
		listTag += "<li><span style='color:blue'>"+result[i].thumbUp+" </span>/ <span >"+result[i].thumbDown+" </span></li>";
		
		}$("#reviewList").append(listTag);
}
</script>




	<!-- /Page Sidebar -->
	
	<!-- Page Content -->
	<div class="adminContent">	
				<div id="adminTable">
				<h1 class="adminListHead">리뷰</h1>
				<ul id="reviewList">					
					<li><input type="checkbox" id="checkAll" />번호</li>
					<li>제목</li>
					<li>작성자</li>
					<li>레퍼런스 번호</li>
					<li>조회수</li>
					<li>추천/비추천</li>
					<!-- DB작업완료 후 for문 생성 -->
					<c:forEach items="${list}" var="vo" varStatus="status">
							
							<li> <input type="checkbox" />&nbsp&nbsp${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/reviewList?noboard=${vo.noboard }">${vo.subject }</a></li>
							<li>${vo.userid}</li>
							<li>${vo.reference }</li>
							<li><input type="hidden" value="${vo.scrap }" />${vo.hit}회</li>
							<li><span style='color:blue'>${vo.thumbUp} </span>/ <span >${vo.thumbDown} </span></li>
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
			</div><br/> 
			<!-- /paging -->
				<div id="reviewBtnDiv">
						<input type="button" id="partnerBtn1" name="deleteReview" value="삭제하기" class="mint_Btn"/>
						<input type="button" id="reviewHideBtn2" name="hideReview" value="비공개"/>
						<input type="button" id="reviewRecommentBtn" name="recomReview" value="추천하기" />
				</div><!-- btn -->
			</div><!-- adminContent -->
<!-- Page Content -->
</body>
</html>