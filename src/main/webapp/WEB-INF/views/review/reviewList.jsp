<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>

<!-- <div class="container"> -->

<!-- 후기게시판 제목 -->
<div class = "mainDiv">

	<!-- 후기 게시판 내용 -->
	<div class="reviewBody" >	
			<div id = "titleletter">
	<!-- 			<span class="title">후기게시판보기</span><br><br> -->
			</div>
		<div class="reviewList-type1">
	
	<!-- 		<div class= "content2"> -->
		
	<!-- 			<div class = "contentlocationdiv2"> -->
	<%-- 			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img1.png"/></a> --%>
	<!-- 			</div> -->
	<!-- 			<div class = "contentlocationdiv2"> -->
	<%-- 			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img2.jpg"/></a> --%>
	<!-- 			</div> <br/> -->
	<!-- 			<div class = "contentlocationdiv2"> -->
	<%-- 			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img3.png"/></a> --%>
	<!-- 			</div> -->
	<!-- 			<div class = "contentlocationdiv2"> -->
	<%-- 			<a href="#"><img src="<%=request.getContextPath() %>/img/img_Review/review_img4.jpg"/></a> --%>
	<!-- 			</div> -->
	<!-- 		</div> -->
			
			<div class ="contentList">
				<div>
					<div>	
						<li id="conttitle">${vo.subject }</li><br>
						<div style = "border-bottom: 1px solid #ebecef; padding-bottom: 20px;">
							<div style = "float : left;">
								<li style = "font-size: small;">${vo.userid }</li>
								<li style = "font-size: small;">${vo.writedate }&nbsp; 조회 : ${vo.hit }</li>
							</div>
							<div  style ="margin-left: 518px;">
								<a href="<%=request.getContextPath()%>/reviewView"><input type="submit" value="삭제" id="revsaveBtn" class="gray_Btn"/></a>
								<a href="<%=request.getContextPath()%>/reviewView"><input type="submit" value="수정" id="revsaveBtn" class="gray_Btn"/></a>
								<a href="<%=request.getContextPath()%>/reviewView"><input type="submit" value="목록" id="revsaveBtn" class="mint_Btn"/></a>
								
							</div>
						</div>
					</div>
					<div>
						<li class="review-content2">${vo.content }	</li>
					</div>
		 		</div>
			</div>
		</div>
	<!--댓글-->
		<input type='hidden' id="noboard" value="${vo.noboard }"/>
		<%@ include file="../inc/reply.jspf"%>
	</div>
</div>