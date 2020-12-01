<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->
	<!-- /Page Sidebar -->
	<!-- Page Content -->
	<div class="adminContent">
		<select name="choice" id="adminSelect">	
				<option value="userid" selected>회원 아이디</option>
			 	<option value="subject" selected>제목</option>
			 	<option value="IsReply">답변여부</option>
		</select>
				<input type="text" name="searchWord" id="questionSearchWord" class="searchText" maxlength="20" placeholder="검색어 입력"/>
				<input type="button" name="search" id="searchBtn" value="검색" class="mint_Btn" style="width:50px; height:30px"/>	
				<div id="adminTable">
				<h1 class=adminListHead>1:1 문의</h1>
				<ul id="questionList">
					<li><input type="checkbox" id="checkAll" />번호</li>
					<li>아이디</li>
					<li>제목</li>
					<li>작성일자</li>
					<li>답변여부</li>				
					
					<c:forEach items="${list}" var="vo" varStatus="status">
								<li><input type="checkbox" />&nbsp&nbsp&nbsp${vo.noqna}</li>
								<li>${vo.userid}</li>
								<li id="subject" ><a href="/home/adminQnaWrite?noqna=${vo.noqna}">${vo.subject}</a></li>
								<li>${vo.writedate}</li>
								<li>
									<c:if test="${vo.answer=='Y'}">
										답변완료
									</c:if>
									<c:if test="${vo.answer=='N'}">
										답변대기
									</c:if>
								</li>
								
							</c:forEach>						
				</ul>			
				</div>
				
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
</div><!--  adminBottom -->
</body>
</html>

