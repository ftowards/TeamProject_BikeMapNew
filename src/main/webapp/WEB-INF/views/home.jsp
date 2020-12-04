<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ include file="/WEB-INF/views/inc/headerMainBxSlider.jspf"%>
<div id="mainDivHome">
	<div id="hitRoute">
		<span class="routeTitle">
			추천여행 코스&nbsp;
			<sub>561개</sub><br/>
			<span class="routeTitle2">바이크맵 관리자가 엄선하여 추천하는 추천 코스입니다.</span>
		</span><br/>
		<div id="content1">
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div><br/>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
			<div class="route">
				<a href="#">
					<img class="hitIcon" src="<%=request.getContextPath() %>/img/img_main/hit_icon.gif"/>
					<img class="thumbnail" src="<%=request.getContextPath() %>/img/img_main/임시.PNG"/>
				</a><br/>
				<img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/>
			</div>
		</div>
	</div><br/>
	
	<div id="routeSearch">
		<a href="<%=request.getContextPath()%>/routeSearch">
			<img style='width:3%' src="<%=request.getContextPath() %>/img/img_main/search.png"/>
			최근 다녀온 200개 루트 검색
		</a>
	</div>
	
	<div id="national">
		<span class="routeTitle">코스 후기</span><br/>
		<div id="location">
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div><br/>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
			<div class="review">
				<a href="#">
					<img src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
				</a>
			</div>
		</div>
	</div>
	<div>
		<a href="#" class="topIcon"><img src="<%=request.getContextPath() %>/img/img_main/top.png" onmouseover="this.src='<%=request.getContextPath() %>/img/img_main/top_over2.png'" onmouseout="this.src='<%=request.getContextPath() %>/img/img_main/top.png'"></a>
	</div>
</div>