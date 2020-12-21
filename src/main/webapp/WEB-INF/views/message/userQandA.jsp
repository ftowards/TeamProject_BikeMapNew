<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="/home/css/userQandA.css" type="text/css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/message/userQandA.js"></script>
<div id="page-wrapper">
  <!-- 사이드바 -->
	<div style="position: absolute;background-color:black;">
		<div id="sidebar-wrapper">
	    	<ul class="sidebar-nav">
	    		<li><img src="<%=request.getContextPath()%>/img/img_admin/QnA.png"/></li>
				<li class="sidebar-brand"><label style="color:rgb(0,176,176)">1:1문의하기</label></li>
				<hr/>
				<li><label for="sendQna">문의하기</label></li>
				<li><label for="readQna">나의 문의사항</label></li>
		    </ul>
		</div>
	</div>
  <!-- /사이드바 -->

  <!-- 본문 -->
	<div class="my">
    	<div class="container-fluid">
    		<!-- 탭 전환용 라디오 버튼 : 숨김 처리 -->
	    	<input type="radio" name="board" id="sendQna" value="1" checked/> 
	    	<input type="radio" name="board" id="readQna" value="2" />
			<!-- 1:1문의하기 Form -->	
			<div class="titleMyDiv1 tab"><label>문의하기</label>
				<ul class="qAndALbl">
					<li>-문의하신 내용을 신속하고 정확하게 답변 드리겠습니다.</li>
					<li>-상담에 대한 답변은 1:1문의>나의 문의사항 에서 확인하실 수 있습니다.</li>
					<li>-1:1 문의글 작성 후에는 수정, 삭제가 되지 않습니다.</li>
				</ul>	
				<form id="qnaInsert">
					<div class="qAndaTypeDiv">
						<ul>
							<li><div class="qAndaTypeLbl">문의유형</div></li>
							<li>
								<select name="noqnatype" class="qAndaTypeBox1">
									<c:forEach var="list" items="${qnatypeList }">
										<option value="${list.noqnatype }">${list.typename }</option>
									</c:forEach>
								</select>
							</li>
						</ul>
					</div>	
					<div class="subjectQandADiv">	
						<ul>
							<li><div class="subjectQandALbl">제&nbsp;목</div></li>
							<li><input type="text" id="subject" name="subject" class="qAndaSubjectBox"/></li>
						</ul>	
					</div>
					<div class="subjectQandADiv">	
						<ul>
							<li><div class="subjectQandALbl">내&nbsp;용</div></li>
							<li><textarea id="content" name="content" class="qAndaContentBox" rows='10' cols='50' maxlength='250'style="resize:none"></textarea></li>
						</ul>	
					</div>	
					<div class="qAndBtnDiv">	
						<ul>
							<li><input type="submit" value="문의하기" class="qandABtnLbl"></li>
							<li><input type="reset" value="다시쓰기" class="qandABtnResetLbl"></li>
						</ul>	
					</div>
				</form>
			</div>
			<!-- 나의 문의사항 시작 -->
			<div class="titleMyDiv1 tab"><label>나의 문의사항</label>
				<input type="checkbox" id="answer" name="answer" value="Y" />
				<span>답변 완료만 보기</span>
				<input type="button" name="deleteQna" onclick='deleteQna();' value="삭제" class="btn_del"/>
				<div class="myBoardMainDiv">
		     		<div>
		     			<div >
		     				<ul id="qnaListTitle" class="listTitle">
		     					<li><input type="checkbox" id="chkAll"/></li>
				     			<li>답변</li>
				     			<li>문의유형</li>
				     			<li>제목</li>
				     			<li>문의내용</li>
				     			<li>등록일</li>
		     				</ul>
		     				<ul id="qnaList" class="list"></ul>
						</div>
						<div id="paging" class="paging"></div>
					</div>
				</div>
				
				<!-- 문의사항 보기 Modal -->
				<div class="modal modalPosition" id="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
						<!-- header -->
						<div class="modal-header" style="border:none">
						
							<button data-dismiss="modal" class="applyTourCloseBtn">X</button>
						</div>
						<!-- body -->
						<div id="content" class="modal-body">
							<div class="qAndaTypeDiv">
								<ul>
									<li><div class="qAndaTypeLbl" style="background-color:rgb(0,176,176);">문의유형</div></li>
									<li><input type="text" id="modalQnatype" name="modalQnatype" class="qAndaTypeBox1" readonly/></li>
								</ul>
							</div>	
							<div class="subjectQandADiv">	
								<ul>
									<li><div class="subjectQandALbl" style="background-color:rgb(0,176,176);">제&nbsp;목</div></li>
									<li><input type="text" id="modalSubject" name="modalSubject" class="qAndaSubjectBox" readonly/></li>
								</ul>	
							</div>
							<div class="subjectQandADiv">	
								<ul>
									<li><div class="subjectQandALbl" style="background-color:rgb(0,176,176);">내&nbsp;용</div></li>
									<li><textarea id="modalContent" name="modalContent" class="qAndaContentBox" rows='10' cols='50' maxlength='250'style="resize:none" readonly></textarea></li>
								</ul>	
							</div>	
							<div class="subjectQandADiv">	
								<ul>
									<li><div class="subjectQandALbl" style="background-color:rgb(0,176,176);">답&nbsp;변</div></li>
									<li><textarea id="modalAnswercontent" name="modalAnswercontent" class="qAndaContentBox" rows='10' cols='50' maxlength='250'style="resize:none" readonly></textarea></li>
								</ul>	
							</div>
						</div>
							<!-- footer -->
							<div class="modal-footer" style="border:none">
								
							</div>
						</div>
					</div>
				</div>
			</div>
			
		</div>
	</div>
</div>