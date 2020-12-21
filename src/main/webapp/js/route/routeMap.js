var map ;
var ps ; 
var markers = [];
var routeMarker = [];
	
var foodMarker = [],
	sightsMarker = [],
	accomodationMarker = [],
	convenientMarker = [];

var bounds ;
var infowindow =new kakao.maps.InfoWindow({zIndex:1, removable : true});

// 루트 저장용 데이터
var geocode = "";
var region = "";

// 루트 표시 마커 생성
var markerStart ;
var markerVia ;
var markerArrive ;

// 장소 마커
var markerFood ;
var markerSights ;
var markerAccom ;
var markerConve ;

// 마커 이미지 미리 생성
var markerSize = new kakao.maps.Size(46, 46); // 출발 마커이미지의 크기입니다
var markerOption = {offset: new kakao.maps.Point(21, 50)}; // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)  

// 루트 마커 이미지를 생성합니다
var startImage = new kakao.maps.MarkerImage('./img/img_route/markerStart.png', markerSize, markerOption);
var arriveImage = new kakao.maps.MarkerImage('./img/img_route/markerArrive2.png', markerSize, markerOption);
var viaImage = new kakao.maps.MarkerImage('./img/img_route/markerVia.png', markerSize, markerOption);

// 장소 마커 이미지 생성
var foodImage = new kakao.maps.MarkerImage('./img/img_route/markerFood.png', markerSize, markerOption);
var sightsImage = new kakao.maps.MarkerImage('./img/img_route/markerSights.png', markerSize, markerOption);
var accomImage = new kakao.maps.MarkerImage('./img/img_route/markerAccom.png', markerSize, markerOption);
var conveImage = new kakao.maps.MarkerImage('./img/img_route/markerConve.png', markerSize, markerOption);

// 1. 지도 만들기


