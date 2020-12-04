<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/home/css/myRoute.css" type="text/css"/>

<div id="page-wrapper">
  <!-- 사이드바 -->
  <div id="sidebar-wrapper">
    <ul class="sidebar-nav">
      <li class="sidebar-brand">
     		<label>저장된 루트</label>   
      </li>
      <li><a href="<%=request.getContextPath()%>/mytourOn">진행여행</a></li>
      <li><a href="<%=request.getContextPath()%>/mytourClose">마감된 여행</a></li>
      <li><a href="<%=request.getContextPath()%>/mytourComplete">완료된 여행</a></li>

    </ul>
  </div>
  <!-- /사이드바 -->

  <!-- 본문 -->
  <div class="myRouteMainDiv">
    <div class="container-fluid">
      <div class="titleMyRouteDiv1"><label>완료된 여행</label></div>
     <div class="myRouteBoardMainDiv">
     	<div>
     		<table class="table table-striped table-hover">
     			<thead>
	     			<tr>
		     			<th>번&nbsp;호</th>
		     			<th>제&nbsp;목</th>
		     			<th>출발일시</th>
		     			<th>종료일시</th>
		     			<th>참&nbsp;가</th>
		     			<th>잔&nbsp;여</th>
		   
	     			</tr>
     			</thead>
     			<tbody>
     			<!-- =====================db작업(반복문)======================== -->
	     			<tr>
	     				<td>800</td>
		     			<td><a href="#">세란이네 코스</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">20-12-01 13:00</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">20-12-01 21:00</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">3</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">2</a></td>
	     			</tr>
	     		</tbody>
	     		<tbody>
     			<!-- ===================임시데이터(db작업 후 삭제)========================= -->
	     			<tr>
	     				<td>900</td>
		     			<td><a href="#">소라네 코스</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">20-12-01 13:00</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">20-12-01 21:00</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">3</a></td>
		     			<td><a data-toggle="collapse" href="#viewAcodian">2</a></td>
	     			</tr>
	     		</tbody>
     		</table>
     		<div id="viewAcodian" class="panel-collapse collapse">
     		<table class="table">
     			<thead>
	     			<tr>
		     			<th>참가자</th>
		     			<th>나이대</th>
		     			<th>모임횟수</th>
		     			<th>좋아요</th>
		     			<th>평가하기</th>

	     			</tr>
     			</thead>
  				<tbody>
					<!-- =====================db작업(아코디언 반복문)======================== -->
	     			<tr>
	     				<td>권세란</td>
		     			<td>20대</td>
		     			<td>5회</td>
		     			<td><img src="<%=request.getContextPath()%>/img/img_myRoute/like.png">5</td>
		     			<td><img src="<%=request.getContextPath()%>/img/img_myRoute/heartColor.png"></td>
		     		
	     			</tr>
				</tbody>
				<tbody>
					<!-- =====================임시데이터(db작업 후 삭제)======================== -->
	     			<tr>
	     				<td>박소라</td>
		     			<td>20대</td>
		     			<td>3회</td>
		     			<td><img src="<%=request.getContextPath()%>/img/img_myRoute/like.png">20</td>
		     			<td><img src="<%=request.getContextPath()%>/img/img_myRoute/heartGray.png" style="width:28px;margin-left:3px;"></td>
		     		
	     			</tr>
				</tbody>		
     		</table>
     				
  			</div>
     	</div>
     </div>
    </div>
  </div>
</div>