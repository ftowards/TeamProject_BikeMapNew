

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->



<%
	String pagefile = request.getParameter("page");
	if(pagefile == null){//처음보여주는 페이지는 회원관리 페이지
		pagefile="userTable";
	}
	
	
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
		<select name="choice" id="adminSelect" >
				<option value="userid" selected>회원 아이디</option>
				<option value="subject" selected>제목</option>
			 
		</select>
	
				<input type="text" name="searchWord" id="searchWord" maxlength="20" placeholder="검색어 입력"/>
				<input type="button" name="search" id="searchBtn" value="검색" class="mint_Btn" style="width:50px; height:30px"/>
		
				<div id="adminTable">
				<h1 id=tableHead>동행모집게시판</h1>
					<ul id="partnerList">
						<li><input type="checkbox" id="checkAll" />번호</li>
						<li>제목</li>
						<li>작성자</li>
						<li>추천</li>
						<li>비추천</li>
						<li>조회수</li>
						<li>등록일</li>
					
						<!-- DB작업완료 후 for문 생성 -->
						
						<li><input type="checkbox" class="check"/>234</li>
						<li class="wordCut">여수 3일 코스 !!!</li>
						<li>sss333</li>
						<li>34</li>
						<li>2</li>
						<li>106</li>
						<li>2020-10-01</li>
					</ul>
			</div>
				<!-- Page Content -->
				<div id="paging">
					<ul>
						<!-- 이전페이지 -->
						<li>
							<%if(nowPage==1){ %>
							◀
							<%}else{ %>
								<a href="/home/adminPartnerTable?nowPage=<%=nowPage-1 %>">◀</a>
							<%} %>
						</li>
						<% for(int p=startPage; p<startPage+onePageNum; p++){ 
							if(p<=totalPage){
								if(p==nowPage){
						 %>
							<li>
								<a href="/home/adminPartnerTable?nowPage=<%=p %>"style="color:rgb(0,176,176);"><%=p %></a>
							</li>
							
						<%} else {%>
						<li>
							<a href="/home/adminPartnerTable?nowPage=<%= p%>"><%=p %></a>
					
						</li>
						<%}
						}//if
					}//for%>
					<li>
						<%if(nowPage<totalPage){ //다음페이지가 없을 경우
						%>
							<a href="/home/adminPartnerTable?nowPage=<%=nowPage+1 %>">▶</a>
						<%} %>
					</ul>
					
						
				</div><!-- paging -->
				<div id="partnerBtn">
						<input type="button" id="partnerBtn1" name="partnerDeleteBtn" value="삭제하기" class="mint_Btn"/><input type="button" id="partnerBtn2" name="partnerHideBtn" value="비공개"/>
				</div><!-- btn -->
			</div><!-- adminContent -->
<!-- Page Content -->
</body>
</html>