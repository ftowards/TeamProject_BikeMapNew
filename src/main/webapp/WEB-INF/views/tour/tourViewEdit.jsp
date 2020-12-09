<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/tourViewEditStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<script>

$(function(){
 	CKEDITOR.replace('content',{
		height:600
		,width:1200
	
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
		var params = "noboard="+${vo.noboard}+"&userid=${vo.userid}&title="+$("#tourWriteTitleEdit").val()+"&content="+CKEDITOR.instances.content.getData();
		
		 	
		console.log(params);
		
		$.ajax({
			type : 'POST',
			url : url,
			data : params,
			success : function(result){
				if(result>0){
					console.log("동행찾기 글쓰기 확인창====="+result);
					toast("글이 수정되었습니다.");
					location.href="/home/tourView?noboard="+${vo.noboard};
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

</script>
<div class="mainDivTourView">
	<form id="tourEditForm">
	
		<div id="tourWriteFormTitleDiv"><label id="tourWriteFormTitleLbl"><b>동행찾기 게시판 글수정</b></label><br/><hr/></div>

	<div id="routeResultDiv" class="routeResultDiv">
		<input type='hidden' id='reference' value='${vo.reference }'/>
		<div><label class="tourWriteConditionTitle">루&nbsp;트</label></div>
		<div class="routeResultDiv2">
			<div class="routeTitleDiv">
				<div style='margin-left : 40px;height : 70px;'><label class="labelClass">루트 제목</label>
					<div id="routeTitle" class="conditionBox"></div>
				</div>		
			</div>
			<div id="routeMap"></div>
			<hr/>
			<div id="elevation_chart"></div>
		</div>
	</div>
	
	<div class="timeConditionDiv">
		<div><label class="tourWriteConditionTitle">시&nbsp;간</label></div>	
		<div id="conditionDiv">
			<div class="conditionDivTop">
				<div class="labelClass"><label>일&nbsp;정</label></div>
				<div>
					<div><label id="departure">${vo.departuredate}</label></div>
				</div>
				<div><label id="departureTime">${vo.departureTime}시</label></div>
				
			</div>
			<div class="conditionDivTop">
				<div>
					<div><label id="arrive">${vo.arrivedate}</label></div>
				</div>
				<div><label id="arriveTime">${vo.arriveTime}시</label></div>
			</div>
			
			<div class="conditionDivTop">
				<div><label class="labelClass">장&nbsp;소</label></div>
				<div>   
					<label id="place">${vo.place}</label>
				</div>
			</div>
			<div class="conditionDivTop" style="margin-top:20px;">
				<div><label  class="labelClass2">마감날짜</label></div>
					<div><label name="deadline" id="deadline" >${vo.deadlinedate }</label></div>
				<div><label id="deadlineTime">${vo.deadlineTime }시</label></div>
			</div>
		</div>
		<div class="timeConditionDiv2">	
			<div><label class="tourWriteConditionTitle">여&nbsp;행</label></div>		
				<div class="conditionDivTop2">
					<div><label class="labelClass">거&nbsp;리</label></div>
					<div><label class="conditionBox" id="distance">${vo.distance}</label></div>
						<label class="kmLbl1">km</label>
					<div><label class="labelClass2" style="margin:-25px 0 0 40px;">소요시간</label></div>
					<div><label style="margin:-25px 0 0 20px;" id="tourtime" class="conditionBox"></label></div>
				</div>	
				<div class="conditionDivTop">
					<div><label  class="labelClass2" >속&nbsp;도</label></div>
					<div><label  class="conditionBox" id="speed">${vo.speed }</label></div>
						<label class="kmLbl2">km</label>
					<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">비&nbsp;용</label></div>
					<div><label style="margin:-25px 0 0 20px;" class="conditionBox">${vo.budget }</label></div>
						<label class="wonLbl">원</label>	
				</div>	
		</div>
		<div class="timeConditionDiv3">	
			<div><label class="tourWriteConditionTitle">모집조건</label></div>	
				<div class="conditionDivTop3">
					<div><label  class="labelClass">인&nbsp;원</label></div>
					<div><label id="room" style="text-align-last:center">${vo.room }</label></div>
	
					<div><label class="labelClass" style="margin-left:20px;">성&nbsp;별</label></div>
					<div><label id="whole">전&nbsp;체</label></div>
					<div><label id="genderboy" class='reggender' <c:if test='${vo.genderM }'>title="on"</c:if>>남</label></div>
					<div><label id="gendergirl" class='reggender' <c:if test='${vo.genderF }'>title="on"</c:if>>여</label></div>
				</div>
		
				<div class="conditionDivTop">
					<div><label class="labelClass">나&nbsp;이</label></div>
					<div><label id="whole2">전&nbsp;체</label></div>
					<div><label id="regageten" class='regage' <c:if test='${vo.age10 }'>title="on"</c:if>>10대</label></div>
					<div><label id="regagetwenty" class='regage' <c:if test='${vo.age20 }'>title="on"</c:if>>20대</label></div>
					<div><label id="regagethirty" class='regage' <c:if test='${vo.age30 }'>title="on"</c:if>>30대</label></div>
				</div>
				<div class="conditionDivBottom">	
					<div><label id="regageforty" class='regage' <c:if test='${vo.age40 }'>title="on"</c:if>>40대</label></div>
					<div><label id="regagefiftyOver" class='regage' <c:if test='${vo.age50 }'>title="on"</c:if> style="width:100px">50대 이상</label></div>					
				</div>
		</div>
	</div>			
	<div id="writeForm">	
	
					<ul>
						<li><input type="text" name="title" id="tourWriteTitleEdit" value="${vo.title }" maxlength="25"/></li>
						<li><textarea name="content" id="content">${vo.content }</textarea></li>
						<li><div id="writebuttonDiv">
							<input type="submit" value="등&nbsp;&nbsp;록"/>
							<input type="reset" value="다시쓰기"/>
						</div></li>
					</ul>
			</div>

	</form>
</div>
<script>
//////// 지도용 변수
var routeMarker = [];
var container = document.getElementById("routeMap");
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
var map = new kakao.maps.Map(container, options);
$(function(){
	
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
	$("#applyTour").on('click',function(){
		var url = "/home/applyTour";
		var data = "noboard="+$("#noboard").val();
		
		$.ajax({
			url : url,
			data : data,
			success : function(result){
				if(result == 1){
					alert("참가 신청이 완료되었습니다.");
					sendMsg($("#noboard").val(), $("#userInformation").val(), 2);
				}else if(result == 2){
					alert("이미 참가 신청 중 입니다.");
				}else if(result == 3){
					alert("이미 참가 중 입니다.");
				}else if(result == 5){
					alert("마감 시간이 지나 참가 신청이 처리되지 않았습니다.");
				}else{
					alert("참가 신청 오류입니다.");
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
					if(confirm("현재 참가 신청 중입니다.\n신청을 취소하시겠습니까?")){
						cancleTour();
					}
				}else if(result == '2'){
					if(confirm("현재 참가 중입니다.\n참가를 취소하시겠습니까?")){
						cancleTour();
					}
				}else {
					alert("참가 내역이 없습니다.");
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
	
	console.log(receiver);
	console.log(sender);
	console.log(type);
	
	var noboard = noboard;
	var msg ="";
	var socketMsg = "";
	
	if(type == 1){
		msg = "<a href='/home/tourView?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>";
		socketMsg = "confirmTour,"+receiver+","+sender+","+noboard;
	}else if(type == 2){ // 참가 신청 메세지
		msg = "<a href='/home/tourView?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가 신청하였습니다.</a>";
		socketMsg = "applyTour,"+receiver+","+sender+","+noboard;
	}else if(type == 3){
		msg = "<a href='/home/tourView?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소였습니다.</a>";
		socketMsg = "cancelTour,"+receiver+","+sender+","+noboard;
	}
	
	var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
	console.log(data);
	
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
	var heartImg = "<img src='<%=request.getContextPath()%>/img/img_myRoute/like.png' style='width:25px;'>";
	
	$result.each(function(i, v){
		tag += "<li>"+v.userid+"</li>";
		tag += "<li>"+v.age+"</li>";
		
		var gender = "남";
		if(v.gender == '2'){
			gender ="여";
		}
		
		tag += "<li>"+gender+"</li>";
		tag += "<li>"+v.tourcnt+"</li>";
		tag += "<li>"+heartImg+v.heart+"</li>";
		
		
		if(v.state == '2'){
			tag += "<li><div class='applying'><label>참가중</label></div></li>";
		}else if(v.state == '1' && manageCondition != 'ok'){
			tag += "<li><div class='applyWait'><label>승인대기</label></div></li>";	
		}else if(manageCondition == 'ok' && v.state =='1'){
			tag +="<li><div class='applyWait'><label onclick='confirmComplist(title)' title='"+$("#noboard").val()+"/"+v.userid+"'>승인</label></div></li>";
		}

		if($("#logId").val() != v.userid){
			tag += "<li><img src='<%=request.getContextPath()%>/img/img_tour/messge.png' style='width:35px;' onclick='sendMessage();'/></li>";
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
				alert("참가 승인 완료되었습니다.");
				sendMsg(strs[0], strs[1], 1);
			}else{
				alert("승인 오류 입니다.");
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
				alert("참가 내역이 취소되었습니다.");
				sendMsg($("#noboard").val(), $("#userInformation").val(), 3);
			}else if(result == 5){
				alert("마감 시간이 지나 신청 취소가 불가능합니다.\n주최자에게 불참을 알려주세요.");
			}else{
				alert("취소 신청 오류입니다. 다시 시도해주십시오.");
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
	});
}
//기존에 표시한 마커 제거
function removeMarker(markerGroup){
	for(var i = 0; i<markerGroup.length; i++){
		markerGroup[i].setMap(null);
	}
	markerGroup =[];
}
</script>
