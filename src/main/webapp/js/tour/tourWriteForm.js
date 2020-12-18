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



$(function(){

	container = document.getElementById("routeMap");
	
	// 투어 모집 링크 타고 들어왔을 때 처리
	
	if($("#reference").val() != null && $("#reference").val() >0){
		setReference($("#reference").val());
	}
	
	
	$("#reggender").on('change', function(){
		if($(this).is(":checked")){
			$("#whole").css('color','rgb(10, 150, 150)').css('background-color','rgb(166, 234, 234)');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if(!($("input[name=reggender]").eq(i).prop("checked"))){
					$("input[name=reggender]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole").css('color','rgb(90,90,90)').css('background-color','#fff');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if($("input[name=reggender]").eq(i).prop("checked")){
					$("input[name=reggender]").eq(i).trigger('click');
				
				}
			}
		}
	});
	
	$("input[name=reggender]").on('change', function(){
		var type = $(this).attr("id");
		if($(this).prop("checked")){
			$("#gender"+type).css('color','rgb(10, 150, 150)').css('background-color','rgb(166, 234, 234)');
		}else{
			$("#gender"+type).css('color','rgb(90,90,90)').css('background-color','#fff');
		}
		
		var cnt = 0;
		if($("#reggender").prop("checked")){
			$("input[name=reggender]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt < 2) {
				$("#reggender").prop("checked", false);
				$("#whole").css('color','rgb(90,90,90)').css('background-color','#fff');
			}
		}else if(!$("#reggender").prop("checked")) {
			$("input[name=reggender]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt == 2) {
				$("#reggender").prop("checked", true);
				$("#whole").css('color','rgb(10, 150, 150)').css('background-color','rgb(166, 234, 234)');
			}
		}
	});
	
	

	$("#regage").on('change',function(){
		if($(this).is(":checked")){
			$("#whole2").css('color','rgb(10, 150, 150)').css('background-color','rgb(166, 234, 234)');
			for(var i = 0; i < $("input[name=regage]").length ; i++){
				if(!($("input[name=regage]").eq(i).prop("checked"))){
					$("input[name=regage]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole2").css('color','rgb(90,90,90)').css('background-color','#fff');
			for(var i = 0 ; i < $("input[name=regage]").length ; i++){
				if($("input[name=regage]").eq(i).prop("checked")){
					$("input[name=regage]").eq(i).trigger('click');
				}
			}
		}
	});
	$("input[name=regage]").on('change', function(){
		var type = $(this).attr("id");
		if($(this).prop("checked")){
			$("#regage"+type).css('color','rgb(10, 150, 150)').css('background-color','rgb(166, 234, 234)');
		}else{
			$("#regage"+type).css('color','rgb(90,90,90)').css('background-color','#fff');
		}
		
		var cnt = 0;
		if($("#regage").prop("checked")){
			$("input[name=regage]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt < 5) {
				$("#regage").prop("checked", false);
				$("#whole2").css('color','rgb(90,90,90)').css('background-color','#fff');
			}
		}else if(!$("#regage").prop("checked")) {
			$("input[name=regage]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt == 5) {
				$("#regage").prop("checked", true);
				$("#whole2").css('color','rgb(10, 150, 150)').css('background-color','rgb(166, 234, 234)');
			}
		}
	});
	
	$("#whole").trigger("click");
	$("#whole2").trigger("click");
	
	// 루트 검색하기
	$("#referenceSearch").on("keyup",function(){
		if($(this).val() == "") {
			$("#searchResultList").css("display","none");
			return false;
		}
		
		var data = "searchWord="+$(this).val();
		var url = "/home/searchReference";
		
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				setSearchList(result);
			}, error : function(){
				console.log("루트 검색 에러");
			}
		});
	});
	
	$("#speed").on("keyup", function(){
		var speed = $("#speed").val();
		
		if($("#speed").val() > 0){
			getTourTime(speed);
		}else {
			$("#speed").val(0);
			return false;
		}
	});
	
	// 날짜 데이터 변경 시
	
	// 1. 출발일자 선택 시 마감일자 변경
	$("#departuredate").on('change',function(){
		var departuredate = $("#departuredate").val();
		
		var date = $("#departuredate").datepicker("getDate");
		$("#deadlinedate").datepicker("setDate",date);
		$("#arrivedate").datepicker("setDate",date);
		
	});
	
	// 2. 출발시간 설정 시 마감시간 변경
	$("#departureTime").on('change', function(){
		if($("#departuredate").val()==""){
			toast("출발날짜를 먼저 입력하세요.");
			$("#departureTime>option").eq(1).prop("selected", true);
			return false;
		}
		
		var dTime = $("#departureTime").val();
		var deadTime = 0;
		if(dTime < 8){
			deadTime = Number(dTime) + 25 - 8;
			$("#deadlineTime>option").eq(deadTime).prop("selected",true);
			
			// 날짜 하루 빼기
			var date = $("#departuredate").datepicker("getDate");
			date.setDate(date.getDate()-1);
			$("#deadlinedate").datepicker("setDate",date);			
		}else{
			deadTime = dTime - 7; 
			$("#deadlineTime>option").eq(deadTime).prop("selected",true);
		}
		
		$("#arriveTime>option").eq(Number(dTime)+2).prop("selected",true);
	});
	
	// 3. 도착일자는 출발 일자보다 작을 수 없다.
	
	$("#arrivedate").on('change',function(){
		var arrivedate = $("#arrivedate").val();
		var departuredate = $("#departuredate").val();
		if(arrivedate < departuredate){
			toast("도착 일자는 출발 일자보다 빠를 수 없습니다.");
			$("#arrivedate").val(departuredate);
			return false;
		}else if(arrivedate == $("#departuredate").val()){
			if(Number($("#arriveTime").val()) <= Number($("#departureTime").val())){
				toast("도착 시간은 출발 시간과 같거나 빠를 수 없습니다.");
				$("#arriveTime>option").eq(Number($("#departureTime").val())+2).prop("selected", true);
				return false;
			}
		}else if(Number($("#arriveTime").val()) <= Number($("#departureTime").val())){
			if(arrivedate <= departuredate){
				var date = $("#departuredate").datepicker("getDate");
				date.setDate(date.getDate()+1);
				$("#arrivedate").datepicker("setDate",date);
				return false;
			}
		}
	});
	
	// 4. 도착일자와 출발 시간이 같을 때는 도착 시간이 출발 시간보다 작을 수 없다.
	$("#arriveTime").on('change', function(){
		var arrivedate = $("#arrivedate").val();
		var departuredate = $("#departuredate").val();
		if(departuredate == arrivedate){
			if(Number($("#arriveTime").val()) <= Number($("#departureTime").val())){
				toast("도착 시간은 출발 시간과 같거나 빠를 수 없습니다.");
				$("#arriveTime>option").eq(Number($("#departureTime").val())+2).prop("selected", true);
				return false;
			}
		}
	});
	
	// 5. 마감 일자 변경 시 출발 일자보다 빠를 수 없다.
	$("#deadlinedate").on('change', function(){
		var dead = $("#deadlinedate").val();
		var departuredate = $("#departuredate").val();
		
		if(departuredate == ""){
			toast("출발 날짜를 먼저 선택하세요.");
			$("#deadlinedate").val("");
			return false;
		}
		
		if(Number($("#deadlineTime").val()) <= Number($("#departureTime").val())){
			if(dead > departuredate){
				toast("마감 시간이 출발 시간보다 늦을 수 없습니다.");
				
				var date = $("#departuredate").datepicker("getDate");
				date.setDate(date.getDate());
				$("#deadlinedate").val("");
				$("#deadlinedate").datepicker("setDate",date);
				
			}
		}else if(Number($("#deadlineTime").val()) > Number($("#departureTime").val())){
			if(dead >= departuredate){
				toast("마감 시간이 출발 시간보다 늦을 수 없습니다.");
				
				var date = $("#departuredate").datepicker("getDate");
				date.setDate(date.getDate()-1);
				$("#deadlinedate").val("");
				$("#deadlinedate").datepicker("setDate",date);
				
			}
		}
	});
	
	// 6. 마감 시간 변경 시
	$("#deadlineTime").on('change', function(){
		var dead = $("#deadlinedate").val();
		var departuredate = $("#departuredate").val();
		if(departuredate == dead){
			if(Number($("#deadlineTime").val()) >= Number($("#departureTime").val())){
				toast("마감시간은 출발 시간과 같거나 늦을 수 없습니다.");
				$("#deadlineTime>option").eq(Number($("#departureTime").val())-1).prop("selected", true);
				$("#deadlineTime").val(Number($("#departureTime").val())-1);
				return false;
			}
		}
	});
});


