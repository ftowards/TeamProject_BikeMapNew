<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/home/css/tourListStyle.css" type="text/css"/>  
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>

<div id="mainDivTour">
<div class="tourSearchListDiv">
<form id="searchTour">	
	<div id="dateDiv">
		<div class="labelClass"><label>일&nbsp;정</label></div>
		<div><input type="text" name="departuredate" placeholder="출발날짜" id="departure" maxlength="10" autocomplete="off"></div>
		<select name="departureTime" id="departureTime" class="departureTime">
			<option value="">시간</option>
			<c:forEach var="i" begin="0" end="24" step="1">
				<option value="${i }">${i }시</option>
			</c:forEach>
		</select>
		<div><label class="label1">~</label></div>
		<div><input type="text" name="arrivedate"	placeholder="도착날짜" id="arrive" maxlength="10" autocomplete="off"></div>
		<select name="arriveTime" id="arriveTime" class="arriveTime"  style="margin-top:-29px">
			<option value="">시간</option>
			<c:forEach var="i" begin="0" end="24" step="1">
				<option value="${i }">${i }시</option>
			</c:forEach>
		</select>
	</div>
	
	<div id="placeDiv">
		<div><label class="labelClass">장&nbsp;소</label></div>
		<div><input type="text" name="place" placeholder="출발장소" id="place" autocomplete="off"></div>
		
		<div id="placeAndDistanceDiv">
			<div><label id="distanceLbl">이동거리</label></div>
			<div><input type="number" name="distance1" class="distance" maxlength="4" autocomplete="off" value="0"></div>
			<label class="kmLbl1">km</label>
			<div style="margin-top:-10px;"><label class="label2">~</label></div>
			<div><input type="number" name="distance2" class="distance" maxlength="4" autocomplete="off" value="0" style="margin:-34px 0 0 230px"></div>
			<div class="kmLbl2">km</div>
		</div>	
	</div>
	
	<div id="regGenderDiv">
		<div><label class="labelClass">성&nbsp;별</label></div>
				<div><label id="whole" for="reggender">전&nbsp;체</label></div>
				<div><label id="genderboy" for="boy">남</label></div>
				<div><label id="gendergirl" for="girl">여</label></div>
				
				<div><input type="checkbox" id="reggender"/></div>
				<div><input type="checkbox" name="reggender" id="boy" value="1" /></div>
				<div><input type="checkbox" name="reggender" id="girl" value="2" /></div>
			</div>
	
	<div id="regAgeDiv">
		<div><label class="labelClass">나&nbsp;이</label></div>
		<div><label id="whole2" for="regage">전&nbsp;체</label></div>
		<div><label id="regageten" for="ten">10대</label></div>
		<div><label id="regagetwenty" for="twenty">20대</label></div>
		<div><label id="regagethirty" for="thirty">30대</label></div>
		<div><label id="regageforty" for="forty">40대</label></div>
		<div><label id="regagefiftyOver" for="fiftyOver" style="width:100px">50대 이상</label></div>
		
		<div><input type="checkbox" id="regage" /></div>
		<div><input type="checkbox" name="regage" id="ten" value="1" /></div>
		<div><input type="checkbox" name="regage" id="twenty" value="2"/></div>
		<div><input type="checkbox" name="regage" id="thirty" value="3" /></div>
		<div><input type="checkbox" name="regage" id="forty" value="4" /></div>
		<div><input type="checkbox" name="regage" id="fiftyOver" value="5"/></div>
		
	</div>
	<div id="searchAndReset">
		<div><input type="submit" name="search" value="검&nbsp;색" id="search"></div>
		<div><input type="button" id="reset" value="초기화" ></div>
	</div>
