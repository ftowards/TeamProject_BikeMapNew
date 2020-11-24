<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>

<!-- <div class="container"> -->

<!-- 후기게시판 제목 -->
<div class = "mainDiv">

<!-- 후기 게시판 내용 -->
<div class="reviewBody" >	
		<div id = "titleletter">
			<span class="title">후기게시판보기</span><br><br>
		</div>
	<div class="reviewList-type1">

		<div class= "content2">
	
			<div class = "contentlocationdiv2">
			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img1.png"/></a>
			</div>
			<div class = "contentlocationdiv2">
			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img2.jpg"/></a>
			</div> <br/>
			<div class = "contentlocationdiv2">
			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img3.png"/></a>
			</div>
			<div class = "contentlocationdiv2">
			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img4.jpg"/></a>
			</div>
		</div>
		
		<div class ="contentList">
		<div>
			<div class="right">
			<div>	
				<span id="conttitle">서울-부산</span>
			</div>
			<div>
				<p class="review-content2">
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
							국가는 노인과 청소년의 복지향향을 위한 정책을 실시할 의무를 진다 
				</p>
			</div>
			</div>
 			</div>
		</div>
	</div>
	
	


<!--댓글-->
			<div id="revcommentDiv">
				<div id ="titlecomment">댓글<span style='color:#00B0B0'>3</span></div>
				<div id = "revcommententer">
					<span class ="userid">userid</span>
					<textarea id = "revcommentBox" name="commentBox" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다."rows="5" cols="20" maxlength="100"></textarea>
						<div id="revtxtCounting">
							<span id="cntSPAN">0</span>&nbsp;<span>/200</span>
							<input type="submit" value="등록" id="revsaveBtn" class="mint_Btn"/>
						<div id="CMTbottomDiv">
						
						</div>
					</div>
				</div>
			</div>
			<div style ="heigth : 20px;"></div>
			
<!--댓글창 -->
			<div id ="revcomment">
				<ul>
					<li class="userid">goguma</li>
					<li>총 200자인 긴 댓글은 이렇게 표시됩니다! 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다</li>
					<li>2020.10.20 13:48</li>
				</ul><hr style="margin:15px 0 15px 0;"/>
				<ul>
					<li class="userid">goguma</li>
					<li>좋은 코스입니다.</li>
					<li>2020.10.20 13:48</li>
				</ul><hr/>
				<ul>
					<li class="userid">goguma</li>
					<li>좋은 코스입니다.</li>
					<li>2020.10.20 13:48</li>
				</ul><hr/>
				<ul>
					<li class="userid">goguma</li>
					<li>좋은 코스입니다.</li>
					<li>2020.10.20 13:48</li>
				</ul><hr/>
				<ul>
					<li class="userid">goguma</li>
					<li>좋은 코스입니다.</li>
					<li>2020.10.20 13:48</li>
				</ul><hr/>
			</div>
			<div id="paging2" style='text-align:center; margin-top:30px; margin-bottom: 120px;'>1&emsp;<span style='color:#00B0B0; font-weight:600;'>2</span>&emsp;3&emsp;4&emsp;5</div>
			
		</div>
	</div>