// 레퍼런스 검색 결과 표시하는 펑션
function setSearchList(result){
	$("#searchResultList").children().remove();
	$("#searchResultList").css('display','block');
	var tag = "";
	
	if(result.length == 0){
		tag+="<Span style='margin : 0 auto'>검색 결과가 없습니다.</span>";
	}else{
		tag = "<ul><li>루트 번호</li><li>루트 제목</li><li>작성자</li>";
	
		for(var i = 0 ; i < result.length; i++){
			tag += "<li><a href='javascript:setReference("+result[i].noboard+")'>"+result[i].noboard+"</a></li>";
			tag += "<li><a href='javascript:setReference("+result[i].noboard+")'>"+result[i].title+"</a></li>";
			tag += "<li><a href='javascript:setReference("+result[i].noboard+")'>"+result[i].userid+"</a></li>";
		}
		tag +="</ul>";
	}
	
	$("#searchResultList").append(tag);
}

// 선택한 레퍼런스 레퍼런스에 저장
function setReference(noboard){
	$("#reference").val(noboard);
	$("#searchResultList").children().remove();
	$("#searchResultList").css('display','none');
	$("#referenceSearch").val("");
	setMapData();
}

// 맵 세팅하기
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

function getRoutePoint(point, chk){
	var points = point.replace("[/]","/").split("/");
	var p = new kakao.maps.LatLng(points[2], points[1]);
	routePosition.push(p);
	bounds.extend(p);
	
	if(chk == 1){
		$("#place").val(points[0]);
	}
}

