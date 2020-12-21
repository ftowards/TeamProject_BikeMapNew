var tourState = 1;

$(function(){
	// 1. 페이징	
	movePage(1);
	// 2. 리스트 불러오기
	$("input[name=tourState]").on('change', function(){
		tourState = $("input[name=tourState]:checked").val();
		movePage(1);
	});
});

function movePage(page){
	
	$.ajax({
		url : "/home/mytour/paging",
		data : "nowPage="+page+"&tourState="+tourState,
		success : function(result){
			setPaging(result);
		},error : function(err){
			console.log(err);
		}			
	});
}

function setPaging(result){
	var tag = "<ul>";
	
	if(result.totalRecord != 0){
		if(result.nowPage != 1){
			tag += "<li onclick='movePage("+(result.nowPage-1)+")'>Prev</li>";
		}
		
		for (var i = result.startPageNum ; i < result.startPageNum + result.onePageNumCount ; i++){
			if(i > result.totalPage){
				break;
			}else if(i == result.nowPage){
				tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
			}else{
				tag += "<li onclick='movePage("+i+");'>"+i+"</li>";
			}
		}
		if(result.nowPage != result.totalPage){
			tag += "<li onclick='movePage("+(result.nowPage+1)+")'>Next</li>";
		}
		
		getList(result.nowPage);
	}else {
		tag +="<li>검색 결과가 없습니다.</li></ul>";
	}
	
	if(tourState == '1'){
		$("#paging1").html(tag);
	}else if(tourState == '2'){
		$("#paging2").html(tag);
	}else if(tourState == '3'){
		$("#paging3").html(tag);
	}
}

function getList(page){
	$.ajax({
		url : "/home/mytour/selectTourlist",
		data : "nowPage="+page+"&tourState="+tourState,
		success : function(result){
			if(result != null){
				setList(result);
			}
		},error : function(err){
			
		}			
	});
}

function setList(result){
	var tag ="";
	var $result = $(result);
	
	if(tourState == '1'){
		// 표 내용
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.deadline+":00</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li>"+val.margin+"</li>";
			tag += "<li>"+val.que+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist("+val.noboard+")'>▼</a></li>";
			
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourOnList").html(tag);
		
	}else if(tourState == '2'){ // 마감된 여행 리스트
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.departure+":00</li>";
			tag += "<li>"+val.arrive+":00</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist("+val.noboard+")'>▼</a></li>";
			
			
			if(chkArriveTime(val.arrive)){
				tag += "<li><button class='tourNo' onclick='completeTour("+val.noboard+")'>완료하기</button></li>"
			}else{
				tag += "<li></li>";
			}
						
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourCloseList").html(tag);
	}else if(tourState == '3'){
		$result.each(function(idx, val){			
			tag += "<li>"+val.noboard+"</li>";
			tag += "<li><a href='/home/tourView?noboard="+val.noboard+"'>"+val.title+"</a></li>";
			tag += "<li>"+val.departure+":00</li>";
			tag += "<li>"+val.arrive+":00</li>";
			tag += "<li>"+val.party+"</li>";
			tag += "<li><a data-toggle='collapse' href='#viewAcodian"+val.noboard+"' onclick='getTourComplist("+val.noboard+")'>▼</a></li>";
			
			tag += "<div id='viewAcodian"+val.noboard+"' class='panel-collapse collapse'><ul id='complist"+val.noboard+"' class='acodianList'></ul></div>";
		});
		$("#tourCompleteList").html(tag);
	}
}

// 투어 완료 처리
function completeTour(noboard){
	toastConfirm("투어를 완료하면 현재 참가 중인 회원 모두 참가 완료 처리 됩니다.<br/>투어를 완료하시겠습니까?", function(){
		$.ajax({
			url : "/home/mytour/completeTour",
			data : "noboard="+noboard,
			success : function(result){
				if(result == 1){
					// 메세지 보내기
					sendCompleteMsg(noboard);
				}				
			},error : function(err){
				console.log(err);
			}
		});
	});
}

function sendCompleteMsg(noboard){
	// 메세지 보낼 리스트 얻어오기
	var sendList = [];

	$.ajax({
		url : "/home/selectComplist",
		data : "noboard="+noboard,
		success : function(result){
			sendMesages(result);
		},error : function(err){
			console.log(err);
		}
	});
	
	function sendMesages(result){
		var $result = $(result);
		$result.each(function(idx, val){
			if(val.state == '2' && val.userid != $("#logId").val()){
				sendList.push(val.userid);
			}
		});
		
		for(var i =0 ; i < sendList.length ; i++){
			sendMsg(noboard, sendList[i], 4);
		}
	}
		
}

