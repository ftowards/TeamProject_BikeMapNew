<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->
<script>
function makeTourTable(result){
	$("#tourList").children().remove();
	var listTag = "";
	for(var i = 0; i < result.length ; i++){
		
		if(i==0){
			listTag +=  "<li><input type='checkbox' id='checkAll' /></li><li>번호</li> <li>제목</li> <li>작성자</li> <li>완료여부</li>"	;
		}			
		//list안에 데이터 추가
		listTag += "<li><input type='checkbox' name='tourCheck' value='"+result[i].noboard+"'/>";
		listTag += "<li>"+result[i].noboard+"</li>";
		listTag += "<li class='wordCut'><a href = '<%=request.getContextPath()%>/tourView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
		listTag += "<li>"+result[i].userid+"</li>";
		listTag += "<li>";
		if(result[i].state=='1'||result[i].state==null){
			listTag +="미완료";
		}else if(result[i].gender=='2'){
			listTag +="완료";
		}
		listTag += "</li>";
			
		}$("#tourList").append(listTag);
}
</script>
	<!-- /Page Sidebar -->
	
	<!-- Page Content -->
	<div class="adminContent">
			
				<div id="adminTable">
				<h1 class="adminListHead">동행모집게시판</h1>
					<ul id="tourList">
						<li><input type="checkbox" id="checkAll" /></li>
						<li>번호</li>
						<li>제목</li>
						<li>작성자</li>
						<li>완료여부</li>
						
					
						<!-- DB작업완료 후 for문 생성 -->
						<c:forEach items="${list}" var="vo" varStatus="status">
							<li><input type="checkbox" name="tourCheck" value="${vo.noboard}"/></li>
							<li>${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/tourView?noboard=${vo.noboard }">${vo.title }</a></li>
							<li>${vo.userid}</li>
							<li>
								<c:if test="${vo.state=='1'||vo.state==null}">
									미완료
								</c:if>
								<c:if test="${vo.state=='2'}">
									완료
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
					
						<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
			</div><br/> 
			<!-- /paging -->
			<div id="partnerBtn">
					<input type="button" id="partnerBtn1" name="partnerDeleteBtn" value="삭제하기" class="mint_Btn"/>
					<input type="button" id="partnerBtn2" name="partnerHideBtn" value="비공개"/>
			</div><!-- btn -->
			</div><!-- adminContent -->
<!-- Page Content -->
</body>
</html>