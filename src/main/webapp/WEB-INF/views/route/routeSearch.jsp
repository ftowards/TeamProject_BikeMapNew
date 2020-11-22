<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<div class="mainDiv">
	<div id="optionBar" style='float:left;'>
		<select name="departurue" id="regionSelect">
		    <option value="">키워드</option>
		    <option value="글제목">글제목</option>
   		    <option value="코스이름">코스이름</option>
		    <option value="작성자">작성자</option>
		</select>
		<input type="text" name="schBar" id="schBar" style='padding-left:10px; color:#7F7F7F; font-size:1em; font-weight:bolder;'/>
		<input type="submit" class="mint_Btn" value="검 색" style='width:70px; height:40px'/>
	</div>
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
	<div id="content">
		<div class="contentDiv">
			<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail2" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
			<div><img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/></div>
		</div>
		<div class="contentDiv">
			<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail2" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
			<div><img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/></div>
		</div>
		<div class="contentDiv">
			<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail2" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
			<div><img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/></div><br/>
		</div>
		<div class="contentDiv">
			<a href="<%=request.getContextPath()%>/routeSearchView"><img class="thumbnail2" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
			<div><img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/></div>
		</div>
		<div class="contentDiv">
			<a href="<%=request.getContextPath()%>/routeSearchView""><img class="thumbnail2" src="<%=request.getContextPath() %>/img/img_main/empire.png"/></a>
			<div><img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/></div>
		</div>
		<div class="contentDiv">
			<img class="thumbnail2" src="<%=request.getContextPath() %>/img/img_main/empire.png"/>
			<div><img class="star" src="<%=request.getContextPath() %>/img/img_main/star.png"/></div>
		</div>
	</div>
</div>