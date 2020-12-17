<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100&display=swap" rel="stylesheet">
<!-- Page Content -->
	<!-- /Page Sidebar -->
<script>
function setCloseRoute1(noboard, type){
  	// ++ 레퍼런스 사용 여부
  	var msg = "비공개 처리";
  	
  	$.ajax({
  		url : "/home/route/chkReference",
  		data : "noboard="+noboard,
  		success : function(result){
  			if(result > 0){
  				toast("현재 투어에 사용 중으로 "+msg+"가 불가합니다");
			}else{
			  	// 1. 스크랩 여부 >> 진행 시 스크랩 취소 됨
			  	
			  	$.ajax({
			  		url :"/home/route/setCloseRoute1",
			  		data : "noboard="+noboard,
			  		success : function(result){
			  			if(result == 1){
			  				toastConfirm("현재 추천 루트로 게시 중입니다. "+ msg +" 시 추천 루트 게시가 취소됩니다.<br/>진행 하시겠습니까?", function(){
			  					setCloseRoute2(noboard, type);
			  					// 스크랩 취소하는 펑션 필요
			  				});
			  			}else {
			  				setCloseRoute2(noboard, type);
			  			}
			  		}, error : function(err){
			  			console.log(err);
			  		}
			  	});
			}
  		},error : function(err){
  			console.log(err);
  		}
  	});
  }
  
  // 2. 현재 해당 루트를 가지고 있는 사람 수 체크 + 명단 가져오기
  function setCloseRoute2(noboard, type){
  	
  	var msg = "비공개 처리";
  	
	$.ajax({
  	  	url : "/home/route/setCloseRoute2",
  	  	data : "noboard="+noboard,
  	  	success : function(result){
  	  		console.log(result.length);
  	  		
  			if(result.length > 0){
  				toastConfirm("현재 "+result.length+"명이 해당 루트를 저장하고 있습니다.<br/>"+msg+" 시 루트 저장이 취소됩니다.<br/>진행 하시겠습니까?", function(){
  					// 저장 취소 , 안내 메세지 발송
  					cancelRouteSave(noboard, result, type);
  					
  					if(type == 'close'){
  						setCloseRoute3(noboard);
					}else if(type == 'del'){
						deleteRoute(noboard);
					}
  				});
  			}else {
  				if(type == 'close'){
  					setCloseRoute3(noboard);
				}else if(type == 'del'){
					deleteRoute(noboard);
				}
  			}
  		}, error : function(err){
  			console.log(err);
  		}
	});
  	
  }
 
 // 3. 비공개로 인한 루트 저장 취소 처리
 // 4. 루트 저장해서 가지고 있던 사람들에게 메세지 발송
  function cancelRouteSave(noboard, result, type){
  	var $result = $(result);
  	
  	var msgType = 1; // 1 : 비공개  , 2 : 삭제

  	
  	var cnt = 0 ;
  	$result.each(function(i,val){  	
  		$.ajax({
  			url : "/home/route/revertRoutelist",
  			data : "noboard="+noboard+"&userid="+val,
  			success : function(result){
  				if(result == 1){
  					sendMsg(noboard, val, msgType);
  				}else{
			  		toast("루트 저장 취소 오류<br/>관리자에 문의하십시오.");
  				}
  			}, error : function(err){
  				console.log(err);
  			}
  		});
  	});
  	
  }
  //비공개 처리
  function setCloseRoute3(noboard){
  	toastConfirm(noboard+"번 루트를 비공개 하시겠습니까?", function(){
	  	$.ajax({
	  		url : "/home/route/setCloseRoute3",
	  		data : "noboard="+noboard,
	  		success : function(result){
	  			if(result >0 ){
	  				toast(noboard+"번 루트를 비공개 처리하였습니다.",1500);
					setTimeout(function(){}, 1500);
					movePage($("#nowPage").val());	
	  			}else{
	  				toast("루트 비공개 처리 오류입니다.");
	  			}
	  		},error : function(err){
	  			console.log(err);
	  		}
	  	});
  	});
  }
  function setOpenRoute(noboard){
	  	
	  	toastConfirm("루트를 공개 처리하면 검색 및 다른 회원들의 리스트에 저장이 가능합니다.<br/>진행하시겠습니까?", function(){
	  		$.ajax({
				url : "/home/route/setOpenRoute",
				data : "noboard="+noboard,
				success : function(result){
					if(result == 1){
						toast(noboard + "번 루트가 공개처리 되었습니다.",1500);
						movePage($("#nowPage").val());				
					}else{
						toast("루트 공개 처리 오류입니다.");
					}
				},error : function(err){
					console.log(err);
				}
	  		});
	  	});
	  }	
