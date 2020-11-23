<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- Page Content -->
<div id="adminTable">
		<h1 id=tableHead>1:1 문의</h1>
		<ul id="questionList">
			
			<li>번호</li>
			<li>아이디</li>
			<li>제목</li>
			<li>작성일자</li>
			<li>답변여부</li>
			
		
			<!-- DB작업완료 후 for문 생성 -->
			
			<li>80</li>
			<li>sss555</li>
			<li class="wordCut">동행 찾기 게시판에서 자꾸 오류가 나요</li>
			<li>작성일자</li>
			<li style="color:lightblue">답변여부</li>				
		</ul>
</div>
<div class="col-md-5 col-sm-5">
              <h2 class="h3-body-title">1대1 문의 내역</h2>
                                <div class="classic-form">
                                    <form class="form-horizontal" role="form" name="emailform" id="emailform" method="post" action="sendemail.php" novalidate="novalidate">
                                        <div class="form-group">
                                            <label for="name" class="col-sm-3 control-label">제목</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="name" name="name" placeholder="이름">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="email" class="col-sm-3 control-label">문의유형</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="tel" class="col-sm-3 control-label">상세내용</label>
                                            <div class="col-sm-9">
                                                <input type="text" class="form-control" id="tel" name="tel" placeholder="답변 시 문자로 발송됩니다.">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="content" class="col-sm-3 control-label">첨부 파일</label>
                                            <div class="col-sm-9">
                                                <textarea class="form-control" id="content" name="content" placeholder="내용" rows="7"></textarea>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                        	<label></label>
                                            <div class="col-sm-offset-3 col-sm-9">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <div class="col-sm-offset-3 col-sm-9">
                                                <button type="submit" id="formsubmit" class="btn btn-block btn-primary">답변달기</button>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
<!-- Page Content -->