<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
$(function(){
	CKEDITOR.replace("content");
	$("#editFrm").submit(function(){
		if($("#subject").val()==""){
			alert("제목을 입력하세요.");
			return false;
		}
		if(CKEDITOR.instances.content.getData()==""){
			alert("글 내용을 입력하세요..");
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
                border-top: 1px solid #ccc;
                margin : 20px 10px;
        }
        table.table2 tr {
                 width: 50px;
                 padding: 10px;
                font-weight: bold;
                vertical-align: top;
                border-bottom: 1px solid #ccc;
        }
        table.table2 td {
                 width: 100px;
                 padding: 10px;
                 vertical-align: top;
                 border-bottom: 1px solid #ccc;
        }



</style>
<div>
	
	
	<!--  
		
		
		첨부파일 <br/>
		
		  

	
	</form>
	-->
	<h1>1대1 문의내역</h1>
	<form method="post" id="replyFrm" action="<%=request.getContextPath()%>/admin/adminReplyOk.do">
        <table  style="padding-top:50px; align=center; width=700; border=0; cellpadding=2;" >
                
                <tr>
                <td bgcolor=white>
                <table class = "table2">
                        <tr>
                        <td>작성자</td>
                        <td>hong1234</td>
                        </tr>
 
                        <tr>
                        <td>제목</td>
                        <td>동행찾기 게시판에서 자꾸 오류가 나요</td>
                        </tr>
 
                        <tr>
                        <td>문의 유형</td>
                        <td><select name="choice" id="bigCate">
								<option value="userid">사용자지정</option>
							</select>
							<select name="choice" id="smallCate">
								<option value="partner">동행찾기</option>
							</select></td>
                        </tr>
                        
                        <tr>
                        <td>첨부파일</td>
                        <td><a href="#">동행찾기 화면캡처.jpg</a></td>
                        </tr>
 
                        <tr>
                        <td>관리자 답변</td>
                        <td><textarea name="content" id="content" cols=85 rows=15>안녕하세요 홈페이지 네임입니다.
												현재 동행찾기 게시판 점검중으로 2020-11-01 02:00이후 정상운영됩니다.
												이용에 불편을 드려서 죄송합니다.
												
												홈페이지 네임드림.</textarea><br/></td>
                        </tr>
                        </table>
 
                       
                        <input type="submit" value="답변달기" class="mint_Btn"/>
                       
                </td>
                </tr>
        </table>
        </form>


</div>

</body>
</html>