<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(function(){
	$("#replyFrm").submit(function(){
		if($("#questionReplyTxt").val()==""){
			alert("답변을 입력하세요..");
			return false;
		}
		return true;
	});
});	
</script>
<style>
		table.table2{
                border-collapse: separate;
                border-spacing: 1px;
                text-align: left;
                line-height: 1.5;
                margin : 0px 10px;
        }
        table.table2 tr {
                width: 50px;
                padding: 10px;
                font-weight: bold;
                vertical-align: top;
        }
        table.table2 td {
                 width: 100px;
                 padding: 10px;
                 vertical-align: top;  
        }
		#tt td{
			border-bottom: 3px solid #ccc;
		}
		#questionReplyDiv{
			padding-left:50px;
			float:left;
		}
</style>
<div id="questionReplyDiv">
	<c:if test="${vo.answer==null||vo.answer=='N'}">
		<h2>1:1 문의내역</h2>	
	</c:if>
	<c:if test="${vo.answer=='Y'}">
		<h2>1:1 문의내역 수정</h2>	
	</c:if>
	<form method="post" id="replyFrm" action="adminQnaWriteOk">
        <input type="hidden" name="noqna" value="${vo.noqna}"/>
        <table  style="align=center; width=60%; border=0; cellpadding=2;" >
                <tr>
                <td bgcolor=white>
                <table class = "table2">
                        <tr>
                        <td>작성자</td>
                        <td>${vo.userid}</td>
                        </tr>
 
                        <tr>
                        <td>제목</td>
                        <td>${vo.subject }</td>
                        </tr>
                    
                        <tr>
                        <td>내용</td>
                        <td>${vo.content }</td>
                        </tr>
 
                        <tr>
                        <td>문의 유형</td>
                        <td><select name="choice" id="bigCate">
								<option value="userid">${vo.typename}</option>
							</select>
                        </tr>                   
                        <tr id="tt">
                        <td>첨부파일</td>
                        <td><a href="#">동행찾기 화면캡처.jpg</a></td>
                        </tr>
                        <tr>
                        <td>관리자 답변</td>
                        <td><textarea name="answercontent" id="questionReplyTxt" cols=70 rows=10 style="resize: none;overflow:hidden;">
                        <c:if test="${vo.answer==null||vo.answer=='N'}">
							안녕하세요 바이크맵 입니다.<br>
							현재 <span>${vo.typename}</span> 게시판 점검중으로 2020-11-01 02:00 이후 정상 운영됩니다.<br>
							이용에 불편을 드려서 죄송합니다.<br>
												
							바이크맵 드림.
						</c:if>					
						<c:if test="${vo.answer=='Y'}">
							<span>${vo.answercontent}</span>
						</c:if>
                        </textarea><br/></td>
                        </tr>
                        </table>    
                        <input type="submit" value="답변달기" id="replySubmit" class="mint_Btn"/>
                       
                </td>
                </tr>
        </table>
        </form>
</div>

</body>
</html>