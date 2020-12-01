<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/home/css/tourWriteFormStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<div id="mainDivTourWrite">
	<form id="tourWriteForm">
	<div id="tourWriteFormTitleDiv"><label id="tourWriteFormTitleLbl"><b>동행찾기 게시판 글쓰기</b></label><br/><hr/></div>
	
	<div id="RouteSearchDiv">
		<div>
			<input type="text" id="referenceSearch" name="reference" placeholder="루트검색(제목/작성자/지역)" autocomplete="off"/>
			<hr style="opacity:0 ; height : 25px;"/>
			<div id="searchResultList">
			</div>
			<input type="hidden" id="reference"/>
		</div>
	</div>
	
	<div class="infoDiv">
		<div id="routeResultDiv" class="routeResultDiv">
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
						<input type="text" name="departure" placeholder="출발날짜" id="departure" maxlength="10" autocomplete="off"/>
					</div>
					<div>
						<select name="departureTime" id="departureTime">
							<c:forEach var="i" begin="0" end="23" step="1">
								<option value="${i }">${i }시</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="conditionDivTop">
					<div>
						<input type="text" name="arrive"	placeholder="도착날짜" id="arrive" maxlength="10" autocomplete="off"/>
					</div>
					<div>
						<select name="arriveTime" id="arriveTime">
							<c:forEach var="i" begin="0" end="23" step="1">
								<option value="${i }">${i }시</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="conditionDivTop">
					<div><label class="labelClass">장&nbsp;소</label></div>
					<div>   
						<input type="text" name="place" id="place" placeholder="ex)신촌역3번 출구" autocomplete="off"/>
					</div>
				</div>
				<div class="conditionDivTop" style="margin-top:20px;">
					<div><label  class="labelClass2">마감날짜</label></div>
						<div><input type="text" name="deadline" placeholder="마감날짜" id="deadline" maxlength="10" autocomplete="off"/></div>
					<div>
						<select name="deadlineTime" id="deadlineTime">
							<c:forEach var="i" begin="0" end="23" step="1">
								<option value="${i }">${i }시</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="timeConditionDiv2">	
			<div><label class="tourWriteConditionTitle">여&nbsp;행</label></div>		
				<div class="conditionDivTop2">
					<div><label  class="labelClass">거&nbsp;리</label></div>
					<div><input type="text" id="distance" name="distance" maxlength="4" class="conditionBox" readonly/></div>
					<label class="kmLbl1">km</label>
					<div><label  class="labelClass2" style="margin:-25px 0 0 40px;" >소요시간</label></div>
					<div><input type="text" id="tourtime" class="conditionBox" maxlength="3" style="margin:-25px 0 0 20px;" readonly/></div>
					
				</div>	
				<div class="conditionDivTop">
					<div><label  class="labelClass2" >속&nbsp;도</label></div>
					<div><input type="number" name="speed" id="speed" maxlength="4" class="conditionBox"/></div>
						<label class="kmLbl2">km</label>
					<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">비&nbsp;용</label></div>
					<div><input type="text" name="budget" maxlength="6" style="margin:-25px 0 0 20px;" class="conditionBox"/></div>
					<label class="wonLbl">원</label>					
				</div>	
			</div>
			<div class="timeConditionDiv3">	
				<div><label class="tourWriteConditionTitle">모집조건</label></div>	
					<div class="conditionDivTop3">
						<div><label  class="labelClass">인&nbsp;원</label></div>
								<select name="room" id="room" style="text-align-last:center">
								<c:forEach var="i" begin="2" end="10" step="1">
									<option value="${i }">${i }</option>
								</c:forEach>
								</select>
			
						<div><label class="labelClass" style="margin-left:20px;">성&nbsp;별</label></div>
						<div><label id="whole" for="reggender">전&nbsp;체</label></div>
						<div><label id="genderboy" for="boy">남</label></div>
						<div><label id="gendergirl" for="girl">여</label></div>
						
						<div><input type="checkbox"  id="reggender" /></div>
						<div><input type="checkbox" name="reggender" id="boy" value="1" /></div>
						<div><input type="checkbox" name="reggender" id="girl" value="2" /></div>
					</div>
				
					<div class="conditionDivTop">
						<div><label class="labelClass">나&nbsp;이</label></div>
						<div><label id="whole2" for="regage">전&nbsp;체</label></div>
						<div><label id="regageten" for="ten">10대</label></div>
						<div><label id="regagetwenty" for="twenty">20대</label></div>
						<div><label id="regagethirty" for="thirty">30대</label></div>
					</div>
					<div class="conditionDivBottom">	
						<div><label id="regageforty" for="forty">40대</label></div>
						<div><label id="regagefiftyOver" for="fiftyOver" style="width:100px">50대 이상</label></div>
				
					
					<div><input type="checkbox"  id="regage" /></div>
					<div><input type="checkbox" name="regage" id="ten" value="1" /></div>
					<div><input type="checkbox" name="regage" id="twenty" value="2"/></div>
					<div><input type="checkbox" name="regage" id="thirty" value="3" /></div>
					<div><input type="checkbox" name="regage" id="forty" value="4" /></div>
					<div><input type="checkbox" name="regage" id="fiftyOver" value="5"/></div>
				</div>
			</div>
		</div>
	</div>		
			<div id="writeForm">		
					<ul>
						<li><input type="text" name="title" id="tourWriteTitle" placeholder="제목을 입력해주세요." maxlength="25"/></li>
						<li><textarea name="content" id="content"></textarea></li>
						<li><div id="writebuttonDiv">
							<input type="submit" value="등&nbsp;&nbsp;록"/>
							<input type="reset" value="다시쓰기"/>
						</div></li>
					</ul>
			</div>
	</form>
