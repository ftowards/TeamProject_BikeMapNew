$(function(vo){
	//result==1 : 완료상태 , 2: 참여인원 있는 상태 , 3: 삭제가능상태
	$(".tourViewDelete").click(function(){
	
		var url ="/home/tourViewDeleteChk";
		var data = "noboard="+$("#noboard").val();
		
		$.ajax({
			url: url,
			data : data,
			success: function(result){
				if(result == 1){
					toast("완료된 여행은 삭제가 불가능합니다.",1500);
				}else if(result == 2){
						selectTourCompList(result);
				}else if(result == 3){
					toastConfirm("삭제된 글은 복구가 불가능합니다.<br/>그래도 삭제하시겠습니까?",function(){
						deleteTourView(result);
					});
			}else{
					toast("글삭제에 실패하였습니다.",1500);
					}
				},error:function(){
					console.log("글삭제 조건 에러");
				}
		});
		return false;
	});
	
	// 참여인원 리스트 구하기
	function selectTourCompList(result){
		var url = "/home/selectTourCompList";
		var data ="noboard="+$("#noboard").val();
		
		$.ajax({
			url:url
			,data:data
			,success : function(result){
				if(result.length>0){
					toastConfirm("현재"+result.length+"명의 참여인원이 있습니다.<br/>그래도 삭제하시겠습니까?",function(){
						selectTourCompReceiver(result);
					});	
				}else{
					toast("참여인원 리스트불러오기에 실패하였습니다.",1500);	
				}
			
			},error:function(){
				console.log("동행찾기 참여리스트 불러오기 에러");
			}
			
			
		});
	
	}
	// 참여인원
	function selectTourCompReceiver(result){
		var $result = $(result);
		
		$result.each(function(i,val){
			if(val != $("#logId").val){
				sendTourDeleteMsg(val);
			}
		});
		
		deleteTourView(result);
	}	
	
	// 게시글 삭제 메세지 보내기
	function sendTourDeleteMsg(receiver){
		var receiver = receiver;
		var sender = $("#logId").val();

		var noboard = $("#noboard").val();
		var msg = sender + "님이 " + noboard + "번 투어를 취소하였습니다.";
		var socketMsg = "cancelTourAdmin,"+receiver+","+sender+","+noboard; 
		
		var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
		
		$.ajax({
			url: "/home/insertNotice",
			data: data,
			success : function(result){
				if(result == 1){
					//socket.send(socketMsg);
				}
			},error:function(err){
				console.log(err);
			}
		});
	}
	
	
	//글삭제하기
	function deleteTourView(){
		
		var url = "/home/deleteTourView";
		var data = "noboard="+$("#noboard").val();
		
		$.ajax({
			url:url
			,data:data
			,success:function(result){
				if(result == 1){
					toast("게시글이 삭제되었습니다.",1500);
					setTimeout(function(){location.href="/home/tourList";}, 1500);
				}else{
					toast("글삭제에 실패하였습니다.",1500);
				}
			},error:function(){
				console.log("글삭제 에러");
			}
		});
		
	}	
});

//목록보기 이동
function goList(){
	var data = $("#pagingVO").serialize();
	
	$("#pagingVO").attr("action", "/home/tourList");
	$("#pagingVO").submit();
}

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
	
	getTourTime();
	
	container = document.getElementById("routeMap");
	 map = new kakao.maps.Map(container, options);
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
			$(this).css('color','#0a9696').css('background','linear-gradient(rgb(205 253 253), rgb(166 234 234))');
			ageCnt++;
		}
		if(ageCnt == 5) {
			$("#whole2").css('color','white').css('background-color','rgb(0,176,176)');
		}
	});
	
	setMapData();
	
	
	//////////////////////////// 이벤트 /////////////////////////
	$("#applyTour").on('click',function(){
		var url = "/home/applyTour";
		var data = "noboard="+$("#noboard").val();
		
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				if(result == 1){
					toast("참가 신청이 완료되었습니다.",1500);
					sendMsg($("#noboard").val(), $("#userid").val(), 2);
				}else if(result == 2){
					toast("이미 참가 신청 중 입니다.",1500);
				}else if(result == 3){
					toast("이미 참가 중 입니다.",1500);
				}else if(result == 4){
					toast("더이상 참가가 불가능합니다.", 1500);	
				}else if(result == 5){
					toast("마감 시간이 지나 참가 신청이 처리되지 않았습니다.",1500);
				}else{
					toast("참가 신청 오류입니다.",1500);
				}
			},error : function(){
				console.log("참가 신청 오류");
			}
		});
	});
	
	$("#cancelTour").on('click', function(){
		var url = "/home/checkCompllistIn";
		var data = "noboard="+$("#noboard").val();
		
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				if(result == '1'){
					toastConfirm("현재 참가 신청 중입니다.<br/>신청을 취소하시겠습니까?",function(){
						cancleTour();
					});
				}else if(result == '2'){
					toastConfirm("현재 참가 중입니다.<br/>참가를 취소하시겠습니까?",function(){
						cancleTour();
					});
				}else {
					toast("참가 내역이 없습니다.",1500);
				}
			},error : function(){
				console.log("참가 취소 오류");
			}
		});
	});
	
	$("#checkComplist").on('click', function(){
		var url = "/home/selectComplist";
		var data = "noboard="+$("#noboard").val();
	
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				setComplist(result);
			}, error : function(){
				console.log("참가자 리스트 호출 에러");
			}
		});
	});
	
});

