// 1. 지도 만들기
	var markers = [];
	var container = document.getElementById("map");
	var options = {
			center : new kakao.maps.LatLng(37.5510907243016, 126.937364458741),
			level : 3,
			draggable : 'true',
			
	};
	
	// 지도 추가
	var map = new kakao.maps.Map(container, options);
	var infowindow = new kakao.maps.InfoWindow({zIndex:1, removable : true});
	
	// 지도 컨트롤러 추가
	var mapTypeControl = new kakao.maps.MapTypeControl();
	var zoomControl = new kakao.maps.ZoomControl();
	
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
	map.addControl(zoomControl, kakao.maps.ControlPosition.Right);

// 검색을 위한 장소 객체 생성
	var ps = new kakao.maps.services.Places();
	
	// 검색 버튼 클릭 시 키워드 검색 실시
	$("#searchWord").on("keydown", function(){
		if(event.keyCode == 13){
			var keyword = $("#searchWord").val();
			if(keyword == ""){
				alert("검색어를 입력하세요.");
				return false;
			}
			ps.keywordSearch(keyword, placeSearchCB, {size: 10});
		}
	});

// 장소 검색 결과값 처리
	function placeSearchCB(data, status, pagination){
		if(status === kakao.maps.services.Status.OK){
					
			// 리스트 표시
			displayPlaces(data);
			// 페이지 번호 표시
			displayPagination(pagination);
			
		}else if(status === kakao.maps.services.Status.ZERO_RESULT){
			alert("검색 결과가 존재하지 않습니다.");
			return ;
		}else if(satus === kakao.maps.services.Statuas.ERROR){
			alert("검색 결과 중 오류가 발생했습니다.");
			return;
		}
	};

// 검색 결과 표시
	function displayPlaces(places){
		var listEl = document.getElementById("placesList");
		var menuEl = document.getElementById("searchPannel");
		var fragment = document.createDocumentFragment();
		var bounds = new kakao.maps.LatLngBounds();
		var listStr = '';
		
		// 기존 검색 결과 제거
		removeAllChildNods(listEl);
		
		// 기존에 표시된 마커 제거
		removeMarker();
		
		for(var i = 0; i<places.length ; i++){
			
			// 마커 생성 표시
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x);
			var marker = addMarker(placePosition, i);
			var itemEl = getListItem(i, places[i]); 
			
			// 지도 위치 수정을 위한 좌표 취합
			bounds.extend(new kakao.maps.LatLng(places[i].y, places[i].x));
			
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
					  '<div class="info">' + '<h5>'+places.place_name + '</h5>';
					  
		if(places.road_address_name){
			itemStr += '<span>'+places.road_address_name + '</span>'+
						'<span class="jibun gray">' + places.address_name + '</span>';
		}else{
			itemStr += '<span>'+places.address_name + '</span>';
		}
		
		itemStr +='<span class="tel">'+places.phone + '</span></div>';
		
		el.innerHTML = itemStr;
		el.className = 'item';
		
		return el;
	}

// 마커 생성 후 지도에 표시
	function addMarker(position, idx, title){
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
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
	function removeMarker(){
		for(var i = 0; i<markers.length; i++){
			markers[i].setMap(null);
		}
		markers =[];
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
		var content = '<div style="padding:5px; font-size:12px;">';
		
		// 인포 윈도우 이름에 링크 설정
		if(places.place_url){
			content += '<a href= "'+places.place_url+'" target="_blank">' + places.place_name + '</a><hr/><ul>';	
		}else{
			content += places.place_name + '<hr/><ul>';
		}
		
		content += "<button onclick='setRoutePoint(value, title)' title='startPoint' value='"+place+"'>출발지 저장</button>";
		content += "<li onclick='console.log(11)'>경유지 지정</li>";
		content += "<button onclick='setRoutePoint(value, title)' title='arrivePoint' value='"+place+"'>도착지 저장</button>";
		
		// 카테고리 추가 버튼 생성
		if(group == 'FD6' || group =='CE7'){
			content += "<hr><button onclick='setPlaceList(value, title)' title='foodList' value='"+place+"'>음식점 저장</button>";
		}else if(group == 'CT1' || group =='AT4'){
			content += "<hr><button onclick='setPlaceList(value, title)' title='sightsList' value='"+place+"'>관광지 저장</button>";
		}else if(group == 'AD5'){
			content += "<hr><button onclick='setPlaceList(value, title)' title='accomodationList' value='"+place+"'>숙박시설 저장</button>";
		}else if(group == 'CS2' || group == 'PK6' ||group == 'SW8' ||group == 'BK9' ||group == 'HP8' ||group == 'PM9'){
			content += "<hr><button onclick='setPlaceList(value, title)' title='convenientList' value='"+place+"'>편의시설 저장</button>";
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
			console.log('checked');
			map.addOverlayMapTypeId(mapType);
		}else{
			console.log('Unchecked');
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
		}else{
			$("#"+type).css("display", "block");
		}
	}	
	

// 출발지 지정
	function setRoutePoint(value, type){
		// value = 장소 정보(string 타입으로 변환한 것)
		// type = 출발지 startPoint / 경유지 viaPoint / 도착지 arrivePoint
		var json = JSON.parse(value);
		
		// 위치 데이터 추출
		var point = "["+json.x+","+json.y+"]";
		
		console.log(value);
		console.log(json.address_name);
		
		// 출발지나 도착지 선택일 경우 원래 칸에 hidden 타입으로 입력
		if(type == 'startPoint' || type == 'arrivePoint'){
			$("#"+type).children("input[type=text]").val(json.place_name);
			$("#"+type).children("input[type=hidden]").val(point);
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
					alert("이미 등록된 장소입니다.");
					overlap++;
					return false;
				}
			});
			
			// 리스트에 여유가 있고, 먼저 등록이 되지 않았을 경우 새로운 리스트 작성
			if(overlap == 0){
				newList += "<li title='"+json.id+"'><a href='"+json.place_url+"' target='_blank'><input type='text' value='"+json.place_name+"'/></a>";
				newList += "<input type='hidden' value='"+value+"'/><button onclick='$(this).parent().remove();'>-</button></li>";
			}else{
				return false;
			}
		} else{
			alert("장소는 코스당 종류 별로 최대 5개 등록이 가능합니다.");
			return false;
		}
		$("#"+type).append(newList);
	}


