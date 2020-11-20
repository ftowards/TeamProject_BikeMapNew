<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<div class="mainDiv" style='margin-top:100px; width:900px;'>
	<div id="mapDiv">
		<b>코스정보보기</b><br/>
		<p>@hong1234</p>
		<div id="map_Altitude">
			<div>
				<img style='width:584px; height:300px;' src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
			</div>
			<div>
				<img style='width:584px; height:165px;' src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
			</div>
		</div>
		<div id="routeInfo">
			<div style='background-color:yellow; height:52.5%;'>
				<div class="title">코스이름</div>
				<div>별별</div>
				<ul>
					<li>총 거리</li>
					<li>심층고도</li>
					<li>하강고도</li>
				</ul>
			</div>
			<div style='background-color:orange; height:15%; text-align:center;'>
				<div style='background-color:green; height:60%;"'>별별별2</div>
			</div>
			<div style='text-align:center;'>
				<input type="button" name="save" value="저&nbsp;장"/>
				<input type="button" name="recruitment" value="인원모집"/>
			</div>
		</div>
	</div>
	<div id="placeList">
		<div id="restaurant">
			<ul>
				<li>3333음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div id="tour">
			<ul>
				<li>A2222음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div id="accommodation">
			<ul>
				<li>AAA음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
		<div id="facilities">
			<ul>
				<li>AAA음식점</li>
				<li>BBBB식당</li>
				<li>CCCC카페</li>
				<li>DDD음식점</li>
			</ul>
		</div>
	</div>
	<div id="commentDiv" style='background-color:pink;'>
		<div id="cmtTitle">댓글 3</div>
		<textarea id="commentBox">주제와 무관한 댓글은 삭제될 수 있습니다.</textarea>
	</div>
	<div id="comment">
		<ul>
			<li>goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20</li>
			<li>13:48</li>
		</ul>
		<ul>
			<li>goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20</li>
			<li>13:48</li>
		</ul>
		<ul>
			<li>goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20</li>
			<li>13:48</li>
		</ul>
		<ul>
			<li>goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20</li>
			<li>13:48</li>
		</ul>
		<ul>
			<li>goguma</li>
			<li>좋은 코스입니다.</li>
			<li>2020.10.20</li>
			<li>13:48</li>
		</ul>
	</div>
</div>