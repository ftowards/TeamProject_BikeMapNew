<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/route.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/route/routeSearch.js"></script>
<div style='width:1200px; height:auto; margin:0 auto'>
	<div class="optionBar" >
		<form id="searchRoute" method="post" action="#">
			<select id="searchBarKey" name="searchBarKey" class="regionSelect">
	   		    <option value="title"<c:if test="${pagingVO.searchKey != null && pagingVO.searchKey == 'title' }">selected</c:if>>코스이름</option>
			    <option value="userid"<c:if test="${pagingVO.searchKey != null && pagingVO.searchKey == 'userid' }">selected</c:if>>작성자</option>
			    <option value="region" <c:if test="${pagingVO.searchKey != null && pagingVO.searchKey == 'region' }">selected</c:if>>지역</option>
			</select>
			<input type="text" id="searchBarWord" name="searchBarWord" class="schBar" style='padding-left:20px; color:#7F7F7F; font-size:17px; font-weight:bolder;'
				<c:if test="${pagingVO.searchWord != null}">value='${pagingVO.searchWord }'</c:if>/>
			<input type="submit" class="mint_Btn" value="검 색" style='width:70px; height:40px'/>
		</form>
		<form id="pagingVO" method="post" action="/home/routeSearchView" style="diplay:none">
			<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
			<input type="hidden" name="searchKey" value="${pagingVO.searchKey }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchKey }"/>
			<input type="hidden" name="noboard" value=""/>
		</form>
	</div>
	<div id="hitDiv">
		<div class="title">추천 루트</div>
		<div id="frame">
			<div id="poster" >
			</div>
		</div>
	</div>
	<div class="routeSearch">
		<div class="title">코스검색</div>
		<div class="orderRadio">
			<input type="radio"  name="order" id="orderNoboard" value="noboard" checked/><label for="orderNoboard" class="subTxt">최신순</label><span id="lBar">&ensp;|&ensp;</span>
			<input type="radio" name="order" id="orderRating" value="rating" /><label for="orderRating" class="subTxt" >평점순</label>
		</div>
	</div>
	<hr class='borderHr'/>
	<div id="content2"></div>
	<hr class='borderHr'/>
	<div id="paging" style='margin-bottom:115px'>
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
	</div>
</div>