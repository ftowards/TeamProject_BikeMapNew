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
			<li id="contents" ><a href="javascript:userPopupOpen();">hong1234</a></li>
			
			
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
    <div id="userlayer" class="layerpop"
        style="width: 200px; height: 250px;">
        <article class="layerpop_area">
        <div class="title">회원정보</div>
        <a href="javascript:userPopupClose();" class="layerpop_close"
            id="userlayerbox_close"></a> <br/>
        <div class="content">
       	hong1234<br/>
       	가입 : 2020.07.24<br/>
        신고횟수 : 10회<br/>
        정지여부 : <span style="font-color:red">정지중</span><br/>
        정지지간 : <span style="font-color:red">2020.11.14</span><br/>
        <input type="button" name="userBanned" value="정지하기" onclick="javascript:suspendPopupOpen();"/>
        <input type="button" name="userPage" value="회원페이지">
        </div>
        </article>
    </div>
    
    <div id="userSuspend" class="layerpop"
    	style="width:300px;height:250px;">
    	<form action="">
	    	<article class="layerpop_area">
	    	<div class="title">회원 정지 설정</div>
	    	<a href="javascript:suspendPopupClose();" class="layerpop_close"
	    		id="suspendlayerbox_close"></a><br/>
	    	<div class="content">
	    	정지 기간 <input type="number" id="suspendTime" min="0" max="90"/>일
	    	<input type="button" name="30days" value="30" onclick="change_suspendTime(this.value)"/>
	    	<input type="button" name="60days" value="60" onclick="change_suspendTime(this.value)"/>
	    	<input type="button" name="90days" value="90" onclick="change_suspendTime(this.value)"/><br/>
	    	사유 <span id="spUsername">홍길동</span>회원님은 <span id="spReportNum">10회</span>
	    	이상 신고 접수되어 아래와 같이 서비스 이용이 제한되었습니다.<br/>
	    	메세지 <textarea placeholder="이용정지 관련 문의가 있으시면 아래 1:1 문의하기 버튼을 클릭하여 고객센터로 문의해 주시기 바랍니다."></textarea><br>
	    	<input type="submit" name="reportMessage" value="등록"/>
	    	</div>
	    	</article>
    	</form>
    </div>
</div>
<!-- Page Content -->