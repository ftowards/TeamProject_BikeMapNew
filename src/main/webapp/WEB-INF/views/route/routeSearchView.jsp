<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<link rel="stylesheet" href="/home/css/routeSearchView.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/route/routeSearchView.js"></script>
<div class="routeSearchViewDiv2">
	<div id="mapDiv" style='width:1200px;'>
		<b>코스정보보기</b><br/><hr id="titleLine"/>
		<div class="wordCut">${routeVO.title}</div>

		<div id="routeWriterMenu">
			<ul>
				<li class="labelClass">작성자</li>
				<li id="userid" onclick="popMsgSend(title)" title="${routeVO.userid }" class="txtShadow">${routeVO.userid }</li>
				<c:if test="${logId == 'admin'}">
					<li><c:if test="${routeVO.scrap !='T' }"><input type="button" value="스크랩" class="WMint_Btn" onclick="scrapRoute()"/></c:if>
						<c:if test="${routeVO.scrap !='F' }"><input type="button" value="스크랩 해제" class="mint_Btn" onclick="releaseRoute()"/></c:if>
					</li>
					<li>
						<c:if test="${routeVO.closed == 'F'}"><input type="button" class="WMint_Btn" value="비공개" onclick="setCloseRoute1('close');"/></c:if>
						<c:if test="${routeVO.closed == 'T'}"><input type="button" class="WMint_Btn" value="공개" onclick="setOpenRoute();"/></c:if>
					</li>
				</c:if>
				<c:if test="${routeVO.userid == logId }">
					<li><input type="button" value="삭제" class="WMint_Btn" onclick="setCloseRoute1('del')"/></li>
					<li>
						<c:if test="${routeVO.closed == 'F'}"><input type="button" class="WMint_Btn" value="비공개" onclick="setCloseRoute1('close');"/></c:if>
						<c:if test="${routeVO.closed == 'T'}"><input type="button" class="WMint_Btn" value="공개" onclick="setOpenRoute();"/></c:if>
					</li>
				</c:if>
			</ul>
			<ul>
				<li class="labelClass">한줄 설명</li><li id="description">${routeVO.description }</li>
			</ul>
		</div>
		<div id="map_Altitude">
			<div id="map" style='width:100%; height:50%; margin-bottom:30px;'></div>
			<div id="elevation_chart"></div>
			<div id="placeList">
				<div><span id="foodTxt">음식점</span><br/>
					<label class="switch">
  						<input type="checkbox" name="foodMarker" class="foodCheck"><span class="slider round"></span>
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
				<div><span id="sightsTxt">관광지</span><br/>
					<label class="switch">
		  				<input type="checkbox" name="sightsMarker" class="sightCheck"><span class="slider round"></span>
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
				<div><span id="accommodationTxt">숙박시설</span><br/>
					<label class="switch">
		  				<input type="checkbox" name="accommodationMarker" class="accommodationCheck"><span class="slider round"></span>
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
				<div><span id="convenientTxt">편의시설</span><br/>
					<label class="switch">
		  				<input type="checkbox" name="convenientMarker" class="convenientCheck"><span class="slider round"></span>
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
					<li><input type="text" value="${routeVO.routepoint1name }" readonly/>
						<input type="hidden" name="routePoint" value="${routeVO.routepoint1point }"/></li>
					<li><input type="text" value="${routeVO.routepoint2name }" readonly/>
						<input type="hidden" name="routePoint" value="${routeVO.routepoint2point }"/></li>
					<c:if test="${routeVO.routepoint3 != null }">
						<li><input type="text" value="${routeVO.routepoint3name }" readonly/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint3point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint4 != null }">
						<li><input type="text" value="${routeVO.routepoint4name }" readonly/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint4point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint5 != null }">
						<li><input type="text" value="${routeVO.routepoint5name }" readonly/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint5point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint6 != null }">
						<li><input type="text" value="${routeVO.routepoint6name }" readonly/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint6point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint7 != null }">
						<li><input type="text" value="${routeVO.routepoint7name }" readonly/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint7point }"/></li>
					</c:if>
				</ul>
				<input type="hidden" id="geocode" value="${routeVO.geocode }"/><br/>
				<div class="title">코스평점</div>
				<div>
					<ul class="starRatingGroup">
						<li><span class='star-rating'><span id="rating" style="width:<c:out value="${routeVO.rating /5 *125 }"/>px"></span></span></li>
						<li><label id="starLbl">${routeVO.rating }</label><span style='color:gray'>(참여 ${routeVO.ratecnt })</span></li>
					</ul>
				</div>
				<div class="course_Info">
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
				    	<option value="">별점을 선택하세요</option>
					    <option value="5">★★★★★</option>
						<option value="4">★★★★☆</option>
						<option value="3">★★★☆☆</option>
						<option value="2">★★☆☆☆</option>
					    <option value="1">★☆☆☆☆</option>
				    </select>
				<input type="button" value="확&nbsp;인" class="gray_Btn" id="grayBtn"/>
			</div>
			<div class="saveBtns">
				<input type="submit" id="routeCollect" name="save" value="저    장" class="blue_Btn" style='border-radius:10px; width:95px; height:45px'/>
				<input type="submit" id="recruitment" value="인원모집" class="WBlue_Btn" style='width:95px; height:45px; letter-spacing:2px'/>
				<form id="tourWriteWithReference" action="/home/tourWriteForm" method = 'post'>
					<input type="hidden" name="reference"/>
				</form>
			</div>
		</div>
	</div><br/>
	
			<!-- 이전글,다음글 & 목록보기 -->
		<div style='width:1200px; padding-top:40px'>
			<form id="pagingVO" method="post" action="/home/routeSearchView" style="diplay:none">
				<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
				<input type="hidden" name="searchKey" value="${pagingVO.searchKey }"/>
				<input type="hidden" name="searchWord" value="${pagingVO.searchWord }"/>
				<input type="hidden" name="order" value="${pagingVO.order }"/>
				<input type="hidden" name="noboard" value="0"/>
			</form>
			<ul>
				<li>
					<hr/>
				</li>
				<c:if test="${next != null }">
					<li class="prevTxt">
						다음글<span class="prev_next">▲</span><a href="javascript:goViewPage(${next.noboard})">${next.title }</a>
					</li>
					<li>
						<hr>
					</li>
				</c:if>
				<c:if test="${prev != null }">
					<li class="prevTxt">
						이전글<span class="prev_next">▼</span><a href="javascript:goViewPage(${prev.noboard})">${prev.title }</a>
					</li>
					<li>
						<hr/>
					</li>
				</c:if>
				<li class="listBtn">
					<button onclick="javascript:goList()">목록보기</button>
				</li>
			</ul>
		</div>
	
	<input type='hidden' id="noboard" value="${routeVO.noboard }"/>
	<%@ include file="../inc/reply.jspf"%>
</div>
<input type="hidden" id="polyline" value="${routeVO.polyline }"/>
