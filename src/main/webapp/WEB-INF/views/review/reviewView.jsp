<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>

<!-- 후기보기메인 -->
<div class="container">
<div class = "mainDiv">

	<div class="reviewBody" style="text-align: center;">	
		<div class = "serch" style="margin-bottom:10px;">
			<select name="searchKeyword" id="searchKeyword">
				<option value="1">키워드</option>
				<option value="2">글제목</option>
				<option value="3">코스이름</option>
				<option value="4">작성자</option>				
			</select>

			<input type="text" id="schBar"> 
			<input type="submit" class="mint_Btn" value="검색" style='width:70px; height:40px'/>
		</div>
		

<!-- 도시 검색창 -->		
		<div style="text-align: left; height : 13px; margin-top: 60px;">
			<span id="title">도시검색</span><br><br>
		</div>
		<div id = content>
			<div id= "contentlocation">

					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img1.png"/></a>
					</div>			
					<div class = "contentlocationdiv">
						<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img2.jpg"/></a>
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
		
		

		<div id= "reviewtitle">

			<a href = "<%=request.getContextPath()%>/reviewList"><span id="title">후기</span></a><br><br>
			<div id="subTxt">추천순<span id="lBar">&ensp;|&ensp;</span><span style='color:#AEAAAA;'>최신순</span></div>
		</div><br/>

		
		

<!-- 후기창 게시판-->

		<div id="paging2" style='text-align:right;'>1&emsp;<span style='color:#00B0B0; font-weight:600;'>2</span>&emsp;3&emsp;4&emsp;5</div>
		<div class ="boardlist">
			<div class="reviewContents" >
	<!-- 후기창 왼쪽 면-->
				<div class ="left">
					<img src="<%=request.getContextPath() %>/img/img_main/banner5.jpg"style="width:100px; height:100px;"/>
				</div>
		<!-- 후기창 오른쪽 면 -->

				<div class="right">
					<div class= "subtitle">
						<span>타이틀</span>
						<a href="#">
							<img class="badge1" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/>
						</a> 
						<a href="#">
							<img class="badge2" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/>
						</a> 
					</div>
						<p id="reviewtext">

							내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
						</p>
				</div>
			<div class="writedate">
					<li class="userid" style="float:left;">@goguma</li>
					<li style="float:right; margin-left: 550px;">2020.10.20 13:48</li>
			</div>
			
 			</div>
		</div>
<!-- 두번째 게시판 -->	
			<div class ="boardlist">
				<div class="reviewContents" >
				
				
			<!-- 후기창 왼쪽 면-->
					<div class ="left">
						<img src="<%=request.getContextPath() %>/img/img_main/banner5.jpg"style="width:100px; height:100px;"/>
					</div>
			<!-- 후기창 오른쪽 면 -->
					<div class="right">
						<div class= "subtitle">
							<span>타이틀</span>
							<a href="#">
								<img class="badge1" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/>
							</a> 
							<a href="#">
								<img class="badge2" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/>
							</a> 
						</div>
							<p id="reviewtext">
								내용내용내용내용내용내용내용내용내용내용내용내용내용
								내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
								내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
								내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
								내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							</p>
					</div>
				<div class="writedate">
						<li class="userid" style="float:left;">@goguma</li>
						<li style="float:right; margin-left: 550px;">2020.10.20 13:48</li>
				</div>
 			</div>
		</div>
<!-- 세번째 게시판 -->		
		<div class ="boardlist">
			<div class="reviewContents" >
		<!-- 후기창 왼쪽 면-->
				<div class ="left">
					<img src="<%=request.getContextPath() %>/img/img_main/banner5.jpg"style="width:100px; height:100px;"/>
				</div>
		<!-- 후기창 오른쪽 면 -->
				<div class="right">
					<div class= "subtitle">
						<span>타이틀</span>
							<a href="#">
								<img class="badge1" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/>
							</a> 
							<a href="#">
								<img class="badge2" src="<%=request.getContextPath() %>/img/img_main/alarm_icon.png"/>
						</a> 
					</div>
					
					</div>
						<p id="reviewtext">
							내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
							내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용내용
						</p>
				</div>
			<div class="writedate">
					<li class="userid" style="float:left;">@goguma</li>
					<li style="float:right; margin-left: 550px;">2020.10.20 13:48</li>
			</div>
			
 			</div>
		</div>
		<div id= "bottom">
		
		</div>
		
	</div>
</div>
</div>




