<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="/home/css/tourWriteFormStyle.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/home/api/ckeditor/ckeditor.js"></script>

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

	$(function(){
		$("#departure,#arrive,#deadline").datepicker({
			changeYear :true,
			changeMonth: true,
			constrainInput:true,
			dateFormat:"yy/mm/dd",
			dayNames:['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
			dayNamesMin:['일','월','화','수','목','금','토'],
			monthNamesShort:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			monthNames:['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			yearRange:"2019:2020"
		
		});
		

		CKEDITOR.replace('content',{
			height:600
			,width:1200
		
		}); 
	 
		
		$("#tourWriteForm").submit(function(){
			CKEDITOR.instances.content.updateElement();		
			
			
			if($("#departure").val()==""){
				alert("출발날짜를 입력하세요.");
				return false;
			}
			if($("#arrive").val()==""){
				alert("도착날짜를 입력하세요.");
				return false;
			}
			if($("#place").val()==""){
				alert("출발장소를 입력하세요.");
				return false;
			}
		 	if($("#departureTime").val()==""){
				alert("출발시간을 입력하세요.");
				return false;
			}
			 
			if($("#tourWriteTitle").val()==""){
				alert("제목을 입력하세요.");
				return false;		
			}
			
		 	if(CKEDITOR.instances.content.getData()==""){
				alert("글내용을 입력하세요.");
				return false;
			}
			 
			var url = "/home/tourWriteFormOk";
			var params = $("#tourWriteForm").serialize();
			
			$.ajax({
				type : 'POST',
				url : url,
				data : params,
				success : function(result){
					if(result>0){
						alert("글이 등록되었습니다.")
						location.href="/home/tourList";
					}else{
						alert("글등록이 실패하였습니다.");
					}
				},error:function(){
					console.log("글쓰기 오류");
				}
			});
			return false;
		});
	});
</script>

<div id="mainDivTourWrite">
	<form id="tourWriteForm">
	<div id="tourWriteFormTitleDiv"><label id="tourWriteFormTitleLbl"><b>동행찾기 게시판 글쓰기</b></label><br/><hr/></div>
	
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
					<input type="text" name="departure" placeholder="출발날짜" id="departure" maxlength="10" autocomplete="off"/>
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
					<input type="text" name="arrive"	placeholder="도착날짜" id="arrive" maxlength="10" autocomplete="off"/>
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
					<input type="text" name="place" id="place" placeholder="ex)신촌역3번 출구" autocomplete="off"/>
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
				<div><input type="text" name="distance" maxlength="4" class="conditionBox"/></div>
				<label class="kmLbl1">km</label>
				<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">비&nbsp;용</label></div>
				<div><input type="text" name="budget" maxlength="6" style="margin:-25px 0 0 20px;" class="conditionBox"/></div>
				<label class="wonLbl">원</label>
			</div>	
			<div class="conditionDivTop">
				<div><label  class="labelClass2" >속&nbsp;도</label></div>
				<div><input type="text" name="speed" id="speed" maxlength="4" class="conditionBox"/></div>
					<label class="kmLbl2">km</label>
					<div><label  class="labelClass2" style="margin:-25px 0 0 40px;">소요시간</label></div>
				<div><input type="text" name="" class="conditionBox" maxlength="3" style="margin:-25px 0 0 20px;"/></div>
					<label class="tourTimeLbl">시간</label>
			</div>	
</div>
<div class="timeConditionDiv3">	
<div><label class="tourWriteConditionTitle">모집조건</label></div>	
			<div class="conditionDivTop3">
				<div><label  class="labelClass">인&nbsp;원</label></div>
						<select name="room" id="room" style="text-align-last:center">
						<c:forEach var="i" begin="2" end="10" step="1">
							<option value="${i }">${i }</option>
						</c:forEach>
						</select>
	
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

