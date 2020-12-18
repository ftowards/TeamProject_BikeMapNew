<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300&display=swap" rel="stylesheet">
<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<div id="questionReplyDiv">
	<h2 class="question_title" >1:1 문의내역</h2>	
	<form method="post" id="replyFrm" action="adminQnaWriteOk">
        <input type="hidden" name="noqna" value="${vo.noqna}"/>
        <ul class="adminQnaView">
        	<li>작성자</li>
        	<li><input type="text" value="${vo.userid }" readonly/></li>
        	<li>문의유형</li>
        	<li><input type="text" value="${vo.typename }" readonly/></li>
        	<li>제  목</li>
        	<li><input type="text" value="${vo.subject }" readonly/></li>
        	<li class="qnaLong">내  용</li>
        	<li class="qnaLong"><textarea readonly>${vo.content }</textarea></li>
          	<li class="qnaLong">답  변</li>
			<c:if test="${vo.answer==null||vo.answer=='N'}">
				<li class="qnaLong">
					<textarea name="answercontent" maxlength="200">안녕하세요 바이크맵 입니다.
이용에 불편을 드려서 죄송합니다.
바이크맵 드림</textarea>
				</li>
			</c:if>					
			<c:if test="${vo.answer=='Y'}">
				<li class="qnaLong"><textarea readonly>${vo.answercontent}</textarea></li>
			</c:if>
			<c:if test="${vo.answer==null||vo.answer=='N'}">
				<li>
					<input type="submit" value="답변달기" id="replySubmit" class="mint_Btn QnaWriteBtn"/>
					<input type="reset" value="다시쓰기" class="mint_Btn QnaWriteBtn"/>
				</li>
        	</c:if>
        </ul>
	</form>
</div>

</body>
</html>