$(function(){
	
	var container = document.getElementById("map");
	var options = {
			center : new kakao.maps.LatLng(37.5510907243016, 126.937364458741),
			level : 3,
			draggable : 'true',
	};
	
	bounds = new kakao.maps.LatLngBounds();
	

	// 지도 추가
	map = new kakao.maps.Map(container, options);
	infowindow = new kakao.maps.InfoWindow({zIndex:1, removable : true});
	
	// 지도 컨트롤러 추가
	var mapTypeControl = new kakao.maps.MapTypeControl();
	var zoomControl = new kakao.maps.ZoomControl();
	
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.Right);

// 검색을 위한 장소 객체 생성
	ps = new kakao.maps.services.Places();
	
	// 검색 버튼 클릭 시 키워드 검색 실시
	$("#searchWord").on("keydown", function(){
		if(event.keyCode == 13){
			var keyword = $("#searchWord").val();
			if(keyword == ""){
				toast("검색어를 입력하세요.",1500);
				return false;
			}
			ps.keywordSearch(keyword, placeSearchCB, {size: 10});
		}
	});
	
	///////////////////////////////// sortable 리스트 세팅 경로 루트 이동 가능하도록

	$("#routePoint").sortable();
	$("#routePoint").children("input[type=text]").disableSelection();
	
	// 리스트 순서가 바뀔 때 마커 새로 설정
	$( "#routePoint" ).on( "sortstop", function() {
		setRouteMarker();
		setDeleteBtn();	
		setStartArriveClass();
 	});
 	
 	// 로그인 팝업 띄우기
 	$("#login").on('click',function(){
 		window.open("/home/loginPopup","Bikemap Login","width=780px, height=400px, left =200px, top=200px");
 	});
 	
 		
// 카테고리 추가
	$("#catename").on('change',function(){
		if($(this).val() == 'addCategory'){
			var catename = prompt("새 카테고리 이름을 입력하세요.", "새 코스");
			var overlap = 0;
			
			// 카테고리 추가 시 중복 확인
			$("#catename").children("option").each(function(){
				var names = $(this).attr("title");
				if(names == catename){
					toast("이미 등록된 이름입니다.",1500);
					overlap++;
					return false;
				}
			});
			
			// 중복이 없다면 비동기식으로 새로운 카테고리 추가
			if(overlap ==0){
				var url = "/home/insertCategory";
				var data = "catename="+catename;
	
				console.log(111);
				$.ajax({
					type : 'POST',
					url : url,
					data : data,
					success : function(result){
						if(result == 1){
							toast("새로운 카테고리가 추가되었습니다.",1500);
							selectCategory();
						}else{
							toast("카테고리 추가 에러",1500);
						}
					}, error : function(){
						console.log("카테고리 새로 추가 에러");
					}
				});
			}			
		}else{
			return false;
		}
	});
 	
	
		// 코스 저장하기
	$("#routeSave").submit(function(){
		var data = "";
		// 1. 타이틀 입력 여부 확인
		if($("#title").val() != ""){
			data+="title="+$("#title").val();
		}else{
			toast("루트 제목을 입력하세요.",1500);
			return false;
		}
		
		// 2. 루트 포인트 2개 이상 존재하는 지 확인
		var cntRoute = 0;
		$("#routePoint>li").each(function(){
			if($(this).children("input[type=text]").val() != null){
				data += "&routepoint"+ ++cntRoute + "=" +$(this).children("input[type=text]").val(); // 루트 장소 이름
				data += "[/]"+$(this).children("input[name=routePoint]").val();
			}
		});
		
		if(cntRoute < 2){
			toast("저장할 경로를 2개 이상 입력하세요.",1500);
			return false;
		}
		
		// 3. geocode 데이터 존재 여부 확인
		if(geocode == ""){
			toast("경로 탐색을 먼저 실행하세요.",1500);
			return false;
		}else{
			data += "&geocode="+geocode;
			data += "&polyline="+linePath;
			data += "&mapcenter="+ map.getCenter();
			data += "&maplevel="+ map.getLevel();
		}
		
		// 4. 거리 상승 하강 고도 설정
		data += "&distance="+$("#distance").text();
		data += "&ascent="+$("#ascent").text();
		data += "&descent="+$("#descent").text();
		
		var region = getRegion();
		data += "&region="+region;
		data += "&closed="+$("input[name=closed]:checked").val();
		
		console.log(data);
		data += "&description="+$("#description").val();
		
		////////// 루트 데이터 //////////
		
		data += "&noroutecate="+$("#catename").val();
		////////// 루트 리스트 데이터 //////////
		
		for(var i = 1 ; i <= $("input[name=foodList]").length ; i++){
			data += "&food"+i+"="+$("input[name=foodList]").eq(i-1).val();
		}
		
		for(var i = 1 ; i <= $("input[name=sightsList]").length ; i++){
			data += "&sights"+i+"="+$("input[name=sightsList]").eq(i-1).val();
		}
		
		for(var i = 1 ; i <= $("input[name=accomodationList]").length ; i++){
			data += "&accom"+i+"="+$("input[name=accomodationList]").eq(i-1).val();
		}
		
		for(var i = 1 ; i <= $("input[name=convenientList]").length ; i++){
			data += "&conve"+i+"="+$("input[name=convenientList]").eq(i-1).val();
		}
		/////////// 장소 데이터 ////////////
		
		var url = "/home/insertRoute";
		
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				if(result == 1){
					toast("루트가 저장되었습니다.",1500);
					clearRoute();
				}else{
					toast("루트가 저장되지 않았습니다.<br/>다시 시도해주십시오.",1500);
				}
			},error : function(){
				console.log("루트 저장 에러");
			}
		});
		return false;
	});
	
});
	

// 장소 검색 결과값 처리
	function placeSearchCB(data, status, pagination){
		if(status === kakao.maps.services.Status.OK){
					
			// 리스트 표시
			displayPlaces(data);
			// 페이지 번호 표시
			displayPagination(pagination);
			
		}else if(status === kakao.maps.services.Status.ZERO_RESULT){
			toast("검색 결과가 존재하지 않습니다.",1500);
			return ;
		}else if(satus === kakao.maps.services.Statuas.ERROR){
			toast("검색 결과 중 오류가 발생했습니다.",1500);
			return;
		}
	};

// 검색 결과 표시
	function displayPlaces(places){
		var listEl = document.getElementById("placesList");
		var menuEl = document.getElementById("searchPannel");
		var fragment = document.createDocumentFragment();
		bounds = new kakao.maps.LatLngBounds();
		var listStr = '';
		
		// 기존 검색 결과 제거
		removeAllChildNods(listEl);
		
		// 기존에 표시된 마커 제거
		removeMarker(markers);
		
		for(var i = 0; i<places.length ; i++){
			
			// 마커 생성 표시
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
			var marker = addMarker(placePosition, i);
			var itemEl = getListItem(i, places[i]); 
			
			// 지도 위치 수정을 위한 좌표 취합
			bounds.extend(placePosition);
			
			(function(marker, places){
				kakao.maps.event.addListener(marker, 'click', function(){
					displayInfowindow(marker, places);
				});
				
				itemEl.onmouseover = function(){
					displayInfowindow(marker, places);
				};
				
			})(marker, places[i]);
			
			fragment.appendChild(itemEl);
		}
		
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;
		map.setBounds(bounds);
	}

