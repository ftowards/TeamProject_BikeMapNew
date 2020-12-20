<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/inc/headerMainBxSlider.jspf"%>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>

<!-- 도시 검색창 -->		
	<div class = "locationSearchDiv">
		<div class="locationSearchTitle">
			<span class="locationTitle1">어디로 떠날까요?</span><br/>
			<span class="locationTitle2">To travel is to take a journey into yourself.</span>
		</div>
		<ul class="locationGroup" style='margin-top:25px'>
			<li class="location1">
				<a href="#" onclick="searchRegion(title);" title='서울'>
					<div class="locationDiv" id="seoul">
						<span class="locationTitle">서울</span>
					</div>
				</a>
				<a href="#" onclick="searchRegion(title);" title='부산'>
					<div class="locationDiv" id="busan">
						<span class="locationTitle">부산</span>
					</div>
				</a>
			</li>
			<li class="location2">
				<a href="#" onclick="searchRegion(title);" title='여수'>
					<div class="locationDiv" id="yeosu">
						<span class="locationTitle">여수</span>
					</div>
				</a>
				<div class="locationDiv" style='margin-top:25px'>
					<a href="#" onclick="searchRegion(title);" title='제주'>
						<div id="jeju">
							<span class="locationTitle">제주</span>
						</div>
					</a>
					<a href="#" onclick="searchRegion(title);" title='전주'>
						<div id="jeonju">
							<span class="locationTitle">전주</span>
						</div>
					</a>
				</div>
			</li>
		</ul>
		<form id="searchRegion" method="post" action="/home/routeSearch"></form>
	</div>	

<div class="banner_wrap2"></div>
<div class="bg_bikemap">
	<img src="<%=request.getContextPath() %>/img/img_main/bg_bikemap3.png"/>
</div>

<div id="mainDivHome">

	<div id="hitRoute">
	<!-- 	<span class="routeTitle" style="width:100%; font-size:35px;">
			추천 루트&nbsp;
		</span><br/> -->
		<div id="content1"></div> <!-- 추천 루트 들어가는 위치 -->
	</div><br/>	
</div>


<div class="reviewFrame">
	<span class="routeTitle review_blinking" style="width:100%; font-size:30px;">
			추천 후기&nbsp;
	</span><br/>
	<div id="reviewTop"></div> <!--  후기 -->
</div>




<a href="#" class="topIcon"><img src="<%=request.getContextPath() %>/img/img_main/top.png" onmouseover="this.src='<%=request.getContextPath() %>/img/img_main/top_over2.png'" onmouseout="this.src='<%=request.getContextPath() %>/img/img_main/top.png'"></a>

<script type="text/javascript">
	$(function(){

		// 추천 루트 썸네일 집어넣기
		// 1. 추천 루트 데이터 호출
		$.ajax({
			url : "/home/route/getRecRoute",
			success : function(result){
				makeThumbnail(result);
			}, error : function(err){
				console.log(err);
			}
		});
		
		// 추천 후기 만들기
		// 1. 추천 후기 리스트 가져오기
		$.ajax({
			url : "/home/reivew/getRecReview",
			success : function(result){
				console.log(result);
				makeThumbnail2(result);
			}, error : function(err){
				console.log(err);
			}
		});
		
		$("#reviewTop").on('mouseover',function(){
			step = 0;
		});
		
		$("#reviewTop").on('mouseout', function(){
			step = 0.5;
		});
	})
	
	var	timer = setInterval('postMove()',5);
	var left = 0;
	var step = 0.5;
	
	// 추천 루트 무한 루프
	function postMove(){
		left = left - step ;
		document.getElementById("reviewTop").style.left = left +"px";
		
		var length = $("#reviewTop>ul>li").length-1;
		if(left <= -370){
			left = 0;
			$("#reviewTop>ul>li").eq(0).insertAfter($("#reviewTop>ul>li").eq(length));
		}
	}
	
	
	
	// 추천 루트 썸네일 집어넣기
	// 2. 지도 썸네일 만들기
 	function makeThumbnail(result){
	
 		var listTag = "<p class='mainRouteTitle'>한 눈에 보는 <span class='blinking'>인기 코스</span></p><ul id='contentDivs'>";
		for(var i = 0 ; i < 4 ; i++){
			// 썸네일 작성부
			listTag += "<li class='contentDivMain'><a href='/home/routeSearchView?noboard="+result[i].noboard+"'><div id='map"+i+"' class='mainMap'></div>";
			// 루트 설명 작성부
			listTag += "<div class='mainSubscript'><ul ><li class='wordCut' id='routeTitle'>"+result[i].title+"</li><li class='wordCut' style='font-size:16px; font-weight:bold;'>"+result[i].region+"</li><li style='font-weight:bold;'>총 거리 "+result[i].distance.toFixed(2)+"km</li>";
			var rateWidth =  (result[i].rating/5 *125);
			listTag += "<li style='color: #d20091; text-align:right; font-weight:bold'>"+result[i].userid+"</li><li style='width:100%; text-align:center; margin-top:11px;'><span class='star-rating'><span style='width:"+rateWidth+"px'></span></span></li></ul></div></a></li>";
		}
		listTag +="</ul>";
		
		$("#content1").html(listTag);

		for(var i = 0 ; i < 4 ; i++){
			var array = result[i].mapcenter.replace("(","").replace(")","").split(",");
			
			var container = document.getElementById("map"+i);
			var options = {
					center : new kakao.maps.LatLng(array[0], array[1]),
					draggable: false,
					level : result[i].maplevel+2
			};
			
			var readyArray = result[i].polyline.replaceAll("),(","||").replace("(","").replace(")","").replaceAll("||",",").split(",");
			
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
	}
	
	// 추천 후기 만들기
	// 2. 추천 후기 리스트 만들기
	function makeThumbnail2(result){
		var listTag = "<ul>";
		var $result = $(result);
		
		console.log(result);
		$result.each(function(i, val){
			
			listTag +="<li class='recommendReview'><a href='/home/reviewView?noboard="+val.noboard+"'>";
			listTag +="<img src='/home/img/img_main/t.png' class='tape'/><div class='thumbnailImage' style='background-image:url("+val.thumbnailImg+")'/></div>";
			listTag +="<ul class='reviewSubscription'><li>"+val.subject+"</li><li class='reviewMainUserid'>@"+val.userid+"</li>";
			listTag += "<li class='reviewMainLike'>추천수:"+val.thumbup+"</li>";
			listTag += "<img src='/home/img/img_main/t.png' class='tapeBottom'/></ul></a></li>";
				
		});
		
		$("#reviewTop").html(listTag);
		
	}
</script>