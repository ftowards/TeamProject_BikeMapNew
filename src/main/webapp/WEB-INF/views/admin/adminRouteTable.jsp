<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->
	<!-- /Page Sidebar -->
<script>
function makeRouteTable(result){
	$("#routeList").children().remove();
	var listTag = "";
	for(var i = 0; i < result.length ; i++){
		
		if(i==0){
			listTag +=  "<li><input type='checkbox' id='checkAll'/></li><li>번호</li> <li>제목</li> <li>작성자</li> <li>평점</li><li>평가횟수</li><li>지역</li><li>비공개 여부</li><li>관리자 추천</li>"	;
		}			
		//list안에 데이터 추가
		listTag += "<li><input type='checkbox' name='listChk' value='"+result[i].noboard+"'/></li>";
		listTag += "<li>"+result[i].noboard+"</li>";
		listTag += "<li class='wordCut'><a href = '<%=request.getContextPath()%>/routeSearchView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
		listTag += "<li>"+result[i].userid+"</li>";
		listTag += "<li>"+result[i].rating+"</li>";
		listTag += "<li>"+result[i].ratecnt+"</li>";
		listTag += "<li>"+result[i].region+"</li>";
		listTag += "<li>";
		if(result[i].closed=='F'||result[i].closed==null){
			listTag +="공개";
		}else if(result[i].gender=='T'){
			listTag +="비공개";
		}
		listTag += "</li>";
		listTag += "<li>";
		listTag += "<label class='switch'>";
		listTag += "<input type='checkbox' name='adminScrapBtn' value='"+result[i].noboard+"'";
		if(result[i].scrap=='T'){
			listTag += "checked='checked'";
		}
		listTag += "><span class='slider round'></span>";
		listTag += "</label>";
		listTag += "</li>";
			
		}$("#routeList").append(listTag);
		
}

</script>	
	<!-- Page Content -->
	<div class="adminContent">	
				<div id="adminTable">
				<h1 class="adminListHead">루트</h1>
				
				<div class="orderRadio">
					<input type="radio" name="order" id="orderNoboard" value="noboard" checked="checked"><label for="orderNoboard" class="subTxt">최신순</label><span id="lBar"> | </span>
					<input type="radio" name="order" id="orderRating" value="rating"><label for="orderRating" class="subTxt">평점순</label>
				</div>
				<ul id="routeList">			
					<li><input type="checkbox" id="checkAll" /></li>		
					<li>번호</li>
					<li>제목</li>
					<li>작성자</li>
					<li>평점</li>
					<li>평가횟수</li>
					<li>지역</li>
					<li>비공개 여부</li>
					<li>관리자 추천</li>
					<!-- DB작업완료 후 for문 생성 -->
					<c:forEach items="${list}" var="vo" varStatus="status">
							<li><input type="checkbox" name="listChk" value="${vo.noboard}" /></li>
							<li>${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/routeSearchView?noboard=${vo.noboard }">${vo.title }</a></li>
							<li>${vo.userid}</li>
							<li>${vo.rating }</li>
							<li>${vo.ratecnt }</li>
							<li>${vo.region}</li>
							<li>
								<c:if test="${vo.closed==null||vo.closed=='F'}">
									공개
								</c:if>
								<c:if test="${vo.closed=='T'}">
									비공개
								</c:if>
							</li>
							<li>
								<c:if test="${vo.scrap==null||vo.scrap=='F'}">
									<label class="switch">
									  <input type="checkbox" name="adminScrapBtn" value="${vo.noboard }">
									  <span class="slider round"></span>
									</label>							
								</c:if>
								<c:if test="${vo.scrap=='T'}">
									<label class="switch">
									  <input type="checkbox" name="adminScrapBtn" value="${vo.noboard }" checked="checked" >
									  <span class="slider round"></span>
									</label>
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
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
			</div><br/> 
			<!-- /paging -->
				<div id="partnerBtn">
						<input type="button" id="partnerBtn1" name="adminScrapAllBtn" value="관리자 추천" class="mint_Btn"/>
						<input type="button" id="partnerBtn2" name="adminReleaseAllBtn" value="관리자 추천 해제"/>
				</div><!-- btn -->
			</div><!-- adminContent -->
<!-- Page Content -->
</body>
</html>