// 검색 결과 목록 만들기
	function getListItem(index, places){
		
		var el = document.createElement('li');
		var itemStr = '<span class="markerbg marker_'+(index+1)+'"></span>'+
					  '<div class="info">' + '<b style="font-size:17px; font-weight:bold; color:#002060">'+places.place_name + '</b>';
					  
		if(places.road_address_name){
			itemStr += '<span style="font-size:15px;">'+places.road_address_name + '</span>'+
						'<span class="jibun gray" style="font-size:12.5px">' + places.address_name + '</span>';
		}else{
			itemStr += '<span>'+places.address_name + '</span>';
		}
		
		itemStr +='<span class="tel" style="font-size:15px; font-weight:bold">'+places.phone + '</span></div>';
		
		el.innerHTML = itemStr;
		el.className = 'item';
		
		return el;
	}

// 마커 생성 후 지도에 표시
	function addMarker(position, idx, title){
	    var imageSrc = '/home/img/img_route/marker_number_gray.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
		var imageSize = new kakao.maps.Size(36,37);
		var imgOptions = {
				spriteSize : new kakao.maps.Size(36,691),
				spriteOrigin : new kakao.maps.Point(0,(idx*46)+10),
				offset : new kakao.maps.Point(13,37)
		},
		markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions ),
		marker = new kakao.maps.Marker({
			position : position,
			image : markerImage
		});
		
		marker.setMap(map);
		markers.push(marker);
		
		return marker;
	}

// 기존에 표시한 마커 제거
	function removeMarker(markerGroup){
		for(var i = 0; i<markerGroup.length; i++){
			markerGroup[i].setMap(null);
		}
		markerGroup =[];
	}

// 페이지 번호 표시
	function displayPagination(pagination){
		var paginationEl = document.getElementById("pagination");
		var fragment = document.createDocumentFragment();
		var i;
		
		// 기존 페이지 번호 삭제
		while(paginationEl.hasChildNodes()){
			paginationEl.removeChild(paginationEl.lastChild);
		}
		
		for (i=1;i<=pagination.last;i++){
			var el = document.createElement('a');
			el.href="#";
			el.innerHTML = i;
			
			if(i===pagination.current){
				el.className ='on';
			}else{
				el.onclick = (function(i){
					return function(){
						pagination.gotoPage(i);
					}
				})(i);
			}
			fragment.appendChild(el);
		}
		paginationEl.appendChild(fragment);
	}