// 저장하기 

// 카테고리 추가
	$("#catename").on('change',function(){
		if($(this).val() == 'addCategory'){
			var catename = prompt("새 카테고리 이름을 입력하세요.", "새 코스");
			var overlap = 0;
			
			// 카테고리 추가 시 중복 확인
			$("#catename").children("option").each(function(){
				var names = $(this).attr("title");
				console.log(names);
				if(names == catename){
					alert("이미 등록된 이름입니다.");
					overlap++;
					return false;
				}
			});
			
			// 중복이 없다면 비동기식으로 새로운 카테고리 추가
			if(overlap ==0){
				var url = "<%=request.getContextPath()%>/insertCategory";
				var data = "catename="+catename;
	
				$.ajax({
					url : url,
					data : data,
					success : function(result){
						if(result == 1){
							alert("새로운 카테고리가 추가되었습니다.");
							selectCategory();
						}else{
							alert("카테고리 추가 에러");
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

// 카테고리 새로 설정하기
	function selectCategory(){
		var url = "<%=request.getContextPath()%>/selectCategory";
		var tag = "";
		
		$.ajax({
			url : url,
			success : function(result){
				var cnt = 0;
				// 카테고리 리스트 추가
				$.each(result, function(index, value){
					tag += "<option value='"+value.nocoursecate+"' title='"+ value.catename+"'>"+value.catename+"</option>";
					cnt++;
				});
				
				// 카테고리 5개 미만일 시 추가하는 옵션 추가
				if(cnt<5){
					tag+= "<option value='addCategory'>카테고리 추가</option>";
				}
				
				$("#catename").html(tag);
			},error : function(){
				alert("카테고리 호출 에러");
			}
		});
	}
	

///////      길 찾기        ///////////////////////////////////////
	
	var coordinates = "";  // 검색할 위치 정보
	var preference = "recommended"; // 검색 타입 // "shortest" "recommended"
	var radiuses = ""; // 반경 -1 로 위치 정보 숫자만틈 세팅
	
	var data = ""; // 리턴 받을 데이터 
	
	var encodeGeo = "";
	
	var points = [];  // 고저도 그리기용 / lat lng ele
	var geometry = []; // 경로 그리기 용 / lat lng
	
	// 출발지 경유지 도착지 y x 가져올 것
	
	function searchRoute(){
		// 1. 경로 정보 가져오기
		var startPoint = $("input[name=startPoint]").val();
		var arrivePoint = $("input[name=arrivePoint]").val();
		
		coordinates = "["+startPoint+","+arrivePoint+"]";
		radiuses = "[50,50]";
		
		console.log(coordinates);


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
		    console.log('Status:', this.status);
		    console.log('Headers:', this.getAllResponseHeaders());
		    console.log('Body:', this.responseText);
		    
		    data = this.responseText;
		    
		    var routeFinding = JSON.parse(data);
		    var route = routeFinding.routes;
		    
		    geometry = decode(route[0].geometry, false);
		    points = decode(route[0].geometry, true);
		    
		    $.each(points, function(index, v){
		    	console.log("위치 " + index + " >> " + v);
		    });
		    
		    $.each(points, function(index, v){
		    	console.log("위치+고도 " + index + " >> " + v);
		    });
		    
		    setRouteLine();
		  }
		};
		
			// *** api 세팅
		    
		    // 필요한 데이터
		    // 1. summary
		    
		    //var routeFinding = JSON.parse(data);
		    //var route = routeFinding.routes;
		    //console.log(route[0].summary);
		    
		    // 2. geometry 
		    //console.log(route[0].geometry);
		    //decode(route[0].geometry, true); 
		    
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
    function setRouteLine(){
    
    	// 기존에 경로 객체가 있을 경우, 맵 상에서 지우기
    	if(polyline != "") {
    		polyline.setMap(null);
		}
    	
    	var linePath = [];
    	// 좌표 정보를 바탕으로 경로 배열 입력하기
    	$.each(points, function(index, v){
    		var p = new kakao.maps.LatLng(v[0], v[1]);
    		linePath.push(p);
    	});
    	
    	// 경로 객체 생성
	    polyline = new kakao.maps.Polyline({
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 5, // 선의 두께 입니다
						    strokeColor: '#00B0B0', // 선의 색깔입니다
						    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
		});
		
		// 지도 위에 세팅!
		polyline.setMap(map);
	}

