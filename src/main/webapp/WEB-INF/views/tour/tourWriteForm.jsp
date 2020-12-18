<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/home/css/tourWriteFormStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=48c22e89a35cac9e08cf90a3b17fdaf2&libraries=services,clusterer,drawing"></script>
<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<script src="https://www.google.com/jsapi"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyC2p-2EeJLzkfyPDjoo7RUtwrPmFtZxrnU&libraries=&v=weekly" defer></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/tour/tourWriteForm.js"></script>
<div id="mainDivTourWrite">
	<form id="tourWriteForm">
	<div id="tourWriteFormTitleDiv"><label id="tourWriteFormTitleLbl"><b>동행찾기 게시판 글쓰기</b></label><br/><hr/></div>
	
	<div id="RouteSearchDiv">
		<div>
			<img src="<%=request.getContextPath() %>/img/img_route/search.png" style='position:relative; left:-502px; width:30px'/>
			<input type="text" id="referenceSearch" placeholder="루트검색(제목/작성자/지역)" autocomplete="off"/>
			<hr style="opacity:0 ; height : 25px;"/>
			<div id="searchResultList">
			</div>
			<input type="hidden" id="reference" name="reference" 
				<c:if test="${vo.reference != null && vo.reference > 0 }">value='${vo.reference }'</c:if>/>
		</div>
	</div>
	
	<div class="infoDiv">
		<div id="routeResultDiv" class="routeResultDiv">
			<div><label class="tourWriteConditionTitle">루&nbsp;트</label></div>
			<div class="routeResultDiv2">
				<div class="routeTitleDiv">
					<div style='width:620px; height:70px; line-height : 70px;'><label class="labelClass" style="padding:0;">루트 제목</label>
						<div id="routeTitle" class="conditionBox"></div>
					</div>		
				</div>
				<div id="routeMap"><div class="placeholder">&nbsp;모집할 루트를 선택하세요.</div></div>
				<hr/>
				<div id="elevation_chart"></div>
			</div>
		</div>
		
		<div class="timeConditionDiv">
			<div><label class="tourWriteConditionTitle">시&nbsp;간</label></div>	
			<div id="conditionDiv">
				<div class="conditionDivTop">
					<div class="labelClass"><label>일&nbsp;정</label></div>
					<div>
						<input type="text" name="departuredate" placeholder="출발 날짜" id="departuredate" maxlength="10" autocomplete="off"/>
					</div>
					<div>
						<select name="departureTime" id="departureTime">
							<option >시간</option>
							<c:forEach var="i" begin="0" end="23" step="1">
								<option value="${i }">${i }시</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="conditionDivTop">
					<div>
						<input type="text" name="arrivedate" placeholder="도착날짜" id="arrivedate" maxlength="10" autocomplete="off"/>
					</div>
					<div>
						<select name="arriveTime" id="arriveTime">
							<option >시간</option>
							<c:forEach var="i" begin="0" end="23" step="1">
								<option value="${i }">${i }시</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="conditionDivTop">
					<div><label class="labelClass">장&nbsp;소</label></div>
					<div>   
						<input type="text" name="place" id="place" placeholder="ex)신촌역3번 출구" autocomplete="off"/>
					</div>
				</div>
				<div class="conditionDivTop" style="margin-top:20px;">
					<div><label  class="labelClass2">마감날짜</label></div>
						<div><input type="text" name="deadlinedate" placeholder="마감날짜" id="deadlinedate" maxlength="10" autocomplete="off"/></div>
					<div>
						<select name="deadlineTime" id="deadlineTime">
							<option >시간</option>
							<c:forEach var="i" begin="0" end="23" step="1">
								<option value="${i }">${i }시</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="timeConditionDiv2">	
			<div><label class="tourWriteConditionTitle">여&nbsp;행</label></div>		
				<div class="conditionDivTop2">
					<div><label  class="labelClass">거&nbsp;리</label></div>
					<div><input type="text" id="distance" name="distance" maxlength="4" class="conditionBox" readonly/></div>
					<label class="kmLbl1">km</label>
					<div><label  class="labelClass2" style="margin:-25px 0 0 19px;" >소요시간</label></div>
					<div><input type="text" id="tourtime" class="conditionBox" maxlength="3" style="margin:-25px 0 0 20px;" readonly/></div>
					
				</div>	
				<div class="conditionDivTop4">
					<div><label  class="labelClass2" >속&nbsp;도</label></div>
					<div><input type="number" name="speed" id="speed" maxlength="4" class="conditionBox"/></div>
						<label class="kmLbl2">km</label>
					<div><label  class="labelClass2" style="margin:-25px; position:relative; left:13px">비&nbsp;용</label></div>
					<div><input type="text" name="budget" id="budget" maxlength="6" class="conditionBox"/></div>
					<label class="wonLbl">원</label>					
				</div>	
			</div>
			<div class="timeConditionDiv3">	
				<div><label class="tourWriteConditionTitle">모집조건</label></div>	
					<div class="conditionDivTop3">
						<div><label  class="labelClass" style='text-align:left; padding-left:17px'>인&nbsp;원</label></div>
								<select name="room" id="room" style="text-align-last:center">
								<c:forEach var="i" begin="2" end="10" step="1">
									<option value="${i }">${i }</option>
								</c:forEach>
								</select>
			
						<div><label class="labelClass">성&nbsp;별</label></div>
						<div><label id="whole" for="reggender">전&nbsp;체</label></div>
						<div><label id="genderboy" for="boy">남</label></div>
						<div><label id="gendergirl" for="girl">여</label></div>
						
						<div><input type="checkbox"  id="reggender" /></div>
						<div><input type="checkbox" name="reggender" id="boy" value="1" /></div>
						<div><input type="checkbox" name="reggender" id="girl" value="2" /></div>
					</div>
				
					<div class="conditionDivTop">
						<div><label class="labelClass" style='text-align:left; padding-left:17px'>나&nbsp;이</label></div>
						<div><label id="whole2" for="regage">전&nbsp;체</label></div>
						<div><label id="regageten" for="ten">10대</label></div>
						<div><label id="regagetwenty" for="twenty">20대</label></div>
						<div><label id="regagethirty" for="thirty">30대</label></div>
					</div>
					<div class="conditionDivBottom">	
						<div><label id="regageforty" for="forty">40대</label></div>
						<div><label id="regagefiftyOver" for="fiftyOver" style="width:100px">50대 이상</label></div>
				
					
					<div><input type="checkbox"  id="regage" /></div>
					<div><input type="checkbox" name="regage" id="ten" value="1" /></div>
					<div><input type="checkbox" name="regage" id="twenty" value="2"/></div>
					<div><input type="checkbox" name="regage" id="thirty" value="3" /></div>
					<div><input type="checkbox" name="regage" id="forty" value="4" /></div>
					<div><input type="checkbox" name="regage" id="fiftyOver" value="5"/></div>
				</div>
			</div>
		</div>
	</div>		
			<div id="writeForm">		
					<ul>
						<li><input type="text" name="title" id="tourWriteTitle" placeholder="제목을 입력해주세요." maxlength="25"/></li>
						<li><textarea name="content" id="content"></textarea></li>
						<li><div id="writebuttonDiv">
							<input type="submit" value="등&nbsp;&nbsp;록"/>
							<input type="reset" value="다시쓰기"/>
						</div></li>
					</ul>
			</div>
	</form>
</div>
