<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<script>
	function makeUserTable(result){
		
		var nowPage =$("#nowPage").val();
		var listNum = 0;
		var listTag = "";
		for(var i = 0; i < result.length ; i++){			
			//alert(result.length+" : 결과 줄");
			if(i==0){
				listTag +=  "<li>번&nbsp;&nbsp;호</li> <li>아이디</li> <li>이&nbsp;&nbsp;름</li> <li>성&nbsp;&nbsp;별</li> <li>나&nbsp;&nbsp;이</li> <li>모임횟수</li> <li>좋아요</li> <li>상태</li> <li>정지설정</li>"	;
			}
			listNum = i+(nowPage-1)*10+1;
			//list안에 데이터 추가
			listTag += "<li>"+listNum+"</li>";
			listTag += "<li class='contents' ><input type='hidden' class='hiddenEmail' value='"+result[i].email+"'/><input type='hidden' class='hiddenRegdate' value='"+result[i].regdate+"'/>";
			listTag += "<a href='#' data-toggle='modal' data-target='#modal_User' title=' 사용자 프로필 보기 ' id='userprofileShow' >"+result[i].userid+"</a></li>";
			listTag += "<li>"+result[i].username+"</li>";
			listTag += "<li class='fa fa-square fa-stack-2x'>";
			if(result[i].gender=='1'){
				listTag +="남";
			}else if(result[i].gender=='2'){
				listTag +="여";
			}
			
			listTag += "</li>";
			
			listTag += "<li>"+result[i].birth+"대</li>";
			listTag += "<li>"+result[i].tourcnt+"회</li>";
			listTag += "<li>"+result[i].heart+"회</li>";			
			listTag += "<li>";
			if(result[i].endday==null){
				if(result[i].active=='N'){
					listTag += "<span class='status text-warning'>•</span> 미인증</li>";
				}else{
					listTag += "<span class='status text-success'>•</span> 활동</li>";
				}
				
				listTag += "<li style='padding-left:50px; color:red'><input type='button' title='"+result[i].userid+"'id='suspendBtn' data-toggle='modal' data-target='#modal_simple'/></li>";
				
			}else{
				listTag += "<span class='status text-danger'>•</span> 정지";
				listTag += "<p class='arrow_box'>~"+result[i].endday+"</p></li>";
				//<!-- endday가 없을때, 정지기간이 지났을때 정지 버튼이 생긴다.  -->
				listTag += "<li style='padding-left:50px; color:red'><input type='button' title='"+result[i].userid+"' id='suspendEditBtn' data-toggle='modal' data-target='#modal_suspendEdit'/></li>";	
			}
			
			$("#userList").html(listTag);
		}
	}
	
</script>

