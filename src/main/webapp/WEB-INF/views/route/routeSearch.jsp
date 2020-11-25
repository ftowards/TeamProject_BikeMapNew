<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<script>
	$(function(){
		$("#searchRoute").submit(function(){
			if($("#searchWord").val() == ""){
				alert("검색어를 입력하세요.");
				return false;
			};
			
			var url = "<%=request.getContextPath()%>/searchRouteOk";
			var data = $("#searchRoute").serialize();
			
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					
					$("#content").children().remove();
					
					console.log(result.length);
					
					for(var i = 0 ; i < result.length ; i++){
						var listTag = "";
						listTag += "<div class='contentDiv'><a href='routeSearchView?noroute="+result[i].noroute+"'><div id='map"+i+"' style='width:250px;height:250px;'></div></a>";
						listTag += "<div><img class='star' src='/home/img/img_main/star.png'/></div></div>";
						
						$("#content").append(listTag);
						
						console.log(result[0].mapcenter);
						var array = result[0].mapcenter.replace("(","").replace(")","").split(",");
						
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
						    strokeColor: '#00B0B0', // 선의 색깔입니다
						    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
						    strokeStyle: 'solid' // 선의 스타일입니다
						});

					    polyline.setMap(map);
					}
					
				}, error : function(){
					console.log("루트 리스트 호출 에러");
				}
			});
			return false;
		});
	})
	
</script>
<div class="mainDiv">
	<form id="searchRoute" method="post" action="#" class="optionBar" style='float:left;'>
		<select name="searchKey" class="regionSelect">
   		    <option value="title">코스이름</option>
		    <option value="userid">작성자</option>
		    <option value="region">지역</option>
		</select>
		<input type="text" id="searchWord" name="searchWord" class="schBar" style='padding-left:10px; color:#7F7F7F; font-size:1em; font-weight:bolder;'/>
		<input type="submit" class="mint_Btn" value="검 색" style='width:70px; height:40px'/>
	</form>
	<div id="hitDiv">
		<b>관리자 추천코스</b>
		<div id="hitCourse">
				<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
				<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
				<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
				<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
				<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
				<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
				<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
				<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
				<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
				<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
		</div>
	</div>
	<div id="routeSearch">
		<div class="title">코스검색</div>
		<div id="subTxt">평점순<span id="lBar">&ensp;|&ensp;</span><span style='color:#AEAAAA;'>최신순</span></div>
		<div id="paging">1&emsp;<span style='color:#00B0B0; font-weight:600;'>2</span>&emsp;3&emsp;4&emsp;5</div>
	</div><br/>
	<div id="content"></div>
</div>