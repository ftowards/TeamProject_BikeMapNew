<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- Page Content -->

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
			<li><a href="#layer2" class="btn-example">hong1234</a>
			
			</li>
			<li>홍길동</li>
			<li>남</li>
			<li>54세</li>
			<li>34회</li>
			<li>14회</li>
			<li style="color:red">10회</li>
			<li style="color:red">정지중</li>
			<li style="color:red">20/11/01~20/11/31</li>
</ul>

<a href="#layer2" class="btn-example">hong1234</a>
<div class="dim-layer">
   			<div class="dimBg"></div>
    			<div id="layer2" class="pop-layer">
        			<div class="pop-container">
            			<div class="pop-conts">
                		<!--content //-->
                		<p class="ctxt mb20">Thank you.<br>
                   			Your registration was submitted successfully.<br>
                    		Selected invitees will be notified by e-mail on JANUARY 24th.<br><br>
                    		Hope to see you soon!
                		</p>

                		<div class="btn-r">
                    		<a href="#" class="btn-layerClose">Close</a>
                		</div>
                <!--// content-->
			            </div>
			        </div>
			    </div>
			</div>
</div>
<!-- Page Content -->