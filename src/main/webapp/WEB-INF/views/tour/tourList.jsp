<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/home/css/tourListStyle.css" type="text/css"/>  
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>

<div id="mainDivTour">
	<div class="tourSearchListDiv">
		<form id="searchTour" method="post">	
			<input type="hidden" name="nowPage" value="${paging.nowPage }"/>
			<input type="hidden" name="noboard" value="0"/>
			<ul class="searchBoardUl">
				<li>
					<div class="labelClass1"><label>일&nbsp;정</label></div>
				</li>
				<li>
					<input type="text" name="departuredate" placeholder="출발날짜" id="departure" maxlength="10" autocomplete="off"/>
					<select name="departureTime" id="departureTime" class="departureTime">
						<option value="">시간</option>
						<c:forEach var="i" begin="0" end="24" step="1">
							<option value="${i }">${i }시</option>
						</c:forEach>
					</select>
					<label class="label1">~</label>
					<input type="text" name="arrivedate"	placeholder="도착날짜" id="arrive" maxlength="10" autocomplete="off">
					<select name="arriveTime" id="arriveTime" class="arriveTime">
						<option value="">시간</option>
						<c:forEach var="i" begin="0" end="24" step="1">
							<option value="${i }">${i }시</option>
						</c:forEach>
					</select>
				</li>
		
				<li>
					<div><label class="labelClass1">장&nbsp;소</label></div>
				</li>
				<li>
					<input type="text" name="place" placeholder="출발장소" id="place" autocomplete="off" value="${paging.place }">
					<label class="labelClass1 distanceLbl">이동거리</label>
					<div class="distanceGroup"><input type="number" name="distance1" class="distance" maxlength="4" autocomplete="off" value="0" value="${paging.distance1 }">
						<label class="kmLbl">km</label></div>
					<label class="label1">~</label>
					<div class="distanceGroup"><input type="number" name="distance2" class="distance" maxlength="4" autocomplete="off" value="0" value="${paging.distance2 }">
						<label class="kmLbl">km</label></div>
				</li>
		
				<li>
					<div><label class="labelClass2">성&nbsp;별</label></div>
				</li>
				<li class="genderGroup">
					<label id="whole" for="reggender">전&nbsp;체</label>
					<label id="genderboy" for="boy">남</label>
					<label id="gendergirl" for="girl">여</label>
					
					<input type="checkbox" id="reggender"/>
					<input type="hidden" id="reggenderPaging" value="${paging.reggender }"/>
					<input type="checkbox" name="reggender" id="boy" value="1" />
					<input type="checkbox" name="reggender" id="girl" value="2" />
				</li>
		
				<li>
					<div><label class="labelClass3">나&nbsp;이</label></div>
				</li>
				<li class="ageGroup">
					<label id="whole2" for="regage">전&nbsp;체</label>
					<label id="regageten" for="ten">10대</label>
					<label id="regagetwenty" for="twenty">20대</label>
					<label id="regagethirty" for="thirty">30대</label>
					<label id="regageforty" for="forty">40대</label>
					<label id="regagefiftyOver" for="fiftyOver" style="width:100px">50대 이상</label>
					
					<input type="checkbox" id="regage" />
					<input type="hidden" id="regagePaging" value="${paging.regage }"/>
					<input type="checkbox" name="regage" id="ten" value="1" />
					<input type="checkbox" name="regage" id="twenty" value="2"/>
					<input type="checkbox" name="regage" id="thirty" value="3" />
					<input type="checkbox" name="regage" id="forty" value="4" />
					<input type="checkbox" name="regage" id="fiftyOver" value="5"/>
					
				</li>
				<li>
					<div>
						<input type="button" name="search" value="검&nbsp;색" id="search">
						<input type="button" id="reset" value="초기화" >
					</div>
				</li>
			</ul>
		</form>
	</div>
	<div>
		<div id="tourSearchTitleDiv"><label id="tourSearchTitleLbl"><b>동행찾기</b></label>
			<input type="button" name="tourWriteBoard" value="글쓰기" onclick="goWriteForm()"></div>
		
	
		<!--  ===========================db작업 / 코스짜기 받아서 수정할 부분 -->
		<div id="tourBoardListDivTop">	
				
		</div>
		<div  id="paging">
			<ul>
				<!-- 이전 페이지 -->
					<c:if test="${paging.nowPage != 1 }">
						<li><a href="#">Prev</a></li>
					</c:if>
					<c:forEach var="p" begin="${paging.startPageNum }" end="${paging.startPageNum + paging.onePageNumCount -1}">
						<c:if test="${paging.totalPage >= p }">
							<c:if test="${paging.nowPage == p }">
								<li style='color:#00B0B0; font-weight:600;'>${p }</li>
							</c:if>
							<c:if test="${paging.nowPage != p }">
								<li><a href='javascript:movePage(${p })' style='color:black; font-weight:600;'>${p }</a></li>
							</c:if>
						</c:if>
					</c:forEach>
			<!-- 다음 페이지 -->
				<c:if test="${paging.nowPage != paging.totalPage }">
					<li><a href="#">Next</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
