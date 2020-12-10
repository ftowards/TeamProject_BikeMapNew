<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/mySavedRouteBoardStyle.css" type="text/css"/>


<div id="page-wrapper">
	<!-- 첫번째 우클릭 div -->
	<div id="rightContext" class="rightContext" >
		<ul>
			<li onclick="excludeList();">리스트 제외</li>
			<li onclick="transferDialog();">카테고리 이동</li>
		</ul>
		<input type="button" class="btn" value="X" onclick="$('#rightContext').css('display','none');"/>
	</div>
	
	<!-- 2번째 추가 div -->
	<div id="rightContext2" class="rightContext" >
		<ul>
			<li><input type="button" class="btn" value="X" onclick="$('#rightContext2').css('display','none');"/></li>
			<li>
				<select id="cateMoveTO">
					<c:forEach var='cate' items="${list }">
	   					<option value="${cate.noroutecate }">${cate.catename }(${cate.recordcnt})</option>
		    		</c:forEach>		
	    		</select>
    		</li>
	    	<li><input type="button" class="btn move" value="옮기기" onclick="transferCategory();"/></li>
	    </ul>
	</div>
	<!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	  		<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_myRoute/bike6.png"/></li>
	     	 	<!-- 탭 카테고리 패널 -->
	     		<li class="sidebar-brand">
	     			<label>저장된 루트</label>   
	    		</li>
	    		<li><label for="tab1">전체 루트(<span id="totalRecord">5</span>)</label></li>
	    		
			</ul>
	   		<ul id="routeCateLbl" class="sidebar-nav">
	   			<c:forEach var='cate' items="${list }" begin="0" step="1" varStatus="status">
	   				<li><label for="tab${status.index+2 }">${cate.catename }(${cate.recordcnt})</label></li> 
		        </c:forEach>
	        </ul>
		</div>
	</div>
	<!-- 탭 조작 패널 -->
	<div id="routeCateRadio">
		<div class="container-fluid">
			<input type="radio" name="tab" class="tabCategory" id="tab1" value="0" checked/>
			<c:forEach var='cate' items="${list }" begin="0" step="1" varStatus="status">
	   			<input type="radio" name="tab" class="tabCategory" id="tab${status.index+2 }" value="${cate.noroutecate }"/>
	        </c:forEach>
		
		<!-- 본문 -->
    	<!-- 전체 코스 -->
			<div class="tabCategory">
				<div class="titleMyRouteDiv1">
					<label>전체 루트</label>
					<div class="orderRadio">
						<input type="radio"  name="order" id="orderNoboard0" value="noboard" checked/><label for="orderNoboard0" class="subTxt">최신순</label><span class="lBar">&ensp;|&ensp;</span>
						<input type="radio" name="order" id="orderRating0" value="rating" /><label for="orderRating0" class="subTxt" >평점순</label>
					</div>
				
	   				<div id="contentDiv0" class="contentBlock"></div>
					<div id="paging0" class="paging"></div>
				</div>
			</div>
			
			<!-- 개별 카테고리 리스트 만들기 -->
			<c:forEach var='cate' items="${list }">
	   			<div class="tabCategory">
					<div class="titleMyRouteDiv1">
						<label>${cate.catename }</label>
						<div class="orderRadio">
							<input type="radio"  name="order" id="orderNoboard${cate.noroutecate }" value="noboard"/><label for="orderNoboard${cate.noroutecate }" class="subTxt">최신순</label><span class="lBar">&ensp;|&ensp;</span>
							<input type="radio" name="order" id="orderRating${cate.noroutecate }" value="rating" /><label for="orderRating${cate.noroutecate }" class="subTxt" >평점순</label>
						</div>
	   					<div id="contentDiv${cate.noroutecate }" class="contentBlock"></div>
						<div id="paging${cate.noroutecate }" class="paging"></div>
					</div>
				</div>
	   		</c:forEach>
   		</div>
	</div> <!-- 탭 조작패널 -->
</div><!-- page-wrapper -->


<script>
var noroutecate = 0;
var nowPage = 1;

$(function(){
	// 페이지 로딩 시 전체 리스트 불러오기
	movePage(1);
			
	$("input[name=order]").on('change',function(){
		movePage(nowPage);
	});
	
	$("input[name=tab]").on('change', function(){
		noroutecate = $("input[name=tab]:checked").val();
		$("#orderNoboard"+noroutecate).prop("checked", true);
		movePage(1);
	});
	
	$(document).on('contextmenu', function(){
		  return false;
	});
	
});

//페이지 이동
function movePage(page){
	// 페이징 먼저 변경
	var url = "/home/myroute/paging";
	var data = "nowPage="+page+"&noroutecate="+noroutecate+"&order="+$("input[name=order]:checked").val();
	
	console.log(data);	
	$.ajax({
		url : url,
		data : data,
		success : function(result){
			if(noroutecate == 0){
				$("#totalRecord").text(result.totalRecord);
			}
			nowPage = result.nowPage;
			setPaging(result);
		},error : function(err){
			console.log("페이징 오류"+err);
		}
	});
}