<!-- Page Content -->
	<!-- /Page Sidebar -->
	
	<!-- Page Content -->
	<div class="adminContent">
		
		<div class="adminTable">
				<h1 class="adminListHead">회원관리</h1>
				<ul id="userList">
							<li>번&nbsp;&nbsp;호</li>
							<li>아이디</li>
							<li>이&nbsp;&nbsp;름</li>
							<li>성&nbsp;&nbsp;별</li>
							<li>나&nbsp;&nbsp;이</li>
							<li>모임횟수</li>
							<li>좋아요</li>
							<li>상태</li>
							<li>정지 설정</li>
							<!-- DB작업완료 후 for문 생성 -->
							<c:forEach items="${list}" var="vo" varStatus="status">
								<li>${status.count+(pagingVO.nowPage-1)*10}</li>
								<li class="contents" >
									<input type="hidden" class="hiddenEmail" value="${vo.email }"/>
									<input type="hidden" class="hiddenRegdate" value="${vo.regdate }"/>
									<a href="#" data-toggle="modal" data-target="#modal_User" title=" 사용자 프로필 보기 " id="userprofileShow" >
										${vo.userid }					
									</a>
								</li>
								<li>${vo.username}</li>
								<li class="fa fa-square fa-stack-2x">
									<c:if test="${vo.gender=='1'}">
										남
									</c:if>
									<c:if test="${vo.gender=='2'}">
										여
									</c:if>
								</li>
								<li>${vo.birth}대</li>
								<li>${vo.tourcnt}회</li>
								<li>${vo.heart}회</li>
								<li>
									<c:if test="${vo.endday==null}"><!-- endday가 없을때, 정지기간이 지났을때 정지 버튼이 생긴다.  -->
											<c:if test="${vo.active=='N'}">
												<span class='status text-warning'>•</span> 미인증
											</c:if>
											<c:if test="${vo.active=='Y'}">
												<span class="status text-success">•</span> 활동
											</c:if>
									</c:if>
									<c:if test="${vo.endday!=null}">
										<span class="status text-danger">•</span> 정지
										<p class="arrow_box">~${vo.endday}</p>
									</c:if>	
								</li>
								<li style="padding-left:50px; color:red">
									<c:if test="${vo.endday==null}"><!-- endday가 없을때, 정지기간이 지났을때 정지 버튼이 생긴다.  -->
										<input type="button" title="${vo.userid}" id="suspendBtn" data-toggle="modal" data-target="#modal_simple"/>
									</c:if>
									<c:if test="${vo.endday!=null}">
										<input type="button"  title="${vo.userid}" id="suspendEditBtn" data-toggle="modal" data-target="#modal_suspendEdit"/>
									</c:if>
								</li>
							</c:forEach>
					</ul>
					      
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
						<c:if test="${pagingVO.nowPage != pagingVO.totalPage}">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
				</div><br/>
			<!-- paging -->
		
			</div><!-- adminContent -->
			
				
	
			<div id="modal_simple" class="modal fade" tabindex="-1" role="dialog">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				   	 <form id="userSuspendFrm" >
				    	<input type="hidden" name="userid" id="userid" value=""/>
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
				          <span aria-hidden="true">&times;</span>
				        </button>
				      </div>
				      <div class="modal-body">
						    	<div class="title" id="userStoptitle">회원 정지 설정</div>
						    	<a href="javascript:suspendPopupClose();" class="layerpop_close"
						    		id="suspendlayerbox_close"></a><br/>
						    	<div id="supspendDiv">
					    	
						    	<div class="pop2Row"> 
						    		<span class="pop2Left">정지 기간</span> <input type="number" id="suspendTime" name="endday" min="0" max="90"/><span style='font-size:20px; margin:0 15px 0 4px'>일</span>
						    		<input type="button" name="30days" value="30" class="stopDayBtn" onclick="change_suspendTime(this.value)"/>
						    		<input type="button" name="60days" value="60" class="stopDayBtn" onclick="change_suspendTime(this.value)"/>
						    		<input type="button" name="90days" value="90" class="stopDayBtn" onclick="change_suspendTime(this.value)"/>
						    	</div>
						    	<div class="pop2Row" style='color: #b90000'><span class="pop2Left" style='color:black'>사유</span><span id="spUserid"></span>회원님은 <span id="spReportNum">10회</span>
						    	이상 신고 접수되어 아래와 같이 서비스 이용이 제한되었습니다.
						    	</div>
						    	<div>
						    		<span class="pop2Left">메세지</span> 
						    		<textarea cols="30" rows="6" id="reportMsg" style="overflow:hidden; width:517px; padding:17px; font-size:17px" name="cause">이용정지 관련 문의가 있으시면 아래 1:1 문의하기 버튼을 클릭하여 고객센터로 문의해 주시기 바랍니다.</textarea>
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
			<div id="modal_suspendEdit" class="modal fade" tabindex="-1" role="dialog">
				  <div class="modal-dialog modal-dialog-centered" role="document">
				    <div class="modal-content">
				    	<form id="userSuspendEditFrm">
				    	<input type="hidden" name="userid" id="suspendEditUserid" value=""/><!-- DB쪽 보낼데이터 -->
					    	<div class="modal-header">
				        		<h5 class="modal-title">회원 정지 수정 및 설정</h5>
					        		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					          		<span aria-hidden="true">&times;</span>
					        		</button>
					      	</div>
					      	<div class="modal-body">
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
					    	</div>
					    	</div>
					    	 <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
						        <input type="submit" class="btn btn-primary" value="변경사항 저장">
							</div>

				    	</form>
			</div>
		</div>
	</div>
	
<!-- 완료 -->
<!-- 	// 가입일 이모티콘 변경 -->
<!-- 	// 필요없는거 빼기 -->
<!-- 	// 하단 클로즈 가운데정렬 -->

<!-- 이것만 해결하자... -->
<!-- // 가로사이즈 줄이기 -->
<!-- // rownum순서 제대로 나오게 db query문 수정  -->

	<div id="modal_User" class="modal fade modal-userprofile"  tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document" >
			<div class="modal-content">	
				<div class="modal-header">
					<h3 class="modal-title">회원 정보</h3>
			    </div>
				<ul class="userInfo">
			    	<li>
						<img src='img/img_reply/p.png' alt="" class="img-rounded img-responsive" />
					</li>
					<li	>
						<h4><span id="modalUsername">홍길동</span></h4>
						<p>
							<i class="glyphicon glyphicon-envelope"></i><span id="modalEmail">bikemap@bikemap.com</span>
			                <br />
			                <i class="glyphicon glyphicon glyphicon-ok-circle"></i><span id="modalRegidate">June 02, 1988</span>
		                </p>
	                </li>
                </ul>
               
               	<div class="modal-footer" style="text-align:center">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>						  
				</div>
			 </div>
		</div>
	</div>
	
		
</div> <!-- modal-bialog .// -->
			<!-- suspend POP -->
<!--  adminBottom -->
</div>
<!-- Page Content -->
</body>
</html>