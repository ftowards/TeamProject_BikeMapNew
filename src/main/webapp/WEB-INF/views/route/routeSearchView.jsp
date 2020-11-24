<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAR4IoCrZIntPC-l88uOp-01K7m9-2svjo&libraries=&v=weekly" defer></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>
$(document).on('keyup', '#commentBox', function(e){
    var commentBox = $(this).val();
    $('#cntSPAN').text(getBytes(commentBox));    
});
 
function getBytes(str){
    var cnt = 0;
    for(var i =0; i<str.length;i++) {
        cnt += (str.charCodeAt(i) >128) ? 2 : 1;
    }
    return cnt;
}
</script>
<div class="mainDiv" style='margin-top:100px; width:900px; height:1800px;'>
	<div id="mapDiv" style='width:900px;'>
		<b>코스정보보기</b><br/><br/>
		<div class="wordCut" style='height:50px;'>${routeVO.title}</div>

		<p>${routeVO.userid }</p>
		<div id="map_Altitude">
			<div id="map" style='width:584px; height:300px;'>
			</div>
			<div id="elevation_chart" style='width:584px; height:165px;'>
			</div>
		</div>
		<div id="routeInfoDiv">
			<div id="routeInfo">
				<ul>
					<li><input type="text" value="${routeVO.routepoint1name }"/>
						<input type="hidden" name="routePoint" value="${routeVO.routepoint1point }"/></li>
					<li><input type="text" value="${routeVO.routepoint2name }"/>
						<input type="hidden" name="routePoint" value="${routeVO.routepoint2point }"/></li>
					<c:if test="${routeVO.routepoint3 != null }">
						<li><input type="text" value="${routeVO.routepoint3name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint3point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint4 != null }">
						<li><input type="text" value="${routeVO.routepoint4name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint4point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint5 != null }">
						<li><input type="text" value="${routeVO.routepoint5name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint5point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint6 != null }">
						<li><input type="text" value="${routeVO.routepoint6name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint6point }"/></li>
					</c:if>
					<c:if test="${routeVO.routepoint7 != null }">
						<li><input type="text" value="${routeVO.routepoint7name }"/>
							<input type="hidden" name="routePoint" value="${routeVO.routepoint7point }"/></li>
					</c:if>
				</ul>
				<input type="hidden" id="geocode" value="${routeVO.geocode }"/>
				<div class="title">코스평점</div>
				<div>
					<img src="<%=request.getContextPath() %>/img/img_main/star.png"/>
					<b>4.8</b>
				</div>
				<div style='padding-left:50px; font-size:1.1em'>
					<p>코스정보</p>
					<ul>
						<li>총 거리 :&nbsp;<span>${routeVO.distance }</span>km</li>
						<li>상승고도 :&nbsp;<span>${routeVO.ascent }</span>m</li>
						<li>하강고도 :&nbsp;<span>${routeVO.descent }</span>m</li>
					</ul>
				</div>
			</div>
			<div id="grade">
				<div class="title">별점주기</div>
					<select name="departurue" id="gradeSelect">
				    	<option value="">별점을 선택하세요</option>
					    <option value="5">★★★★★</option>
						<option value="4">★★★★☆</option>
						<option value="3">★★★☆☆</option>
						<option value="2">★★☆☆☆</option>
					    <option value="1">★☆☆☆☆</option>
				    </select>
				<input type="button" value="확&nbsp;인" class="gray_Btn" id="grayBtn"/>
			</div>
			<div style='text-align:center; margin-top:130px;'>
				<input type="submit" name="save" value="저&nbsp;장" class="mint_Btn" style='border-radius: 5px;'/>
				<input type="submit" name="recruitment" value="인원모집" class="WMint_Btn"/>
			</div>
		</div>
	</div>
	<div id="placeList">
		<div >
			<ul id="foodList">
				
				<li><c:if test="${placeVO.food1!= null }"></c:if></li>
				<li>3333음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div>
			<ul id="sightsList">
				<li>관광지</li>
				<li>A2222음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div>
			<ul  id="accommodationList">
				<li>숙박시설</li>
				<li>AAA음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div>
			<ul  id="convenientList">
				<li>편의시설</li>
				<li>AAA음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
	</div>

	<div id="commentDiv">
		<div id="cmtTitle">댓글 <span style='color:#00B0B0'>5</span></div>
		<span class="userid">hong1234</span>
		<input type="submit" value="등록" id="saveBtn" class="mint_Btn"/>
		<textarea id="commentBox" name="commentBox" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다." rows="5" cols="20" maxlength="100"></textarea>
		<div id="txtCounting"><span id="cntSPAN">0</span>&nbsp;<span>/200</span></div>
		<div id="CMTbottomDiv"></div>
	</div>
	<hr/>
	<div id="comment">
		<ul>
			<li class="userid">goguma</li>
			<li>총 200자인 긴 댓글은 이렇게 표시됩니다! 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다 긴 댓글은 이렇게 표시됩니다</li>
			<li>2020.10.20 13:48</li>
		</ul><hr style="margin:15px 0 15px 0;"/>
		<ul>
			<li class="userid">goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20 13:48</li>
		</ul><hr/>
		<ul>
			<li class="userid">goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20 13:48</li>
		</ul><hr/>
		<ul>
			<li class="userid">goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20 13:48</li>
		</ul><hr/>
		<ul>
			<li class="userid">goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20 13:48</li>
		</ul><hr/>
	</div>
	<div id="paging2" style='text-align:center; margin-top:30px;'>1&emsp;<span style='color:#00B0B0; font-weight:600;'>2</span>&emsp;3&emsp;4&emsp;5</div>
</div>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/routeSearchView.js"></script>