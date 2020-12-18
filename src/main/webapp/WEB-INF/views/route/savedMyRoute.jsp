<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<link rel="stylesheet" href="/home/css/mySavedRouteBoardStyle.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/route/myTourList.js"></script>
<div id="page-wrapper">
	<!-- 첫번째 우클릭 div -->
	<div id="rightContext" class="rightContext" >
		<input type="button" class="btn" value="X" onclick="$('#rightContext').css('display','none');"/>
		<ul>
			<li onclick="excludeList();">리스트 제외</li>
			<li onclick="transferDialog();">카테고리 이동</li>
		</ul>
	</div>
	
	<!-- 2번째 추가 div -->
	<div id="rightContext2" class="rightContext2" >
		<input type="button" class="btn" value="X" onclick="$('#rightContext2').css('display','none');"/>
		<ul>
			<li>
				<select id="cateMoveTO">
					<c:forEach var='cate' items="${list }">
	   					<option value="${cate.noroutecate }">${cate.catename }(${cate.recordcnt})</option>
		    		</c:forEach>		
	    		</select>
    		</li>
	    	<li><input type="button" class="btn move" value="옮기기" style="margin-top:7px;" onclick="transferCategory();"/></li>
	    </ul>
	</div>
	<!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	  		<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_myRoute/bike6.png"/></li>
	     	 	<!-- 탭 카테고리 패널 -->
	     		<li class="sidebar-brand">
	     			<label style="color:rgb(0,176,176)">저장 루트</label>   
	    		</li>
	    		<hr/>
	    		<li><label for="tab1">전체 루트(<span id="totalRecord">5</span>)</label></li>
	    		
			</ul>
	   		<ul id="routeCateLbl" class="sidebar-nav">
	   			<c:forEach var='cate' items="${list }" begin="0" step="1" varStatus="status">
	   				<li><label for="tab${status.index+2 }">${cate.catename }(${cate.recordcnt})</label></li> 
		        </c:forEach>
	        </ul>
		</div>
	</div>
	<!-- 탭 조작 패널 -->
	<div id="routeCateRadio">
		<div class="container-fluid">
			<input type="radio" name="tab" class="tabCategory" id="tab1" value="0" checked/>
			<c:forEach var='cate' items="${list }" begin="0" step="1" varStatus="status">
	   			<input type="radio" name="tab" class="tabCategory" id="tab${status.index+2 }" value="${cate.noroutecate }"/>
	        </c:forEach>
		
		<!-- 본문 -->
    	<!-- 전체 코스 -->
			<div class="tabCategory">
				<div class="titleMyRouteDiv1">
					<label>전체 루트</label>
					<div class="orderRadio">
						<input type="radio"  name="order" id="orderNoboard0" value="noboard" checked/><label for="orderNoboard0" class="subTxt">최신순</label><span class="lBar">&ensp;|&ensp;</span>
						<input type="radio" name="order" id="orderRating0" value="rating" /><label for="orderRating0" class="subTxt" >평점순</label>
					</div>
				
	   				<div id="contentDiv0" class="contentBlock"></div>
	   				<div class="pagingDiv">
						<div id="paging0" class="paging"></div>
					</div>
				</div>
			</div>
			
			<!-- 개별 카테고리 리스트 만들기 -->
			<c:forEach var='cate' items="${list }">
	   			<div class="tabCategory">
					<div class="titleMyRouteDiv1">
						<label>${cate.catename }</label>
						<div class="orderRadio">
							<input type="radio"  name="order" id="orderNoboard${cate.noroutecate }" value="noboard"/><label for="orderNoboard${cate.noroutecate }" class="subTxt">최신순</label><span class="lBar">&ensp;|&ensp;</span>
							<input type="radio" name="order" id="orderRating${cate.noroutecate }" value="rating" /><label for="orderRating${cate.noroutecate }" class="subTxt" >평점순</label>
						</div>
	   					<div id="contentDiv${cate.noroutecate }" class="contentBlock"></div>
						<div id="paging${cate.noroutecate }" class="paging"></div>
					</div>
				</div>
	   		</c:forEach>
   		</div>
	</div> <!-- 탭 조작패널 -->
</div><!-- page-wrapper -->