function setMap(result){
	// 지도 추가
	
	$("#routeMap").children().remove();
	var map = new kakao.maps.Map(container, options);
	
	var titleTag = "<a href='/home/routeSearchView?noboard="+result.noboard+"'>"+result.title+"</a>";
	$("#routeTitle").html(titleTag);
	
	var distance = result.distance;
	$("#distance").val(distance);
	
	routePosition = [];
	bounds = new kakao.maps.LatLngBounds();
	
	// 기존 경로 마커 삭제
	removeMarker(routeMarker);

	
	// 루트 마커 세팅하기 
	// 마커 지정할 좌표 순서대로 입력
	var routeData = result.noboard;
	
	// 경로 위치 저장
	getRoutePoint(result.routepoint1, 1);
	getRoutePoint(result.routepoint2);
	if(result.routepoint3 != null ) {getRoutePoint(result.routepoint3)}
	if(result.routepoint4 != null ) {getRoutePoint(result.routepoint4)}
	if(result.routepoint5 != null ) {getRoutePoint(result.routepoint5)}
	if(result.routepoint6 != null ) {getRoutePoint(result.routepoint6)}
	if(result.routepoint7 != null ) {getRoutePoint(result.routepoint7)}
		
	var points = decode(result.geocode, true);
	setRouteLine(points, map);
	
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

function getTourTime(speed){
	var distance =$("#distance").val();
	if(distance == ""){
		toast("코스를 지정하세요.");
		$("#speed").val("");
		return false;
	}
	
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
		 $("#tourtime").val(timeTxt);
	 }
}

	$(function(){
		$("#departuredate,#arrivedate,#deadlinedate").datepicker({
			changeYear :true,
			changeMonth: true,
			constrainInput:true,
			dateFormat:"yy/mm/dd",
			dayNames:['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			yearRange:"2019:2021"
		
		});
		
	 	CKEDITOR.replace('content',{
			height:600
			,width:1200
			,extraPlugins: 'easyimage',
		    cloudServices_tokenUrl: 'https://76760.cke-cs.com/token/dev/fb98221c99f6d4fccf45b51c839a7d022ad90ab2f9dfbc25f02ecdc03d98',
		    cloudServices_uploadUrl: 'https://76760.cke-cs.com/easyimage/upload/'
		
		}); 
	  
		
		$("#tourWriteForm").submit(function(){
			CKEDITOR.instances.content.updateElement();		
			
			if($("#reference").val()==""){
				toast("루트를 선택하세요.");
				$("#referenceSearch").focus();
				return false;
			}
			
			if($("#departuredate").val()==""){
				toast("출발날짜를 입력하세요.");
				$("#departuredate").focus();
				return false;
			}
			
			if($("#departureTime").val()==""){
				toast("출발시간을 입력하세요.");
				$("#departureTime").focus();
				return false;
			}

			if($("#arrivedate").val()==""){
				toast("도착날짜를 입력하세요.");
				$("#arrivedate").focus();
				return false;
			}
			
			if($("#arriveTime").val()==""){
				toast("도착시간을 입력하세요.");
				$("#arriveTime").focus();
				return false;
			}

			if($("#place").val()==""){
				toast("출발장소를 입력하세요.");
				$("#place").focus();
				return false;
			}
			
			if($("#deadlinedate").val()==""){
				toast("마감날짜를 입력하세요.");
				$("#deadlinedate").focus();
				return false;
			}
			if($("#deadlineTime").val()==""){
				toast("마감시간를 입력하세요.");
				$("#deadlineTime").focus();
				return false;
			}
			
			/////////////////////
			// 현재 시간과 비교 
			var tourDate = $("#deadlinedate").datepicker("getDate");
			var tourHour = $("#deadlineTime").val();			
			tourDate.setHours(tourHour);

			var nowDate = new Date();
			if(nowDate >= tourDate){
				toast("투어는 현재 시간 이전으로 설정할 수 없습니다.");
				return false;
			}

			if($("#tourWriteTitle").val()==""){
				toast("제목을 입력하세요.");
				$("#tourWriteTitle").focus();
				return false;		
			}
			
		 	if(CKEDITOR.instances.content.getData()==""){
				toast("글내용을 입력하세요.");
				$("#content").focus();
				return false;
			}
		 	
		 	var genderCnt = 0;
		 	$("input[name=reggender]").each(function(){
		 		
		 		if($(this).prop("checked")){
		 			genderCnt++;
		 		}
		 	});
		 	
	 		if(genderCnt == 0){
	 			toast("성별 조건을 하나 이상 선택하세요.");
	 			return false;
	 		}
		 	
	 		var ageCnt = 0;
		 	$("input[name=regage]").each(function(){
		 		if($(this).prop("checked")){
		 			ageCnt++;
		 		}
		 	});
		 	
	 		if(ageCnt == 0){
	 			toast("나이 조건을 하나 이상 선택하세요.");
	 			return false;
	 		}
	 		
	 		if($("#speed").val()==""){
				$("#speed").val(0);
			}
	 		
	 		if($("#budget").val()==""){
				$("#budget").val(0);
			}
		 	
			var url = "/home/tourWriteFormOk";
			var params = $("#tourWriteForm").serialize();
			
			console.log(params);
			
			$.ajax({
				type : 'POST',
				url : url,
				data : params,
				success : function(result){
					console.log(result);
					if(result>0){
						toastConfirm("게시글 작성 이후 모집 요강 수정이 불가능합니다.\n등록 하시겠습니까?",function(){
							location.href="/home/tourList";
						});
					}else{
						toast("글등록이 실패하였습니다.");
					}
				},error:function(){
					console.log("글쓰기 오류");
				}
			});
			return false;
		});
	});
	
	
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

    function setRouteLine(points, map){
    
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