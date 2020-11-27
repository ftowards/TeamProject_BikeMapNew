<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<div id="mainDiv2">
	<div id="mapDiv" style='width:800px;'>
		<b>코스정보보기</b><br/><hr id="titleLine"/>
		<div class="wordCut">${routeVO.title}</div>

		<div class="txtShadow">@${routeVO.userid }</div>
		<div id="map_Altitude">
			<div id="map" style='width:584px; height:300px;'>
			</div>
			<div id="elevation_chart" style='width:584px; height:165px;'>
			</div>
	<div id="placeList">
		<div>음식점<br/>
			<label class="switch">
  				<input type="checkbox" name="foodMarker"><span class="slider round"></span>
			</label><br/>
				<ul id="foodList" style='margin-top:15px'>
					<c:if test="${placeVO.food1placename != null }">
						<li><a href="${placeVO.food1placeurl }" target="_blank">${placeVO.food1placename }</a>
							<input type="hidden" name="foodList" value="${placeVO.food1point }"/><li>
					</c:if>
					<c:if test="${placeVO.food2placename != null }">
						<li><a href="${placeVO.food2placeurl }" target="_blank">${placeVO.food2placename }</a>
							<input type="hidden" name="foodList" value="${placeVO.food1point }"/><li>
					</c:if>
					<c:if test="${placeVO.food3placename != null }">
						<li><a href="${placeVO.food3placeurl }" target="_blank">${placeVO.food3placename }</a>
							<input type="hidden" name="foodList" value="${placeVO.food3point }"/><li>
					</c:if>
					<c:if test="${placeVO.food4placename != null }">
						<li><a href="${placeVO.food4placeurl }" target="_blank">${placeVO.food4placename }</a>
							<input type="hidden" name="foodList" value="${placeVO.food4point }"/><li>
					</c:if>
					<c:if test="${placeVO.food5placename != null }">
						<li><a href="${placeVO.food5placeurl }" target="_blank">${placeVO.food5placename }</a>
							<input type="hidden" name="foodList" value="${placeVO.food5point }"/><li>
					</c:if>
				</ul>
			</div>
		<div>관광지<br/>
			<label class="switch">
  				<input type="checkbox" name="sightsMarker"><span class="slider round"></span>
			</label><br/>
				<ul id="sightsList" style='margin-top:15px'>
					<c:if test="${placeVO.sights1placename != null }">
						<li><a href="${placeVO.sights1placeurl }" target="_blank">${placeVO.sights1placename }</a>
							<input type="hidden" name="sightsList" value="${placeVO.sights1point }"/><li>
					</c:if>
					<c:if test="${placeVO.sights2placename != null }">
						<li><a href="${placeVO.sights2placeurl }" target="_blank">${placeVO.sights2placename }</a>
							<input type="hidden" name="sightsList" value="${placeVO.sights1point }"/><li>
					</c:if>
					<c:if test="${placeVO.sights3placename != null }">
						<li><a href="${placeVO.sights3placeurl }" target="_blank">${placeVO.sights3placename }</a>
							<input type="hidden" name="sightsList" value="${placeVO.sights3point }"/><li>
					</c:if>
					<c:if test="${placeVO.sights4placename != null }">
						<li><a href="${placeVO.sights4placeurl }" target="_blank">${placeVO.sights4placename }</a>
							<input type="hidden" name="sightsList" value="${placeVO.sights4point }"/><li>
					</c:if>
					<c:if test="${placeVO.sights5placename != null }">
						<li><a href="${placeVO.sights5placeurl }" target="_blank">${placeVO.sights5placename }</a>
							<input type="hidden" name="sightsList" value="${placeVO.sights5point }"/><li>
					</c:if>
				</ul>
			</div>
		<div>숙박시설<br/>
			<label class="switch">
  				<input type="checkbox" name="accommodationMarker"><span class="slider round"></span>
			</label><br/>
				<ul id="accommodationList" style='margin-top:15px'>
					<c:if test="${placeVO.accom1placename != null }">
						<li><a href="${placeVO.accom1placeurl }" target="_blank">${placeVO.accom1placename }</a>
							<input type="hidden" name="accommodationList" value="${placeVO.accom1point }"/><li>
					</c:if>
					<c:if test="${placeVO.accom2placename != null }">
						<li><a href="${placeVO.accom2placeurl }" target="_blank">${placeVO.accom2placename }</a>
							<input type="hidden" name="accommodationList" value="${placeVO.accom1point }"/><li>
					</c:if>
					<c:if test="${placeVO.accom3placename != null }">
						<li><a href="${placeVO.accom3placeurl }" target="_blank">${placeVO.accom3placename }</a>
							<input type="hidden" name="accommodationList" value="${placeVO.accom3point }"/><li>
					</c:if>
					<c:if test="${placeVO.accom4placename != null }">
						<li><a href="${placeVO.accom4placeurl }" target="_blank">${placeVO.accom4placename }</a>
							<input type="hidden" name="accommodationList" value="${placeVO.accom4point }"/><li>
					</c:if>
					<c:if test="${placeVO.accom5placename != null }">
						<li><a href="${placeVO.accom5placeurl }" target="_blank">${placeVO.accom5placename }</a>
							<input type="hidden" name="accommodationList" value="${placeVO.accom5point }"/><li>
					</c:if>
				</ul>
			</div>
		<div>편의시설<br/>
			<label class="switch">
  				<input type="checkbox" name="convenientMarker"><span class="slider round"></span>
			</label><br/>
				<ul id="convenientList" style='margin-top:15px'>
					<c:if test="${placeVO.conve1placename != null }">
						<li><a href="${placeVO.conve1placeurl }" target="_blank">${placeVO.conve1placename }</a>
							<input type="hidden" name="convenientList" value="${placeVO.conve1point }"/><li>
					</c:if>
					<c:if test="${placeVO.conve2placename != null }">
						<li><a href="${placeVO.conve2placeurl }" target="_blank">${placeVO.conve2placename }</a>
							<input type="hidden" name="convenientList" value="${placeVO.conve1point }"/><li>
					</c:if>
					<c:if test="${placeVO.conve3placename != null }">
						<li><a href="${placeVO.conve3placeurl }" target="_blank">${placeVO.conve3placename }</a>
							<input type="hidden" name="convenientList" value="${placeVO.conve3point }"/><li>
					</c:if>
					<c:if test="${placeVO.conve4placename != null }">
						<li><a href="${placeVO.conve4placeurl }" target="_blank">${placeVO.conve4placename }</a>
							<input type="hidden" name="convenientList" value="${placeVO.conve4point }"/><li>
					</c:if>
					<c:if test="${placeVO.conve5placename != null }">
						<li><a href="${placeVO.conve5placeurl }" target="_blank">${placeVO.conve5placename }</a>
							<input type="hidden" name="convenientList" value="${placeVO.conve5point }"/><li>
					</c:if>
				</ul>
		</div>
	</div>
		</div>
		<div id="routeInfoDiv">
			<div id="routeInfo">
				<ul>
					<li><input type="text" value="${routeVO.routepoint1name }"/>
						<input type="hidden" name="routePoint" value="${routeVO.routepoint1point }"/></li>
					<li><input type="text" value="${routeVO.routepoint2name }"/>
						<input type="hidden" name="routePoint" value="${routeVO.routepoint2point }"/></li>
					<c:if test="${routeVO.routepoint3 != null }">
						<li><input type="text" value="${routeVO.routepoint3name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint3point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint4 != null }">
						<li><input type="text" value="${routeVO.routepoint4name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint4point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint5 != null }">
						<li><input type="text" value="${routeVO.routepoint5name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint5point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint6 != null }">
						<li><input type="text" value="${routeVO.routepoint6name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint6point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint7 != null }">
						<li><input type="text" value="${routeVO.routepoint7name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint7point }"/></li>
					</c:if>
				</ul>
				<input type="hidden" id="geocode" value="${routeVO.geocode }"/>
				<div class="title">코스평점</div>
				<div>
					<img src="<%=request.getContextPath() %>/img/img_main/star.png" style="width:135px"/>
					<label id="starLbl">4.8</label>
				</div>
				<div style='padding-left:25px; font-size:1em; font-weight:bold; color:#004554'>
					<p>코스정보</p>
					<ul>
						<li>총 거리 :&nbsp;<span>${routeVO.distance }</span>km</li>
						<li>상승고도 :&nbsp;<span>${routeVO.ascent }</span>m</li>
						<li>하강고도 :&nbsp;<span>${routeVO.descent }</span>m</li>
					</ul>
				</div>
			</div>
			<div id="grade">
				<div class="title">별점주기</div>
					<select name="departurue" id="gradeSelect">
				    	<option value="">별점주기</option>
					    <option value="5">★★★★★</option>
						<option value="4">★★★★☆</option>
						<option value="3">★★★☆☆</option>
						<option value="2">★★☆☆☆</option>
					    <option value="1">★☆☆☆☆</option>
				    </select>
				<input type="button" value="확&nbsp;인" class="gray_Btn" id="grayBtn"/>
			</div>
			<div style='text-align:center; margin-top:130px;'>
				<input type="submit" name="save" value="저&nbsp;장" class="blue_Btn" style='border-radius: 5px; width:80px; height:40px'/>
				<input type="submit" name="recruitment" value="인원모집" class="WBlue_Btn" style='height:40px'/>
			</div>
		</div>
	</div><br/><br/>
	<input type='hidden' id="noboard" value="${routeVO.noboard }"/>
	<%@ include file="../inc/reply.jspf"%>
</div>
<input type="hidden" id="polyline" value="${routeVO.polyline }"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/routeSearchView.js"></script>