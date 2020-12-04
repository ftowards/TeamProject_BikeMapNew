<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/home/css/mySavedRouteBoardStyle.css" type="text/css"/>


<div id="page-wrapper">
 	 <!-- 사이드바 -->
	<div id="sidebar-wrapper">
  	  <ul class="sidebar-nav">
    	<li><img src="<%=request.getContextPath()%>/img/img_myRoute/bike.png"/></li>
     	 <!-- 탭 카테고리 패널 -->
     	<li class="sidebar-brand">
     		<label>저장된 루트</label>   
    	</li>
     	<li><label for="tab1">전체코스(5)</label></li>
      	<li><label for="tab2">내 코스(3)</label></li>
       	<li><label for="tab3">장거리 코스(2)</label></li>
        <li><label for="tab4">단거리 코스(2)</label></li>
	   </ul>
	   </div>
    <!-- 탭 조작 패널 -->
	    <div>
	    	<input type="radio" name="tab" class="tabCategory" id="tab1" checked/>
	    	<input type="radio" name="tab" class="tabCategory" id="tab2"/>
	    	<input type="radio" name="tab" class="tabCategory" id="tab3"/>
	    	<input type="radio" name="tab" class="tabCategory" id="tab4"/>
	    	 
	    	 <!-- 본문 -->
	    	 <!-- 전체 코스 -->
  			<div class="tabCategory" id="tabCategoryPannel1">
				<div class="container-fluid">
    				<div class="titleMyRouteDiv1">
    					<label>전체코스</label>
    				</div>
    				<div  id="paging">
						<div class='tourImgDivClass'><a href="#">
							<div><img src="<%=request.getContextPath()%>/img/img_tour/map.png" class="tourImgClass"/></div>
						<div class="blackWrapDiv">
							<p style='font-size:25px;' class='tourBoardTitle'><b>제목제목</b></p>
							<p style='font-size:20px;' class='tourBoardWrite'>20/11/31~20/12/01</p>
							<hr style='width:200px;'/>
							<p style='font-size:40px;' class='tourBoardDay'><b>총3.12km</b></p>
							<p style='font-size:20px;' class='tourBoardUserid'>@작성자</p>
						</div>
						<div class="startPlaceDiv">별위치</div></a>
						</div>
					
					</div>
    				
 				</div>
   			</div>
   
   			
   			<!-- 내 코스 -->
     		<div  class="tabCategory" id="tabCategoryPannel2">
				<div class="container-fluid">
    				<div class="titleMyRouteDiv1">
    					<label>내 코스</label></div>
    				<div>
    					<div>23131434</div>
    				</div>
 				</div>
    		</div>
	   
	   
	   
	   
	   
	   </div> <!-- 탭 조작패널 -->
</div><!-- page-wrapper -->

