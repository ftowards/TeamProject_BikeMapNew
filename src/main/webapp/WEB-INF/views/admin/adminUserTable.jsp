<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	function makeUserTable(result){
		$("#userList").children().remove();
		var listTag = "";
		for(var i = 0; i < result.length ; i++){
			
			//alert(result.length+" : 결과 줄");
			if(i==0){
				listTag +=  "<li>번호</li> <li>아이디</li> <li>이름</li> <li>성별</li> <li>나이</li> <li>모임횟수</li> <li>좋아요</li> <li>정지여부</li> <li>정지기간</li>"	;
			}
			//list안에 데이터 추가
			listTag += "<li>"+result[i].rownum+"</li>";
			listTag += "<li id='contents' ><a href='javascript:userPopupOpen();'>"+result[i].userid+" </a></li>";
			listTag += "<li>"+result[i].username+"</li>";
			listTag += "<li>";
			if(result[i].gender=='1'){
				listTag +="남";
			}else if(result[i].gender=='2'){
				listTag +="여";
			}
			listTag += "</li>";
			
			listTag += "<li>"+result[i].birth+"세</li>";
			listTag += "<li>"+result[i].tourcnt+"회</li>";
			listTag += "<li>"+result[i].heart+"회</li>";
			
			listTag += "<li style='color:red'>";
				if(result[i].endday==null){
					listTag +="<input type='button' title="+result[i].userid+" id='suspendBtn'/>";
					listTag += "</li>";
					listTag += "<li style='color:red'>-</li>";
				}else{ 
					listTag +="<input type='button' title="+result[i].userid+" id='suspendEditBtn'/>";
					listTag += "</li>";
					listTag += "<li style='color:red'>~"+result[i].endday+"</li>";
				}		
			}
			$("#userList").append(listTag);
		}
</script>

