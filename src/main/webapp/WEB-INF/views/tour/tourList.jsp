<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/home/css/tourListStyle.css" type="text/css"/>
 <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
	$(function(){
		
		//성별 css,체크 변화
		$("#reggender").on('change', function(){
			console.log(111);
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
		
	});	
	//페이징 리스트 만들기
	function setPaging(vo){
		//이전 페이징 삭제
		$("#paging").children().remove();
		var tag="<ul>";
		
		if(vo.nowPage != 1){
			tag += "<li><a href='javascript.movePage("+(vo.nowPage-1)+");'>Prev</a></li>";
		}
		for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount-1; i++){
			if(vo.totalPage >= i){
				if(vo.nowPage == i){
					tag += "<li style='color:rgb(0,176,176)'><b>"+i+"</b></li>";
				}else{
					tag += "<li><a href='javascript:movePage("+i+")' style='color:black;'>"+i+"</a></li>";
				}
			}
		}
		if(vo.nowPage != vo.totalPage){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage+1)")'>Next</a></li>";
		}
		$("#paging").append(tag);
	}

	//페이지 이동
	function movePage(p){
		
		//페이징 변경
		var url ="<%=request.getContextPath()%>/search"
	}
	
</script>
<div id="mainDiv">
<form id="searchTour">	
	<div id="dateDiv">
		<div class="labelClass"><label>일&nbsp;정</label></div>
		<div><input type="text" name="departure" placeholder="출발날짜" id="departure" maxlength="10" autocomplete="off"></div>
		<div><label  id="label1">~</label></div>
		<div><input type="text" name="arrive"	placeholder="도착날짜" id="arrive" maxlength="10" autocomplete="off"></div>
	</div>
	
	<div id="placeDiv">
		<div><label class="labelClass">장&nbsp;소</label></div>
		<div><input type="text" name="place" placeholder="출발장소" id="place"></div>
		
		<div id="placeAndDistanceDiv">
			<div><label id="distanceLbl">이동거리</label></div>
			<div><input type="text" name="distance" placeholder="ex)10km" id="distance"></div>
		</div>	
	</div>
	
	<div id="regGenderDiv">
		<div><label class="labelClass">성&nbsp;별</label></div>
				<div><label id="whole" for="reggender">전&nbsp;체</label></div>
				<div><label id="genderboy" for="boy">남</label></div>
				<div><label id="gendergirl" for="girl">여</label></div>
				
				<div><input type="checkbox" name="reggender" id="reggender"/></div>
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
		
		<div><input type="checkbox" name="regage" id="regage" /></div>
		<div><input type="checkbox" name="regage" id="ten" value="1" /></div>
		<div><input type="checkbox" name="regage" id="twenty" value="2"/></div>
		<div><input type="checkbox" name="regage" id="thirty" value="3" /></div>
		<div><input type="checkbox" name="regage" id="forty" value="4" /></div>
		<div><input type="checkbox" name="regage" id="fiftyOver" value="5"/></div>
		
	</div>
	<div id="searchAndReset">
		<div><input type="submit" name="search" value="검&nbsp;색" id="search"></div>
		<div><input type="reset" name="reset" value="초기화" id="reset"></div>
	</div>
</form>
	<hr/>
	<div id="tourSearchTitleDiv"><label id="tourSearchTitleLbl"><b>동행찾기</b></label></div>
	<div  id="paging">
		<ul>
			<c:forEach begin="${paging.startPageNum }" end="${paging.startPageNum + paging.onePageNumCount -1 }" var="p">
				<c:if test="${paging.totalPage >= p }">
					<c:if test="${paging.nowPage == p }">
						<li style="color:rgb(0,176,176)"><b>${p }</b></li>
					</c:if>
					<c:if test="${paging.nowPage != p }">
						<li><a href="<%=request.getContextPath() %>/tourList?nowPage=${p }&onePageRecord=${paging.onePageRecord}">${p }</a></li>
					</c:if>
				</c:if>
			</c:forEach>
			<!-- 다음페이지 -->
				<c:if test="${paging.nowPage != paging.totalPage }">
					<li><a href="<%=request.getContextPath()%>/tourList?nowPage=${paging.nowPage+1}"></a></li>
				</c:if>
		</ul>
	</div>
	
	<!--  ===========================db작업 / 코스짜기 받아서 수정할 부분 -->
	<div id="tourBoardListDivTop">	
		<c:forEach var ="list" items="${viewAll }">
			<a href="<%=request.getContextPath()%>/tourView?noboard=${list.noboard}">
			<div class="tourImgDivClass">
				<div><img src="<%=request.getContextPath()%>/img/img_tour/map.png" class="tourImgClass"/></div>
					<div class="blackWrapDiv">	
						<p  style="font-size:15px;">${list.title }</p>
						<p style="font-size:12px;">${list.departure}~${list.arrive }</p>
						<hr style="width:150px;"/>
						<p style="font-size:36px; "><b>1Day</b></p>
					</div>
			</div>	
		</a>
		</c:forEach>
	</div>

	
		<div id="tourWriteDiv"><input type="button" name="tourWriteBoard" value="글쓰기" onclick="location.href='<%=request.getContextPath()%>/tourWriteForm'"></div>
</div>
