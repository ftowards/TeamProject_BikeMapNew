// 1. 지도 만들기
	var markers = [];
	var routeMarker = [];
	
	var foodMarker = [],
		sightsMarker = [],
		accommodationMarker = [],
		convenientMarker = [];
	
	var container = document.getElementById("map");
	var options = {
			center : new kakao.maps.LatLng(37.5510907243016, 126.937364458741),
			draggable: false,
			level : 3
	};
	var bounds = new kakao.maps.LatLngBounds();
	
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
	var arriveImage = new kakao.maps.MarkerImage('./img/img_route/markerArrive.png', markerSize, markerOption);
	var viaImage = new kakao.maps.MarkerImage('./img/img_route/markerVia.png', markerSize, markerOption);
	
	// 장소 마커 이미지 생성
	var foodImage = new kakao.maps.MarkerImage('./img/img_route/markerFood.png', markerSize, markerOption);
	var sightsImage = new kakao.maps.MarkerImage('./img/img_route/markerSights.png', markerSize, markerOption);
	var accomImage = new kakao.maps.MarkerImage('./img/img_route/markerAccom.png', markerSize, markerOption);
	var conveImage = new kakao.maps.MarkerImage('./img/img_route/markerConve.png', markerSize, markerOption);
	
	// 지도 추가
	var map = new kakao.maps.Map(container, options);
	var infowindow = new kakao.maps.InfoWindow({zIndex:1, removable : true});
	
/////////////////// 기본 데이터 세팅 /////////////////
$(function(){

	// 루트 마커 세팅하기 
	// 마커 지정할 좌표 순서대로 입력
	var routePosition = [];
	$("input[name=routePoint]").each(function(){
		var points = $(this).val().split("/");
		var p = new kakao.maps.LatLng(points[1], points[0]);
		routePosition.push(p);
		bounds.extend(p);
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
	
	var points = decode($("#geocode").val(), true);
	setRouteLine(points);
	
	// 장소 마커 만들기
	for(var idx = 1 ; idx <= 4 ; idx++){
		if(idx == 1){
			selector = "input[name=foodList]";
			markerImage = foodImage;
		}else if(idx == 2){
			selector = "input[name=sightsList]";
			markerImage = sightsImage;
		}else if(idx == 3){
			selector = "input[name=accommodationList]";
			markerImage = accomImage;
		}else if(idx == 4){
			selector = "input[name=convenientList]";
			markerImage = conveImage;
		}
		
		var routePosition = [];
		$(selector).each(function(){
			var array = $(this).val().split("/");
			var p = new kakao.maps.LatLng(array[1], array[0]);
			
			console.log(p);
			bounds.extend(p);
			routePosition.push(p);
		});
		
		for(var i = 0 ; i < routePosition.length ; i++){
			var marker = new kakao.maps.Marker({
				position : routePosition[i]
				, image : markerImage
				
			});
			
			if(idx == 1){foodMarker.push(marker);}
			else if(idx == 2){sightsMarker.push(marker);}
			else if(idx == 3){accommodationMarker.push(marker);}
			else if(idx == 4){convenientMarker.push(marker);}
		}
	}
	
	// 경로 지도 범위에 포함 시키기
	var polylineArray = $("#polyline").val().replaceAll("),(","||").replace("(","").replace(")","").replaceAll("||",",").split(",");
	for ( var k = 0 ; k < polylineArray.length ; k+=2){
		var p = new kakao.maps.LatLng(polylineArray[k], polylineArray[k+1]);
		bounds.extend(p);
	}
	
	map.setBounds(bounds);
	
	
	$("#routeCollect").on('click',function(){
		// 로그인 상태가 아닐 때 로그인 팝업 띄우기
		var logId = $("#replyUseridDiv").text();
		if(logId == ""){
			window.open("/home/loginPopup","Bikemap Login","width=600px, height=200px, left =200px, top=200px");
			return false;
		}
	
 		window.open("/home/routeCollect","Bikemap","width=400px, height=200px, left =300px, top=300px");
 	});
});
/////////////////// event //////////////////////////

// 장소 마커 표시 -- 푸드
$("input[name=foodMarker]").on("change",function(){
	if($(this).prop("checked")){
		setPlaceMarker(foodMarker);
	}else{
		removeMarker(foodMarker);
	}
});

// 장소 마커 표시 -- 관광지
$("input[name=sightsMarker]").on("change",function(){
	if($(this).prop("checked")){
		setPlaceMarker(sightsMarker);
	}else{
		removeMarker(sightsMarker);
	}
});

// 장소 마커 표시 -- 숙박
$("input[name=accommodationMarker]").on("change",function(){
	if($(this).prop("checked")){
		setPlaceMarker(accommodationMarker);
	}else{
		removeMarker(accommodationMarker);
	}
});

// 장소 마커 표시 -- 편의시설
$("input[name=convenientMarker]").on("change",function(){
	if($(this).prop("checked")){
		setPlaceMarker(convenientMarker);
	}else{
		removeMarker(convenientMarker);
	}
});

////// 평점 주기
$("#grayBtn").on('click', function(){
	
	// 로그인 상태가 아닐 때 로그인 팝업 띄우기
	var logId = $("#replyUseridDiv").text();
	if(logId == ""){
		window.open("/home/loginPopup","Bikemap Login","width=600px, height=200px, left =200px, top=200px");
		return false;
	}
	
	if($("#logId").val() == $("#userid").text()){
		alert("회원님이 작성한 루트는 평가할 수 없습니다.");
		return false;
	}

  	var rating = $("#gradeSelect").val();
  	
  	if(rating == ""){
  		alert("평점을 선택해주세요.");
  		return false;
  	}
  	
  	var url = "/home/rateRoute";
  	var data = "noboard="+$("#noboard").val();
  		data += "&rating="+rating;
  		
  	$.ajax({
  		type : 'POST',
  		url : url,
  		data : data,
  		success : function(result){
  			if(result == 2){
  				alert("이미 평점을 등록한 루트입니다.");
  			}else {
  				alert("평점이 등록되었습니다.");
  				setRating();
  			}
  		},error : function(){
  			console.log("평점 입력 오류");
  		}
  	});
});


/////////////////// function //////////////////////

// 기존에 표시한 마커 제거
	function removeMarker(markerGroup){
		for(var i = 0; i<markerGroup.length; i++){
			markerGroup[i].setMap(null);
		}
		markerGroup =[];
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


// 장소 마커 설정하기
	function setPlaceMarker(markers){		
		for(var i = 0 ; i < markers.length ; i++){
			markers[i].setMap(map);
		}
	}
	
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
	
	// geometry 해석하기
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
    
    
    // 경로 객체 생성하기
    var polyline = "";
    // Load the Visualization API and the columnchart package.
    google.load("visualization", "1", { packages: ["columnchart"] });

    function setRouteLine(points){
    
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
						    strokeColor: '#FF0162', // 선의 색깔입니다
						    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
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
    });
  }
  
  // 평점 부여 후 변경
  function setRating(){
  	var url = "/home/selectRouteRating";
  	var data = "noboard="+$("#noboard").val();
  	
  	$.ajax({
  		type : 'POST',
  		url : url,
  		data : data,
  		success : function(result){
  			$("#starLbl").text(result.rating);
  			$("#starLbl").next().text("("+result.ratecnt+")");
  		},error : function(){
  			console.log("평점 호출 에러");
  		}
  	});
  }