<!-- Page Content -->
	<!-- /Page Sidebar -->
	
	<!-- Page Content -->
	<div class="adminContent">
		
		<div class="adminTable">
				<h1 class="adminListHead">회원관리</h1>
				<ul id="userList">
							<li>번호</li>
							<li>아이디</li>
							<li>이름</li>
							<li>성별</li>
							<li>나이</li>
							<li>모임횟수</li>
							<li>좋아요</li>
							<li>정지여부</li>
							<li>정지기간</li>
							<!-- DB작업완료 후 for문 생성 -->
							<c:forEach items="${list}" var="vo" varStatus="status">
								<li>${vo.rownum}</li>
								<li id="contents" ><a href="javascript:userPopupOpen();">${vo.userid }</a></li>
								<li>${vo.username}</li>
								<li>
									<c:if test="${vo.gender=='1'}">
										남
									</c:if>
									<c:if test="${vo.gender=='2'}">
										여
									</c:if>
								</li>
								<li>${vo.birth}세</li>
								<li>${vo.tourcnt}회</li>
								<li>${vo.heart}회</li>
								<li style="color:red">
									<c:if test="${vo.endday==null}"><!-- endday가 없을때, 정지기간이 지났을때 정지 버튼이 생긴다.  -->
										<input type="button" title="${vo.userid}" id="suspendBtn"/>
									</c:if>
									<c:if test="${vo.endday!=null}">
										<input type="button"  title="${vo.userid}" id="suspendEditBtn"/>
									</c:if>
							
								</li>
								<li style="color:red">~${vo.endday}</li>
							</c:forEach>
					</ul>
					   
				
				    <!--Popup Start -->
				    <div id="userlayer" class="layerpop"
				        style="width: 200px; height: 300px;">
				        <article class="layerpop_area">
				        <div class="title" style="padding:15px; border-bottom:2px solid #00B0B0">회원정보</div>
				        <a href="javascript:userPopupClose();" class="layerpop_close"
				            id="userlayerbox_close"></a> <br/>
				        <div class="content">
				       	hong1234<br/>
				       	가입 : 2020.07.24<br/>
				        신고횟수 : 10회<br/>
				        <div id="pop1_IsStop">정지여부 : <span style="font-color:red">정지중</span></div>
				        <div id="pop1_StopTime">정지지간 : <span style="font-color:red">2020.11.14</span><br/></div>
				        <div style="border-bottom:2px solid #00B0B0; padding-bottom:10px">
					        <input type="button" name="userBanned" value="정지하기" onclick="javascript:suspendPopupOpen();" class="red_Btn"/>
					        <input type="button" name="userPage" value="회원페이지">
				       </div>
				        </div>
				        </article>
				    </div>
				    
				   
				<!-- Page Content -->
				<div id="paging">
					<ul>
					<!-- 이전 페이지 -->
						<c:if test="${pagingVO.nowPage != 1 }">
							<li><a href="javascript:movePage(${pagingVO.nowPage-1 })"> Prev </a></li>
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
					<!-- 다음 페이지 -->
						<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
				</div><br/>
			<!-- paging -->
		
			</div><!-- adminContent -->
			
	
		<!-- 모달 12/04 검사맡고 진행.. 
		<section class="section-content py-5">

		<button data-toggle="modal" data-target="#modal_simple" class="btn btn-primary" type="button">  Modal simple  </button>

		<button data-toggle="modal" data-target="#modal_aside_right" class="btn btn-primary" type="button">  Modal aside right  </button>

		<button data-toggle="modal" data-target="#modal_aside_left" class="btn btn-primary" type="button">  Modal aside left  </button>
		
		

		</section>
			<div id="modal_simple" class="modal fade" tabindex="-1" role="dialog">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				   	 <form id="userSuspendFrm" >
				    	<input type="hidden" name="userid" id="userid" value=""/>
				      <div class="modal-header">
				        <h5 class="modal-title">회원 정지 설정</h5>
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
						    	<div class="title">회원 정지 설정</div>
						    	<a href="javascript:suspendPopupClose();" class="layerpop_close"
						    		id="suspendlayerbox_close"></a><br/>
						    	<div id="supspendDiv">
					    	
					    	
						    	<div class="pop2Row"> 
						    		<span class="pop2Left">정지 기간</span> <input type="number" id="suspendTime" name="endday" min="0" max="90"/>일
						    		<input type="button" name="30days" value="30" class="mint_Btn" onclick="change_suspendTime(this.value)"/>
						    		<input type="button" name="60days" value="60" class="mint_Btn" onclick="change_suspendTime(this.value)"/>
						    		<input type="button" name="90days" value="90" class="mint_Btn" onclick="change_suspendTime(this.value)"/>
						    	</div>
						    	<div class="pop2Row"><span class="pop2Left">사유</span><span id="spUserid">홍길동</span>회원님은 <span id="spReportNum">10회</span>
						    	이상 신고 접수되어 아래와 같이 서비스 이용이 제한되었습니다.
						    	</div>
						    	<div>
						    		<span class="pop2Left">메세지</span> 
						    		<textarea cols="30" rows="6" id="reportMsg" style="overflow:hidden" name="cause">
						    			이용정지 관련 문의가 있으시면 아래 1:1 문의하기 버튼을 클릭하여 고객센터로 문의해 주시기 바랍니다.
						    		</textarea>
								</div>
							</div>
						    	
					  </div>
				    <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						        <input type="submit" class="btn btn-primary" value="변경사항 저장">
					</div>
					</form>
				    </div>
				  </div> <!-- modal-bialog .// -->
				</div> <!-- modal.// -->
			<!-- suspend POP -->
			
			<!-- suspend Editpopup -->
			<div id="userSuspendEdit" class="layerpop"
				    	style="width:330px;height:300px;">
				    	
				    	<form id="userSuspendEditFrm">
				    	<input type="hidden" name="userid" id="suspendEditUserid" value=""/><!-- DB쪽 보낼데이터 -->
					    
					    	<article class="layerpop_area">
					    	<div class="title">회원 정지 수정</div>
					    	<a href="javascript:suspendEditPopupClose();" class="layerpop_close"
					    		id="suspendlayerbox_close"></a><br/>
					    	<div id="supspendDiv">
					    		<div class="pop2Row">
					    			<input type="radio" name="selSuspend" value="0" >정지해제
					    			<input type="radio" name="selSuspend" value="1" checked="checked">정지기간연장
					    		</div> 
					    		
						    	<div class="pop2Row" id="aa"> 
						    		<span class="pop2Left">정지 기간 변경</span> <input type="number" id="suspendEditTime" name="endday"  placeholder="(-입력시 정지기간 감소)"/>일
						    		<input type="button" name="days" value="3" class="mint_Btn" onclick="change_suspendEditTime(this.value)"/>
						    		<input type="button" name="days" value="6" class="mint_Btn" onclick="change_suspendEditTime(this.value)"/>
						    		<input type="button" name="days" value="9" class="mint_Btn" onclick="change_suspendEditTime(this.value)"/> 
						    	</div>
						    	<div class="pop2Row"><span class="pop2Left">사유</span><span id="spEditUserid"> </span> 회원님은 <span id="spReportNum">10회</span>
						    	이상 신고 접수되어 아래와 같이 서비스 이용이 제한되었습니다.
						    	</div>
						    	<div>
						    		<span class="pop2Left">메세지</span> 
						    		<textarea cols="30" rows="6" id="reportMsg" style="overflow:hidden" name="cause">
						    			이용정지 관련 문의가 있으시면 아래 1:1 문의하기 버튼을 클릭하여 고객센터로 문의해 주시기 바랍니다.
						    		</textarea>
								</div>
						    	<input type="submit" value="등록" />
					    	</div>
					    	</article>
				    	</form>
		
			</div>
			<!-- suspend POP -->
<!--  adminBottom -->
</div>
</div>
<!-- Page Content -->
</body>
</html>