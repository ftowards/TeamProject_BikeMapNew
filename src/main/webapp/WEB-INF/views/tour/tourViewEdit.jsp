<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/tourViewEditStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/tour/tourViewEdit.js"></script>

<div class="mainDivTourView">
	<form id="tourEditForm">
	
		<div id="tourWriteFormTitleDiv"><label id="tourWriteFormTitleLbl"><b>동행찾기 게시판 글수정</b></label><br/><hr/></div>

		<div id="routeResultDiv" class="routeResultDiv">
			<input type='hidden' id='reference' value='${vo.reference }'/>
			<input type="hidden" id="noboard" value="${vo.noboard }"/>
			<input type="hidden" id="userid" value="${vo.userid }"/>
			<div><label class="tourWriteConditionTitle">루&nbsp;트</label></div>
			<div class="routeResultDiv2">
				<div class="routeTitleDiv">
					<div style='margin-left : 40px;height : 70px;'><label class="labelClass">루트 제목</label>
						<div id="routeTitle" class="conditionBox"></div>
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
						<div><label id="departure">${vo.departuredate}</label></div>
					</div>
					<div><label id="departureTime">${vo.departureTime}시</label></div>
					
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
						<div><label name="deadline" id="deadline" >${vo.deadlinedate }</label></div>
					<div><label id="deadlineTime">${vo.deadlineTime }시</label></div>
				</div>
			</div>
			<div class="timeConditionDiv2">	
				<div><label class="tourWriteConditionTitle">여&nbsp;행</label></div>		
					<div class="conditionDivTop2">
						<div><label class="labelClass">거&nbsp;리</label></div>
						<div><label class="conditionBox" id="distance">${vo.distance}</label></div>
							<label class="kmLbl1">km</label>
						<div><label class="labelClass2" style="margin:-25px 0 0 40px;">소요시간</label></div>
						<div><label style="margin:-25px 0 0 20px;" id="tourtime" class="conditionBox"></label></div>
					</div>	
					<div class="conditionDivTop">
						<div><label  class="labelClass2" >속&nbsp;도</label></div>
						<div><label  class="conditionBox" id="speed">${vo.speed }</label></div>
							<label class="kmLbl2">km</label>
						<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">비&nbsp;용</label></div>
						<div><label style="margin:-25px 0 0 20px;" class="conditionBox">${vo.budget }</label></div>
							<label class="wonLbl">원</label>	
					</div>	
			</div>
			<div class="timeConditionDiv3">	
				<div><label class="tourWriteConditionTitle">모집조건</label></div>	
					<div class="conditionDivTop3">
						<div><label  class="labelClass">인&nbsp;원</label></div>
						<div><label id="room" style="text-align-last:center">${vo.room }</label></div>
		
						<div><label class="labelClass" style="margin-left:20px;">성&nbsp;별</label></div>
						<div><label id="whole">전&nbsp;체</label></div>
						<div><label id="genderboy" class='reggender' <c:if test='${vo.genderM }'>title="on"</c:if>>남</label></div>
						<div><label id="gendergirl" class='reggender' <c:if test='${vo.genderF }'>title="on"</c:if>>여</label></div>
					</div>
			
					<div class="conditionDivTop">
						<div><label class="labelClass">나&nbsp;이</label></div>
						<div><label id="whole2">전&nbsp;체</label></div>
						<div><label id="regageten" class='regage' <c:if test='${vo.age10 }'>title="on"</c:if>>10대</label></div>
						<div><label id="regagetwenty" class='regage' <c:if test='${vo.age20 }'>title="on"</c:if>>20대</label></div>
						<div><label id="regagethirty" class='regage' <c:if test='${vo.age30 }'>title="on"</c:if>>30대</label></div>
					</div>
					<div class="conditionDivBottom">	
						<div><label id="regageforty" class='regage' <c:if test='${vo.age40 }'>title="on"</c:if>>40대</label></div>
						<div><label id="regagefiftyOver" class='regage' <c:if test='${vo.age50 }'>title="on"</c:if> style="width:100px">50대 이상</label></div>					
					</div>
			</div>
		</div>			
		<div id="writeForm">	
			<ul>
				<li><input type="text" name="title" id="tourWriteTitleEdit" value="${vo.title }" maxlength="25"/></li>
				<li><textarea name="content" id="content">${vo.content }</textarea></li>
				<li><div id="writebuttonDiv">
					<input type="submit" value="등&nbsp;&nbsp;록"/>
					<input type="reset" value="다시쓰기"/>
				</div></li>
			</ul>
		</div>

	</form>
</div>