<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/tourViewStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/tour/tourView.js"></script>
<div class="mainDivTourView">
	<div id="tourViewFormTitleDiv"><label id="tourWriteTitle"><b>${vo.title}</b></label>
		<div class="tourViewEditAndDeleteDiv">
		
				<c:choose>
				<c:when test="${logStatus != null && logStatus != '' && logId == vo.userid}">
					<c:if test="${vo.state != '2'}">
						<div><label class="tourViewEdit"><a href="<%=request.getContextPath()%>/tourViewEdit?noboard=${vo.noboard}">수정</a></label></div>
					</c:if>
					<div><label class="tourViewDelete">삭제</label></div>
				</c:when>
				</c:choose>	
		</div>
	</div>
	<div id="routeResultDiv" class="routeResultDiv">
		<input type='hidden' id='reference' value='${vo.reference }'/>
		<div><label class="tourWriteConditionTitle">루&nbsp;트</label></div>
		<div class="routeResultDiv2">
			<div class="routeTitleDiv">
				<div style='margin-left : 40px;height : 55px;'>
					<label style='color:blue'>코스 상세보기 <span class="blue_arrow">click!</span>
						<img src="<%=request.getContextPath() %>/img/img_tour/blue_arrow.png" style='width:20px; padding-top: 8px;'/>
					</label>
					<div id="routeTitle" class="conditionBox tourLink" style="margin-top:-4px; font-family: 'Nanum Gothic', sans-serif;"></div>
				</div>
				<div>
        			<input type="text" value="${vo.userid}" id="userid" readonly onclick="popMsgSend(value)" class="conditionBox txtShadow2">
        		</div>
			</div>
			<div id="routeMap"></div>
			<hr/>
			<div id="elevation_chart"></div>
		</div>
	</div>
	
	<div class="timeConditionDiv">
		<div><label class="tourWriteConditionTitle">시&nbsp;간</label></div>	
		<div id="conditionDiv">
			<div class="conditionDivTop">
				<div class="labelClass"><label>일&nbsp;정</label></div>
				<div>
					<div><label id="departure" style='color:black;'>${vo.departuredate}</label></div>
				</div>
				<div><label id="departureTime" style='color:black;'>${vo.departureTime}시</label></div>
				
			</div>
			<div class="conditionDivTop">
				<div>
					<div><label id="arrive">${vo.arrivedate}</label></div>
				</div>
				<div><label id="arriveTime">${vo.arriveTime}시</label></div>
			</div>
			
			<div class="conditionDivTop">
				<div><label class="labelClass">장&nbsp;소</label></div>
				<div>   
					<label id="place">${vo.place}</label>
				</div>
			</div>
			<div class="conditionDivTop" style="margin-top:20px;">
				<div><label  class="labelClass2">마감날짜</label></div>
					<div><label name="deadline" id="deadline" style='color:black;'>${vo.deadlinedate }</label></div>
				<div><label id="deadlineTime" style='color:black;'>${vo.deadlineTime }시</label></div>
			</div>
		</div>
		<div class="timeConditionDiv2">	
			<div><label class="tourWriteConditionTitle">여&nbsp;행</label></div>		
				<div class="conditionDivTop2">
					<div><label class="labelClass" style='position:relative; top:1px; right:10px; color:#ce0000;'>거&nbsp;리</label></div>
					<div><label class="conditionBox" id="distance" style='top:11px; right:18px; color:#ce0000;'>${vo.distance}&nbsp;&nbsp;</label></div>
						<label class="kmLbl1">km</label>
					<div><label class="labelClass2" style="margin:-50px 0 0 203px;">소요시간</label></div>
					<div><label style="position:relative; top:-41px; left:297px;" id="tourtime" class="conditionBox"></label></div>
				</div>	
				<div class="conditionDivTop">
					<div><label  class="labelClass2" style='position:relative; top:8px; right:10px;'>속&nbsp;도</label></div>
					<div><label  class="conditionBox" id="speed" style='position:relative; top:17px; right:9px;'>${vo.speed }</label></div>
						<label class="kmLbl2">km</label>
					<div><label  class="labelClass2" style="margin:-35px 0 0 172px; position:relative; bottom:10px;">비&nbsp;용</label></div>
					<div><label style="position:relative; left:280px; top:-35px;" class="conditionBox">${vo.budget }</label></div>
						<label class="wonLbl">원</label>	
				</div>	
		</div>
		<div class="timeConditionDiv3">	
			<div><label class="tourWriteConditionTitle">모집조건</label></div>	
				<div class="conditionDivTop3">
					<div><label class="labelClass" style='position:relative; right:18px'>인&nbsp;원</label></div>
					<div><label id="room" style="position: relative; right: 28px;">${vo.room }</label></div>
	
					<div><label class="labelClass" style="margin-left:-30px; position:relative; left:8px;">성&nbsp;별</label></div>
					<div><label id="whole">전&nbsp;체</label></div>
					<div><label id="genderboy" class='reggender' <c:if test='${vo.genderM }'>title="on"</c:if>>남</label></div>
					<div><label id="gendergirl" class='reggender' <c:if test='${vo.genderF }'>title="on"</c:if>>여</label></div>
				</div>
		
				<div class="conditionDivTop">
					<div><label class="labelClass" style='position:relative; right:18px'>나&nbsp;이</label></div>
					<div><label id="whole2">전&nbsp;체</label></div>
					<div><label id="regageten" class='regage' <c:if test='${vo.age10 }'>title="on"</c:if>>10대</label></div>
					<div><label id="regagetwenty" class='regage' style='position:relative; left:14px;' <c:if test='${vo.age20 }'>title="on"</c:if>>20대</label></div>
					<div><label id="regagethirty" class='regage' style='left: 86px; position:relative; top:10px;' <c:if test='${vo.age30 }'>title="on"</c:if>>30대</label></div>
				</div>
				<div class="conditionDivBottom">	
					<div><label id="regageforty" class='regage' style='position:relative; left:75px;' <c:if test='${vo.age40 }'>title="on"</c:if>>40대</label></div>
					<div><label id="regagefiftyOver" class='regage' style='position:relative; left:89px; width:90px;' <c:if test='${vo.age50 }'>title="on"</c:if> style="width:100px">50대 이상</label></div>					
				</div>
		</div>
	</div>			
	<div id="writeForm">
		<div class="tourViewWriteFormClass">
        	<div style="float:right" ><button class="conditionBox" id="tourlistBtn" onclick="javascript:goList()">목록보기</button></div>
       		<!-- 목록보기 페이징 보내기 -->
       		<form id="pagingVO" method="post" action="/home/tourView" style="display:none">
       			<input type="hidden" name="nowPage" value="${pagingVO.nowPage}"/>
      				 <input type="hidden" name="departuredate" value="${pagingVO.departuredate}"/>
       			<input type="hidden" name="departureTime" value="${pagingVO.departureTime}"/>
       			<input type="hidden" name="arrivedate" value="${pagingVO.arrivedate}"/>
       			<input type="hidden" name="arriveTime" value="${pagingVO.arriveTime}"/>
       			<input type="hidden" name="place" value="${pagingVO.place}"/>
       			<input type="hidden" name="reggender" value="${pagingVO.reggender}"/>
       			<input type="hidden" name="regage" value="${pagingVO.regage}"/>
       			<input type="hidden" name="order" value="${pagingVO.order}"/>
       			<input type="hidden" name="distance1" value="${pagingVO.distance1 }"/>
       			<input type="hidden" name="distance1" value="${pagingVO.distance2 }"/>
       		</form>
		</div>
		<div class="temp">	
			<div id="checkComplist" class="roomCheckDivLbl" data-target="#dialog" data-toggle="modal" ><img src="<%=request.getContextPath()%>/img/img_tour/roomCheck.png"/>&nbsp;<label>참여 인원 확인하기</label></div>
			<c:if test="${logId == vo.userid}">
				<input type="hidden" id="manageConditon" value="ok"/>
			</c:if>
		</div>
	
	<c:if test="${logId != vo.userid && logId != null}">
		<div id="tourStateDiv">
			<button id="applyTour">참가신청</button>
			<button id="cancelTour">참가취소</button>
		</div>			 		
	</c:if>	
		<div class="tourViewWriteFormClass">
			<div><label style='font-size:15px'>모집 내용</label></div>
			<div>
				<div id="content"><img src="<%=request.getContextPath()%>/img/img_tour/bubble.png" style='width:20px;'/><span class='tourContentTxt'>${vo.content }</span></div>
			</div>
		</div>
	</div>	
	<!-- 참가 인원 확인 창 : 모달 창 만들기 -->
	<div class="modal" id="dialog">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header" style="border:none">
					<label><img src="<%=request.getContextPath()%>/img/img_tour/people.png" style="width:30px">&ensp;참여 인원 확인</label>
					<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
				</div>
				<!-- body -->
				<div class="modal-body">
					<ul id="listTitle" >
						<li>아이디</li>
						<li>나이대</li>
						<li>성별</li>
						<li>여행횟수</li>
						<li>좋아요</li>
						<li>상태</li>
						<li>쪽지</li>
					</ul>
					<ul id="complist"></ul>
				</div>
				<!-- footer -->
				<div class="modal-footer" style="border:none">
					
				</div>
			</div>
		</div>
	</div>	


	
	<input type="hidden" id="noboard" value="${vo.noboard}">
	<%@ include file="../inc/reply.jspf"%>
</div>