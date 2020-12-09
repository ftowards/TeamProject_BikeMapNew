<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<script>	
	function makeQnaTable(result){
		$("#questionList").children().remove();
		var listTag = "";
		for(var i = 0; i < result.length ; i++){		
			//alert(result.length+" : 결과 줄");
			if(i==0){
				listTag +=  "<li><input type='checkbox' id='checkAll' /></li><li>번호</li> <li>아이디</li> <li>제목</li> <li>작성일자</li> <li>답변여부</li> "	;
			}
			//list안에 데이터 추가
			listTag += "<li><input type='checkbox' /></li>";
			listTag += "<li>"+result[i].noqna+"</li>";
			listTag += "<li id='subject' class='wordCut' ><a href=''/home/adminQnaWrite?noqna="+result[i].noqna+">"+result[i].subject+"</a></li>";
			listTag += "<li>"+result[i].writedate+"</li>";
			listTag += "<li style='color:00B0B0'>";
			if(result[i].answer=='Y'){
				listTag +="답변완료";
			}else if(result[i].answer=='N'||result[i].answer==null){
				listTag +="답변대기";
			}
			listTag += "</li>";
		}$("#questionList").append(listTag);
	}
</script>
<!-- Page Content -->
	<!-- /Page Sidebar -->
	<!-- Page Content -->
	<div class="adminContent">
				<div id="adminTable">
				<h1 class=adminListHead>1:1 문의</h1>
				<ul id="questionList">
					<li><input type="checkbox" id="checkAll" /></li>
					<li>번&nbsp;&nbsp;호</li>
					<li>아이디</li>
					<li>제&nbsp;&nbsp;목</li>
					<li>작성 일자</li>
					<li>답변여부</li>				
					
					<c:forEach items="${list}" var="vo" varStatus="status">
								<li><input type="checkbox" name="listChk"/></li>
								<li>${vo.noqna}</li>
								<li>${vo.userid}</li>
								<li id="subject" class='wordCut' ><a href="/home/adminQnaWrite?noqna=${vo.noqna}&answer=${vo.answer}">${vo.subject}</a></li>
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
								<li><a href="javascript:">Prev</a></li>
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
				<input type="button" id="partnerBtn1" name="partnerDeleteBtn" value="삭제하기" class="mint_Btn"/><input type="button" id="partnerBtn2" name="partnerHideBtn" value="비공개"/>
				</div><!-- btn -->
			</div><!-- adminContent -->
<!-- Page Content -->
</div><!--  adminBottom -->
</body>
</html>