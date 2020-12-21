<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="stylesheet" href="/home/css/routeMap.css" type="text/css" />
<script type="text/javascript"	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly"	defer></script>
<link rel="stylesheet"	href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap"	rel="stylesheet">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript"	src="<%=request.getContextPath() %>/js/route/routeMap.js"></script>
<div id="mainDivMap">
	<div id="info">
		<!-- 탭 아이콘 패널 -->
		<div id="naviIcon">
			<ul>
				<li><label for="tab1"><img
						src="<%=request.getContextPath()%>/img/img_course/searchGray.png"
						onmouseover="this.src='<%=request.getContextPath()%>/img/img_course/searchColor.png'"
						onmouseout="this.src='<%=request.getContextPath()%>/img/img_course/searchGray.png'"></label></li>
				<li><label for="tab2"><img
						src="<%=request.getContextPath()%>/img/img_course/mapGray.png"
						onmouseover="this.src='<%=request.getContextPath()%>/img/img_course/mapColor.png'"
						onmouseout="this.src='<%=request.getContextPath()%>/img/img_course/mapGray.png'"></label></li>
				<li><label for="tab3"><img
						src="<%=request.getContextPath()%>/img/img_course/buildingGray.png"
						onmouseover="this.src='<%=request.getContextPath()%>/img/img_course/buildingColor.png'"
						onmouseout="this.src='<%=request.getContextPath()%>/img/img_course/buildingGray.png'"></label></li>
				<li><label for="tab4"><img
						src="<%=request.getContextPath()%>/img/img_course/saveGray.png"
						onmouseover="this.src='<%=request.getContextPath()%>/img/img_course/saveColor.png'"
						onmouseout="this.src='<%=request.getContextPath()%>/img/img_course/saveGray.png'"></label></li>
				<li><label for="tab5"><img
						src="<%=request.getContextPath()%>/img/img_course/info2.png"></label></li>
			</ul>
		</div>

		<!-- 지도 검색 조작 패널 -->
		<div id="infoPannel">
			<input type="radio" name="tab" class="tabIcon" id="tab1" checked /> <input
				type="radio" name="tab" class="tabIcon" id="tab2" /> <input
				type="radio" name="tab" class="tabIcon" id="tab3" /> <input
				type="radio" name="tab" class="tabIcon" id="tab4" /> <input
				type="radio" name="tab" class="tabIcon" id="tab5" />

			<!-- 검색 패널 -->
			<div class="tab" id="pannel1" style='overflow-x: hidden;'>
				<div id="searchPannel">
					<input type="text" name="searchWord" id="searchWord"
						placeholder="장소·주소를 검색하세요" /><br /> <input type="checkbox"
						id="chkBicycle" onclick="setOverlayMapTypeId()" /> <span
						class="grayTxt">자전거도로 정보 보기</span>
					<hr class="route_hr" />
					<div style="height: 25px;" onclick="showCategory();">
						<img id="listImg"
							src="<%=request.getContextPath()%>/img/img_route/star3.png" /> <label
							id="searchLbl" class="grayTxt">카테고리 검색 ▼</label>
					</div>
					<hr class="route_hr" />
					<!-- 
					category 분류
					음식점 fd6 음식점 / ce7 카페
					관광지 ct1 문화시설 / at4 관광명소  
					숙박   ad5 숙박
					편의시설	cs2 편의점 / pk6 주차장 /sw8 지하철역 / bk9 은행 / hp8 병원 / pm9 약국
				 	-->
					<ul id="category" style="display: none;">
						<li>
							<button value="FD6" class="food_Btn"
								onclick="searchPlaceCategory(value);">음식점</button>
							<button value="CE7" class="food_Btn"
								onclick="searchPlaceCategory(value);">카&nbsp;&nbsp;&nbsp;페</button>
						</li>
						<li>
							<button value="CT1" class="sights_Btn"
								onclick="searchPlaceCategory(value);">문화시설</button>
							<button value="AT4" class="sights_Btn"
								onclick="searchPlaceCategory(value);">관광명소</button>
						</li>
						<li>
							<button value="AD5" class="accomodation_Btn"
								onclick="searchPlaceCategory(value);">숙&nbsp;&nbsp;&nbsp;박</button>
						</li>
						<li>
							<button value="CS2" class="convenient_Btn"
								onclick="searchPlaceCategory(value);">편의점</button>
							<button value="PM9" class="convenient_Btn"
								onclick="searchPlaceCategory(value);">약&nbsp;&nbsp;&nbsp;국</button>
							<button value="HP8" class="convenient_Btn"
								onclick="searchPlaceCategory(value);">병&nbsp;&nbsp;&nbsp;원</button>
							<button value="PK6" class="convenient_Btn"
								onclick="searchPlaceCategory(value);">주차장</button>
							<button value="SW8" class="convenient_Btn"
								onclick="searchPlaceCategory(value);">지하철</button>
							<button value="BK9" class="convenient_Btn"
								onclick="searchPlaceCategory(value);">은&nbsp;&nbsp;&nbsp;행</button>
						</li>
						<hr class="route_hr" />
					</ul>
				</div>
				<ul id="placesList"></ul>
				<div id="pagination"></div>
			</div>
			<!-- 길찾기 -->
			<div class="tab">
				<br />
				<br />
				<ul id="routePoint">
					<li class="tab_liTag"><input type="text" class="startBox"
						placeholder="출발지를 지정하세요" readonly /> <input type="hidden"
						name="routePoint" /></li>
					<li class="tab_liTag"><input type="text" class="arriveBox"
						placeholder="도착지를 지정하세요" readonly /> <input type="hidden"
						name="routePoint" /></li>
				</ul>
				<div style='padding-left: 37px; margin-top: 10px'>
					<select name="preference" class="selectBox" style='width: 180px'>
						<option value="recommended" selected>추천 경로</option>
						<option value="shortest">최단 거리</option>
					</select> <input type="button" value="경로 탐색" onclick="searchRoute();"
						class="mint_Btn" style='font-size:14px; height:35px; border-radius:7px;' />
				</div>
				<div style='text-align: center'>
					<input type="button" value="지점 전환" onclick="changeStartArrive();"
						class="blue_Btn1"
						style='font-size: 16px; width: 105px; padding: 11px 12px' /> <input
						type="button" value="초기화" onclick="clearRoute();" class="gray_Btn"
						style='font-size: 16px; width: 105px; padding: 11px 12px' />
				</div>
				<div id="routeInfo">
					총 거리 : <span id="distance"></span>km<br /> 상승고도 : <span id="ascent"></span>m<br />
					하강고도 : <span id="descent"></span>m<br />
				</div>
				<div id="elevation_chart"></div>
				<div id="chart_Back"></div>
			</div>

			<!-- 저장한 장소 목록 -->
			<div class="tab" id="pannel3">
				<div onclick="showPlaceList(title);" title="foodList"
					style='background-color: #EB3807'>
					<img id="likeImg"
						src="<%=request.getContextPath()%>/img/img_route/food.png" />찜한
					음식점
				</div>
				<ul id="foodList" style="display: none;"></ul>
				<div onclick="showPlaceList(title);" title="sightsList"
					style='background-color: #002060'>
					<img id="likeImg"
						src="<%=request.getContextPath()%>/img/img_route/sights.png" />찜한
					관광지
				</div>
				<ul id="sightsList" style="display: none;"></ul>
				<div onclick="showPlaceList(title);" title="accomodationList"
					style='background-color: #5A147A'>
					<img id="likeImg"
						src="<%=request.getContextPath()%>/img/img_route/accomodation.png" />찜한
					숙박시설
				</div>
				<ul id="accomodationList" style="display: none;"></ul>
				<div onclick="showPlaceList(title);" title="convenientList"
					style='background-color: #2E75B6'>
					<img id="likeImg"
						src="<%=request.getContextPath()%>/img/img_route/convenient.png" />찜한
					편의시설
				</div>
				<ul id="convenientList" style="display: none;"></ul>
			</div>

			<!-- 저장 탭-->
			<div class="tab">
				<c:if test="${logId == null }">
					<img id="lockImg"
						src="<%=request.getContextPath()%>/img/img_register/lock.png" />
					<div
						style="line-height: 10px; margin-bottom: 55px; text-align: center; font-family: 'Noto Sans KR', sans-serif">
						<h3 style='display: inline-block;'>코스 저장하기</h3>
						<br />
						<h4 style='display: inline-block; color: #005766'>로그인 후 이용
							가능합니다.</h4>
					</div>
					<div id="logButtons">
						<input type="button" id="login" name="login" value="로그인"
							class="mint_Btn"
							style='width: 80px; height: 35px; font-size: 15px' /> <input
							type="button" name="login" value="회원가입" class="WMint_Btn"
							onclick="location.href='/home/registerForm'" />
					</div>
				</c:if>
				<c:if test="${logId!=null }">
					<form id="routeSave">
						<input type="text" name="title" id="title"
							placeholder="루트 이름을 입력하세요" /><br /> <select id="catename"
							class="selectBox" style='width:192px; border-radius:7px; margin-left:7px'>
							<c:forEach var="list" items="${category }">
								<option value="${list.noroutecate }" title="${list.catename }">${list.catename}</option>
							</c:forEach>
							<c:if test="${fn:length(category) < 5}">
								<option value="addCategory">카테고리 추가</option>
							</c:if>
						</select><br/> <span class="saveTxt">※ 루트 공개여부를 설정해주세요.</span><br/>
						<div style='margin: 8px 0 12px 18px;'>
							<input type="radio" name="closed" value="F" checked />
							<span class="saveTxt2"> 공개</span>&emsp;&emsp;&emsp; 
							<input type="radio" name="closed" value="T" /><span class="saveTxt2">비공개</span>
						</div>
						<br />
						<div id="saveDiv3">
							<textarea name="description" id="description"
								placeholder="루트에 대한 설명을 적어주세요." rows="6" cols="15"
								style="resize: none" maxlength="50"></textarea>
							<br />
						</div>
						<div id="saveDiv2">
							<input type="submit" value="나의 루트 저장하기" class="blue_Btn" id="saveBtn" />
						</div>
						<div id="saveDiv1">
							<img
								src="<%=request.getContextPath()%>/img/img_route/bicycle.gif"/>
						</div>
					</form>
				</c:if>
			</div>
			<!-- 루트짜기 도움말 탭 -->
			<div class="tab">
				<div class="info_tab">
					<span class='info_title'>1. 검색</span><br/>
					<button data-target="#dialog1" data-toggle="modal" class='info_btn'>이용가이드</button>
					<br /> <span class='info_title'>2. 길찾기</span><br/>
					<button data-target="#dialog2" data-toggle="modal" class='info_btn'>이용가이드</button>
					<br /> <span class='info_title'>3. 저장 장소</span><br/>
					<button data-target="#dialog3" data-toggle="modal" class='info_btn'>이용가이드</button>
					<br /> <span class='info_title'>4. 저장</span><br/>
					<button data-target="#dialog4" data-toggle="modal" class='info_btn'>이용가이드</button>
					<br/>
				</div>
				<br/> <img src="<%=request.getContextPath()%>/img/img_course/speech_bubble.png" style="width:350px"/>
				<div class="info_tab2">
					<img src="<%=request.getContextPath()%>/img/img_course/bike_black.png" style="width: 165px; margin:25px 0 22px 0"/><br/>
						<span class="info_txt1">바이크맵 이용이 어려우신가요?</span><br/>
					<div class="info_txt2">
						상단의 <span class='blinking'>이용 가이드</span>를 참고해보세요!
					</div>
				</div>
			</div>
		</div>

		<!-- =====================================모달창====================================== -->

		<!-- 루트짜기 이용가이드 : 1.검색 모달창-->
		<div class="modal" id="dialog1">
			<div class="modal-dialog"
				style='margin: 85px 0 0 350px; padding: 15px 0 10px 23px;'>
				<div class="modal-content">
					<!-- header -->
					<div class="modal-header" style="border: none">
						<label><img	src="<%=request.getContextPath()%>/img/img_course/info.png" style="width: 30px">&ensp;한 눈에 보는 바이크맵 이용가이드&nbsp;
							<span style='font-size: 25px; color: #EB3807'>[검색]</span>
						</label>
						<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
					</div>
					<!-- body -->
					<div class="modal-body">
						<img src="<%=request.getContextPath()%>/img/img_course/1_search_info.png"/>
					</div>
					<!-- footer -->
					<div class="modal-footer" style="border: none"></div>
				</div>
			</div>
		</div>


		<!-- 루트짜기 이용가이드 : 2.길찾기 모달창 -->
		<div class="modal" id="dialog2">
			<div class="modal-dialog"
				style='margin: 85px 0 0 350px; padding: 15px 0 10px 23px;'>
				<div class="modal-content">
					<!-- header -->
					<div class="modal-header" style="border: none">
						<label><img src="<%=request.getContextPath()%>/img/img_course/info.png" style="width:30px">&ensp;한 눈에 보는 바이크맵 이용가이드&nbsp;
							<span style='font-size: 25px; color: #002060'>[길찾기]</span>
						</label>
						<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
					</div>
					<!-- body -->
					<div class="modal-body">
						<img src="<%=request.getContextPath()%>/img/img_course/2_routepoint_info.png"/>
					</div>
					<!-- footer -->
					<div class="modal-footer" style="border: none"></div>
				</div>
			</div>
		</div>



		<!-- 루트짜기 이용가이드 : 3.저장 장소 모달창 -->
		<div class="modal" id="dialog3">
			<div class="modal-dialog"
				style='margin: 85px 0 0 350px; padding: 15px 0 10px 23px;'>
				<div class="modal-content">
					<!-- header -->
					<div class="modal-header" style="border: none">
						<label><img	src="<%=request.getContextPath()%>/img/img_course/info.png" style="width: 30px">&ensp;한 눈에 보는 바이크맵 이용가이드&nbsp;
							<span style='font-size: 25px; color: #5A147A'>[저장장소]</span>
						</label>
						<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
					</div>
					<!-- body -->
					<div class="modal-body">
						<img src="<%=request.getContextPath()%>/img/img_course/3_show_place_list.png"/>
					</div>
					<!-- footer -->
					<div class="modal-footer" style="border: none"></div>
				</div>
			</div>
		</div>



		<!-- 루트짜기 이용가이드 : 4.저장 모달창 -->
		<div class="modal" id="dialog4">
			<div class="modal-dialog"
				style='margin: 85px 0 0 350px; padding: 15px 0 10px 23px;'>
				<div class="modal-content">
					<!-- header -->
					<div class="modal-header" style="border: none">
						<label><img	src="<%=request.getContextPath()%>/img/img_course/info.png" style="width: 30px">&ensp;한 눈에 보는 바이크맵 이용가이드&nbsp;
							<span style='font-size: 25px; color: #2E75B6'>[저장]</span>
						</label>
						<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
					</div>
					<!-- body -->
					<div class="modal-body">
						<img src="<%=request.getContextPath() %>/img/img_course/4_route_save.png"/>
					</div>
					<!-- footer -->
					<div class="modal-footer" style="border: none"></div>
				</div>
			</div>
		</div>

	</div>
	<div id="map"></div>
</div>