// 완료 버튼 표시 여부 체크 / 도착 시간과 현재 시간 비교
function chkArriveTime(arrive){
	var times = arrive.replace(" ", "-").split("-")

	var arriveDate = new Date(2000+Number(times[0]), Number(times[1])-1, times[2], times[3], 0, 0, 0);
	var date = new Date();
	
	if(date.getTime() - arriveDate.getTime() > 0){
		return true; // 완료 표시 해야 함
	}else{
		return false; // 완료 표시 안 함
	}
}

function getTourComplist(noboard){
	var url = "/home/tour/selectEvallist";
	if(tourState == '1' || tourState == '2'){
		url = "/home/selectComplist";
	}
	
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
	if(tourState == '1'){
		tag += "<li><b>참가자</b></li><li><b>나이</b></li><li><b>성별</b></li><li><b>모임횟수</b></li><li><b>좋아요</b></li><li><b>참가상태</b></li><li></li>";
		
		$result.each(function(idx, val){
			tag += "<li><span onclick='popMsgSend(title)' title='"+val.userid+"'>"+val.userid+"</span></li>";
			tag += "<li>"+val.age+"대</li>";
			
			if(val.gender == '1'){
				tag += "<li>남</li>";
			}else{ 
				tag += "<li>여</li>";
			}
			
			tag += "<li>"+val.tourcnt+"</li>";
			tag += "<li><img src='/home/img/img_myRoute/like3.png'/>"+"<span class='acodianList_like'>"+val.heart+"</span>"+"</li>";
			
			if(val.state == '1'){
				tag += "<li><button class='tourOk'>대기</button></li>";
				tag += "<li><button class='tourIn' onclick='confirmComplist(title)' title='"+noboard+"/"+val.userid+"'>승&nbsp;인</button></li>";
			}else if(val.state == '2'){
				tag += "<li><button class='tourOk'>참가 중</button></li>";
				if(val.userid != $("#logId").val()){
					tag += "<li><button class='tourOut' onclick='cancelComplist(title)' title='"+noboard+"/"+val.userid+"'>취&nbsp;소</button></li>";
				}else{
					tag +="<li></li>";
				}
			}			
		});
		
		$("#complist"+noboard).html(tag);
	}else if(tourState == '2'){
		tag += "<li><b>참가자</b></li><li><b>나이</b></li><li><b>성별</b></li><li><b>모임횟수</b></li><li><b>좋아요</b></li><li><b>참가상태</b></li><li></li>";
		
		$result.each(function(idx, val){
			if(val.state != '1'){
				tag += "<li><span onclick='popMsgSend(title)' title='"+val.userid+"'>"+val.userid+"</span></li>";
				tag += "<li>"+val.age+"대</li>";
				
				if(val.gender == '1'){
					tag += "<li>남</li>";
				}else{ 
					tag += "<li>여</li>";
				}
				
				tag += "<li>"+val.tourcnt+"</li>";
				tag += "<li><img src='/home/img/img_myRoute/like3.png'/>"+"<span class='acodianList_like'>"+val.heart+"</span>"+"</li>";
				
				if(val.state == '3'){
					tag += "<li><div class='tourOut' style='margin: 7.5px auto;'>불&nbsp;참</div></li>";
					tag += "<li></li>";
				}else if(val.state == '2'){
					tag += "<li><button class='tourOk'>참가 중</button></li>";
					if(val.userid != $("#logId").val()){
						tag += "<li><button class='tourOut' onclick='absentComplist(title)' title='"+noboard+"/"+val.userid+"'>불&nbsp;참</button></li>";
					}else{
						tag +="<li></li>";
					}
				}
			}
		});
		
		$("#complist"+noboard).html(tag);
	}else if(tourState == '3'){
		tag += "<li><b>참가자</b></li><li><b>나이</b></li><li><b>성별</b></li><li><b>모임횟수</b></li><li><b>좋아요</b></li><li><b>평가여부</b></li><li></li>";
		
		$result.each(function(idx, val){		
			
			tag += "<li><span onclick='popMsgSend(title)' title='"+val.objid+"'>"+val.objid+"</span></li>";
			tag += "<li>"+val.age+"대</li>";
			
			if(val.gender == '1'){
				tag += "<li>남</li>";
			}else{ 
				tag += "<li>여</li>";
			}
			
			tag += "<li>"+val.tourcnt+"</li>";
			tag += "<li><img src='/home/img/img_myRoute/like3.png'/>"+"<span class='acodianList_like'>"+val.heart+"</span>"+"</li>";
			
			if(val.eval == 'N'){
				tag += "<li><div class='tourOut' style='color:rgb(64,64,64); background-color:#fff; margin:7px 0 0 60px;'>미평가</div></li>";
				tag += "<li><button class='tourOut' onclick='addLike(title)' title='"+noboard+"/"+val.objid+"'>좋아요</button></li>";
			}else if(val.eval == 'Y'){
				tag += "<li><button class='tourOk'>평가</button></li>";
				tag +="<li></li>";
			}
		});
		
		$("#complist"+noboard).html(tag);
	}
}

