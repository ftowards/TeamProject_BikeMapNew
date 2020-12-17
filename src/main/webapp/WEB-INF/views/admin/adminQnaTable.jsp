<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<script>

$(function(){
	movePage(1);

	$("input[name=answer]").on('change', function(){
		movePage(1);
	});
	
	$(document).on("change", "input[id=checkAll]", function(){
		console.log(11);
		if($("#checkAll").prop("checked")){
			$("#questionList input[name=chkList]").prop("checked",true);
		}else{
			$("#questionList input[name=chkList]").prop("checked",false);
		}
	});
});


	function makeQnaTable(result){
		var listTag = "";
		for(var i = 0; i < result.length ; i++){		
			//alert(result.length+" : 결과 줄");
			if(i==0){
				listTag +=  "<li><input type='checkbox' id='checkAll' /></li><li>번호</li> <li>아이디</li> <li>제목</li> <li>작성일자</li> <li>답변여부</li> "	;
			}
			//list안에 데이터 추가
			listTag += "<li><input type='checkbox' name='chkList' value='"+result[i].noqna+"' /></li>";
			console.log(result[i]);
			if(result[i].answer == 'N'){
				listTag += "<li class='answerYet'>"+result[i].noqna+"</li>";
				listTag += "<li class='answerYet'>"+result[i].userid+"</li>";
				listTag += "<li id='subject' class='wordCut answerYet' ><a href='/home/adminQnaWrite?noqna="+result[i].noqna+"'>"+result[i].subject+"</a></li>";
				listTag += "<li class='answerYet'>"+result[i].writedate+"</li>";
				listTag += "<li style='color:00B0B0'  class='answerYet'>답변 대기</li>";
			}else{
				listTag += "<li>"+result[i].noqna+"</li>";
				listTag += "<li >"+result[i].userid+"</li>";
				listTag += "<li id='subject' class='wordCut' ><a href='/home/adminQnaWrite?noqna="+result[i].noqna+"'>"+result[i].subject+"</a></li>";
				listTag += "<li>"+result[i].writedate+"</li>";
				listTag += "<li style='color:00B0B0'>답변 완료</li>";
			}
		}$("#questionList").html(listTag);
	}
	
	function deleteQna(){
		$("#questionList input[type=checkbox]").each(function(i, val){
			if($(this).prop("checked")){

				$.ajax({
					url : "/home/deleteQna",
					data : "noqna="+$(this).val(),
					success : function(result){
						if(result == 1){
							movePage(1);
						}
					}, error : function(err){
						console.log(err);
					}
				});
			}
		});	
	}
</script>
<!-- Page Content -->
	<!-- /Page Sidebar -->
	<!-- Page Content -->
	<div class="adminContent">
				<div id="adminTable">
					<h1 class=adminListHead>1:1 문의사항</h1>
						<div class="answerAlready">
							<input type="checkbox" id="answer" name="answer" value="N" />
							<span>미답변 만 보기</span>
						</div>
					<ul id="questionList"></ul>			
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
				</div>
				<!-- /paging -->
				<div id="partnerBtn">
					<input type="button" id="partnerBtn1" name="partnerDeleteBtn" onclick="deleteQna();" value="삭제하기" class="mint_Btn"/>
				</div><!-- btn -->
			</div><!-- adminContent -->
			
<!-- Page Content -->
</div><!--  adminBottom -->
</body>
</html>