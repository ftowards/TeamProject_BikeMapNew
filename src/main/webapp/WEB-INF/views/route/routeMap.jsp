<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	#container{width : 1200px;height : 70vh; margin:0 auto;}
	#container>div{float:left;}
	#info{width:350px; height : 100%; }
	#info>div{float:left;}
		#naviIcon{width : 48px; height : 100%; background-color : white;
					border-left : 1px solid #00B0B0; border-right : 1px solid #00B0B0;}
		#naviIcon img{width : 40px; maring : 4px auto;}
		#infoPannel{width : 300px; height : 100%;}
	#map{width : 800px; height : 100%; background-color: lightblue;}
	#infoPannel>input[type=radio]{display:none;}
	.tab{display:none;}
	
	#tab1:checked~div:nth-of-type(1){display:block;}
	#tab2:checked~div:nth-of-type(2){display:block;}
	#tab3:checked~div:nth-of-type(3){display:block;}
	#tab4:checked~div:nth-of-type(4){display:block;}
	
	#pannel1{height: 100%; overflow : auto; }
	#searchPannel{position:sticky; top :0; background-color: #00B0B0; color : white;
				  z-index : 500;}
	#placeList{}
	#searchWord{width : 95%; height : 30px;border-radius : 5px; margin : 0 auto; border : 2pxl solid black;}
	
	<!-- 검색한 리스트 스타일 -->
	#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
	#menu_wrap .option{text-align: center;}
	#menu_wrap .option p {margin:10px 0;}  
	#menu_wrap .option button {margin-left:5px;}
	#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
	#placesList .item span {display: block;margin-top:4px;}
	#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	#placesList .item .info{padding:10px 0 10px 55px;}
	#placesList .info .gray {color:#8a8a8a;}
	#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
	#placesList .info .tel {color:#009900;}
	#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
	#placesList .item .marker_1 {background-position: 0 -10px;}
	#placesList .item .marker_2 {background-position: 0 -56px;}
	#placesList .item .marker_3 {background-position: 0 -102px}
	#placesList .item .marker_4 {background-position: 0 -148px;}
	#placesList .item .marker_5 {background-position: 0 -194px;}
	#placesList .item .marker_6 {background-position: 0 -240px;}
	#placesList .item .marker_7 {background-position: 0 -286px;}
	#placesList .item .marker_8 {background-position: 0 -332px;}
	#placesList .item .marker_9 {background-position: 0 -378px;}
	#placesList .item .marker_10 {background-position: 0 -423px;}
	#placesList .item .marker_11 {background-position: 0 -470px;}
	#placesList .item .marker_12 {background-position: 0 -516px;}
	#placesList .item .marker_13 {background-position: 0 -562px;}
	#placesList .item .marker_14 {background-position: 0 -608px;}
	#placesList .item .marker_15 {background-position: 0 -654px;}
	#pagination {margin:10px auto;text-align: center;}
	#pagination a {display:inline-block;margin-right:10px;}
	#pagination .on {font-weight: bold; cursor: default;color:#777;}
	
	<!-- 카테고리 검색 탭 스타일 -->
	#category{widht : 100%;}
	#category>li{width : 100%; height: 30px;line-height : 30px; overflow:auto;}
	#category>li:nth-of-type(4){height : 60px;}
	.subCategory{background-color: gray}
	
	.button{float : left; width : 20%; border : white 2px solid; border-radius: 8px;
			text-decoration: none; text-align : center; font-size : 10px; padding : 4px;
			margin : 0 10px; color : white; background-color: #00B0B0;}
	.button:hover{color: #00B0B0; background-color: white}
	
	<!-- 저장리스트 스타일 -->
	#pannel3{width : 100%; overflow: auto; padding: 0; margin:0; background-color:red;}
	#pannel3>div{width : 100%; height : 40px; line-height : 40px; background-color: #00B0B0; color : white;
				border-bottom : 1px solid white;}

</style>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
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
					<input type="checkbox" id="chkBicycle" onclick="setOverlayMapTypeId()" /> 자전거도로 정보 보기
					<hr>
					<div style="height:25px;line-height:25px;"onclick="showCategory();"><h5>카테고리 검색</h5></div>
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
							<button value="CE7" class="button" onclick="searchPlaceCategory(value);">카페</button>
						</li>
						<li>
							<button value="CT1" class="button" onclick="searchPlaceCategory(value);">문화시설</button>
							<button value="AT4" class="button" onclick="searchPlaceCategory(value);">관광명소</button>
						</li>
						<li>
							<button value="AD5" class="button" onclick="searchPlaceCategory(value);">숙박</button>
						</li>
						<li>
							<button value="CS2" class="button" onclick="searchPlaceCategory(value);">편의점</button>
							<button value="PM9" class="button" onclick="searchPlaceCategory(value);">약국</button>
							<button value="HP8" class="button" onclick="searchPlaceCategory(value);">병원</button>
							<button value="PK6" class="button" onclick="searchPlaceCategory(value);">주차장</button>
							<button value="SW8" class="button" onclick="searchPlaceCategory(value);">지하철</button>
							<button value="BK9" class="button" onclick="searchPlaceCategory(value);">은행</button>
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
					<li id="startPoint"><input type="text"/>
						<input type="hidden" name="startPoint"/></li>
					<li id="arrivePoint"><input type="text"/>
						<input type="hidden" name="arrivePoint"/></li>
				</ul>
				
				<select name=""></select>
				<input type="button" value="경로 탐색" onclick="searchRoute();"/>
			</div>
			
			<!-- 저장한 장소 목록 -->
			<div class="tab" id="pannel3">
				<div onclick="showPlaceList(title);" title="foodList">찜한 음식점</div>
				<ul id="foodList" style="display:none;"></ul>				
				<div onclick="showPlaceList(title);" title="sightsList">찜한 관광지</div>
				<ul id="sightsList" style="display:none;"></ul>
				<div onclick="showPlaceList(title);" title="accomodationList">찜한 숙박시설</div>
				<ul id="accomodationList" style="display:none;"></ul>
				<div onclick="showPlaceList(title);" title="convenientList">찜한 편의시설</div>
				<ul id="convenientList" style="display:none;"></ul>
			</div>
			
			<!-- 저장 탭-->
			<div class="tab">
				<c:if test="${logId == null }">
						<h5>로그인 후 이용 가능합니다.</h5>
				</c:if>
				<c:if test="${logId!=null }">
				<form>
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