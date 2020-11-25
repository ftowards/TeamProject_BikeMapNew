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
	
	
	//===============댓글쓰기 200자 제한================
	$("#tourReplyWrite").keyup(function(){
		var commentBox = $(this).val();
	    $('#cntSPAN').text(getBytes(commentBox)); 
	});
	function getBytes(str){
	    var cnt = 0;
	    for(var i =0; i<str.length;i++) {
	        cnt += (str.charCodeAt(i) >128) ? 2 : 1;
	    }
	    return cnt;
	}
	//==================댓글 리스트 구하기=================
		function tourReplyListSelect(){
		var url ="/home/tourReplyList";
		var params="notour=${vo.notour}";
		
		$.ajax({
			url:url
			,data:params
			,success:function(result){
				var $result = $(result);
				var tag="";
				$result.each(function(i,v){
					tag += "<li style='color:rgb(64,64,64)'><b>"+ v.userid+"</b></li>";
					if(v.userid=='${logId}'){
						tag+="<div class='tourReplyEditDiv'><input type='button' class='tourReplyEdit' value='수정'/>";
						tag+="<input type='button' class='tourReplyDel' value='삭제'/></div>";
					}
					tag+="<li style='margin-top:10px;'>"+v.reply+"</li>";
					tag+="<li style='margin-top:10px;'>"+v.writedate+"</li><hr/>";
				});
				$("#tourReplyList").html(tag);
			},error:function(){
				console.log("댓글 선택 에러 발생....");
			}
			
		});
	}

	//===================댓글 쓰기==============================================
	//댓글이 있는지 없는지 확인
	$("#tourReplyForm").submit(function(){
		if($("#tourReplyWrite").val()==""){
			alert("댓글 내용을 입력해주세요.");
			return false;
		}
		//데이터 구하기
		var url ="/home/tourReplyWriteOk";
		var params = $("#tourReplyForm").serialize();
		
		$.ajax({
			url:url
			,data:params
			,success:function(result){
				tourReplyListSelect();
				$("#tourReplyWrite").val("");
				
			},error:function(){
				console.log("댓글쓰기 에러 발생..");
			}
		});
		
		return false;
	});
	
	tourReplyListSelect();
});

</script>
<div id="mainDiv">

	<div id="tourViewFormTitleDiv"><label id="tourViewFormTitleLbl"><b>동행찾기 게시판 글보기(게스트)</b></label><br/><hr/></div>
	
	<div id="RouteSearchDiv">
		<div><input type="text" name="noroute" placeholder="코스검색(코스번호/키워드)"/></div>
		<div><input type="button" name="routeSearchBtn" value="검&nbsp;&nbsp;색"/></div>
	</div>
	
	<div id="routeResultDiv">코스사진~~~~~</div>
	
	<div id="conditionDiv">
			<div class="conditionDivTop">
				<div class="labelClass"><label>일&nbsp;정</label></div>
				<div><label id="departure">${vo.departure}</label></div>
				<div><label  id="label1">~</label></div>
				<div><label id="arrive">${vo.arrive}</label></div>
			</div>
		
			<div class="conditionDivTop">
				<div><label class="labelClass2">장소/시간</label></div>
				<div>  
					<label id="place">${vo.place}</label>
				</div>
				<div>
					<label id="departureTime">13시</label>
				</div>
				<div>
					<label id="departureMinutes">30분</label>
				</div>
			</div>
		
			<div class="conditionDivTop">
				<div><label  class="labelClass2">이동거리</label></div>
				<div><label class="conditionBox">${vo.distance}</label></div>
			</div>	
			<div class="conditionDivTop">
				<div><label  class="labelClass2" >예상속도</label></div>
				<div><label  class="conditionBox">${vo.speed }</label></div>
				<div><label  class="labelClass2" style="margin-left:8px;">예상비용</label></div>
				<div><label  class="conditionBox">${vo.budget }</label></div>
			</div>	
			<span>&nbsp;</span>
			<div class="conditionDivTop">
				<div><label  class="labelClass">작성자</label></div>
				<div><label id="useridBox">${vo.userid}</label></div>
				<div><label  class="labelClass">인&nbsp;원</label></div>
					<label id="room" style="text-align-last:center">${vo.room }</label>
			</div>
			<div class="conditionDivTop">
				<div><label class="labelClass">성&nbsp;별</label></div>
				<div><label id="whole" for="reggender">전&nbsp;체</label></div>
				<div><label id="genderboy" for="boy">남</label></div>
				<div><label id="gendergirl" for="girl">여</label></div>
				
				<div><input type="checkbox" id="reggender"/></div>
				<div><input type="checkbox" name="reggender" id="boy" value="1" /></div>
				<div><input type="checkbox" name="reggender" id="girl" value="2" /></div>
			</div>
		
			<div class="conditionDivTop">
				<div><label class="labelClass">나&nbsp;이</label></div>
				<div><label id="whole2" for="regage">전&nbsp;체</label></div>
				<div><label id="regageten" for="ten">10대</label></div>
			</div>
			<div class="conditionDivBottom">
				<div><label id="regagetwenty" for="twenty">20대</label></div>
				<div><label id="regagethirty" for="thirty">30대</label></div>
				<div><label id="regageforty" for="forty">40대</label></div>
			</div>
			<div class="conditionDivBottom">
				<div><label id="regagefiftyOver" for="fiftyOver" style="width:100px">50대 이상</label></div>
			</div>
			
			<div><input type="checkbox" id="regage" /></div>
			<div><input type="checkbox" name="regage" id="ten" value="1" /></div>
			<div><input type="checkbox" name="regage" id="twenty" value="2"/></div>
			<div><input type="checkbox" name="regage" id="thirty" value="3" /></div>
			<div><input type="checkbox" name="regage" id="forty" value="4" /></div>
			<div><input type="checkbox" name="regage" id="fiftyOver" value="5"/></div>
		
		
			<div class="conditionDivTop" style="margin-top:20px;">
				<div><label  class="labelClass2">마감날짜</label></div>
				<div><label id="deadline">${vo.deadline}</label></div>
				<div>
					<label id="deadlineTime">15시</label>
				</div>
			</div>
	</div>
			<div id="writeForm">		
						<div><label id="tourWriteTitle">${vo.title}</label></div>
						<div id="content">${vo.content }</div>
			</div>
	
			<div id="roomCheckDiv">
				<div></div>
				<div><label>참여인원 확인하기></label></div>
			</div>
	
			<div id="tourStateDiv">
			<form>
				<div><button type="submit" name="state" value="1" id="stateApply">참가신청</button></div>
				<div><button type="submit" name="state" value="3" id="stateCancel">참가취소</button></div>
			</form>		 
			</div>
			
		<!-- ========================댓글 달기====================================================== -->
			<div id="tourReplyDivMain">
				<div id="tourReplyDiv">
					<div>댓글</div>
					<div style="color:rgb(0,176,176)"><b>3</b></div>
				</div>
				<div id="tourReplyUseridDiv">${logId}</div>
				<div id="tourReplytWriteDiv">
					<form method="post" id="tourReplyForm">
					<textarea name="reply" id="tourReplyWrite" maxlength="100" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다."></textarea>
					<div id="tourTextCntDiv"><span id="cntSPAN" style="padding-right:10px;">0</span>&nbsp;/200</div>
						<input type="hidden" name="notour" value="${vo.notour}">	
						<div><input type="submit" value="등 록" id="tourReplySubmit"></div>
					</form>	
				</div>
				<div id="tourReplyViewDiv">
				<hr/>
				<ul id="tourReplyList">
			
					</ul>
				</div>	
		</div>
</div>