</div>

<script>

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
	$("#reggender").on('change', function(){
		if($(this).is(":checked")){
			$("#whole").css('color','white').css('background-color','rgb(0,176,176)');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if(!($("input[name=reggender]").eq(i).prop("checked"))){
					$("input[name=reggender]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole").css('color','rgb(123,123,123)').css('background-color','white');
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
			$("#gender"+type).css('color','white').css('background-color','rgb(0,176,176)');
		}else{
			$("#gender"+type).css('color','rgb(123,123,123)').css('background-color','white');
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
				$("#whole").css('color','rgb(123,123,123)').css('background-color','white');
			}
		}else if(!$("#reggender").prop("checked")) {
			$("input[name=reggender]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt == 2) {
				$("#reggender").prop("checked", true);
				$("#whole").css('color','white').css('background-color','rgb(0,176,176)');
			}
		}
	});
	
	

	$("#regage").on('change',function(){
		if($(this).is(":checked")){
			$("#whole2").css('color','white').css('background-color','rgb(0,176,176)');
			for(var i = 0; i < $("input[name=regage]").length ; i++){
				if(!($("input[name=regage]").eq(i).prop("checked"))){
					$("input[name=regage]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole2").css('color','rgb(123,123,123)').css('background-color','white');
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
			$("#regage"+type).css('color','white').css('background-color','rgb(0,176,176)');
		}else{
			$("#regage"+type).css('color','rgb(123,123,123)').css('background-color','white');
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
				$("#whole2").css('color','rgb(123,123,123)').css('background-color','white');
			}
		}else if(!$("#regage").prop("checked")) {
			$("input[name=regage]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt == 5) {
				$("#regage").prop("checked", true);
				$("#whole2").css('color','white').css('background-color','rgb(0,176,176)');
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
		getTourTime();
	});
	
	// 날짜 데이터 변경 시
	
	// 1. 출발일자 선택 시 마감일자 변경
	$("#departure").on('change',function(){
		var departure = $("#departure").val();
		console.log(departure);
		$("#deadline").val(departure);
	});
	
	// 2. 출발시간 설정 시 마감시간 변경
	$("#departureTime").on('change', function(){
		if($("#departure").val()==""){
			alert("출발날짜를 먼저 입력하세요.");
			$("#departureTime>option").eq(0).prop("selected", true);
			return false;
		}
		
		var dTime = $("#departureTime").val();
		var deadTime = 0;
		console.log(dTime);
		if(dTime < 8){
			deadTime = Number(dTime) + 24 -8;
			$("#deadlineTime>option").eq(deadTime).prop("selected",true);
			
			// 날짜 하루 빼기
			var date = $("#departure").datepicker("getDate");
			date.setDate(date.getDate()-1);
			$("#deadline").datepicker("setDate",date);			
		}else{
			deadTime = dTime - 8; 
			$("#deadlineTime>option").eq(deadTime).prop("selected",true);
		}
	});
	
	// 3. 도착일자는 출발 일자보다 작을 수 없다.
	
	$("#arrive").on('change',function(){
		var arrive = $("#arrive").val();
		var departure = $("#departure").val();
		if(arrive < departure){
			alert("도착 일자는 출발 일자보다 빠를 수 없습니다.");
			$("#arrive").val(departure);
			return false;
		}else if(arrive == $("#departure").val()){
			if(Number($("#arriveTime").val()) <= Number($("#departureTime").val())){
				alert("도착 시간을 출발 시간과 같거나 빠를 수 없습니다.");
				$("#arriveTime>option").eq(Number($("#departureTime").val())+1).prop("selected", true);
				$("#arriveTime").val(Number($("#departureTime").val())+1);
				return false;
			}
		}else if(Number($("#arriveTime").val()) <= Number($("#departureTime").val())){
			if(arrive <= departure){
				var date = $("#departure").datepicker("getDate");
				date.setDate(date.getDate()+1);
				$("#arrive").val("");
				$("#arrive").datepicker("setDate",date);
				return false;
			}
		}
	});
	
	// 4. 도착일자와 출발 시간이 같을 때는 도착 시간이 출발 시간보다 작을 수 없다.
	$("#arriveTime").on('change', function(){
		var arrive = $("#arrive").val();
		var departure = $("#departure").val();
		if(departure == arrive){
			if(Number($("#arriveTime").val()) <= Number($("#departureTime").val())){
				alert("도착 시간을 출발 시간과 같거나 빠를 수 없습니다.");
				$("#arriveTime>option").eq(Number($("#departureTime").val())+1).prop("selected", true);
				$("#arriveTime").val(Number($("#departureTime").val())+1);
				return false;
			}
		}
	});
	
	// 5. 마감 일자 변경 시 출발 일자보다 빠를 수 없다.
	$("#deadline").on('change', function(){
		var dead = $("#deadline").val();
		var departure = $("#departure").val();
		
		if(departure == ""){
			alert("출발 날짜를 먼저 선택하세요.");
			$("#deadline").val("");
			return false;
		}
		
		if(Number($("#deadlineTime").val()) <= Number($("#departureTime").val())){
			if(dead > departure){
				alert("마감 시간이 출발 시간보다 늦을 수 없습니다.");
				
				var date = $("#departure").datepicker("getDate");
				date.setDate(date.getDate());
				$("#deadline").val("");
				$("#deadline").datepicker("setDate",date);
				
			}
		}else if(Number($("#deadlineTime").val()) > Number($("#departureTime").val())){
			if(dead >= departure){
				alert("마감 시간이 출발 시간보다 늦을 수 없습니다.");
				
				var date = $("#departure").datepicker("getDate");
				date.setDate(date.getDate()-1);
				$("#deadline").val("");
				$("#deadline").datepicker("setDate",date);
				
			}
		}
	});
	
	// 6. 마감 시간 변경 시
	$("#deadlineTime").on('change', function(){
		var dead = $("#deadline").val();
		var departure = $("#departure").val();
		if(departure == dead){
			if(Number($("#deadlineTime").val()) >= Number($("#departureTime").val())){
				alert("마감시간은 출발 시간과 같거나 늦을 수 없습니다.");
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

function getRoutePoint(point){
	var points = point.replace("[/]","/").split("/");
	var p = new kakao.maps.LatLng(points[2], points[1]);
	routePosition.push(p);
	bounds.extend(p);
}

function setMap(result){
	
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

function getTourTime(){
	var distance =$("#distance").val();
	if(distance == ""){
		alert("코스를 지정하세요.");
		$("#speed").val("");
		return false;
	}
	
	 var speed = $("#speed").val();
	 
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

	$(function(){
		$("#departure,#arrive,#deadline").datepicker({
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
		
		}); 
	  
		
		$("#tourWriteForm").submit(function(){
			CKEDITOR.instances.content.updateElement();		
			
			if($("#reference").val()==""){
				alert("루트를 선택하세요.");
				return false;
			}
			
			if($("#departure").val()==""){
				alert("출발날짜를 입력하세요.");
				return false;
			}

			if($("#arrive").val()==""){
				alert("도착날짜를 입력하세요.");
				return false;
			}

			if($("#place").val()==""){
				alert("출발장소를 입력하세요.");
				return false;
			}
			
			if($("#deadline").val()==""){
				alert("마감날짜를 입력하세요.");
				return false;
			}

			if($("#tourWriteTitle").val()==""){
				alert("제목을 입력하세요.");
				return false;		
			}
			
		 	if(CKEDITOR.instances.content.getData()==""){
				alert("글내용을 입력하세요.");
				return false;
			}
			 
			var url = "/home/tourWriteFormOk";
			var params = $("#tourWriteForm").serialize();
			
			console.log(params);
			return false;
			
			$.ajax({
				type : 'POST',
				url : url,
				data : params,
				success : function(result){
					console.log(result);
					if(result>0){
						alert("글이 등록되었습니다.")
						location.href="/home/tourList";
					}else{
						alert("글등록이 실패하였습니다.");
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