function makeRouteTable(result){
	$("#routeList").children().remove();
	var listTag = "";
	for(var i = 0; i < result.length ; i++){
		
		if(i==0){
			listTag +=  "<li><input type='checkbox' id='checkAll'/></li><li>번&nbsp;&nbsp;호</li> <li>제&nbsp;&nbsp;목</li> <li>작성자</li> <li>평&nbsp;&nbsp;점</li><li>평가횟수</li><li>지&nbsp;&nbsp;역</li><li>비공개여부</li><li>관리자추천</li>"	;
		}			
		//list안에 데이터 추가
		listTag += "<li><input type='checkbox' name='listChk' value='"+result[i].noboard+"'/></li>";
		listTag += "<li>"+result[i].noboard+"</li>";
		listTag += "<li class='wordCut'><a href = '<%=request.getContextPath()%>/routeSearchView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
		listTag += "<li>"+result[i].userid+"</li>";
		listTag += "<li>"+result[i].rating+"</li>";
		listTag += "<li>"+result[i].ratecnt+"</li>";
		listTag += "<li class='wordCut' >"+result[i].region+"</li>";
		
		listTag += "<li>";
		listTag += "<label class='switch'>";
		listTag += "<input type='checkbox' name='adminHideBtn' value='"+result[i].noboard+"'";
		if(result[i].closed=='T'){
			listTag += "checked='checked'";
		}
		listTag += "><span class='slider round'></span>";
		
		listTag += "</li>";
		listTag += "<li>";
		listTag += "<label class='switch'>";
		listTag += "<input type='checkbox' name='adminScrapBtn' value='"+result[i].noboard+"'";
		if(result[i].scrap=='T'){
			listTag += "checked='checked'";
		}
		listTag += "><span class='slider round'></span>";
		listTag += "</label>";
		listTag += "</li>";
			
		}$("#routeList").append(listTag);
		
}

</script>	
	<!-- Page Content -->
	<div class="adminContent">	
				<div id="adminTable">
				<h1 class="adminListHead">루트게시판</h1>				
				<div class="orderRadio">
					<input type="radio" name="order" id="orderNoboard" value="noboard" checked="checked"><label for="orderNoboard" class="subTxt">최신순</label><span id="lBar"> | </span>
					<input type="radio" name="order" id="orderRating" value="rating"><label for="orderRating" class="subTxt">평점순</label>
				</div>
				<ul id="routeList">			
					<li><input type="checkbox" id="checkAll" /></li>		
					<li>번&nbsp;&nbsp;호</li>
					<li>제&nbsp;&nbsp;목</li>
					<li>작성자</li>
					<li>평&nbsp;&nbsp;점</li>
					<li>평가횟수</li>
					<li>지&nbsp;&nbsp;역</li>
					<li>비공개여부</li>
					<li>관리자추천</li>
					<!-- DB작업완료 후 for문 생성 -->
					<c:forEach items="${list}" var="vo" varStatus="status">
							<li><input type="checkbox" name="listChk" value="${vo.noboard}" /></li>
							<li>${vo.noboard}</li>
							<li class='wordCut'><a href = "<%=request.getContextPath()%>/routeSearchView?noboard=${vo.noboard }">${vo.title }</a></li>
							<li>${vo.userid}</li>
							<li>${vo.rating}</li>
							<li>${vo.ratecnt }</li>
							<li class='wordCut'>${vo.region}</li>
							<li>								
								<label class="switch">
								<c:if test="${vo.closed==null||vo.closed=='F'}">
									  <input type="checkbox" name="adminHideBtn" value="${vo.noboard }">				
								</c:if>
								<c:if test="${vo.closed=='T'}">
									  <input type="checkbox" name="adminHideBtn" value="${vo.noboard }" checked="checked" >							
								</c:if>
								 <span class="slider round"></span>
								</label>							
								<input type="hidden" class="userid" value="${vo.userid }"/>
							</li>
							<li>	
								<label class="switch">
								<c:if test="${vo.scrap==null||vo.scrap=='F'}">
									  <input type="checkbox" name="adminScrapBtn" value="${vo.noboard }">				
								</c:if>
								<c:if test="${vo.scrap=='T'}">
									  <input type="checkbox" name="adminScrapBtn" value="${vo.noboard }" checked="checked" >							
								</c:if>
								 <span class="slider round"></span>
								</label>							
								<input type="hidden" class="userid" value="${vo.userid }"/>
							</li>
					</c:forEach>
				</ul>
				</div>
				<!-- Page Content -->
				<!-- paging -->
			 
			<div id="paging">
					<ul>				
						<c:if test="${pagingVO.nowPage != 1 }">
							<li><a href="javascript:movePage(${pagingVO.nowPage-1 })"> Prev </a></li>
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
					
						<c:if test="${pagingVO.nowPage != pagingVO.totalPage }">
							<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
						</c:if>
					</ul>
			</div><br/>
			<!-- /paging -->
			</div><!-- adminContent -->
				<div id="partnerBtn">
						<input type="button" id="partnerBtn1" name="adminScrapAllBtn" value="관리자 추천" class="mint_Btn"/>
						<input type="button" id="partnerBtn2" name="adminReleaseAllBtn" value="관리자 추천 해제" class="red_Btn"/>
				</div><!-- btn -->
<!-- Page Content -->
</body>
</html>