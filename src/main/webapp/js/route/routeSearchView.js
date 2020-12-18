// 1. 지도 만들기
	var markers = [];
	var routeMarker = [];
	
	var foodMarker = [],
		sightsMarker = [],
		accommodationMarker = [],
		convenientMarker = [];
	
	var container ;
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
	var map ;
	var infowindow = new kakao.maps.InfoWindow({zIndex:1, removable : true});
	
/////////////////// 기본 데이터 세팅 /////////////////
$(function(){

	container = document.getElementById("map");
	map = new kakao.maps.Map(container, options);

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
			window.open("/home/loginPopup","Bikemap Login","width=780px, height=400px, left =200px, top=200px");
			return false;
		}
	
 		window.open("/home/routeCollect","Bikemap","width=600px, height=230px, left =300px, top=300px");
 	});
 	
 	$("#recruitment").on('click', function(){
 		
 		$.ajax({
			url: "/home/checkTourcnt",
			success : function(result){
				if(result < 5){
					toast("투어 참가 횟수가 5회 미만일 경우 투어를 모집할 수 없습니다.");
				}else {
			 		$("input[name=reference]").val($("#noboard").val());
			 		$("#tourWriteWithReference").submit();
				}
			},error : function(err){
				console.log(err);
			}
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
			window.open("/home/loginPopup","Bikemap Login","width=800px, height=400px, left =200px, top=200px");
			return false;
		}
		
		if($("#logId").val() == $("#userid").text()){
			toast("회원님이 작성한 루트는 평가할 수 없습니다.",1500);
			return false;
		}
	
	  	var rating = $("#gradeSelect").val();
	  	
	  	if(rating == ""){
	  		toast("평점을 선택해주세요.",1500);
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
	  				toast("이미 평점을 등록한 루트입니다.",1500);
	  			}else {
	  				toast("평점이 등록되었습니다.",1500);
					setTimeout(setRating(),2000);
	  			}
	  		},error : function(){
	  			console.log("평점 입력 오류");
	  		}
	  	});
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
					toast("이미 등록된 이름입니다.",1500);
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
				console.log("카테고리 호출 에러");
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
      colors:["#ffb437"],
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
  			$("#rating").attr("title", result.rating);
  			setRatingStar();
  			
  		},error : function(){
  			console.log("평점 호출 에러");
  		}
  	});
  }
  	
  // 비공개 전환
  function setCloseRoute1(type){
  	// ++ 레퍼런스 사용 여부
  	var noboard = $("#noboard").val();
  	var msg = "삭제";

	if(type == 'close'){
		msg = "비공개 처리";
	}
  	
  	$.ajax({
  		url : "/home/route/chkReference",
  		data : "noboard="+noboard,
  		success : function(result){
  			if(result > 0){
  				toast("현재 투어나 후기에 사용 중으로 "+msg+"가 불가합니다");
			}else{
			  	// 1. 스크랩 여부 >> 진행 시 스크랩 취소 됨
			  	
			  	$.ajax({
			  		url :"/home/route/setCloseRoute1",
			  		data : "noboard="+noboard,
			  		success : function(result){
			  			if(result == 1){
			  				toastConfirm("현재 추천 루트로 게시 중입니다. "+ msg +" 시 추천 루트 게시가 취소됩니다.<br/>진행 하시겠습니까?", function(){
			  					// 스크랩 취소하는 펑션 필요
			  					$.ajax({
									url : "/home/releaseRoute",
									data : "noboard="+noboard,
									success : function(result){
										if(result > 0){
											toast("스크랩 해제",1000);
											setTimeout(function(){setCloseRoute2(noboard, type);},1500);
										}else{
											toast("스크랩 해제 오류",1500);
										}
									}, error : function(err){
										console.log(err);
									}
								});
			  				});
			  			}else {
			  				setCloseRoute2(noboard, type);
			  			}
			  		}, error : function(err){
			  			console.log(err);
			  		}
			  	});
			}
  		},error : function(err){
  			console.log(err);
  		}
  	});
  }
  
  // 2. 현재 해당 루트를 가지고 있는 사람 수 체크 + 명단 가져오기
  function setCloseRoute2(noboard, type){
  	
  	var msg = "삭제";
  	if(type == 'close'){
  		msg = "비공개";
  	}
  	
	$.ajax({
  	  	url : "/home/route/setCloseRoute2",
  	  	data : "noboard="+noboard,
  	  	success : function(result){
  	  		
  			if(result.length > 0){
  				toastConfirm("현재 "+result.length+"명이 해당 루트를 저장하고 있습니다.<br/>"+msg+" 시 루트 저장이 취소됩니다.<br/>진행 하시겠습니까?", function(){
  					// 저장 취소 , 안내 메세지 발송
  					cancelRouteSave(noboard, result, type);
  					
  					if(type == 'close'){
  						setCloseRoute3(noboard);
					}else if(type == 'del'){
						deleteRoute(noboard);
					}
  				});
  			}else {
  				if(type == 'close'){
  					setCloseRoute3(noboard);
				}else if(type == 'del'){
					deleteRoute(noboard);
				}
  			}
  		}, error : function(err){
  			console.log(err);
  		}
	});
  	
  }
 
 // 3. 비공개로 인한 루트 저장 취소 처리
 // 4. 루트 저장해서 가지고 있던 사람들에게 메세지 발송
  function cancelRouteSave(noboard, result, type){
  	var $result = $(result);
  	
  	var msgType = 1; // 1 : 비공개  , 2 : 삭제
  	if(type == 'del'){
  		msgType = 2;
  	}
  	
  	var cnt = 0 ;
  	$result.each(function(i,val){  	
  		$.ajax({
  			url : "/home/route/revertRoutelist",
  			data : "noboard="+noboard+"&userid="+val,
  			success : function(result){
  				if(result == 1){
  					sendMsg(noboard, val, msgType);
  				}else{
			  		toast("루트 저장 취소 오류<br/>관리자에 문의하십시오.");
  				}
  			}, error : function(err){
  				console.log(err);
  			}
  		});
  	});
  	
  }
  
  // 5-2. 삭제
  function deleteRoute(noboard){
   	toastConfirm(noboard+"번 루트를 삭제 하시겠습니까?", function(){
	  	$.ajax({
	  		url : "/home/route/deleteRoute",
	  		data : "noboard="+noboard,
	  		success : function(result){
	  			if(result >0){
	  				toast(noboard+"번 루트를 삭제하였습니다.",1000);
	  				setTimeout(function(){location.href='/home/routeSearch';},1500);
	  			}else{
	  				toast("루트 삭제 오류입니다.<br/>관리자에게 문의하세요.");
	  			}
	  		},erro : function(err){
	  			console.log(err);
	  		}
	  	});
	  });
  }
  
  // 5-1. 비공개 처리
  function setCloseRoute3(noboard){
  	toastConfirm(noboard+"번 루트를 비공개 하시겠습니까?", function(){
	  	$.ajax({
	  		url : "/home/route/setCloseRoute3",
	  		data : "noboard="+noboard,
	  		success : function(result){
	  			if(result >0 ){
	  				toast(noboard+"번 루트를 비공개 처리하였습니다.",1000);
					setTimeout(function(){console.log(noboard); goViewPage(noboard);}, 1500);
	  			}else{
	  				toast("루트 비공개 처리 오류입니다.");
	  			}
	  		},error : function(err){
	  			console.log(err);
	  		}
	  	});
  	});
  }
  
  // 공개 처리
  function setOpenRoute(){
  	var noboard = $("#noboard").val();
  	
  	toastConfirm("루트를 공개 처리하면 검색 및 다른 회원들의 리스트에 저장이 가능합니다.<br/>진행하시겠습니까?", function(){
  		$.ajax({
			url : "/home/route/setOpenRoute",
			data : "noboard="+noboard,
			success : function(result){
				if(result == 1){
					toast(noboard + "번 루트가 공개처리 되었습니다.",1000);
					setTimeout(function(){goViewPage(noboard);}, 1500);
					
				}else{
					toast("루트 공개 처리 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
  		});
  	});
  }	
  
// 스크랩 하고 댓글 / 메세지 남기기
function scrapRoute(noboard){
	var noboard = $("#noboard").val();

	$.ajax({
		url : "/home/scrapRoute",
		data : "noboard="+noboard,
		success : function(result){
			if(result > 0){
				toast("스크랩 완료",1500);
				leaveMessage(noboard);			
			}else{
				toast("스크랩 오류",1500);
			}
		}, error : function(err){
			console.log(err);
		}
	});
}
  
// 스크랩 해제
function releaseRoute(noboard){
	var noboard = $("#noboard").val();

	$.ajax({
		url : "/home/releaseRoute",
		data : "noboard="+noboard,
		success : function(result){
			if(result > 0){
				toast("스크랩 해제",1500);
				setTimeout(function(){location.reload(true)},1500);
			}else{
				toast("스크랩 해제 오류",1500);
			}
		}, error : function(err){
			console.log(err);
		}
	});
}

function leaveMessage(noboard){
	
	sendMsg(noboard, $("#userid").val(), 3);
	
	//데이터 구하기
	var data = "reply="+"해당 루트가 추천 루트로 게시됩니다. 게시를 원치 않으실 경우 관리자 문의 부탁드립니다.";
		data += "&noboard="+noboard;
		
	$.ajax({
		url:"/home/replyWriteOk"
		,data: data
		,success:function(result){
			if(result == 1){
				setTimeout(function(){location.reload(true)},1500);
			}
		},error:function(){
			console.log("댓글쓰기 에러 발생..");
		}
	});
}
  
  //메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(noboard, receiver, type){
	var receiver = receiver;
	var sender = $("#logId").val();
	
	var noboard = noboard;
	var msg ="";
	var socketMsg = "";
	
	
	
	if(type == 1){
		msg = sender + "님이 " + noboard + "번 루트를 비공개 처리하였습니다.";
		socketMsg = "closeRoute,"+receiver+","+sender+","+noboard;
	}else if(type == 2){
		msg = sender + "님이 " + noboard + "번 루트를 삭제하였습니다.";
		socketMsg = "deleteRoute,"+receiver+","+sender+","+noboard;
	}else if(type == 3){
		msg = "<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+noboard+ "번 루트가 추천 루트로 등록되었습니다.</a>";
		socketMsg = "scrapRoute,"+receiver+","+sender+","+noboard;
	}
	
	var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
	
	$.ajax({
		url : "/home/insertNotice",
		data : data,
		success : function(result){
			if(result == 1){
				socket.send(socketMsg);
			}
		},error : function(err){
			console.log(err);
		}
	})
}

function setRatingStar(){
	var rateWidth =  $("#rating").attr("title")/5 *125;
	$("#rating").css('width', rateWidth+'px');
}

function goViewPage(noboard){
	
	$("input[name=noboard]").val(noboard)
	var data = $("#pagingVO").serialize();

	$("#pagingVO").attr("action","/home/routeSearchView" );
	$("#pagingVO").submit();
}

// 리스트 이동
function goList(){
	var data = $("#pagingVO").serialize();
	
	$("#pagingVO").attr("action","/home/routeSearch" );
	$("#pagingVO").submit();
}

// 쪽지창 열기
//쪽지창 열기
function popMsgSend(userid){
	
	if($("#logId").val()== "" || $("#logId").val() == null){
		toast("쪽지 보내기는 회원만 이용 가능합니다.",1500);	
		return false;	
	}
	if(userid == 'admin' || userid == $("#logId").val()){
		return false
	}
	
	window.open('/home/sendMsg?userid='+userid, 'msg', 'width=425px, height=360px, left =200px, top=200px, resizable=0');	
}