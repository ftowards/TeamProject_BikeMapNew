<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<div style='width:800px; height:1500px; margin:0 auto'>
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
		<div id="paging">
			<ul>
			<!-- 이전 페이지 -->
				<c:if test="${pagingVO.nowPage != 1 }">
					<li><a href="#">Prev</a></li>
				</c:if>
				<c:forEach var="page" begin="${pagingVO.startPageNum }" end="${pagingVO.startPageNum + pagingVO.onePageNumCount -1}">
					<c:if test="${pagingVO.totalPage >= page }">
						<c:if test="${pagingVO.nowPage == page }">
							<li style='color:#00B0B0; font-weight:600;'>${page }</li>
						</c:if>
						<c:if test="${pagingVO.nowPage != page }">
							<li><a href="javascript:movePage(${page })" style='color:black; font-weight:600;'>${page }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
			<!-- 다음 페이지 -->
				<c:if test="${pagingVO.nowPage != pagingVO.totalPage }">
					<li><a href="#">Next</a></li>
				</c:if>
			</ul>
		</div><br/>
		<div id="content"></div>
	</div>
</div>
<script>
	$(function(){
		
		// 페이지 로딩 시 전체 리스트 불러오기
		movePage(1);
			
		// 검색
		$("#searchRoute").submit(function(){
			if($("#searchWord").val() == ""){
				alert("검색어를 입력하세요.");
				return false;
			};
			
			movePage(1);
			return false;
		});
	});
	
	
	//////////////////// function ///////////////////
	
	// 지도 썸네일 만들기
 	function makeThumbnail(result){
		$("#content").children().remove();
		
		for(var i = 0 ; i < result.length ; i++){
			var listTag = "";
			listTag += "<div class='contentDiv'><a href='routeSearchView?noboard="+result[i].noboard+"'><div id='map"+i+"' style='width:250px;height:250px;'></div></a>";
			listTag += "<div><img class='star' src='/home/img/img_main/star.png'/></div></div>";
			
			$("#content").append(listTag);
			
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
			    strokeColor: '#00B0B0', // 선의 색깔입니다
			    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			    strokeStyle: 'solid' // 선의 스타일입니다
			});
	    	polyline.setMap(map);
		}
	}
	
	// 페이징 리스트 만들기
	function setPaging(vo){
		// 이전 페이징 삭제
		$("#paging").children().remove();
		var tag = "<ul>";
		
		if(vo.nowPage != 1){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage -1)+");'>Prev</a></li>";
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
		
		$("#paging").append(tag);
					
	}
	
	// 페이지 이동
	function movePage(page){
		
		// 페이징 먼저 변경
		var url = "<%=request.getContextPath()%>/searchRoutePaging";
		var data = $("#searchRoute").serialize();
			data += "&nowPage="+page;
			
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				setPaging(result);
			},error : function(){
				console.log("페이징 오류");
			}
		});
		
		if($("#searchWord").val() ==""){
			url = "<%=request.getContextPath()%>/searchRouteAll";
		} else {
			url = "<%=request.getContextPath()%>/searchRouteOk";
		}

		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				if( result.length <= 0 ){
					alert("검색 결과가 없습니다.");
				} else{ 
					makeThumbnail(result);
				}
			}, error : function(){
				console.log("페이지 + 검색 결과 호출 에러");
			}
		});
	}
	
</script>