</form>

	

	<div id="tourSearchTitleDiv"><label id="tourSearchTitleLbl"><b>동행찾기</b></label></div>
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
	
	<!--  ===========================db작업 / 코스짜기 받아서 수정할 부분 -->
	<div id="tourBoardListDivTop">	
			
	</div>
	
	
		<div id="tourWriteDiv"><input type="button" name="tourWriteBoard" value="글쓰기" onclick="location.href='<%=request.getContextPath()%>/tourWriteForm'"></div>
</div>
</div>
<script>
$(function(){
	
	//성별 css,체크 변화
	$("#reggender").on('change', function(){
		if($(this).is(":checked")){
			$("#whole").css('color','white').css('background-color','rgb(0,176,176)');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if(!($("input[name=reggender]").eq(i).prop("checked"))){
					$("input[name=reggender]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole").css('color','rgb(0,176,176)').css('background-color','rgba(0,176,176,0.2)');
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
			$("#gender"+type).css('color','rgb(0,176,176)').css('background-color','rgba(0,176,176,0.2)');
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
				$("#whole").css('color','rgb(0,176,176)').css('background-color','rgba(0,176,176,0.2)');
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
		yearRange:"2019:2020"
	});
	
	$("#departure").on('change',function(){
		$("#departureTime>option").eq(1).prop("selected", true);
	});
	
	$("#arrive").on('change',function(){
		$("#arriveTime>option").eq(1).prop("selected", true);
	});

	 
	$("#whole").trigger("click");
	$("#whole2").trigger("click");
	
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
	
	$("#searchTour").submit(function(){
		movePage(1, true);
		return false;
	});
	
	movePage(1, false);	
		
});
	function setPaging(vo, search){
		// 이전 페이징 삭제
		$("#paging").children().remove();
		nowPage = vo.nowPage;
		
		console.log(vo);
		var tag = "<ul>";
		
		if(vo.nowPage != 1){
			tag += "<li style='margin-right:25px;'><a href='javascript:movePage("+(vo.nowPage -1)+", "+search+");'>Prev</a></li>";
		}
		
		for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount -1 ; i++){
			if(vo.totalPage >= i){
				if(vo.nowPage == i){
					tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
				}else{
					tag += "<li><a href='javascript:movePage("+i+", "+search+")' style='color:black; font-weight:600;'>"+i+"</a></li>";
				}
			}
		}
	
		if(vo.nowPage != vo.totalPage){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage +1)+", "+search+")'>Next</a></li>"
		}
		$("#paging").append(tag);
	}
	
	//페이지 이동
	function movePage(p, search){
		
		var url ="<%=request.getContextPath()%>/searchTourPagingAll";
		
		if(search){
			url = "/home/searchTourPaging";	
			console.log("검색 조건");
		}

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
					alert("검색 결과가 없습니다.");
				}else{
					setPaging(result, search);
					tourListSelect(p, search);	
				}
			},error:function(){
				console.log("페이징 오류");
			}
		});
	}
	
	function tourListSelect(p, search){
		
		var url ="/home/tourPagingListAll";
		
		if(search){
			url ="/home/tourPagingList";	
		}
		
		var	params = $("#searchTour").serialize();
			params += "&nowPage="+p;
		
		$.ajax({
			url:url
			,data:params
			,success:function(result){
				if(result == null){
					alert("검색 결과가 없습니다.");
					return false;
				}else{
					$("#tourBoardListDivTop").children().remove();
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
			tag += "<div class='tourImgDivClass'><a href='/home/tourView?noboard="+v.noboard+"'>";
			tag += "<div id='map"+i+"' class='tourImgClass'></div>";
			tag += "<div class='blackWrapDiv'>";	
			tag += "<p style='font-size:25px;' class='tourBoardTitle'><b>"+ v.title+"</b></p>";
			tag += "<p style='font-size:20px;' class='tourBoardWrite'>"+v.departure+'~'+v.arrive+"</p>";
			tag += "<hr style='width:200px;'/>";
			tag += "<p style='font-size:40px;' class='tourBoardDay'><b>1Day</b></p></div></a></div>";
			
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
</script>