//메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(noboard, receiver, type){
	var receiver = receiver;
	var sender = $("#logId").val();
	
	var noboard = noboard;
	var msg ="";
	var socketMsg = "";
	
	if(type == 1){
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>";
		socketMsg = "confirmTour,"+receiver+","+sender+","+noboard;
	}else if(type == 2){ // 참가 신청 메세지
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가 신청하였습니다.</a>";
		socketMsg = "applyTour,"+receiver+","+sender+","+noboard;
	}else if(type == 3){
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소였습니다.</a>";
		socketMsg = "cancelTour,"+receiver+","+sender+","+noboard;
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

function setComplist(result){
	var tag = "";
	var $result = $(result);
	
	var manageCondition = $("#manageConditon").val();
	var heartImg = "<img src='/home/img/img_myRoute/like3.png' style='width:19px; margin-right:5px'>";
	
	$result.each(function(i, v){
		tag += "<li>"+v.userid+"</li>";
		tag += "<li>"+v.age+"</li>";
		
		var gender = "남";
		if(v.gender == '2'){
			gender ="여";
		}
		
		tag += "<li>"+gender+"</li>";
		tag += "<li>"+v.tourcnt+"</li>";
		tag += "<li>"+heartImg+"<span style='color:#cc113c; font-weight:bold;'>"+v.heart+"</span>"+"</li>";
		
		
		if($("#logId").val() == $("#userid").val()){ // 작성자면
			// 리스트 참가 여부
			if($("#logId").val() == v.userid){ // 작성자 정보
				tag += "<li><div class='applying'><label>참가중</label></div></li>";
			}else {
				if(v.state == '2'){
					tag +="<li><div class='applyWait'><label onclick='revertComplist(title)' title='"+$("#noboard").val()+"/"+v.userid+"'>추방</label></div></li>";					
				}else if(v.state == '1'){
					tag +="<li><div class='applyWait'><label onclick='confirmComplist(title)' title='"+$("#noboard").val()+"/"+v.userid+"'>승인</label></div></li>";
				}else if(v.state == '3'){
					tag +="<li><div class='applyWait'><label >불참</label></div></li>";
				}
			}
		}else{ // 작성자가 아닐 때
			if(v.state == '2'){
				tag += "<li><div class='applying'><label>참가중</label></div></li>";
			}else if(v.state == '1'){
				tag += "<li><div class='applyWait'><label>승인대기</label></div></li>";
			}else if(v.state == '3'){
				tag +="<li><div class='applyWait'><label >불참</label></div></li>";
			}
		}
		
		if($("#logId").val() != v.userid){
			tag += "<li><img src='/home/img/img_tour/messge.png' style='width:35px;' onclick='popMsgSend(title);' title='"+v.userid+"'/></li>";
		}else{
			tag +="<li></li>";
		}
	});
	
	$("#complist").html(tag);
	
}

function confirmComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	$.ajax({
		url : "/home/mytour/confirmComplist",
		data : data,
		success : function(result){
			if(result == 1){
				toast("참가 승인 완료되었습니다.",1500);
				sendMsg(strs[0], strs[1], 1);
			}else if(result == 2){
				toast("참여 인원이 마감되었습니다.", 1500);
			}else {
				toast("승인 오류 입니다.",1500);
			}
		},error : function(err){
			console.log(err);
		}
	});	
}

function revertComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	$.ajax({
		url : "/home/mytour/revertComplist",
		data : data,
		success : function(result){
			if(result == 5){
				toast("마감 시간이 지나 참가 취소 처리가 불가합니다.");
			}else if(result == 1){
				toast("참가 취소 처리 되었습니다.",1500);
				sendMsg(strs[0], strs[1], 2);
			}else{
				toast("참가 취소 처리 오류입니다.");
			}
		},error : function(err){
			console.log(err);
		}
	});	
}


function cancleTour(){
	var url = "/home/cancelTour";
	var data = "noboard="+$("#noboard").val();
	
	$.ajax({
		url : url,
		data : data,
		success : function(result){
			if(result == 1){
				toast("참가 내역이 취소되었습니다.");
				sendMsg($("#noboard").val(), $("#userid").val(), 3);
			}else if(result == 5){
				toast("마감 시간이 지나 신청 취소가 불가능합니다.<br/>주최자에게 불참을 알려주세요.",1500);
			}else{
				toast("취소 신청 오류입니다. 다시 시도해주십시오.",1500);
			}
		},error : function(){
			console.log("참가 신청 오류 발생");
		}
	});
}

function getTourTime(){
	var distance =$("#distance").text();
	var speed = $("#speed").text();
	 
	if(speed == 0){
		$("#tourtime").text("-");
		return false;
	}
	
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