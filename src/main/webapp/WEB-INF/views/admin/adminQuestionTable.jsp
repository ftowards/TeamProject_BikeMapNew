<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->



<%
	
	//dao 선언
	//총레코드수
	int totalRecord = 30;//총레코드수
	int onePageRecord = 5;//한페이지당 출력할 레코드 수
	int nowPage = 1;//현재페이지 번호 
	int totalPage = 0;//총페이지 수
	int onePageNum = 5;//한번에 표시할 페이지 수
	int startPage = 1; //페이지 번호의 시작번호
	//
	//-----------------------------------------------
	//현재페이지 정보 구하기
	String nowPageStr = request.getParameter("nowPage");
	if(nowPageStr != null){
		nowPage = Integer.parseInt(nowPageStr);
	}
	//총페이지 수 계산하기 
	totalPage = (int)Math.ceil(totalRecord/(double)onePageRecord);
	//페이지 번호의 시작번호 구하기
	startPage = ((nowPage-1)/onePageNum*onePageNum)+1;
	
	//전체레코드 구하기 페이지별 변경
	//List<FreeboardVO> list = dao.getAllRecord(nowPage, onePageRecord, totalPage, totalRecord);
	

%>

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
					
					<!-- DB작업완료 후 for문 생성 -->
					<li><input type="checkbox" class="check"/>80</li>
					<li>sss555</li>
					<li class="wordCut"><a href="/home/adminReplyWrite">동행 찾기 게시판에서 자꾸 오류가 나요</a></li>
					<li>작성일자</li>
					<li style="color:lightblue">답변여부</li>			
				</ul>		
				
				</div>
				
				<div id="paging">
					<ul>
						<!-- 이전페이지 -->
						<li>
							<%if(nowPage==1){ %>
							◀
							<%}else{ %>
								<a href="/home/adminQuestionTable&nowPage=<%=nowPage-1 %>">◀</a>
							<%} %>
						</li>
						<% for(int p=startPage; p<startPage+onePageNum; p++){ 
							if(p<=totalPage){
								if(p==nowPage){
						 %>
							<li>
								<a href="/home/adminQuestionTable?nowPage=<%=p %>"style="color:rgb(0,176,176);"><%=p %></a>
							</li>
							
						<%} else {%>
						<li>
							<a href="/home/adminQuestionTable?nowPage=<%= p%>"><%=p %></a>
					
						</li>
						<%}
						}//if
					}//for%>
					<li>
						<%if(nowPage<totalPage){ //다음페이지가 없을 경우
						%>
							<a href="/home/adminQuestionTable?nowPage=<%=nowPage+1 %>">▶</a>
						<%} %>
					</ul>
					
						
				</div><!-- paging -->
				<div id="partnerBtn">
						<input type="button" id="partnerBtn1" name="partnerDeleteBtn" value="삭제하기" class="mint_Btn"/>
						<input type="button" id="partnerBtn2" name="partnerHideBtn" value="비공개"/>
				</div><!-- btn -->
			</div><!-- adminContent -->
	
<!-- Page Content -->
</body>
</html>

