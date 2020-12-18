var nowPage = 1 ;

$(function(){
		
		$.ajax({
			url : "/home/route/getRecRoute",
			success : function(result){
				console.log(result);
				makeThumbnail(result, 1);
			}, error : function(err){
				console.log(err);
			}
		});
				
		$("#poster").on('mouseover',function(){
			step = 0;
		});
		
		$("#poster").on('mouseout', function(){
			step = 0.4;
		});
		
		nowPage = $("input[name=nowPage]").val();
		// 페이지 로딩 시 전체 리스트 불러오기
		movePage(nowPage);
			
		// 검색
		$("#searchRoute").submit(function(){
			if($("#searchBarWord").val() == ""){
				alert("검색어를 입력하세요.");
				return false;
			};
			movePage(1);
			return false;
		});
		
		$("input[name=order]").on('change',function(){
			movePage(nowPage);
		});
});
	
	var	timer = setInterval('postMove()',7);
	var left = 0;
	var step = 0.4;
	
	// 추천 루트 무한 루프
	function postMove(){
		left = left - step ;
		document.getElementById("poster").style.left = left +"px";
		
		var length = $("#poster>ul>li").length-1;
		if(left <= -300){
			left = 0;
			$("#poster>ul>li").eq(0).insertAfter($("#poster>ul>li").eq(length));
		}
	}
	
	//////////////////// function ///////////////////
	
	// 지도 썸네일 만들기
 	function makeThumbnail(result, type){
	
 		var mapId = 'map';
		if(type == 1){	mapId = 'recMap'; 	}
		
		var listTag = "<ul id='contentDivs'>";
		for(var i = 0 ; i < result.length ; i++){
			// 썸네일 작성부
			listTag += "<li class='contentDiv' onclick='goViewPage("+result[i].noboard+")'><div id='"+mapId+i+"' class='map'></div>";
			// 루트 설명 작성부
			listTag += "<div class='routeSubscript'><ul ><li class='wordCut' style='font-size:18px; color:#0f6767; font-weight:bold; margin:4px 0 2px 0'>"+result[i].title+"</li><li class='wordCut' style='font-size:15px; font-weight:bold'>"+result[i].region+"</li><li>총 거리 "+result[i].distance.toFixed(2)+"km</li>";
			var rateWidth =  (result[i].rating/5 *125);
			listTag += "<li style='text-align:right'>"+result[i].userid+"</li><li><span class='star-rating'><span style='width:"+rateWidth+"px'></span></span></li></ul></div></li>";
		}
		listTag +="</ul>";
		
		if(type == 1){	$("#poster").html(listTag);	}
		else{	$("#content2").html(listTag);	}
			
		for(var i = 0 ; i < result.length ; i++){
			var array = result[i].mapcenter.replace("(","").replace(")","").split(",");
			
			var container = document.getElementById(mapId+i);
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

		tag += "</ul>";
		$("#paging").append(tag);
					
	}
	
	// 페이지 이동
	function movePage(page){
		
		// 페이징 먼저 변경
		var url = "/home/searchRoutePaging";
		var data = "nowPage="+page+"&searchKey="+$("#searchBarKey").val()+"&searchWord="+$("#searchBarWord").val();
			data += "&order="+$("input[name=order]:checked").val();
				
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				if(result.totalRecord <= 0){
					toast("검색 결과가 없습니다.",1500);
					return false;
				}else{
					$("input[name=searchKey]").val($("#searchBarKey").val())
					$("input[name=searchWord]").val($("#searchBarWord").val())
					
					setPaging(result);
					nowPage = result.nowPage;
					$("input[name=nowPage]").val(nowPage);
					
					// 리스트 데이터 검색
					url = "/home/searchRouteOk";
					$.ajax({
						type : 'POST',
						url : url,
						data : data,
						success : function(result){
							makeThumbnail(result);
						}, error : function(){
							console.log("페이지 + 검색 결과 호출 에러");
						}
					});
				}
			},error : function(err){
				console.log("페이징 오류 "+ err);
			}
		});
	}

	// 뷰페이지 이동
	function goViewPage(noboard){		
		$("input[name=noboard]").val(noboard)
		var data = $("#pagingVO").serialize();
		data += "&order="+$("input[name=order]:checked").val();
		
		$("#pagingVO").submit();
	}