// 인포 윈도우 작업
// 중요!!!@!#@!#@!#@!#@!#@!
	function displayInfowindow(marker, places){
		
		// 플레이스 객체 스트링으로 전환
		var place = JSON.stringify(places);
		
		var group = places.category_group_code;
		var content = '<div id="infoWin">'; // 인포윈도우
		$("#infoWin").parent().parent().addClass("infoWindow");
		
		// 인포 윈도우 이름에 링크 설정
		if(places.place_url){
			content += '<a href= "'+places.place_url+'" target="_blank" id="info_a">' + places.place_name + '</a><ul>';	
		}else{
			content += places.place_name + '<hr/><ul>';
		}
		
		content += "<br/><button onclick='setRoutePoint(value, title)' title='startPoint' id='start_Btn' value='"+place+"'>출발지 지정</button><br/>";
		content += "<button onclick='setRoutePoint(value, title)' title='viaPoint' id='via_Btn' value='"+place+"'>경유지 지정</button><br/>";
		content += "<button onclick='setRoutePoint(value, title)' title='arrivePoint' id='arrive_Btn' value='"+place+"'>도착지 지정</button>";
		
		// 카테고리 추가 버튼 생성
		if(group == 'FD6' || group =='CE7'){
			content += "<hr class='route_modalhr'><div class='categoryDiv1'><button onclick='setPlaceList(value, title)' title='foodList' class='food_Btn2' value='"+place+"'>음식점 저장</button></div>";
		}else if(group == 'CT1' || group =='AT4'){
			content += "<hr class='route_modalhr'><div class='categoryDiv1'><button onclick='setPlaceList(value, title)' title='sightsList' class='sights_Btn2' value='"+place+"'>관광지 저장</button></div>";
		}else if(group == 'AD5'){
			content += "<hr class='route_modalhr'><div class='categoryDiv2'><button onclick='setPlaceList(value, title)' title='accomodationList' class='accomodation_Btn2' value='"+place+"'>숙박시설 저장</div></button>";
		}else if(group == 'CS2' || group == 'PK6' ||group == 'SW8' ||group == 'BK9' ||group == 'HP8' ||group == 'PM9'){
			content += "<hr class='route_modalhr'><div class='categoryDiv2'><button onclick='setPlaceList(value, title)' title='convenientList' class='convenient_Btn2' value='"+place+"'>편의시설 저장</div></button>";
		}
		content += '</ul></div>';
		
		infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

// 결과 검색 목록에 리스트 삭제
	function removeAllChildNods(el){
		while(el.hasChildNodes()){
			el.removeChild(el.lastChild);
		}
	}
	
// 자전거 도로 표시 온오프 처리
	function setOverlayMapTypeId(){
		var chkBicycle = document.getElementById("chkBicycle");
		var mapType = kakao.maps.MapTypeId.BICYCLE;
		
		if(chkBicycle.checked){
			map.addOverlayMapTypeId(mapType);
		}else{
			map.removeOverlayMapTypeId(mapType);
		}
	};

// 카테고리 검색 클릭 시 카테고리 분류 표시
	var categoryOpen = 1;
	function showCategory(){
		if(categoryOpen == 1){
			$("#category").css("display", "block");
			categoryOpen++;
		} else {
			$("#category").css("display","none");
			categoryOpen--;
		}
	}

// 장소 검색
	function searchPlaceCategory(value){
		var bounds = new kakao.maps.LatLngBounds(map.getBounds().getSouthWest(), map.getBounds().getNorthEast());
		
		ps.categorySearch(value, placeSearchCB,{
			location : map.getCenter(),
			bounds : bounds,
			size : 10
		});
	}	

// 찜한 리스트 오픈
	function showPlaceList(type){
		var chk = $("#"+type).css("display");		
		if(chk == 'block'){
			$("#"+type).css("display", "none");
			if(type== 'foodList') { removeMarker(foodMarker);}
			else if(type== 'sightsList') { removeMarker(sightsMarker);}
			else if(type== 'accomodationList'){removeMarker(accomodationMarker);}
			else if(type== 'convenientList'){removeMarker(convenientMarker);}
		}else{
			if($("#"+type).children("li").length == 0){
				toast("찜한 리스트가 없습니다.",1500);
			}else{
				$("#"+type).css("display", "block");
				if(type == 'foodList') { setPlaceMarker(foodMarker);}
				else if(type== 'sightsList') { setPlaceMarker(sightsMarker);}
				else if(type== 'accomodationList'){setPlaceMarker(accomodationMarker);}
				else if(type== 'convenientList'){setPlaceMarker(convenientMarker);}
			}
		}
	}
	

// 장소 리스트 설정
	function setPlaceList(value, type){
		// value = 장소 정보(string 타입으로 변환한 것)
		// type = 장소 리스트 종류 (음식 / 관광지 / 숙박시설 / 편의시설)
		
		var json = JSON.parse(value);
		var cnt = $("#"+type).children("li").length;
		var newList ="";
		var overlap = 0;
		
		// 현재 등록된 리스트 숫자 확인 : 5개 이상이면 오류 메세지 출력 후 더 이상 추가가 안 됨.
		if(cnt < 5){
			
			// 이미 등록된 장소 일 경우 추가로 등록이 되지 않음
			$("#"+type).children("li").each(function(){
				var id = $(this).attr("title");
				if(id == json.id){
					toast("이미 등록된 장소입니다.");
					overlap++;
					return false;
				}
			});
			
			// 리스트에 여유가 있고, 먼저 등록이 되지 않았을 경우 새로운 리스트 작성
			if(overlap == 0){
				newList += "<li class='tab_liTag' title='"+json.id+"'><a href='"+json.place_url+"' target='_blank'><input type='text' value='"+json.place_name+"' readonly/></a>";
				newList += "<input type='hidden' name='"+type+"' value='"+value+"'/><button class='listDel_Btn' onclick='$(this).parent().remove();";
					if(type == 'foodList') { newList += "setPlaceMarker(foodMarker);";}
					else if(type== 'sightsList') { newList += "setPlaceMarker(sightsMarker);";}
					else if(type== 'accomodationList'){newList += "setPlaceMarker(accomodationMarker);";}
					else if(type== 'convenientList'){newList += "setPlaceMarker(convenientMarker);";}
				newList += "'><img id='listDel_img' src='/home/img/img_route/listDelBtn.png'/></button></li>";
				$("#"+type).append(newList);
					
				if($("#"+type).css("display") == 'block'){
					if(type == 'foodList') { setPlaceMarker(foodMarker);}
					else if(type== 'sightsList') { setPlaceMarker(sightsMarker);}
					else if(type== 'accomodationList'){setPlaceMarker(accomodationMarker);}
					else if(type== 'convenientList'){setPlaceMarker(convenientMarker);}
				}
			}else{
				return false;
			}
		} else{
			toast("장소는 코스당 종류 별로 최대 5개 등록이 가능합니다.",1500);
			return false;
		}
	}
	
// 장소 마커 설정하기
	function setPlaceMarker(markers){
		
		if(markers == foodMarker){
			selector = "input[name=foodList]";
			markerImage = foodImage;
		}else if(markers == sightsMarker){
			selector = "input[name=sightsList]";
			markerImage = sightsImage;
		}else if(markers == accomodationMarker){
			selector = "input[name=accomodationList]";
			markerImage = accomImage;
		}else if(markers == convenientMarker){
			selector = "input[name=convenientList]";
			markerImage = conveImage;
		}
		
		var routePosition = [];
		$(selector).each(function(){
			
			var json = JSON.parse($(this).val());
			var p = new kakao.maps.LatLng(json.y, json.x);
			
			routePosition.push(p);
		});
		
		removeMarker(markers);
		
		for(var i = 0 ; i < routePosition.length ; i++){
			var marker = new kakao.maps.Marker({
				position : routePosition[i]
				, image : markerImage
			});
			
			marker.setMap(map);
			markers.push(marker);
		}
	}


	// map 사이즈 변경
	function resizeMap(){
		var width = window.innerWidth - 430 + "px";	
	 	$("#map").css("width",width);
	 	map.relayout();
 	}

// 경로 포인트 지정
// 출발지 도착지 지정시 각각 첫번째 마지막 위치에 입력
// 경유지 지정 시 마지막 li 앞에 데이터 입력 (경유지 5개 일 시 추가 안 됨)
	function setRoutePoint(value, type){
		// value = 장소 정보(string 타입으로 변환한 것)
		// type = 출발지 startPoint / 경유지 viaPoint / 도착지 arrivePoint
		var json = JSON.parse(value);
		
		// 위치 데이터 추출
		var point = json.x+"/"+json.y;
		
		// 이미 등록된 장소인지 확인
		var overlap = 0;
		$("input[name=routePoint]").each(function(){
			if($(this).val() == point){
				toast("이미 등록된 위치입니다.");
				overlap ++;
				return false;
			}
		});
			
		if(overlap == 0){ // overlap(중복 위치 아닐 때만 입력);
			// 출발지나 도착지 선택일 경우 원래 칸에 hidden 타입으로 입력
			if(type == 'startPoint'){
				$("#routePoint>li:eq(0)").children("input[type=text]").attr("value",json.place_name);
				$("#routePoint>li:eq(0)").children("input[name=routePoint]").val(point);
				$("#routePoint>li:eq(0)").append("<input type='hidden' name='region' value='"+json.address_name+"'/>");
				
			}else if(type == 'arrivePoint'){
				$("#routePoint>li:last").children("input[type=text]").attr("value",json.place_name);
				$("#routePoint>li:last").children("input[name=routePoint]").val(point);
				$("#routePoint>li:last").append("<input type='hidden' name='region' value='"+json.address_name+"'/>");
			}else{ // 경유지 지정일 때 총 갯수 확인
				var cnt = $("#routePoint").children("li").length;
				console.log(cnt);
				// 5개 이상일 때 오류 메세지 출력
				if( cnt >= 7 ){
					toast("경유지는 5개까지만 설정 가능합니다.");
					return false;
				}else{ // 경유지에 남은 자리가 있을 경우 추가 가능
					var viaTag = "<li class='tab_liTag ui-sortable-handle'><input type='text' value='"+json.place_name+"' readonly/>";
						viaTag += "<input type='hidden' name='routePoint' value='"+point+"'/>"
						viaTag += "<input type='hidden' name='region' value='"+json.address_name+"'/></li>";
					$("#routePoint>li:last").before(viaTag);
				}
			}
		} // 중복이 있을 경우 추가 액션 없음
		setDeleteBtn();
		setRouteMarker();

	}
	
// 경유지 리스트에만 삭제 버튼 추가하기
	function setDeleteBtn(){
		var cnt = $("#routePoint").children("li").length ;
		var tag = "<button class='listDel_Btn' onclick='$(this).parent().remove();setRouteMarker();'><img id='listDel_img' src='/home/img/img_route/listDelBtn.png'/></button>";
		$("#routePoint>li").children("button").remove();
		for (var i = 0 ; i < cnt ; i ++){
			if( i > 0 && i < cnt-1){
				$("#routePoint>li").eq(i).append(tag);
			}
		}
	}
	
// 루트 첫번째 마지막 li에만 start arrivebox 태그 넣기
	function setStartArriveClass(){
		for (var i = 0 ; i < $("#routePoint>li").length; i++){
			var obj = $("#routePoint>li").eq(i).children("input[type=text]");
			if(i == 0){
				obj.removeClass();
				obj.addClass('startBox');
				obj.attr("placeholder","출발지를 지정하세요");
			}else if(i > 0 && i < $("#routePoint>li").length-1){
				obj.removeClass();
				obj.attr("placeholder","");
			}else{
				obj.removeClass();
				obj.addClass('arriveBox');
				obj.attr("placeholder","도착지를 지정하세요");
			}
		}
	}

// 루트 마커 세팅하기 
// 여러 이벤트에 대응하기 위해 펑션 자체에서 경로 포인트의 좌표를 읽어와서 설정하도록
	function setRouteMarker(){
		
		// 마커 지정할 좌표 순서대로 입력
		var routePosition = [];
		$("input[name=routePoint]").each(function(){
			var points = $(this).val().split("/");
			var p = new kakao.maps.LatLng(points[1], points[0]);
			routePosition.push(p);
		});
		
		// 기존 경로 마커 삭제
		removeMarker(routeMarker);
		
		// 경로 마커 만들기
		for(var i = 0 ; i < routePosition.length ; i++){
			// 기본 마커 이미지는 경유 / 첫번째 좌표는 출발 마커 / 마지막 좌표는 도착 마커 배당
			var markerImage = viaImage;
			if(i == 0) { markerImage = startImage; }
			else if(i == routePosition.length-1 ) {markerImage = arriveImage;}
		
			var marker = new kakao.maps.Marker({
				position : routePosition[i]
				, image : markerImage
			});
			
			marker.setMap(map);
			routeMarker.push(marker);
		}
		
		if($("input[name=routePoint]:first").val() != "" && $("input[name=routePoint]:last").val() != ""){
			searchRoute();
		}
	}

// 카테고리 새로 설정하기
	function selectCategory(){
		var url = "/home/selectCategory";
		var tag = "";
		
		$.ajax({
			url : url,
			success : function(result){
				var cnt = 0;
				// 카테고리 리스트 추가
				$.each(result, function(index, value){
					tag += "<option value='"+value.noroutecate+"' title='"+ value.catename+"'>"+value.catename+"</option>";
					cnt++;
				});
				
				// 카테고리 5개 미만일 시 추가하는 옵션 추가
				if(cnt<5){
					tag+= "<option value='addCategory'>카테고리 추가</option>";
				}
				
				$("#catename").html(tag);
			},error : function(){
				toast("카테고리 호출 에러");
			}
		});
	}
	

///////      길 찾기        ///////////////////////////////////////
	
	var coordinates = "";  // 검색할 위치 정보
	var preference = ""; // 검색 타입 // "shortest" "recommended"
	var radiuses = ""; // 반경 -1 로 위치 정보 숫자만틈 세팅
	
	var data = ""; // 리턴 받을 데이터 
	
	var encodeGeo = "";
	
	var points = [];  // 고저도 그리기용 / lat lng ele
	
	// 출발지 경유지 도착지 y x 가져올 것
	
	function searchRoute(){
		if($("#routePoint>li:first").children("input[type=text]").val() == "" || $("#routePoint>li:last").children("input[type=text]").val() == ""){
			toast("경로를 검색할 위치를 입력하세요.");
			return false;
		}
	
		// 1. 경로 정보 가져오기
		
		// 화면 범위 초기화
		bounds = new kakao.maps.LatLngBounds();
		
		// 경로 검색할 좌표 설정하기
		preference = $("select[name=preference]").val();
		console.log(preference);
		coordinates = "[";
		radiuses = "[";
		var cnt = $("input[name=routePoint]").length;
		for(var i = 0 ; i < cnt ; i++){
			var points = $("input[name=routePoint]").eq(i).val().split("/"); 
			var p = "["+points[0]+","+ points[1]+"]"; // 경로 좌표 재설정
			var bound = new kakao.maps.LatLng(points[1], points[0]); // 지도 범위 좌표 재설정
			if ( i < cnt-1){
				coordinates += p+",";
				radiuses += "500,";
			} else{
				coordinates += p +"]";
				radiuses += "500"+"]";
			}
			bounds.extend(bound);
		};
		// 화면 범위 재설정
		map.setBounds(bounds);

		// 2. 경로 정보 검색 후 데이터 반환
			// 데이터 세팅 // coordinates preference radiuses
			//[[126.935316109263,37.5537457619471],[126.992123140096,37.5338817636524]]
			//"preference":"recommended" /"shortest" / ,"radiuses":[-1,-1]		
		var body = '{"coordinates":'+coordinates+',';
	  		body += '"attributes":["avgspeed","percentage","detourfactor"],"elevation":"true","geometry_simplify":"false",';
	     	body += '"maneuvers":"true","preference":"'+preference+'","radiuses":'+radiuses+',"units":"km","geometry":"true"}';
		
		// 3. 루트 검색 요청
		let request = new XMLHttpRequest();	
		//	리퀘스트 타입															/// 경로 검색 다른 타입도 추가할 지 고민해봄
		request.open('POST', "https://api.openrouteservice.org/v2/directions/cycling-regular");
		
		request.setRequestHeader('Accept', 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8');
		request.setRequestHeader('Content-Type', 'application/json');
		request.setRequestHeader('Authorization', '5b3ce3597851110001cf62483a51dabd7ec34a519a6a93992fe61ea7');
		
		request.onreadystatechange = function (){
		  if (this.readyState === 4) {
		    //console.log('Status:', this.status);
		    //console.log('Headers:', this.getAllResponseHeaders());
		    //console.log('Body:', this.responseText);
		    
		    data = this.responseText;
		    
		    var routeFinding = JSON.parse(data);
		    var route = routeFinding.routes;
		    
		    points = decode(route[0].geometry, true);
		    setRouteLine(points);
		    
		    geocode = route[0].geometry;
		    
		    $("#distance").text(route[0].summary.distance.toFixed(2));
		    $("#ascent").text(route[0].summary.ascent);
		    $("#descent").text(route[0].summary.descent);
		    
		  }
		};
		
		request.send(body);
	}
	
	// 3. geometry 해석하기
  	function decode(encodedPolyline, includeElevation){
	    // array that holds the points
	    let points = []
	    let index = 0
	    const len = encodedPolyline.length
	    let lat = 0
	    let lng = 0
	    let ele = 0
	    while (index < len) {
	      let b
	      let shift = 0
	      let result = 0
	      do {
	        b = encodedPolyline.charAt(index++).charCodeAt(0) - 63 // finds ascii
	        // and subtract it by 63
	        result |= (b & 0x1f) << shift
	        shift += 5
	      } while (b >= 0x20)
	
	      lat += ((result & 1) !== 0 ? ~(result >> 1) : (result >> 1))
	      shift = 0
	      result = 0
	      do {
	        b = encodedPolyline.charAt(index++).charCodeAt(0) - 63
	        result |= (b & 0x1f) << shift
	        shift += 5
	      } while (b >= 0x20)
	      lng += ((result & 1) !== 0 ? ~(result >> 1) : (result >> 1))
	
	      if (includeElevation) {
	        shift = 0
	        result = 0
	        do {
	          b = encodedPolyline.charAt(index++).charCodeAt(0) - 63
	          result |= (b & 0x1f) << shift
	          shift += 5
	        } while (b >= 0x20)
	        ele += ((result & 1) !== 0 ? ~(result >> 1) : (result >> 1))
	      }
	      try {
	        let location = [(lat / 1E5), (lng / 1E5)]
	        if (includeElevation) location.push((ele / 100))
	        points.push(location)
	      } catch (e) {
	        console.log(e)
	      }
	    }
	    return points
  	}
    
    
    // 4. 경로 객체 생성하기
    var polyline = "";
    var linePath = [];
    // Load the Visualization API and the columnchart package.
    google.load("visualization", "1", { packages: ["columnchart"] });

    function setRouteLine(points){
    
    	// 기존에 경로 객체가 있을 경우, 맵 상에서 지우기
    	if(polyline != "") {
    		polyline.setMap(null);
		}
    	
    	linePath = [];
    	// 좌표 정보를 바탕으로 경로 배열 입력하기
    	$.each(points, function(index, v){
    		var p = new kakao.maps.LatLng(v[0], v[1]);
    		linePath.push(p);
    	});
    	
    	// 경로 객체 생성
	    polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 6, // 선의 두께 입니다
						    strokeColor: '#FF0162', // 선의 색깔입니다
						    strokeOpacity: 0.6, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
		});
		
		// 지도 위에 세팅!
		polyline.setMap(map);
		removeMarker(markers);
		
		// 경로 정보 제공
				
		
        // Create an ElevationService.
        const elevator = new google.maps.ElevationService();
        
        // 고저도 그릴 경로 세팅
        var path =[];
        $.each(points, function(idx, v){
        	var p = new google.maps.LatLng(v[0], v[1]);
        	path.push(p);
        });
        
        // Draw the path, using the Visualization API and the Elevation service.
        elevator.getElevationAlongPath(
          {
            path: path,
            samples: 256,
          },
          plotElevation
        );
		
	}
		
	// 경로 차트 그리기
  // Takes an array of ElevationResult objects, draws the path on the map
  // and plots the elevation profile on a Visualization API ColumnChart.
  function plotElevation(elevations, status) {
    const chartDiv = document.getElementById("elevation_chart");

    if (status !== "OK") {
      // Show the error code inside the chartDiv.
      chartDiv.innerHTML =
        "Cannot show elevation: request failed because " + status;
      return;
    }
    // Create a new chart in the elevation_chart DIV.
    const chart = new google.visualization.ColumnChart(chartDiv);
    // Extract the data from which to populate the chart.
    // Because the samples are equidistant, the 'Sample'
    // column here does double duty as distance along the
    // X axis.
    const data = new google.visualization.DataTable();
    data.addColumn("string", "Sample");
    data.addColumn("number", "Elevation");

    for (let i = 0; i < elevations.length; i++) {
      data.addRow(["", elevations[i].elevation]);
    }
    // Draw the chart using the data within its DIV.
    chart.draw(data, {
     width : $("#elevation_chart").width(),
     height: $("#elevation_chart").height(),
     legend: "none",
	 titleY: "Elevation (m)",
      colors:["#ffb437"],
    });
  }
    
	function changeStartArrive(){
		$("#routePoint").prepend($("#routePoint>li:last"));
		$("#routePoint").append($("#routePoint>li:eq(1)"));
		setRouteMarker();
	}
	
	function clearRoute(){
		$("#routePoint>li").children("button").trigger("click");
		$("#routePoint>li").children("input").attr("value", "");
		
		$("#pannel3 button").trigger("click");
		
		if(routeMarker != null){
			removeMarker(routeMarker);
		}
		
		// 기존에 경로 객체가 있을 경우, 맵 상에서 지우기
    	if(polyline != "") {
    		polyline.setMap(null);
    		geocode = "";
		}
		
		// 경로데이터 지우기
		if($("#elevation_chart").children() != null){
			$("#elevation_chart").children().remove();
		}
		
		$("#distance").text("");
		$("#ascent").text("");
		$("#descent").text("");	
		
		$("#title").val("");
		$("#description").val("");
	}
	
	function getRegion(){
		var result ="";
		
		var array = $("#routePoint>li").children("input[name=region]:first").val().split(" ");
		result += array[0]+"/"+array[1]+"/";
		
		array = $("#routePoint>li").children("input[name=region]:last").val().split(" ");
		result += array[0]+"/"+array[1]+"/";
			
		return result;
	}