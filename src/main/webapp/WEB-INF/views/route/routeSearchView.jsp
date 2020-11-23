<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<div class="wordCut" style='height:50px;'>사용자가 만든 코스의 제목이 들어갈 자리입니다. 제목이 길어지면 텍스트는 점으로 표시됩니다.</div>

		<p>@hong1234</p>
		<div id="map_Altitude">
			<div>
				<img style='width:584px; height:300px;' src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
			</div>
			<div>
				<img style='width:584px; height:165px;' src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
			</div>
		</div>
		<div id="routeInfoDiv">
			<div id="routeInfo">
				<div class="title">코스평점</div>
				<div>
					<img src="<%=request.getContextPath() %>/img/img_main/star.png"/>
					<b>4.8</b>
				</div>
				<div style='padding-left:50px; font-size:1.1em'>
					<p>코스정보</p>
					<ul>
						<li>총 거리 :&nbsp;<span>AAA</span></li>
						<li>심층고도 :&nbsp;<span>BBB</span></li>
						<li>하강고도 :&nbsp;<span>CCC</span></li>
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
		<div id="restaurant">
			<ul>
				<li>음식점</li>
				<li>3333음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div id="tour">
			<ul>
				<li>관광지</li>
				<li>A2222음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div id="accommodation">
			<ul>
				<li>숙박시설</li>
				<li>AAA음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div id="facilities">
			<ul>
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