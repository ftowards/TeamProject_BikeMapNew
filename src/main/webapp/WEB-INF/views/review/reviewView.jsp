<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>

<!-- 후기보기메인 -->
<div class="container">
<div class = "mainDiv">

	<div class="reviewBody">	
		<div class = "serch">
			<select name="searchKeyword" id="searchKeyword">
				<option value="1">키워드</option>
				<option value="2">글제목</option>
				<option value="3">코스이름</option>
				<option value="4">작성자</option>				
			</select>

			<input type="text" id="schBar"> 
			<input type="submit" class="mint_Btn" value="검 색"/>
		</div>
		

<!-- 도시 검색창 -->		
		<div class= "reviewtitle">
			<span class="title">도시검색</span><br><br>
		</div>
		
		
		<div class = content>
			<div id= "contentlocation">

					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img1.png" /></a>
					</div>			
					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img2.jpg" /></a>
					</div>
					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img3.png"/></a>
					</div>
					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img4.jpg"/></a>
					</div>
					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img5.png"/></a>
					</div>
					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img6.png"/></a>
				</div>
			</div>
		</div>


<!-- 	후기 제목 -->
		<div class= "reviewtitle">
			<span class="title">후기 게시판</span><br><br>
			<div id="subTxt">추천순<span id="lBar">&ensp;|&ensp;</span><span style='color:#AEAAAA;'>최신순</span>
				<input type="button" style = "float : right"class="gray_Btn" name="reviewWriteBoard" value="글쓰기" onclick="location.href='<%=request.getContextPath()%>/reviewWriteForm'">
			</div>
		</div><br/>
		

<!-- 후기창 게시판-->

		
		
		<c:forEach var="vo" items="${list}">
				<div class ="boardlist">
					<div class="reviewContents">
			<!-- 후기창 왼쪽 면-->
						<div class ="left">
							<img src="<%=request.getContextPath() %>/img/img_main/banner5.jpg"style="width:100px; height:100px;"/>
						</div>
				<!-- 후기창 오른쪽 면 -->
		
						<div class="right">
							<div class= "subtitle">
								<li>${vo.noboard }&emsp;<a href = "<%=request.getContextPath()%>/reviewList?noboard=${vo.noboard }">${vo.subject }</a></li>
<!-- 								<a href="#"> -->
<%-- 									<img class="badge1" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/> --%>
<!-- 								</a>  -->
<!-- 								<a href="#"> -->
<%-- 									<img class="badge2" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/> --%>
<!-- 								</a>  -->
							</div>
								<li id="reviewtext">${vo.content }</li>
						</div>
						<div class="writedate">
								<li class="userid" style="float:left; margin-left: 5px;">${vo.userid }</li>
								<li style="margin-left: 595px;">${vo.writedate }</li>
						</div>
						
		 			</div>
				</div>
			</c:forEach>
		
		<div id="paging2" style='text-align:center; margin: 20px;'>1&emsp;<span style='color:#00B0B0; font-weight:600; '>2</span>&emsp;3&emsp;4&emsp;5</div>
		</div>
		<div id= "bottom"></div>
		
	</div>
</div>




