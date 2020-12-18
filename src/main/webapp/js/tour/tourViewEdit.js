$(function(){
 	CKEDITOR.replace('content',{
		height:600
		,width:1200
		,extraPlugins: 'easyimage',
	    cloudServices_tokenUrl: 'https://76760.cke-cs.com/token/dev/fb98221c99f6d4fccf45b51c839a7d022ad90ab2f9dfbc25f02ecdc03d98',
	    cloudServices_uploadUrl: 'https://76760.cke-cs.com/easyimage/upload/'
	}); 
  
	
	$("#tourEditForm").submit(function(){
		CKEDITOR.instances.content.updateElement();		
		
		if($("#tourWriteTitleEdit").val()==""){
			toast("제목을 입력하세요.");
			$("#tourWriteTitleEdit").focus();
			return false;		
		}
		
	 	if(CKEDITOR.instances.content.getData()==""){
			toast("글내용을 입력하세요.");
			$("#content").focus();
			return false;
		}
	 	
		var url = "/home/tourEditFormOk";
		var params = "noboard="+$("#noboard").val()+"&userid="+$("#userid").val()+"&title="+$("#tourWriteTitleEdit").val()+"&content="+CKEDITOR.instances.content.getData();
		
		console.log(params);
		
		$.ajax({
			type : 'POST',
			url : url,
			data : params,
			success : function(result){
				if(result>0){
					toast("글이 수정되었습니다.");
					location.href="/home/tourView?noboard="+$("#noboard").val();
				}else{
					toast("글수정이 실패하였습니다.");
				}
			},error:function(){
				console.log("글쓰기 오류");
			}
		});
		return false;
	});
});

//////// 지도용 변수
var routeMarker = [];
var container ;
var options = {
		center : new kakao.maps.LatLng(37.5510907243016, 126.937364458741),
		draggable: false,
		level : 3
};
var routePosition = [];
var bounds = new kakao.maps.LatLngBounds();
// 루트 표시 마커 생성
var markerStart ;
var markerVia ;
var markerArrive ;
// 마커 이미지 미리 생성
var markerSize = new kakao.maps.Size(46, 46); // 출발 마커이미지의 크기입니다
var markerOption = {offset: new kakao.maps.Point(21, 50)}; // 출발 마커이미지에서 마커의 좌표에 일치시킬 좌표를 설정합니다 (기본값은 이미지의 가운데 아래입니다)  
// 루트 마커 이미지를 생성합니다
var startImage = new kakao.maps.MarkerImage('./img/img_route/markerStart.png', markerSize, markerOption);
var arriveImage = new kakao.maps.MarkerImage('./img/img_route/markerArrive.png', markerSize, markerOption);
var viaImage = new kakao.maps.MarkerImage('./img/img_route/markerVia.png', markerSize, markerOption);
// 지도 추가
var map ;

$(function(){
	
	container = document.getElementById("routeMap");
	map = new kakao.maps.Map(container, options);
	getTourTime();
	
	var genderCnt = 0 ;
	$(".reggender").each(function(){
		if($(this).attr('title') != null){
			$(this).css('color','white').css('background-color','rgb(0,176,176)');
			genderCnt++;
		}
		if(genderCnt == 2) {
			$("#whole").css('color','white').css('background-color','rgb(0,176,176)');
		}
	});
	var ageCnt = 0 ;
	$(".regage").each(function(){
		if($(this).attr('title') != null){
			$(this).css('color','white').css('background-color','rgb(0,176,176)');
			ageCnt++;
		}
		if(ageCnt == 5) {
			$("#whole2").css('color','white').css('background-color','rgb(0,176,176)');
		}
	});
	
	setMapData();
	
	
	//////////////////////////// 이벤트 /////////////////////////
	
});

function getTourTime(){
	var distance =$("#distance").text();
	var speed = $("#speed").text();
	 
	if(speed > 0 ){
		
		var time = Math.floor(distance/speed);	 
		var minute = Math.floor((distance/speed - time)*60);
		 
		if(minute.toString().length == 1){
			minuteTxt = "0"+minute;
		}else{
			minuteTxt = ""+minute;
		}
		 
		var second =  Math.floor(((distance/speed - time)*60 - minute)*60);
		 
		if(second.toString().length == 1){
			secondTxt = "0"+second;
		}else{
			secondTxt = ""+second;
		}
		
		var timeTxt = time +":" + minuteTxt+ ":" + secondTxt;
		console.log(timeTxt);
		$("#tourtime").text(timeTxt);
	}
}

//맵 세팅하기
function setMapData(){
	var data = "noboard="+$("#reference").val();
	var url = "/home/setMap";
	
	$.ajax({
		url : url,
		data : data,
		success : function(result){
			setMap(result);
		},error : function(){
			console.log("레퍼런스 맵 호출 에러" );
		}
	});
	
}
function getRoutePoint(point){
	var points = point.replace("[/]","/").split("/");
	var p = new kakao.maps.LatLng(points[2], points[1]);
	routePosition.push(p);
	bounds.extend(p);
}
function setMap(result){
	
	var titleTag = "<a href='/home/routeSearchView?noboard="+result.noboard+"'>"+result.title+"</a>";
	$("#routeTitle").html(titleTag);
	
	routePosition = [];
	bounds = new kakao.maps.LatLngBounds();
	
	// 기존 경로 마커 삭제
	removeMarker(routeMarker);
	
	// 루트 마커 세팅하기 
	// 마커 지정할 좌표 순서대로 입력
	var routeData = result.noboard;
	
	// 경로 위치 저장
	getRoutePoint(result.routepoint1);
	getRoutePoint(result.routepoint2);
	if(result.routepoint3 != null ) {getRoutePoint(result.routepoint3)}
	if(result.routepoint4 != null ) {getRoutePoint(result.routepoint4)}
	if(result.routepoint5 != null ) {getRoutePoint(result.routepoint5)}
	if(result.routepoint6 != null ) {getRoutePoint(result.routepoint6)}
	if(result.routepoint7 != null ) {getRoutePoint(result.routepoint7)}
		
	var points = decode(result.geocode, true);
	setRouteLine(points);
	
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
	
	// 경로 지도 범위에 포함 시키기
	var polylineArray = result.polyline.replaceAll("),(","||").replace("(","").replace(")","").replaceAll("||",",").split(",");
	for ( var k = 0 ; k < polylineArray.length ; k+=2){
		var p = new kakao.maps.LatLng(polylineArray[k], polylineArray[k+1]);
		bounds.extend(p);
	}
	
	map.setBounds(bounds);
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
	    return points;
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
//기존에 표시한 마커 제거
function removeMarker(markerGroup){
	for(var i = 0; i<markerGroup.length; i++){
		markerGroup[i].setMap(null);
	}
	markerGroup =[];
}
