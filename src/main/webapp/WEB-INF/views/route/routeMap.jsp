<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="/home/css/routeMap.css" type="text/css"/>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAR4IoCrZIntPC-l88uOp-01K7m9-2svjo&libraries=&v=weekly" defer></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
 <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<div id="container">
	<div id="info">
		<!-- 탭 아이콘 패널 -->
		<div id="naviIcon">
			<ul>
				<li><label for="tab1"><img src="<%=request.getContextPath() %>/img/img_course/searchGray.png"/></label></li>
				<li><label for="tab2"><img src="<%=request.getContextPath() %>/img/img_course/mapGray.png" /></label></li>
				<li><label for="tab3"><img src="<%=request.getContextPath() %>/img/img_course/buildingGray.png"/></label></li>
				<li><label for="tab4"><img src="<%=request.getContextPath() %>/img/img_course/saveGray.png"/></label></li>	
			</ul>
		</div>
		
		<!-- 지도 검색 조작 패널 -->
		<div id="infoPannel">
			<input type="radio" name="tab" class="tabIcon" id="tab1" checked/>
			<input type="radio" name="tab" class="tabIcon" id="tab2"/>
			<input type="radio" name="tab" class="tabIcon" id="tab3"/>
			<input type="radio" name="tab" class="tabIcon" id="tab4"/>
			
			<!-- 검색 패널 -->
			<div class="tab" id="pannel1">
				<div id="searchPannel">
					<input type="text" name="searchWord" id="searchWord" placeholder="검색어를 입력하세요."/><br/>
					<input type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" /> <span class="grayTxt">자전거도로 정보 보기</span>
					<hr>
					<div style="height:25px;"onclick="showCategory();">
						<img id="listImg" src="<%=request.getContextPath() %>/img/img_route/favorite.png"/>
						<label id="searchLbl" class="grayTxt">카테고리 검색 ▼</label></div>
						<hr/>
					<!-- 
					category 분류
					음식점 fd6 음식점 / ce7 카페
					관광지 ct1 문화시설 / at4 관광명소  
					숙박   ad5 숙박
					편의시설	cs2 편의점 / pk6 주차장 /sw8 지하철역 / bk9 은행 / hp8 병원 / pm9 약국
				 	-->
					<ul id="category" style="display:none;">
						<li>
							<button value="FD6" class="button" onclick="searchPlaceCategory(value);">음식점</button>
							<button value="CE7" class="button" onclick="searchPlaceCategory(value);">카&nbsp;&nbsp;&nbsp;페</button>
						</li>
						<li>
							<button value="CT1" class="button" onclick="searchPlaceCategory(value);">문화시설</button>
							<button value="AT4" class="button" onclick="searchPlaceCategory(value);">관광명소</button>
						</li>
						<li>
							<button value="AD5" class="button" onclick="searchPlaceCategory(value);">숙&nbsp;&nbsp;&nbsp;박</button>
						</li>
						<li>
							<button value="CS2" class="button" onclick="searchPlaceCategory(value);">편의점</button>
							<button value="PM9" class="button" onclick="searchPlaceCategory(value);">약&nbsp;&nbsp;&nbsp;국</button>
							<button value="HP8" class="button" onclick="searchPlaceCategory(value);">병&nbsp;&nbsp;&nbsp;원</button>
							<button value="PK6" class="button" onclick="searchPlaceCategory(value);">주차장</button>
							<button value="SW8" class="button" onclick="searchPlaceCategory(value);">지하철</button>
							<button value="BK9" class="button" onclick="searchPlaceCategory(value);">은&nbsp;&nbsp;&nbsp;행</button>
						</li>
						<hr>
					</ul>
				</div>
		        <ul id="placesList"></ul>
		        <div id="pagination"></div>
			</div>			
			<!-- 길찾기 -->
			<div class="tab">
				<ul>
					<li id="startPoint" class="tab_liTag"><input type="text"/>
						<input type="hidden" name="startPoint"/></li>
					<li id="arrivePoint" class="tab_liTag"><input type="text"/>
						<input type="hidden" name="arrivePoint"/></li>
				</ul>
				
				<select name="preference">
					<option value="recommended" selected>추천 경로</option>
					<option value="shortest">최단 거리</option>
				</select>
				<input type="button" value="경로 탐색" onclick="searchRoute();"/><br/>
				<input type="button" value="지점 전환" onclick="changeStartArrive();"/><br/>
				<input type="button" value="초기화" onclick="clearRoute();"/>
				<div id="routeInfo">
					총거리 : <span id="distance"></span>km<br/>
					상승고도 : <span id="ascent"></span>m<br/>
					하강고도 : <span id="descent"></span>m<br/>
				</div>
				<div id="elevation_chart"></div>
			</div>
			
			<!-- 저장한 장소 목록 -->
			<div class="tab" id="pannel3">
				<div onclick="showPlaceList(title);" title="foodList">
					<img id="likeImg" src="<%=request.getContextPath() %>/img/img_route/like.png"/>찜한 음식점
				</div>
					<ul id="foodList" style="display:none;"></ul>				
				<div onclick="showPlaceList(title);" title="sightsList">
					<img id="likeImg" src="<%=request.getContextPath() %>/img/img_route/like.png"/>찜한 관광지
				</div>
					<ul id="sightsList" style="display:none;"></ul>
				<div onclick="showPlaceList(title);" title="accomodationList">
					<img id="likeImg" src="<%=request.getContextPath() %>/img/img_route/like.png"/>찜한 숙박시설
				</div>
					<ul id="accomodationList" style="display:none;"></ul>
				<div onclick="showPlaceList(title);" title="convenientList">
					<img id="likeImg" src="<%=request.getContextPath() %>/img/img_route/like.png"/>찜한 편의시설
				</div>
					<ul id="convenientList" style="display:none;"></ul>
			</div>
			
			<!-- 저장 탭-->
			<div class="tab">
				<c:if test="${logId == null }">
						<img id="lockImg" src="<%=request.getContextPath() %>/img/img_register/lock.png"/>
						<div style='line-height:10px; margin-bottom:55px;'>
							<h3 style='padding-left:83px'>코스 저장하기</h3>
							<h4 style='padding-left:45px; color:#005766'>로그인 후 이용 가능합니다.</h4>
						</div>
						<div id="logButtons">
							<input type="button" name="login" value="로그인" class="mint_Btn" onclick="location.href='/home/login'"/>
							<input type="button" name="login" value="회원가입" class="WMint_Btn" onclick="location.href='/home/registerForm'"/>
						</div>
				</c:if>
				<c:if test="${logId!=null }">
				<form id="routeSave">
					<input type="text" name="title" id="title" placeholder="코스 이름을 입력하세요"/>
						<select name="catename" id="catename">
							<c:forEach var="list" items="${category }">
								<option value="${list.nocoursecate }" title="${list.catename }">${list.catename}</option>
							</c:forEach>
							<c:if test="${fn:length(category) < 5}">
								<option value="addCategory">카테고리 추가</option>
							</c:if>
						</select>
					<input type="radio" name="closed" value="F" checked/><span>공개</span>
					<input type="radio" name="closed" value="T"/><span>비공개</span>
					<input type="submit" value="저장"/>
				</form>
				</c:if>
			</div>
		</div>
	</div>
	<div id="map">
	
	</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/routeMap.js"></script>