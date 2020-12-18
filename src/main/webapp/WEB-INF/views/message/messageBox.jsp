<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/home/css/messageBox.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/message/messageBox.js"></script>
<div id="page-wrapper">
  <!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	    	<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_tour/messge.png"/></li>
				<li class="sidebar-brand"><label style="color:rgb(0,176,176)">쪽지함</label></li>
				<hr/>
				<li><label for="receiveBox">받은 쪽지</label></li>
				<li><label for="sendBox">보낸 쪽지</label></li>
				<li><label for="noticeBox">알림</label></li>
				<li><label for="sendMessage">쪽지 보내기</label></li>
		    </ul>
		</div>
	</div>
	<div class="modal modal-sm modalPosition" id="dialog">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<!-- header -->
				<div class="modal-header" style="border:none">
					<label><img src="<%=request.getContextPath()%>/img/img_tour/messge.png" style="width:30px">&ensp;<span id="msgId"></span></label>
					<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
				</div>
				<!-- body -->
				<div id="msgView" class="modal-body">
				</div>
				<!-- footer -->
				<div class="modal-footer" style="border:none">
					
				</div>
			</div>
		</div>
	</div>	

  <!-- 본문 -->
	<div class="my">
    	<div class="container-fluid">
    		<!-- 탭 전환용 라디오 버튼 : 숨김 처리 -->
	    	<input type="radio" name="messageBox" id="receiveBox" value="1" checked/> 
	    	<input type="radio" name="messageBox" id="sendBox" value="2" />
	    	<input type="radio" name="messageBox" id="noticeBox" value="3" />
	    	<input type="radio" name="messageBox" id="sendMessage" value="4" />
			<!-- On 시작 -->	
			<div class="titleMyDiv1 tab"><label>받은 쪽지함</label>
				<span class="readYetChk">
					<input type="checkbox" id="read1" name="read" value="F" />
					<span>안 읽은 쪽지만 보기</span>
				</span>
				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<input type="button" name="readMsg" value="읽음" class="btn"/>
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="receiveBoxTitle" class="listTitle">
		     					<li><input type="checkbox" name="chkAll" id="chkAll1"/></li>
				     			<li>보낸회원</li>
				     			<li>내용</li>
				     			<li>날짜</li>
		     				</ul>
		     				<ul id="messageList1" class="list"></ul>
						</div>
						<div id="paging1" class="paging"></div>
					</div>
				</div>
			</div>
			<!-- 보낸 쪽지함 시작 -->
			<div class="titleMyDiv1 tab"><label>보낸 쪽지함</label>
				<span class="readYetChk">
					<input type="checkbox" id="read2" name="read" value="F" />
					<span>안 읽은 쪽지만 보기</span>
				</span>				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="sendBoxTitle" class="listTitle">
		     					<li><input type="checkbox"name="chkAll"  id="chkAll2"/></li>
				     			<li>받은회원</li>
				     			<li>내용</li>
				     			<li>날짜</li>
		     				</ul>
		     				<ul id="messageList2" class="list"></ul>
						</div>
						<div id="paging2" class="paging"></div>
					</div>
				</div>
			</div>
			<!-- Close 시작 -->
			<div class="titleMyDiv1 tab"><label>알림</label>
				<span class="readYetChk">
					<input type="checkbox" id="read3" name="read" value="F" />
					<span>안 읽은 쪽지만 보기</span>
				</span>				<input type="button" name="deleteMsg" value="삭제" class="btn_del"/>
				<input type="button" name="readMsg" value="읽음" class="btn" />
				
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="noticeBoxTitle" class="listTitle">
		     					<li><input type="checkbox" name="chkAll" id="chkAll3"/></li>
				     			<li>보낸회원</li>
				     			<li>내용</li>
				     			<li>날짜</li>
		     				</ul>
		     				<ul id="messageList3" class="list"></ul>
						</div>
						<div id="paging3" class="paging"></div>
					</div>
				</div>
			</div>
			<div class="titleMyDiv1 tab"><label>쪽지 보내기</label>
				<br/>
				<iframe src="/home/sendMsg" ></iframe>
			</div>
		</div>
	</div>
</div>