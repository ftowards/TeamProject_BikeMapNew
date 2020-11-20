<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->

<style>

</style>

<div id="adminTable">
<h1 id=tableHead>회원관리</h1>
<ul id="userList">
			<li>번호</li>
			<li>아이디</li>
			<li>이름</li>
			<li>성별</li>
			<li>나이</li>
			<li>모임횟수</li>
			<li>좋아요</li>
			<li>신고</li>
			<li>정지여부</li>
			<li>정지기간</li>
			<!-- DB작업완료 후 for문 생성 -->
			
			<li>857</li>
			<li id="contents" ><a href="javascript:goDetail('테스트');">hong1234</a></li>
			
			
			<li>홍길동</li>
			<li>남</li>
			<li>54세</li>
			<li>34회</li>
			<li>14회</li>
			<li style="color:red">10회</li>
			<li style="color:red">정지중</li>
			<li style="color:red">20/11/01~20/11/31</li>
</ul>
			   

    <!--Popup Start -->
    <div id="layerbox" class="layerpop"
        style="width: 350px; height: 350px;">
        <article class="layerpop_area">
        <div class="title">회원정보</div>
        <a href="javascript:popupClose();" class="layerpop_close"
            id="layerbox_close"></a> <br>
        <div class="content">
       	hong1234<br/>
       	가입 : 2020.07.24<br/>
        신고횟수 : 10회<br/>
        정지여부 : <span style="font-color:red">정지중</span><br/>
        정지지간 : <span style="font-color:red">2020.11.14</span><br/>
        <input type="button" name="userBanned" value="정지하기"/>
        <input type="button" name="userPage" value="회원페이지">
        </div>
        </article>
    </div>
    <div></div>



</div>
<!-- Page Content -->