// 페이징 리스트 만들기
function setPaging(vo){
	var tag = "";
	
	if(vo.totalRecord > 0){
		if(vo.nowPage != 1){
			tag += "<li onclick='movePage("+(vo.nowPage -1)+");'>Prev</a></li>";
		}
		
		for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount -1 ; i++){
			if(vo.totalPage >= i){
				if(vo.nowPage == i){
					tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
				}else{
					tag += "<li onclick='movePage("+i+")' style='color:black; font-weight:600;'>"+i+"</li>";
				}
			}
		}
		if(vo.nowPage != vo.totalPage){
			tag += "<li onclick='movePage("+(vo.nowPage+1)+")'>Next</li>";
		}
		getList(vo.nowPage);
	}else {
		tag +="<li>검색 결과가 없습니다.</li>";
	}
	$("#paging"+noroutecate).html(tag);
}

// 페이지에 맞춰서 리스트 얻기
function getList(page){
	var data = "nowPage="+page+"&noroutecate="+noroutecate+"&order="+$("input[name=order]:checked").val();
	
	$.ajax({
		url : "/home/myroute/selectMyroute",
		data : data,
		success : function(result){
			makeThumbnail(result);
		}, error : function(){
			console.log("페이지 + 검색 결과 호출 에러");
		}
	});
}

// 지도 썸네일 만들기
function makeThumbnail(result){
	
	var listTag = "";
	for(var i = 0 ; i < result.length ; i++){
		
		if(i== 0){
			listTag += "<ul>";
		}
		// 썸네일 작성부
		listTag += "<li class='contentDiv'><a class='targetArea' href='routeSearchView?noboard="+result[i].noboard+"' onclick='return false;' onmousedown='clickTumbnail(href);'><div id='map"+noroutecate+"_"+i+"' class='map'></div>";
		// 루트 설명 작성부
		listTag += "<div class='routeSubscript'><ul ><li class='wordCut'>"+result[i].title+"</li><li class='wordCut'>"+result[i].region+"</li><li>"+result[i].distance.toFixed(2)+"km</li>";
		var rateWidth =  (result[i].rating/5 *125);
		listTag += "<li>"+result[i].userid+"</li><li><span class='star-rating'><span style='width:"+rateWidth+"px'></span></span></li></ul></div></a></li>";
	}
	
	listTag += "</ul>";
	
	$("#contentDiv"+noroutecate).html(listTag);
	
	for(var i = 0 ; i < result.length ; i++){
		var array = result[i].mapcenter.replace("(","").replace(")","").split(",");
		
		var container = document.getElementById("map"+noroutecate+"_"+i);
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

var contextNoboard = "";
function clickTumbnail(href){
	var btn = event.button;
	contextNoboard =href.substring(href.indexOf("noboard=")+8); 
	console.log(href);
	console.log(contextNoboard);
	
	if(btn == 0){
		location.href = href;
	}else if(btn == 2){
		var x = event.pageX + 'px';
		var y = event.pageY + 'px';
		
		$("#rightContext").css("display", "block");
		$("#rightContext").css("top", y);
		$("#rightContext").css("left",x);
	}
	return false;
}

function excludeList(){
	$.ajax({
		url : "/home/myroute/excludeList",
		data : "noboard="+contextNoboard,
		success : function(result){
			if(result > 0){
				toast(contextNoboard +" 번 루트를 리스트에서 삭제하였습니다.", 1500);
				movePage(nowPage);
			}else{
				toast("루트 리스트 삭제 오류 입니다.", 1500);
			}
		},error : function(err){
			console.log(err);
		}
	});
}

function transferDialog(){
	var x = event.pageX + 'px';
	var y = event.pageY + 'px';
	
	$("#rightContext").css("display","none");
	$("#rightContext2").css("display","block");
	$("#rightContext2").css("top", y);
	$("#rightContext2").css("left",x);

}

function transferCategory(){
	var routecateTo = $("#cateMoveTO").val();
		
	if(noroutecate == routecateTo){
		toast("현재 위치한 카테고리입니다.",1500);
		return false;
	}
	
	var data = "noboard="+contextNoboard+"&noroutecate="+$("#cateMoveTO").val();
	console.log(data);
	
	$.ajax({
		url : "/home/myroute/transferCategory",
		data : data,
		success : function(result){
			if(result > 0){
				toast(contextNoboard +" 번 루트를 이동하였습니다.", 1500);
				setTimeout(function(){location.reload(true)},1500);
			}else{
				toast("카테고리 이동 오류 입니다.", 1500);
			}
		},error : function(err){
			console.log(err);
		}
	});
}
</script>
