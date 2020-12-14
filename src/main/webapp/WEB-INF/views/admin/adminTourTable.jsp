<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<!-- Page Content -->
<script>
$(function(){
	movePage(1);
	$("input[name=state]").on('change', function(){
		movePage(1);
	});

});

function getTourComplist(noboard, tourState){
	   var url = "/home/tour/selectEvallist";
	   
	   if(tourState == '1' || tourState == '2'){
	      url = "/home/selectComplist";
	   }
	   
	   $.ajax({
	      url : url,
	      data : "noboard="+noboard,
	      success : function(result){
	         setAcodianList(result, noboard, tourState);
	      },error : function(err){
	         console.log(err);
	      }
	   });
	}

	// 참가자 목록 만들기
	function setAcodianList(result, noboard, tourState){
	   console.log(result);
	   var $result = $(result);
	   
	   var tag =""
	   if(tourState == '2'){
	      tag += "<li><b>참가자</b></li><li><b>나이</b></li><li><b>성별</b></li><li><b>모임횟수</b></li><li><b>좋아요</b></li><li><b>참가상태</b></li><li></li>";
	      
	      $result.each(function(idx, val){
	         if(val.state != '1'){
	            tag += "<li><span onclick='popMsgSend(title)' title='"+val.userid+"'>"+val.userid+"</span></li>";
	            tag += "<li>"+val.age+"대</li>";
	            
	            if(val.gender == '1'){
	               tag += "<li>남</li>";
	            }else{ 
	               tag += "<li>여</li>";
	            }
	            
	            tag += "<li>"+val.tourcnt+"</li>";
	            tag += "<li><img src='/home/img/img_myRoute/like.png'/>"+val.heart+"</li>";
	            
	            if(val.state == '3'){
	               tag += "<li>불참</li>";
	               tag += "<li></li>";
	            }else if(val.state == '2'){
	               tag += "<li><button class='tourOk'>참가 중</button></li>";
	               if(val.userid != $("#logId").val()){
	                  tag += "<li><button class='tourOut' onclick='absentComplist(title)' title='"+noboard+"/"+val.userid+"'>불&nbsp;참</button></li>";
	               }else{
	                  tag +="<li></li>";
	               }
	            }
	         }
	      });
	      
	      $("#complist"+noboard).html(tag);
	   }}

function makeTourTable(result){
	
	
	$("#tourList").children().remove();
	var listTag = "";
	for(var i = 0; i < result.length ; i++){
		
		if(i==0){
			listTag +=  "<li><input type='checkbox' id='checkAll' /></li><li>번&nbsp;&nbsp;호</li><li>제&nbsp;&nbsp;목</li><li>작성자</li><li>참가인원</li><li>참가목록</li><li>완료여부</li>";	
		}
		//list안에 데이터 추가
		listTag += "<li><input type='checkbox' name='listChk' value='"+result[i].noboard+"'/>";
		listTag += "<li>"+result[i].noboard+"</li>";
		listTag += "<li class='wordCut'><a href = '<%=request.getContextPath()%>/tourView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
		listTag += "<li>"+result[i].userid+"</li>";
		listTag += "<li>"+result[i].party+"</li>";
		listTag += "<li><a data-toggle='collapse' href='#viewAcodian"+result[i].noboard+"' onclick='getTourComplist("+result[i].noboard+")'>▼</a></li>";
		listTag += "<li>";
		if(result[i].state=='1'||result[i].state==null){
			listTag +="미완료";
		}else if(result[i].state=='2'){
			listTag +="완료";
		}
		listTag += "</li>";
		
		//listTag += "<div id='viewAcodian"+result[i].noboard+"' class='panel-collapse collapse'><ul id='complist"+result[i].noboard+"' class='acodianList'></ul></div>";
		}$("#tourList").append(listTag);
}
</script>
	<!-- /Page Sidebar -->
	<!-- 미완료된 리스트보기추가 -->
	<!-- Page Content -->
	<div class="adminContent">
				<div id="adminTable">
				
				<h1 class="adminListHead">동행모집게시판</h1>
				<!-- 모집중인게시판만보기 -->
				<div class="answerAlready">
							<input type="checkbox" id="state" name="state" value="1" />
							<span> 모집 게시글만 검색</span>
				</div>
					<ul id="tourList">
						<li><input type="checkbox" id="checkAll" /></li>
						<li>번&nbsp;&nbsp;호</li>
						<li>제&nbsp;&nbsp;목</li>
						<li>작성자</li>
						<li>참가인원</li>
						<li>참가목록</li>
						<li>완료여부</li>
					
						<c:forEach items="${list}" var="vo" varStatus="status">
							<li><input type="checkbox" name="listChk" value="${vo.noboard}" title="${vo.userid }"/></li>
							<li>${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/tourView?noboard=${vo.noboard }">${vo.title }</a></li>
							<li>${vo.userid}</li>
							<li>${vo.party }</li>
							<li><a data-toggle='collapse' href="#viewAcodian${vo.noboard}" onclick='getTourComplist(${vo.noboard},${vo.state })'>▼</a>	</li>
							<li>
								<c:if test="${vo.state=='1'||vo.state==null}">
									모집중
								</c:if>
								<c:if test="${vo.state=='2'}">
									완료
								</c:if>						
								<!-- 내일 한번 여쭤보자~~ -->
									
							</li>
							<div id="viewAcodian${vo.noboard}" class='panel-collapse collapse'><ul id="complist${vo.noboard}" class='acodianList'></ul></div>
					</c:forEach>
				</ul>
			</div>
			<!-- Page Content -->
			<!-- paging -->
			
			<div id="paging">
					<ul>
						<c:if test="${pagingVO.nowPage != 1 }">
							<li><a href="#">Prev</a></li>
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
						<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
			</div><br/> 
			<!-- /paging -->
			</div><!-- adminContent -->
			<div id="partnerBtn">
					<input type="button" id="partnerBtn1" name="partnerDeleteBtn" value="삭제하기" class="mint_Btn"/>
					<input type="button" id="partnerBtn2" name="partnerHideBtn" value="비공개"/>
			</div><!-- btn -->
<!-- Page Content -->
</body>
</html>