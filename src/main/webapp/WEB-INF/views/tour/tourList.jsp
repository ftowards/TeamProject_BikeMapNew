<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/home/css/tourListStyle.css" type="text/css"/>  
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/tour/tourList.js"></script>
<div id="mainDivTour">
	<div class="tourSearchListDiv">
		<form id="searchTour" method="post">	
			<input type="hidden" name="nowPage" value="${paging.nowPage }"/>
			<input type="hidden" name="noboard" value="0"/>
			<ul class="searchBoardUl">
				<li>
					<div class="labelClass1"><label>일&nbsp;정</label></div>
				</li>
				<li>
					<input type="text" name="departuredate" placeholder="출발날짜" id="departure" maxlength="10" autocomplete="off"value="${paging.departuredate}"/>
					<select name="departureTime" id="departureTime" class="departureTime">
						<option value="">시간</option>
						<c:forEach var="i" begin="0" end="24" step="1">
							<option value="${i }" <c:if test="${paging.departureTime != '' && paging.departureTime == i }">selected</c:if>>${i }시</option>
						</c:forEach>
					</select>
					<label class="label1">~</label>
					<input type="text" name="arrivedate"	placeholder="도착날짜" id="arrive" maxlength="10" autocomplete="off" value="${paging.arrivedate}"/>
					<select name="arriveTime" id="arriveTime" class="arriveTime">
						<option value="">시간</option>
						<c:forEach var="i" begin="0" end="24" step="1">
							<option value="${i }"<c:if test="${paging.arriveTime != '' && paging.arriveTime == i }">selected</c:if>>${i }시</option>
						</c:forEach>
					</select>
				</li>
		
				<li>
					<div><label class="labelClass1">장&nbsp;소</label></div>
				</li>
				<li>
					<input type="text" name="place" placeholder="출발장소" id="place" autocomplete="off" value="${paging.place }">
					<label class="labelClass1 distanceLbl">이동거리</label>
					<div class="distanceGroup"><input type="number" name="distance1" class="distance" maxlength="4" autocomplete="off" value="${paging.distance1 }">
						<label class="kmLbl">km</label></div>
					<label class="label1">~</label>
					<div class="distanceGroup"><input type="number" name="distance2" class="distance" maxlength="4" autocomplete="off" value="${paging.distance2 }">
						<label class="kmLbl">km</label></div>
				</li>
		
				<li>
					<div><label class="labelClass2">성&nbsp;별</label></div>
				</li>
				<li class="genderGroup">
					<label id="whole" for="reggender">전&nbsp;체</label>
					<label id="genderboy" for="boy">남</label>
					<label id="gendergirl" for="girl">여</label>
					
					<input type="checkbox" id="reggender"/>
					<input type="hidden" id="reggenderPaging" value="${paging.reggender }"/>
					<input type="checkbox" name="reggender" id="boy" value="1" />
					<input type="checkbox" name="reggender" id="girl" value="2" />
				</li>
		
				<li>
					<div><label class="labelClass3">나&nbsp;이</label></div>
				</li>
				<li class="ageGroup">
					<label id="whole2" for="regage">전&nbsp;체</label>
					<label id="regageten" for="ten">10대</label>
					<label id="regagetwenty" for="twenty">20대</label>
					<label id="regagethirty" for="thirty">30대</label>
					<label id="regageforty" for="forty">40대</label>
					<label id="regagefiftyOver" for="fiftyOver" style="width:100px">50대 이상</label>
					
					<input type="checkbox" id="regage" />
					<input type="hidden" id="regagePaging" value="${paging.regage }"/>
					<input type="checkbox" name="regage" id="ten" value="1" />
					<input type="checkbox" name="regage" id="twenty" value="2"/>
					<input type="checkbox" name="regage" id="thirty" value="3" />
					<input type="checkbox" name="regage" id="forty" value="4" />
					<input type="checkbox" name="regage" id="fiftyOver" value="5"/>
					
				</li>
				<li>
					<div>
						<input type="button" name="search" value="검&nbsp;색" id="search">
						<input type="button" id="reset" value="초기화" >
					</div>
				</li>
			</ul>
		</form>
	</div>
	<div>
		<div id="tourSearchTitleDiv"><label id="tourSearchTitleLbl"><b>동행찾기</b></label>
			<input type="button" name="tourWriteBoard" value="글쓰기" onclick="goWriteForm()"></div>
		
	
		<!--  ===========================db작업 / 코스짜기 받아서 수정할 부분 -->
		<div id="tourBoardListDivTop"></div>
		
		<div  id="paging">
			<ul>
				<!-- 이전 페이지 -->
					<c:if test="${paging.nowPage != 1 }">
						<li><a href="#">Prev</a></li>
					</c:if>
					<c:forEach var="p" begin="${paging.startPageNum }" end="${paging.startPageNum + paging.onePageNumCount -1}">
						<c:if test="${paging.totalPage >= p }">
							<c:if test="${paging.nowPage == p }">
								<li style='color:#00B0B0; font-weight:600;'>${p }</li>
							</c:if>
							<c:if test="${paging.nowPage != p }">
								<li><a href='javascript:movePage(${p })' style='color:black; font-weight:600;'>${p }</a></li>
							</c:if>
						</c:if>
					</c:forEach>
				<!-- 다음 페이지 -->
				<c:if test="${paging.nowPage != paging.totalPage }">
					<li><a href="#">Next</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>