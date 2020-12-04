<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<script>

	$(function(){
		$("#reviewdel").click(function(){
			if(confirm("삭제하시겠습니까?")){
				location.href="/home/reviewDel?noboard=${vo.noboard}";	
			}
			
		});
		
	});
	
	
</script>


<!-- 후기게시판 제목 -->
<div class = "mainDiv">

	<!-- 후기 게시판 내용 -->
	<div class="reviewBody" >	
			<div id = "titleletter">
	<!-- 			<span class="title">후기게시판보기</span><br><br> -->
			</div>
		<div class="reviewList-type1">
				
			<div class ="contentList">
				<div>
					<div>
						<ul>
							<li id="conttitle">${vo.subject }</li><br/>
						</ul>	
						<div style = "border-bottom: 1px solid #ebecef; padding-bottom: 20px;">
							<div style = "float : left;">
								<ul>
									<li style = "font-size: small;">${vo.noboard }</li>
									<li style = "font-size: small;">${vo.userid }</li>
									<li style = "font-size: small;">${vo.writedate }&nbsp; 조회 : ${vo.hit }</li>
								</ul>
							</div>
							<div  style ="margin-left: 518px;">
								<input type="button" value="삭제" id="reviewdel" class="gray_Btn"/>
								<a href="<%=request.getContextPath()%>/reviewEdit?noboard=${vo.noboard }"><input type="submit" value="수정" id="revsaveBtn" class="gray_Btn"/></a>
								<a href="<%=request.getContextPath()%>/reviewView"><input type="submit" value="목록" id="revsaveBtn" class="mint_Btn"/></a>
								
							</div>
						</div>
					</div>
					<div>
						<ul>
							<li class="review-content2">${vo.content }</li>
						</ul>
					</div>
		 		</div>
			</div>
		</div>
	<!--댓글-->
		<input type='hidden' id="noboard" value="${vo.noboard }"/>
		<%@ include file="../inc/reply.jspf"%>
	</div>
</div>