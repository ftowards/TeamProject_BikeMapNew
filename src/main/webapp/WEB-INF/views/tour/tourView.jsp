<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/home/css/tourViewStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script>

$(function(){
	$("#reggender").on('change', function(){
		console.log(111);
		if($(this).is(":checked")){
			$("#whole").css('color','white').css('background-color','rgb(0,176,176)');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if(!($("input[name=reggender]").eq(i).prop("checked"))){
					$("input[name=reggender]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole").css('color','rgb(123,123,123)').css('background-color','white');
			for(var i = 0 ; i < $("input[name=reggender]").length ; i++){
				if($("input[name=reggender]").eq(i).prop("checked")){
					$("input[name=reggender]").eq(i).trigger('click');
				
				}
			}
		}
	});
	$("input[name=reggender]").on('change', function(){
		var type = $(this).attr("id");
		if($(this).prop("checked")){
			$("#gender"+type).css('color','white').css('background-color','rgb(0,176,176)');
		}else{
			$("#gender"+type).css('color','rgb(123,123,123)').css('background-color','white');
		}
	});

	$("#regage").on('change',function(){
		if($(this).is(":checked")){
			$("#whole2").css('color','white').css('background-color','rgb(0,176,176)');
			for(var i = 0; i < $("input[name=regage]").length ; i++){
				if(!($("input[name=regage]").eq(i).prop("checked"))){
					$("input[name=regage]").eq(i).trigger('click');
				}
			}
		}else{
			$("#whole2").css('color','rgb(123,123,123)').css('background-color','white');
			for(var i = 0 ; i < $("input[name=regage]").length ; i++){
				if($("input[name=regage]").eq(i).prop("checked")){
					$("input[name=regage]").eq(i).trigger('click');
				}
			}
		}
	});
	$("input[name=regage]").on('change', function(){
		var type = $(this).attr("id");
		if($(this).prop("checked")){
			$("#regage"+type).css('color','white').css('background-color','rgb(0,176,176)');
		}else{
			$("#regage"+type).css('color','rgb(123,123,123)').css('background-color','white');
		}
	});

});

</script>
<div class="mainDivTourView">

	<div id="tourViewFormTitleDiv"><label id="tourViewFormTitleLbl"><b>동행찾기 게시판 글보기(게스트)</b></label><br/><hr/></div>
	
	<div id="RouteSearchDiv">
		<div><input type="text" name="reference" placeholder="코스검색(코스번호/키워드)"/></div>
	</div>
	
	<div id="routeResultDiv">코스사진~~~~~</div>
	
<div class="timeConditionDiv">
<div><label class="tourWriteConditionTitle">시&nbsp;간</label></div>	
	<div id="conditionDiv">
			<div class="conditionDivTop">
				<div class="labelClass"><label>일&nbsp;정</label></div>
				<div>
					<div><label id="departure">${vo.departure}</label></div>
				</div>
				<div>
					<select name="departureTime" id="departureTime">
						<c:forEach var="i" begin="0" end="24" step="1">
							<option value="${i }">${i }시</option>
						</c:forEach>
					</select>
				</div>
				
				
			</div>
			<div class="conditionDivTop">
				<div>
					<div><label id="arrive">${vo.arrive}</label></div>
				</div>
				<div>
					<select name="arriveTime" id="arriveTime">
						<c:forEach var="i" begin="0" end="24" step="1">
							<option value="${i }">${i }시</option>
						</c:forEach>
					</select>
				</div>
			</div>
			
			
			<div class="conditionDivTop">
				<div><label class="labelClass">장&nbsp;소</label></div>
				<div>   
					<label id="place">${vo.place}</label>
				</div>
			</div>
			<div class="conditionDivTop" style="margin-top:20px;">
				<div><label  class="labelClass2">마감날짜</label></div>
					<div><input type="text" name="deadline" placeholder="마감날짜" id="deadline" maxlength="10" autocomplete="off"/></div>
				<div>
					<select name="deadlineTime" id="deadlineTime">
						<c:forEach var="i" begin="0" end="24" step="1">
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
				<div><label class="conditionBox">${vo.distance}</label></div>
				<label class="kmLbl1">km</label>
				<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">비&nbsp;용</label></div>
				<div><label style="margin:-25px 0 0 20px;"  class="conditionBox">${vo.budget }</label></div>
				<label class="wonLbl">원</label>
			</div>	
			<div class="conditionDivTop">
				<div><label  class="labelClass2" >속&nbsp;도</label></div>
					<div><label  class="conditionBox">${vo.speed }</label></div>
					<label class="kmLbl2">km</label>
					<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">소요시간</label></div>
					<div><label style="margin:-25px 0 0 20px;"  class="conditionBox">4</label></div>
					<label class="tourTimeLbl">시간</label>
			</div>	
</div>
<div class="timeConditionDiv3">	
<div><label class="tourWriteConditionTitle">모집조건</label></div>	
			<div class="conditionDivTop3">
				<div><label  class="labelClass">인&nbsp;원</label></div>
				<div><label id="room" style="text-align-last:center">${vo.room }</label></div>
	
				<div><label class="labelClass" style="margin-left:20px;">성&nbsp;별</label></div>
				<div><label id="whole" for="reggender">전&nbsp;체</label></div>
				<div><label id="genderboy" for="boy">남</label></div>
				<div><label id="gendergirl" for="girl">여</label></div>
				
				<div><input type="checkbox"  id="reggender"/></div>
				<div><input type="checkbox" name="reggender" id="boy" value="1" /></div>
				<div><input type="checkbox" name="reggender" id="girl" value="2" /></div>
			</div>
		
			<div class="conditionDivTop">
				<div><label class="labelClass">나&nbsp;이</label></div>
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




			<div id="writeForm">		
						<div><label id="tourWriteTitle">${vo.title}</label></div>
						<hr/>
						<div id="content">${vo.content }</div>
			</div>
	
			<div id="roomCheckDiv">
				
					<div></div>
		
				<div class="roomCheckDivLbl"><label>참여인원 확인하기></label></div>
			</div>
	
			<div id="tourStateDiv">
			<form>
				<div><button type="submit" name="state" value="1" id="stateApply">참가신청</button></div>
				<div><button type="submit" name="state" value="3" id="stateCancel">참가취소</button></div>
			</form>		 
			</div>
	<input type="hidden" id="noboard" value="${vo.noboard}">
	<%@ include file="../inc/reply.jspf"%>
</div>

