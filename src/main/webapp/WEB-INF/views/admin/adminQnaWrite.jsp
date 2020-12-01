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

	<h2>1대1 문의내역</h2>
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
                        <td><textarea readonly cols=70 rows=10 style="resize: none;overflow:hidden;">${vo.content }</textarea></td>
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
                        <td><textarea name="answercontent" id="questionReplyTxt" cols=70 rows=10 style="resize: none;overflow:hidden;">안녕하세요 홈페이지 네임입니다.
												현재 동행찾기 게시판 점검중으로 2020-11-01 02:00이후 정상운영됩니다.
												이용에 불편을 드려서 죄송합니다.
												
												홈페이지 네임드림.</textarea><br/></td>
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