<script>
var nowPage = $("input[name=nowPage]").val();
$(function(){
	
	//성별 css,체크 변화
	$("#reggender").on('change', function(){
		if($(this).is(":checked")){
			$("#whole").css('color','white').css('background-color','#7f5ab1');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if(!($("input[name=reggender]").eq(i).prop("checked"))){
					$("input[name=reggender]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole").css('color','#63468a').css('background-color','#e9e4fb');
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
			$("#gender"+type).css('color','white').css('background-color','#7f5ab1');
		}else{
			$("#gender"+type).css('color','#63468a').css('background-color','#e9e4fb');
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
				$("#whole").css('color','#63468a').css('background-color','#e9e4fb');
			}
		}else if(!$("#reggender").prop("checked")) {
			$("input[name=reggender]").each(function(){
				if($(this).prop("checked")){
					cnt++;
				}
			});
			if(cnt == 2) {
				$("#reggender").prop("checked", true);
				$("#whole").css('color','white').css('background-color','#7f5ab1');
			}
		}
	});
	
	
	//나이  css,체크 변화
	$("#regage").on('change',function(){
		if($(this).is(":checked")){
			$("#whole2").css('color','white').css('background-color','rgb(0,176,176)');
			for(var i = 0; i < $("input[name=regage]").length ; i++){
				if(!($("input[name=regage]").eq(i).prop("checked"))){
					$("input[name=regage]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole2").css('color','rgb(0,176,176)').css('background-color','rgba(0,176,176,0.2)');
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
			$("#regage"+type).css('color','rgb(0,176,176)').css('background-color','rgba(0,176,176,0.2)');
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
				$("#whole2").css('color','rgb(0,176,176)').css('background-color','rgba(0,176,176,0.2)');
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
	
	$("#departure,#arrive").datepicker({
		changeYear :true,
		changeMonth: true,
		constrainInput:true,
		dateFormat:"yy/mm/dd",
		dayNames:['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		dayNamesMin:['일','월','화','수','목','금','토'],
		monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		yearRange:"2020:2021"
	});
	
	$("#departure").on('change',function(){
		$("#departureTime>option").eq(1).prop("selected", true);
	});
	
	$("#arrive").on('change',function(){
		$("#arriveTime>option").eq(1).prop("selected", true);
	});
	 
	// 초기화
	$("#reset").click(function(){
		$("input[type=text]").val("");
		$("#departureTime>option").eq(0).prop("selected", true);
		$("#arriveTime>option").eq(0).prop("selected", true);
		$("input[type=number]").val(0);
		
		if(!($("#reggender").prop("checked"))){
			$("#whole").trigger("click");
		}
		if(!($("#regage").prop("checked"))){
			$("#whole2").trigger("click");
		}
	});
	
	$("input[name=search]").on('click', function(){
		
		if($("input[name=distance1]").val() == ""){
			$("input[name=distance1]").val(0);
		}
		if($("input[name=distance2]").val() == ""){
			$("input[name=distance2]").val(0);
		}

		movePage(1);
	});
	
	if($("#reggenderPaging").val() != "" ){
		var reggender = $("#reggenderPaging").val();
		if(reggender.indexOf("1") > -1 ){
			$("#genderbod").trigger("click");
		}
		if(reggender.indexOf("2") > -1) {
			$("#gendergirl").trigger("click");
		}
	}
		
	if($("#regagePaging").val() != "" ){
		var regage = $("#regagePaging").val();
		if(regage.indexOf("1") > -1 ){
			$("#regageten").trigger("click");
		}
		if(regage.indexOf("2") > -1) {
			$("#regagetwenty").trigger("click");
		}
		if(regage.indexOf("3") > -1 ){
			$("#regagethirty").trigger("click");
		}
		if(regage.indexOf("4") > -1) {
			$("#regageforty").trigger("click");
		}
		if(regage.indexOf("5") > -1 ){
			$("#regagefiftyOver").trigger("click");
		}
	}
	
	movePage(nowPage);	
		
});
	function setPaging(vo){
		// 이전 페이징 삭제
		nowPage = vo.nowPage;
		
		console.log(vo);
		var tag = "<ul>";
		
		if(vo.nowPage != 1){
			tag += "<li style='margin-right:25px;'><a href='javascript:movePage("+(vo.nowPage -1)+");'>Prev</a></li>";
		}
		
		for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount -1 ; i++){
			if(vo.totalPage >= i){
				if(vo.nowPage == i){
					tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
				}else{
					tag += "<li><a href='javascript:movePage("+i+")' style='color:black; font-weight:600;'>"+i+"</a></li>";
				}
			}
		}
	
		if(vo.nowPage != vo.totalPage){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage +1)+")'>Next</a></li>"
		}
		$("#paging").html(tag);
	}
	
	//페이지 이동
	function movePage(p){
		
		$("input[name=nowPage]").val(p);
		var url ="<%=request.getContextPath()%>/searchTourPaging";
		
		//페이징 변경
		var	params = $("#searchTour").serialize();
			params += "&nowPage="+p;
			console.log(params);
	
		$.ajax({
			 type: 'POST'
			,url:url
			,data:params
			,success:function(result){
				if(result.totalRecord == 0){
					toast("검색 결과가 없습니다.", 1500);
				}else{
					setPaging(result);
					tourListSelect(p);	
				}
			},error:function(){
				console.log("페이징 오류");
			}
		});
	}
	
	function tourListSelect(p){
		
		var url ="/home/tourPagingList";
		var	params = $("#searchTour").serialize();
			params += "&nowPage="+p;
		
		$.ajax({
			url:url
			,data:params
			,success:function(result){
				if(result == null){
					toast("검색 결과가 없습니다.",1500);
					return false;
				}else{
					console.log(result);
					setList(result);
				}
			},error:function(){
				console.log("리스트 선택 에러 발생....");
			}
		});
	}
	
	// 리스트 만들기, List<tourVO>
	function setList(result){
		var $result = $(result);
		var tag="";
		$result.each(function(i,v){
			tag += "<div class='tourImgDivClass'><a href='javascript:goViewPage("+(v.noboard)+");'>";
			tag += "<div id='map"+i+"' class='tourImgClass'></div>";
			tag += "<div class='blackWrapDiv'>";	
			tag += "<p style='font-size:25px;' class='tourBoardTitle'><b>"+ v.title+"</b></p>";
			tag += "<p style='font-size:20px; color:#00b0b0; letter-spacing:2px; font-weight:bold' class='tourBoardWrite'>"+v.departure+'~'+v.arrive+"</p>";
			tag += "<hr style='width:200px;'/>";
			tag += "<p style='font-size:34px; letter-spacing:2px' class='tourBoardDay'><b>"+'총 '+v.distance+'km'+"</b></p></div></a></div>";
		
			// 썸네일 만들기
			$.ajax({
				url : "/home/selectRouteForThumbnail",
				data : "noboard="+v.reference,
				success : function(result){
					makeThumbnail(i, result);
				},error : function(){
					console.log("썸네일 호출 에러");
				}
			});
		});
		$("#tourBoardListDivTop").html(tag);
	}
	
	// 지도 썸네일 만들기
 	function makeThumbnail(idx, result){
		console.log(result);
		var array = result.mapcenter.replace("(","").replace(")","").split(",");
		
		var container = document.getElementById("map"+idx);
		var options = {
				center : new kakao.maps.LatLng(array[0], array[1]),
				draggable: false,
				level : result.maplevel+2
		};
		
		var readyArray = result.polyline.replaceAll("),(","||").replace("(","").replace(")","").replaceAll("||",",").split(",");
		
		var linePath = [];
		for(var j = 0 ; j < readyArray.length ; j += 2) {
			var p = new kakao.maps.LatLng(readyArray[j], readyArray[j+1]);
			linePath.push(p);
		}
		
		var map = new kakao.maps.Map(container, options);
	    var polyline = new kakao.maps.Polyline({
		    path: linePath, // 선을 구성하는 좌표배열 입니다
		    strokeWeight: 5, // 선의 두께 입니다
		    strokeColor: '#FF0162', // 선의 색깔입니다
		    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid' // 선의 스타일입니다
		});
    	polyline.setMap(map);
	}
	
	
	function goViewPage(noboard){
		
		$("#searchTour").attr("action",'/home/tourView')
		$("input[name=noboard]").val(noboard);
		
		console.log($("#searchTour").serialize());
		$("#searchTour").submit();
	}
	
	function goWriteForm(){
		
		$.ajax({
			url: "/home/checkTourcnt",
			success : function(result){
				if(result < 5){
					toast("투어 참가 횟수가 5회 미만일 경우 투어를 모집할 수 없습니다.");
				}else {
					location.href='<%=request.getContextPath()%>/tourWriteForm';
				}
			},error : function(err){
				console.log(err);
			}
		});
	}
</script>