function addLike(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&objid="+strs[1];
	
	toastConfirm("좋아요 평가는 취소할 수 없으며, 평가 여부를 상대방이 알 수 없습니다.<br/>"+strs[1]+" 님에게 좋아요를 보내시겠습니까?", function(){
		
		$.ajax({
			url : "/home/mytour/addHeart",
			data : data,
			success : function(result){
				if(result == 1){
					toast("좋아요", 1500);
				}else{
					toast("좋아요 처리 처리 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
		});	
		getTourComplist(strs[0]);
	});
}

function absentComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	toastConfirm("불참(결석) 처리는 다시 되돌릴 수 없습니다.<br/>"+strs[1]+" 님을 불참 처리하시겠습니까?", function(){
		
		$.ajax({
			url : "/home/mytour/absentComplist",
			data : data,
			success : function(result){
				if(result == 1){
					toast("불참 처리 완료되었습니다.",1500);
					sendMsg(strs[0], strs[1], 3);
				}else{
					toast("처리 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
		});	
		getTourComplist(strs[0]);
	});
}

function confirmComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	$.ajax({
		url : "/home/mytour/confirmComplist",
		data : data,
		success : function(result){
			if(result == 1){
				toast("참가 승인 완료되었습니다.",1500);
				sendMsg(strs[0], strs[1], 1);
			}else if(result == 2){
				toast("참여 인원이 마감되었습니다.", 1500);
			}else {
				toast("승인 오류 입니다.",1500);
			}
		},error : function(err){
			console.log(err);
		}
	});	
	getTourComplist(strs[0]);
}

function cancelComplist(title){
	var strs = title.split("/");
	var data = "noboard="+strs[0]+"&userid="+strs[1];
	
	$.ajax({
		url : "/home/mytour/revertComplist",
		data : data,
		success : function(result){
			if(result == 5){
				toast("마감 시간이 지나 참가 취소 처리가 불가합니다.");
			}else if(result == 1){
				toast("참가 취소 처리 되었습니다.",1500);
				sendMsg(strs[0], strs[1], 2);
			}else{
				toast("참가 취소 처리 오류입니다.");
			}
		},error : function(err){
			console.log(err);
		}
	});	
	getTourComplist(strs[0]);
}

// 메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(noboard, receiver, type){
	var receiver = receiver;
	var sender = $("#logId").val();
	
	var noboard = noboard;
	var msg ="";
	var socketMsg = "";
	if(type == 1){
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>";
		socketMsg = "confirmTour,"+receiver+","+sender+","+noboard;
	}else if(type == 2){
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소처리 하였습니다.</a>";
		socketMsg = "revertTour,"+receiver+","+sender+","+noboard;
	}else if(type == 3){
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>" + noboard + "번 투어가 불참 처리되었습니다.</a>";
		socketMsg = "absentTour,"+receiver+","+sender+","+noboard;
	}else if(type == 4){
		msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ noboard + "번 투어가 완료되었습니다.</a>";
		socketMsg = "completeTour,"+receiver+","+sender+","+noboard;
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
//쪽지창 열기
function popMsgSend(userid){
	
	if($("#logId").val()== "" || $("#logId").val() == null){
		toast("쪽지 보내기는 회원만 이용 가능합니다.",1500);	
		return false	
	}
	
	if(userid == 'admin' || userid == $("#logId").val()){
		return false
	}
	
	window.open('/home/sendMsg?userid='+userid, 'msg', 'width=425px, height=360px, left =200px, top=200px, resizable=0');	
}