var $result ;
var socket = null;
var type ;
var btn, userid;

	$(function(){
		type = $("#type").val();
		
		sock = new SockJS('/home/echo');
		socket = sock;
		  
		sock.onopen = function(){
			console.log("통신 연결 완료");
		}
		
		
		sock.onclose = function(){
			console.log("연결 종료");
		}
		
		sock.onerror = function(err){
			console.log("통신 장애 " + err);
		}
		
		$(document).on('click','.contents',function(){
	    	btn = $(this);  
	    	var userName = btn.next().text();
	    	console.log(userName);
	    	var userEmail = $(this).children(".hiddenEmail").val();
	    	var userRegdate = $(this).children(".hiddenRegdate").val();
	    	$('#modalUsername').html(userName); 
	    	$('#modalEmail').html(userEmail); 
	        $('#modalRegidate').html(userRegdate);     
    	});
    	
    	$(document).on('click','#suspendBtn',function(){
	    	btn = $(this);   	
	    	userid = $(this).attr("title");
	        $('#userid').val(userid);        
	        $('#spUserid').text(userid);
	        $("#suspendTime").val(0);
    	});
    	
    	$(document).on('click','#suspendEditBtn',function(){
    		btn = $(this);
	    	userid = $(this).attr("title");
	        $('#suspendEditUserid').val(userid);
	        $('#spEditUserid').text(userid);
	        $("#suspendTime").val(0);
   		 });
    	
    	$(document).on('submit',"#userSuspendFrm", function(){	
	        var params = $("#userSuspendFrm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
	        jQuery.ajax({
	            url: 'userSuspendOk',
	            type: 'POST',
	            data:params,
	            contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	            success: function (result) {
	                $('#modal_simple').modal('toggle');		
	                movePage($("#nowPage").val());
	            },
		        error:function(e){
	            	console.log('정지연장', e.responseText);
	            }
	        });	
	        return false;
        });
        
		$(document).on('submit',"#userSuspendEditFrm", function(){	
			var params = jQuery("#userSuspendEditFrm").serialize(); // serialize() : 입력된 모든Element(을)를 문자열의 데이터에 serialize 한다.
	        jQuery.ajax({
	            url: 'userSuspendUpdateOk',
	            type: 'POST',
	            data:params,
	            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
	            success: function (result) {
	            	$('#modal_suspendEdit').modal('toggle');
	            	if(result.enddayStr==null){
		            	console.log(result); 	
		            	movePage($("#nowPage").val());	         	
	            	}	            	
	            	btn.parent().next().text(result.enddayStr);	            	
	            },
	            error:function(e){
	            	console.log('정지연장', e.responseText);
	            }
	        });
	        return false;
	 	});  	

    	// 라디오버튼 클릭시 이벤트 발생
		$('input:radio[name=selSuspend]').click(function(){	
            if($('input[name=selSuspend]:checked').val() == "0"){
                //$('input:number[name=endday]').attr("readonly",true);
                $('input[name=endday]').val(-91);
                $('#aa').hide();
                // radio 버튼의 value 값이 0이라면 비활성화, 최대값+1을 빼준다.->정지 해제
     
            }else if($("input[name=selSuspend]:checked").val() == "1"){
                  $('input[name=endday]').val(0);
                  $('#aa').show();
                  // radio 버튼의 value 값이 1이라면 활성화
            }
        }); 
    	
    	
    	$("#adminSearchFrm").submit(function(){
    		if($("#userSearchWord").val() == ""){
    			toast("검색어를 입력하세요.", 1500);
    			movePage($("#nowPage").val());
    			return false;
    		}
    		return true;
    	});
    	
    	$('#reportMsg').on('keyup', function() {
 		   if($(this).val().length > 200) {//varchar500이므로...
 		         $(this).val($(this).val().substring(0, 200));
 		   }
 		});

    	/* 체크박스버튼관련 메소드 */
    	$(document).on('click','#checkAll', function(){
			 $('input:checkbox[name=listChk]').not(this).prop('checked', this.checked);
		});	
    	
    	// 체크된 개별 버튼  클릭시     	
    	$(document).on('change','input:checkbox[name=adminScrapBtn]', function(){
    		var noboard = $(this).val();
    		var userid = $(this).parents().next(".userid").val();
    		var closed = $(this).parents().parents().prev().children("label").children("input").is(":checked");
    		
    		var dataSingle = {"noboard":noboard};

    		//추천하는경우
    		if($(this).is(":checked") == true) {
    			if(closed == true){
    				toast("현재 비공개 중인 루트 입니다.",1500);
    				$(this).prop("checked", false);
    				return false;	
    			}
    			
    			$.ajax({
		            url: 'scrapRoute',
		            data:dataSingle,
		            success: function (result) {
		            	if(result>0){
			            	leaveMessage(noboard, userid);
			            	toast(userid+"님의 글이 추천되었습니다.", 1500);
		            	}else{
		            		console.log("스크랩 실패;;")
		            	}	    
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
		        });
    		}else if($(this).is(":checked")==false){ //추천 해제
    			$.ajax({
		            url: 'releaseRoute',
		            data:dataSingle,
		            success: function (result) {
		            	if(result>0){
			            	toast("스크랩 해제 완료",1500);         
		            	}else{
		            		toast("스크랩 해제 실패", 1500);
		            	}	    
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
		        });
    		}
    	});
    	
    	// 관리자 루트 추천 한꺼번에 여러개
    	$(document).on('click','input:button[name=adminScrapAllBtn]', function(){
    	
    		var chkArray = new Array();
    		var noboards = "";
    		var useridAll = "";
			
    		$('input:checkbox[name=listChk]:checked').each(function(){	
				chkArray.push(this.value);
				noboards += this.value+"/";
    		});
			
    		//현재 고치게 될 넘버만 들어있음.
			for(var i=0; i<chkArray.length; i++){
				for(var j = 0 ; j< 10 ; j++){
					if(chkArray[i] == $("#routeList>li").eq(9*(j+1)+1).text()){
						useridAll += $("#routeList>li").eq(9*(j+1)+3).text()+"/";
					}
				}
			}

			//추천하는경우
    		if(chkArray.length>0) {
   				
   				$.ajax({
		            url: 'scrapRouteAll',
		            data: "noboards="+noboards + "&userids="+useridAll,
		            success: function (result) {
		            	
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
	      	  	});
   				movePage($("#nowPage").val());
   				return false;
    		}
    	});

    	//루트추천해제 여러개
    	$(document).on('click','input:button[name=adminReleaseAllBtn]', function(){	    		
    		var chkArray = new Array();
    		var alreadyChk = new Array();
			$('input:checkbox[name=listChk]:checked').each(function(){	
				chkArray.push(this.value);	
    		});

			//현재 체크표시한 데이터가 이미 해제되어있는지 확인한다. 벨류가 눌러져있는지 확인.
    		$('input:checkbox[name=adminScrapBtn]:not(:checked)').each(function(){
				var index = chkArray.indexOf(this.value); 			
				if(index>-1){
    				chkArray.splice(index, 1);
    			}
				console.log("삭제");
			});
			
    		if(chkArray.length>0) {  			
    			for(var i=0; i<chkArray.length; i++){
    				var dataSingle = {"noboard":chkArray[i]};
    				$.ajax({
		            url: 'releaseRoute',
		            data:dataSingle,
		            success: function (result) {
		            	if(result>0){
			            	console.log("스크랩 해제 완료");         
		            	}else{
		            		console.log("스크랩 실패")
		            	}	    
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
		        });
    			}
    			movePage($("#nowPage").val());
    		}
    	});
    	
    	// 관리자 루트게시판 비공개 처리
    	// 체크된 루트비공개 개별 버튼  클릭시 
    	$(document).on('change','input:checkbox[name=adminHideBtn]', function(){	
    		var noboard = $(this).val();
    		var type="close";
    		if($(this).is(":checked") == true) {  
    			setCloseRoute1(noboard, type);
    		}else{
    			setOpenRoute(noboard);
    		}
    		movePage($("#nowPage").val());
    	});
//     	  	
    	$(document).on('change','input:radio[name=order]', function(){	
    		var order = $("input[name=order]:checked").val();
    		//추천하는경우
    		movePage(1);
    	});
    	
    	//리뷰게시판 관리자 추천 비추천
    	$(document).on('change','input:checkbox[name=adminReviewScrapBtn]', function(){	
    		var noboard = $(this).val();
    		var userid = $(this).parents().next(".userid").val();
    		
    		var dataSingle = {"noboard":noboard};
    		
    		//리뷰게시판 추천하는경우
    		if($(this).is(":checked") == true) {  
    			$.ajax({
		            url: 'scrapReview',
		            data:dataSingle,
		            success: function (result) {
		            	if(result>0){
			            	leaveMessage(noboard, userid);
			            	toast(userid+"님의 글이 추천되었습니다.", 1500);
		            	}else{
		            		console.log("스크랩 실패;;")
		            	}	    
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
		        });
    		}else if($(this).is(":checked")==false){//리뷰게시판 추천 해제
    			$.ajax({
		            url: 'releaseReview',
		            data:dataSingle,
		            success: function (result) {
		            	if(result>0){
			            	toast(userid+"님의 글이 추천 해제 되었습니다.", 1500);      
		            	}else{
		            		console.log("스크랩 해제 실패;;")
		            	}	    
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
		        });
    		}
    	});
    	
    	// 리뷰게시판 관리자 추천 한꺼번에 여러개
    	$(document).on('click','input:button[name=adminReviewScrapAllBtn]', function(){	    		
    		var noboards = "";
    		var useridAll = "";
    		   		
    		$result.each(function(i, val){
    			if($("input[name=listChk]").eq(i).prop("checked")){
    				
       				$.ajax({
    		            url: 'scrapReviewAll',
    		            data: "noboard="+val.noboard + "&userid="+val.userid,
    		            success: function (result) {
    		            	if(result>0){
    			            	leaveMessage(val.noboard, val.userid, 4);
    		            		setTimeout(function(){}, 1500);
    		            	}else{
    		            		console.log("스크랩 실패;;")
    		            	}	    
    		            },
    		            error:function(e){
    		            	console.log('관리자 추천', e.responseText);
    		            	return false;
    		            }
    	      	  	});

    			}
    		});
    		
    		movePage($("#nowPage").val());
    	});
    	
    	//리뷰글 추천해제 여러개
    	$(document).on('click','input:button[name=adminReviewReleaseAllBtn]', function(){	    		
    		var chkArray = new Array();
    		var alreadyChk = new Array();
			$('input:checkbox[name=listChk]:checked').each(function(){	
				chkArray.push(this.value);	
    		});
			//현재 체크표시한 데이터가 이미 해제되어있는지 확인한다. 벨류가 눌러져있는지 확인.
    		$('input:checkbox[name=adminReviewScrapBtn]:not(:checked)').each(function(){
				var index = chkArray.indexOf(this.value); 			
				if(index>-1){
    				chkArray.splice(index, 1);
    			}
			});
    		if(chkArray.length>0) {  			
    			for(var i=0; i<chkArray.length; i++){
    				var dataSingle = {"noboard":chkArray[i]};
    				$.ajax({
		            url: 'releaseReview',
		            data:dataSingle,
		            success: function (result) {
		            	if(result>0){
			            	console.log("스크랩 해제 완료");         
		            	}else{
		            		console.log("스크랩 실패")
		            	}	    
		            },
		            error:function(e){
		            	console.log('관리자 추천', e.responseText);
		            	return false;
		            }
		        });
    			}
    			movePage($("#nowPage").val());
    		}
    	});
    	
		movePage(1);
		$("input[name=state]").on('change', function(){
			movePage(1);
		});
		
		$("#checkAll").on("change", function(){
			if($("#checkAll").prop("checked")){
				$("#reviewList input[name=listChk]").prop("checked",true);
			}else{
				$("#reviewList input[name=listChk]").prop("checked",false);
			}
		});
		
		$(function(){
			$("#replyFrm").submit(function(){
				if($("#questionReplyTxt").val()==""){
					alert("답변을 입력하세요..");
					return false;
				}
				return true;
			});
		});	
		
		$("input[name=answer]").on('change', function(){
			movePage(1);
		});
		
		$(document).on("change", "input[id=checkAll]", function(){
			if($("#checkAll").prop("checked")){
				$("#questionList input[name=chkList]").prop("checked",true);
			}else{
				$("#questionList input[name=chkList]").prop("checked",false);
			}
		});
				
    });


	// function ///////////////////////////////////////////////

	//Admin USER 테이블
    //버튼 클릭시 정지기간 조정
    function change_suspendTime(time){
    	$('#suspendTime').val(time);
    }
    
    function change_suspendEditTime(time){
    	$('#suspendEditTime').val(time);
    }
    
    //페이징 리스트 만들기
    function setPaging(vo){

		var tag = "<ul>";
		if(vo.nowPage != 1){
			tag += "<li style='margin-right:25px;'><a href='javascript:movePage("+(vo.nowPage -1)+");'>Prev</a></li>";
		}
		
		for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount -1 ; i++){
			if(vo.totalPage >= i){
				if(vo.nowPage == i){
					tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
				}else{
					tag += "<li><a href='javascript:movePage("+i+")' style='color:black; font-weight:600;'>"+i+"</a></li>";
				}
			}
		}

		if(vo.nowPage != vo.totalPage){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage +1)+")'>Next</a></li>"
		}
		$("#paging").html(tag);	
		$("#nowPage").attr("value",vo.nowPage);
	}
	
	function movePage(page){		
		// 페이징 먼저 변경
		var url = "/home/adminPaging";
		var data = $("#adminSearchFrm").serialize();
		data += "&order="+$("input[name=order]:checked").val();	
		data += "&nowPage="+page;
		
		if(type=='qna'){
			data += "&answer="+$("input[name=answer]:checked").val();
		}else if(type=='tour'){
			data += "&state="+$("input[name=state]:checked").val();
		}
					
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				setPaging(result);
				nowPage = result.nowPage;
			},error : function(){
				console.log("페이징 오류");
			}
		});
		
		if(type=='user'){
    		url = "/home/adminUserAjax";	
		}else if(type=='tour'){
    		url = "/home/adminTourAjax";   		
		}else if(type=='review'){
    		url = "/home/adminReviewAjax";			 
		}else if(type=='qna'){
    		url = "/home/adminQnaAjax";
		}else if(type=='route'){
			url = "/home/adminRouteAjax";
		}		
		
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				if( result.length <= 0 ){
					toast("검색 결과가 없습니다.", 1500);
					setTimeout(location.reload(), 1500);
					
				} else{ 
					if(type=='user'){
						makeUserTable(result);						
					}else if(type=='tour'){
						makeTourTable(result)
					}else if(type=='review'){
						makeReviewTable(result)
					}else if(type=='qna'){
						makeQnaTable(result)
					}else if(type=='route'){
						makeRouteTable(result)
					}
					$result = $(result);
				}
			}, error : function(error){
				console.log("페이지 + 검색 결과 호출 에러"+error);
			}
			
		});
		
	}
	
	function leaveMessage(noboard, userid, type){
			
		//데이터 구하기
		var data = "reply="+"해당 루트가 추천 루트로 게시됩니다. 게시를 원치 않으실 경우 관리자 문의 부탁드립니다.";
			data += "&noboard="+noboard;
		
		if(type == 4){
			data = "reply="+"해당 후기가 추천 후기로 게시됩니다. 게시를 원치 않으실 경우 관리자 문의 부탁드립니다.";
			data += "&noboard="+noboard;
		}
		
		$.ajax({
			url:"/home/replyWriteOk"
			,data: data
			,success:function(result){
				if(result == 1){
					sendMsg(noboard, userid, 4);
				}
			},error:function(){
				console.log("댓글쓰기 에러 발생..");
			}
		});
	}
  
  //메세지 저장하기 ++ 통신으로 메세지 보내기
	function sendMsg(noboard, receiver, type){
		var receiver = receiver;
		var sender = $("#logId").val();

		var noboard = noboard;
		var msg ="";
		var socketMsg = "";
		
		if(type == 1){
			msg = sender + "님이 " + noboard + "번 루트를 비공개 처리하였습니다.";
			socketMsg = "closeRoute,"+receiver+","+sender+","+noboard;
		}else if(type == 2){
			msg = sender + "님이 " + noboard + "번 루트를 삭제하였습니다.";
			socketMsg = "deleteRoute,"+receiver+","+sender+","+noboard;
		}else if(type == 3){
			msg = "<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+noboard+ "번 루트가 추천 루트로 등록되었습니다.</a>";
			socketMsg = "scrapRoute,"+receiver+","+sender+","+noboard;
		}else if(type == 4){
			msg = "<a href='/home/reviewView?noboard="+noboard+"' target='_blank'>"+ noboard+" 번 후기가 추천 후기로 등록되었습니다.</a>";
			socketMsg = "scrapReview,"+receiver+","+sender+","+noboard;
		}
		
		var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
		
		$.ajax({
			url : "/home/insertNotice",
			data : data,
			success : function(result){
				if(result == 1){
					socket.send(socketMsg);
				}
			},error : function(err){
				console.log(err);
			}
		})
	}
	
	// 알림
	function toast(msg, time) {
		var y = window.scrollY + 200 + "px";
		$(".noticeBoard").css("top",y);

		var toast = $("#toast");
    	toast.addClass("reveal");
    	$("#toastMsg").html(msg);
    	
    	var click = '$("#toast").removeClass("reveal")';
    	if(time == null || time == 'undefined'){
    		var tag = "<br><input type='button' class='mintBtn' value='닫기' onclick='"+click+"'/>";
    		$("#toastMsg").append(tag);
		}else {
			setTimeout(function(){
				toast.removeClass("reveal");
			}, time);
		}
	}
	
	function toastConfirm(msg, callback) {
		var y = window.scrollY + 200 + "px";
		$(".noticeBoard").css("top",y);
		
		var toast = $("#toastConfirm");
    	toast.addClass("reveal");
    	$("#toastConfirmMsg").html(msg);
    	
       	var cnt = 0;
       	$("#toastConfirm .btn").click(function(){
       		if(typeof callback != 'undefined' && callback && cnt == 0){
       		 	if(typeof callback == 'function'){
    				callback();
    				cnt++;
    			}
    		}
    		$("#toastConfirm").removeClass("reveal");
    	});
   	}	
   	
   		function makeUserTable(result){
		
		var nowPage =$("#nowPage").val();
		var listNum = 0;
		var listTag = "";
		for(var i = 0; i < result.length ; i++){			
			//alert(result.length+" : 결과 줄");
			if(i==0){
				listTag +=  "<li>번&nbsp;&nbsp;호</li> <li>아이디</li> <li>이&nbsp;&nbsp;름</li> <li>성&nbsp;&nbsp;별</li> <li>나&nbsp;&nbsp;이</li> <li>모임횟수</li> <li>좋아요</li> <li>상태</li> <li>정지설정</li>"	;
			}
			listNum = i+(nowPage-1)*10+1;
			//list안에 데이터 추가
			listTag += "<li>"+listNum+"</li>";
			listTag += "<li class='contents' ><input type='hidden' class='hiddenEmail' value='"+result[i].email+"'/><input type='hidden' class='hiddenRegdate' value='"+result[i].regdate+"'/>";
			listTag += "<a href='#' data-toggle='modal' data-target='#modal_User' title=' 사용자 프로필 보기 ' id='userprofileShow' >"+result[i].userid+"</a></li>";
			listTag += "<li>"+result[i].username+"</li>";
			listTag += "<li class='fa fa-square fa-stack-2x'>";
			if(result[i].gender=='1'){
				listTag +="남";
			}else if(result[i].gender=='2'){
				listTag +="여";
			}
			
			listTag += "</li>";
			
			listTag += "<li>"+result[i].birth+"대</li>";
			listTag += "<li>"+result[i].tourcnt+"회</li>";
			listTag += "<li>"+result[i].heart+"회</li>";			
			listTag += "<li>";
			if(result[i].endday==null){
				if(result[i].active=='N'){
					listTag += "<span class='status text-warning'>•</span><span style='color:#9a6303'>미인증</span></li>";
				}else{
					listTag += "<span class='status text-success'>•</span><span style='color:#002701'>활&ensp;동</span></li>";
				}
				
				listTag += "<li style='padding-left:27px; color:red'><input type='button' title='"+result[i].userid+"'id='suspendBtn' data-toggle='modal' data-target='#modal_simple'/></li>";
				
			}else{
				listTag += "<span class='status text-danger'>•</span><span style='color:#900200'>정&ensp;지</span>";
				listTag += "<p class='arrow_box'>~"+result[i].endday+"</p></li>";
				//<!-- endday가 없을때, 정지기간이 지났을때 정지 버튼이 생긴다.  -->
				listTag += "<li style='padding-left:27px; color:red'><input type='button' title='"+result[i].userid+"' id='suspendEditBtn' data-toggle='modal' data-target='#modal_suspendEdit'/></li>";	
			}
			
			$("#userList").html(listTag);
		}
	}
	
	function getTourComplist(noboard ){
     url = "/home/selectComplist";
	   
	   $.ajax({
	      url : url,
	      data : "noboard="+noboard,
	      success : function(result){
	         setAcodianList(result, noboard);
	      },error : function(err){
	         console.log(err);
	      }
	   });
	}
	
	// 참가자 목록 만들기
	function setAcodianList(result, noboard){
	   console.log(result);
	   var $result = $(result);
	   
	   var tag =""
	     tag += "<li><b>참가자</b></li><li><b>나이</b></li><li><b>성별</b></li><li><b>모임횟수</b></li><li><b>좋아요</b></li><li><b>참가상태</b></li>";
	      
	     $result.each(function(idx, val){
	        if(val.state == '2'){
	           tag += "<li><span onclick='popMsgSend(title)' title='"+val.userid+"'>"+val.userid+"</span></li>";
	           tag += "<li>"+val.age+"대</li>";
	           
	           if(val.gender == '1'){
	              tag += "<li>남</li>";
	           }else{ 
	              tag += "<li>여</li>";
	           }
	           
	           tag += "<li>"+val.tourcnt+"</li>";
	           tag += "<li><img src='/home/img/img_myRoute/like3.png'/>"+"<span style='color:#cc113c'>"+val.heart+"</span>"+"</li>";
	           tag += "<li><button class='tourOk'>참가 중</button></li>";
	        }
	     });
	     
	     $("#complist"+noboard).html(tag);
	}

	function makeTourTable(result){
		
		
		var listTag = "";
		for(var i = 0; i < result.length ; i++){
	
			//list안에 데이터 추가
			listTag += "<li><input type='checkbox' name='listChk' value='"+result[i].noboard+"'/>";
			listTag += "<li>"+result[i].noboard+"</li>";
			listTag += "<li class='wordCut'><a href = '/home/tourView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
			listTag += "<li>"+result[i].userid+"</li>";
			listTag += "<li>"+result[i].party+"</li>";
			listTag += "<li><a data-toggle='collapse' href='#viewAcodian"+result[i].noboard+"' onclick='getTourComplist("+result[i].noboard+")'>▼</a></li>";
			listTag += "<li>";
			if(result[i].state=='1'||result[i].state==null){
				listTag +="<span class='complete'>미완료</span>";
			}else if(result[i].state=='2'){
				listTag +="<span class='imperfect'>완료</span>";
			}
			listTag += "</li>";
			listTag += "<div id='viewAcodian"+result[i].noboard+"' class='panel-collapse collapse'><ul id='complist"+result[i].noboard+"' class='acodianList'></ul></div>";
			
			}$("#tourList").html(listTag);
	}
	
	function deleteTour(){
		var cnt = 0;
		$("input[name=listChk]").each(function(i, val){
			if($(this).prop("checked")){
				cnt ++;
			}
		});
		
		if(cnt > 1){
			toast("투어 삭제는 하나씩 진행해주십시오.", 1500);
			return false;
		}
		
		var noboard =$("input[name=listChk]:checked").val(); 
		
		var url ="/home/tourViewDeleteChk";
		var data = "noboard="+noboard;
		
		$.ajax({
			url: url,
			data : data,
			success: function(result){
				if(result == 1){
					toast("완료된 여행은 삭제가 불가능합니다.",1500);
				}else if(result == 2){
					selectTourCompList(noboard);
				}else if(result == 3){
					toastConfirm("삭제된 글은 복구가 불가능합니다.<br/>그래도 삭제하시겠습니까?",function(){
						deleteTourView(noboard);
					});
			}else{
					toast("글삭제에 실패하였습니다.",1500);
					}
				},error:function(){
					console.log("글삭제 조건 에러");
				}
		});
	}

	//글삭제하기
	function deleteTourView(noboard){
		
		var url = "/home/deleteTourView";
		var data = "noboard="+noboard;
		
		$.ajax({
			url:url
			,data:data
			,success:function(result){
				if(result == 1){
					toast("게시글이 삭제되었습니다.",1500);
					setTimeout(function(){movePage($("#nowPage").val());}, 1500);
				}else{
					toast("글삭제에 실패하였습니다.",1500);
				}
			},error:function(){
				console.log("글삭제 에러");
			}
		});
	}	

	// 참여인원 리스트 구하기
	function selectTourCompList(noboard){
		var url = "/home/selectTourCompList";
		var data ="noboard="+noboard;
		
		$.ajax({
			url:url
			,data:data
			,success : function(result){
				if(result.length>0){
					toastConfirm("현재 "+result.length+"명의 참여인원이 있습니다.<br/>그래도 삭제하시겠습니까?",function(){
						selectTourCompReceiver(result, noboard);
					});	
				}else{
					toast("참여인원 리스트불러오기에 실패하였습니다.",1500);	
				}
			},error:function(){
				console.log("동행찾기 참여리스트 불러오기 에러");
			}
		});
	}

	// 참여인원
	function selectTourCompReceiver(result, noboard){
		var $result = $(result);
		
		$result.each(function(i,val){
			setTimeout(sendTourDeleteMsg(val, noboard), 1500);
		});
		
		deleteTourView(noboard);
	}	
	
	// 게시글 삭제 메세지 보내기
	function sendTourDeleteMsg(receiver, noboard){
		var receiver = receiver;
		var sender = $("#logId").val();
			
		var msg = sender + "님이 " + noboard + "번 투어를 취소하였습니다.";
		var socketMsg = "cancelTourAdmin,"+receiver+","+sender+","+noboard; 
		
		var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
		
		$.ajax({
			url: "/home/insertNotice",
			data: data,
			success : function(result){
			},error:function(err){
				console.log(err);
			}
		});
	}
	
	function setCloseRoute1(noboard, type){
	  	// ++ 레퍼런스 사용 여부
	  	var msg = "비공개 처리";
	  	
	  	$.ajax({
	  		url : "/home/route/chkReference",
	  		data : "noboard="+noboard,
	  		success : function(result){
	  			if(result > 0){
	  				toast("현재 투어에 사용 중으로 "+msg+"가 불가합니다");
				}else{
				  	// 1. 스크랩 여부 >> 진행 시 스크랩 취소 됨
				  	
				  	$.ajax({
				  		url :"/home/route/setCloseRoute1",
				  		data : "noboard="+noboard,
				  		success : function(result){
				  			if(result == 1){
				  				toastConfirm("현재 추천 루트로 게시 중입니다. "+ msg +" 시 추천 루트 게시가 취소됩니다.<br/>진행 하시겠습니까?", function(){
				  					setCloseRoute2(noboard, type);
				  					// 스크랩 취소하는 펑션 필요
				  				});
				  			}else {
				  				setCloseRoute2(noboard, type);
				  			}
				  		}, error : function(err){
				  			console.log(err);
				  		}
				  	});
				}
	  		},error : function(err){
	  			console.log(err);
	  		}
	  	});
	  }
  
  // 2. 현재 해당 루트를 가지고 있는 사람 수 체크 + 명단 가져오기
  function setCloseRoute2(noboard, type){
  	
  	var msg = "비공개 처리";
  	
	$.ajax({
  	  	url : "/home/route/setCloseRoute2",
  	  	data : "noboard="+noboard,
  	  	success : function(result){
  	  		console.log(result.length);
  	  		
  			if(result.length > 1){
  				toastConfirm("현재 "+result.length+"명이 해당 루트를 저장하고 있습니다.<br/>"+msg+" 시 루트 저장이 취소됩니다.<br/>진행 하시겠습니까?", function(){
  					// 저장 취소 , 안내 메세지 발송
  					cancelRouteSave(noboard, result, type);
  					
  					if(type == 'close'){
  						setCloseRoute3(noboard);
					}else if(type == 'del'){
						deleteRoute(noboard);
					}
  				});
  			}else {
  				if(type == 'close'){
  					setCloseRoute3(noboard);
				}else if(type == 'del'){
					deleteRoute(noboard);
				}
  			}
  		}, error : function(err){
  			console.log(err);
  		}
	});
  	
  }
 
 // 3. 비공개로 인한 루트 저장 취소 처리
 // 4. 루트 저장해서 가지고 있던 사람들에게 메세지 발송
	  function cancelRouteSave(noboard, result, type){
	  	var $result = $(result);
	  	
	  	var msgType = 1; // 1 : 비공개  , 2 : 삭제
	
	  	
	  	var cnt = 0 ;
	  	$result.each(function(i,val){  	
	  		$.ajax({
	  			url : "/home/route/revertRoutelist",
	  			data : "noboard="+noboard+"&userid="+val,
	  			success : function(result){
	  				if(result == 1){
	  					sendMsg(noboard, val, msgType);
	  				}else{
				  		toast("루트 저장 취소 오류<br/>관리자에 문의하십시오.");
	  				}
	  			}, error : function(err){
	  				console.log(err);
	  			}
	  		});
	  	});
	}
	  //비공개 처리
	function setCloseRoute3(noboard){
	  	toastConfirm(noboard+"번 루트를 비공개 하시겠습니까?", function(){
		  	$.ajax({
		  		url : "/home/route/setCloseRoute3",
		  		data : "noboard="+noboard,
		  		success : function(result){
		  			if(result >0 ){
		  				toast(noboard+"번 루트를 비공개 처리하였습니다.",1500);
						setTimeout(function(){}, 1500);
						movePage($("#nowPage").val());	
		  			}else{
		  				toast("루트 비공개 처리 오류입니다.");
		  			}
		  		},error : function(err){
		  			console.log(err);
		  		}
		  	});
	  	});
  	}
  
	function setOpenRoute(noboard){
	  	
	  	toastConfirm("루트를 공개 처리하면 검색 및 다른 회원들의 리스트에 저장이 가능합니다.<br/>진행하시겠습니까?", function(){
	  		$.ajax({
				url : "/home/route/setOpenRoute",
				data : "noboard="+noboard,
				success : function(result){
					if(result == 1){
						toast(noboard + "번 루트가 공개처리 되었습니다.",1500);
						movePage($("#nowPage").val());				
					}else{
						toast("루트 공개 처리 오류입니다.");
					}
				},error : function(err){
					console.log(err);
				}
	  		});
	  	});
	}	
	  
	function makeRouteTable(result){
		$("#routeList").children().remove();
		var listTag = "";
		for(var i = 0; i < result.length ; i++){
			
			if(i==0){
				listTag +=  "<li><input type='checkbox' id='checkAll'/></li><li>번&nbsp;&nbsp;호</li> <li>제&nbsp;&nbsp;목</li> <li>작성자</li> <li>평&nbsp;&nbsp;점</li><li>평가횟수</li><li>지&nbsp;&nbsp;역</li><li>비공개여부</li><li>관리자추천</li>"	;
			}			
			//list안에 데이터 추가
			listTag += "<li><input type='checkbox' name='listChk' value='"+result[i].noboard+"'/></li>";
			listTag += "<li>"+result[i].noboard+"</li>";
			listTag += "<li class='wordCut'><a href = '/home/routeSearchView?noboard="+result[i].noboard+"'>"+result[i].title+"</a></li>";
			listTag += "<li>"+result[i].userid+"</li>";
			listTag += "<li>"+result[i].rating+"</li>";
			listTag += "<li>"+result[i].ratecnt+"</li>";
			listTag += "<li class='wordCut' >"+result[i].region+"</li>";
			
			listTag += "<li>";
			listTag += "<label class='switch'>";
			listTag += "<input type='checkbox' name='adminHideBtn' value='"+result[i].noboard+"'";
			if(result[i].closed=='T'){
				listTag += "checked='checked'";
			}
			listTag += "><span class='slider round'></span>";
			
			listTag += "</li>";
			listTag += "<li>";
			listTag += "<label class='switch'>";
			listTag += "<input type='checkbox' name='adminScrapBtn' value='"+result[i].noboard+"'";
			if(result[i].scrap=='T'){
				listTag += "checked='checked'";
			}
			listTag += "><span class='slider round'></span>";
			listTag += "</label>";
			listTag += "<input type='hidden' class='userid' value='"+result[i].userid+"'/>";
			listTag += "</li>";
				
		}
		$("#routeList").append(listTag);
	}
	
	function makeReviewTable(result){
		var listTag = "";
		for(var i = 0; i < result.length ; i++){
			if(i==0){
				listTag +=  "<li><input type='checkbox' id='checkAll' /></li><li>번&nbsp;&nbsp;호</li> <li>제&nbsp;&nbsp;목</li> <li>작성자</li> <li>레퍼런스 번호</li><li>조회수</li><li>추천/비추천</li> <li>관리자추천</li>"	;
			}			
			//list안에 데이터 추가
			listTag += "<li><input type='checkbox'  name='listChk' value='"+result[i].noboard+"'/></li>"
			listTag += "<li>"+result[i].noboard+"</li>";
			listTag += "<li class='wordCut'><a href = '/home/reviewView?noboard="+result[i].noboard+"'>"+result[i].subject+"</a></li>";
			listTag += "<li>"+result[i].userid+"</li>";
			listTag += "<li>"+result[i].reference+"</li>";
			listTag += "<li><input type='hidden' value='"+result[i].scrap+"' />"+result[i].hit+"회</li>";
			listTag += "<li style='letter-spacing:2px'><span style='color:#0000b5; font-size:19px'>"+result[i].thumbup+" </span><span class='review_lBar'>/</span> <span style='color:#b30200; font-size:19px'>"+result[i].thumbdown+" </span></li>";
			listTag += "<li>";
			listTag += "<label class='switch'>";
			listTag += "<input type='checkbox' name='adminReviewScrapBtn' value='"+result[i].noboard+"'";
			if(result[i].scrap=='T'){
				listTag += "checked='checked'";
			}
			listTag += "><span class='slider round'></span>";
			listTag += "</label>";
			listTag += "<input type='hidden' class='userid' value='"+result[i].userid+"'/>";
			listTag += "</li>";
			}$("#reviewList").html(listTag);
	}
	
	function deleteReview(){
		$('input[name=listChk]:checked').each(function(i, val){
				var noboard = $(this).val();
				toastConfirm(noboard+"번 리뷰 게시물을 삭제하시겠습니까?", function(){
	        $.ajax({
	          url : "/home/reviewDel",
	          data : "noboard="+noboard,
	          success : function(result){
	            if(result > 0){
	           		toast("후기를 삭제하였습니다.", 1500);
	           		setTimeout(movePage(1),1500);
	            }else {
	              toast("후기 삭제 오류 입니다. 다시 시도해주십시오.", 1500);
	            }
	          }, error : function(err){
	            console.log(err);
	          }
	  			});
			  });
		});
	}
	
	function makeQnaTable(result){
		var listTag = "";
		for(var i = 0; i < result.length ; i++){		
			//alert(result.length+" : 결과 줄");
			if(i==0){
				listTag +=  "<li><input type='checkbox' id='checkAll' /></li><li>번호</li> <li>아이디</li> <li>제목</li> <li>작성일자</li> <li>답변여부</li> "	;
			}
			//list안에 데이터 추가
			listTag += "<li><input type='checkbox' name='chkList' value='"+result[i].noqna+"' /></li>";
			if(result[i].answer == 'N'){
				listTag += "<li class='answerYet'>"+result[i].noqna+"</li>";
				listTag += "<li class='answerYet'>"+result[i].userid+"</li>";
				listTag += "<li id='subject' class='wordCut answerYet'><a href='/home/adminQnaWrite?noqna="+result[i].noqna+"'>"+result[i].subject+"</a></li>";
				listTag += "<li class='answerYet'>"+result[i].writedate+"</li>";
				listTag += "<li class='answerYet' style='letter-spacing:1px; font-size:17px;'>대기중</li>";
			}else{
				listTag += "<li>"+result[i].noqna+"</li>";
				listTag += "<li >"+result[i].userid+"</li>";
				listTag += "<li id='subject' class='wordCut' style='color:black'><a href='/home/adminQnaWrite?noqna="+result[i].noqna+"'>"+result[i].subject+"</a></li>";
				listTag += "<li>"+result[i].writedate+"</li>";
				listTag += "<li style='color:00B0B0'>답변 완료</li>";
			}
		}$("#questionList").html(listTag);
	}
	
	function deleteQna(){
		$("#questionList input[type=checkbox]").each(function(i, val){
			if($(this).prop("checked")){

				$.ajax({
					url : "/home/deleteQna",
					data : "noqna="+$(this).val(),
					success : function(result){
						if(result == 1){
							movePage(1);
						}
					}, error : function(err){
						console.log(err);
					}
				});
			}
		});	
	}
		