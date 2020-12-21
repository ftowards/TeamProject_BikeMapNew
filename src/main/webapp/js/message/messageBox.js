var messageBox = 1;
var nowPage = 1;
var $result ;

$(function(){
	// 1. 페이징	
	movePage(nowPage);
	// 2. 리스트 불러오기
	$("input[name=messageBox]").on('change', function(){
		$("#read"+messageBox).prop("checked", false);
		messageBox = $("input[name=messageBox]:checked").val();
		console.log(messageBox);

		if(messageBox != 4){
			movePage(1);
		}
	});
	
	$("input[name=read]").on('change', function(){
		movePage(1);
	});
	
	$("input[name=chkAll]").on('change', function(){
		if($("input[name=chkAll]").eq(messageBox-1).prop("checked")){
			$("#messageList"+messageBox+" input[type=checkbox]").prop("checked", true);
		}
		
		if(!($("input[name=chkAll]").eq(messageBox-1).prop("checked"))){
			$("#messageList"+messageBox+" input[type=checkbox]").prop("checked", false);
		}
	});
	
	$("input[name=deleteMsg]").on('click', function(){
		
		$("#messageList"+messageBox+" input[type=checkbox]").each(function(){
			if($(this).prop("checked")){
				deleteMsg($(this).val());				
			};
		});
	});
	
	$("input[name=readMsg]").on('click', function(){
		$("#messageList"+messageBox+" input[type=checkbox]").each(function(){
			if($(this).prop("checked")){
				readMsg($(this).val());				
			};
		});
	});	
});

function movePage(page){
	
	nowPage = page;
	$("#chkAll"+messageBox).prop("checked", false);
	
	var data = "nowPage="+page+"&messageBox="+messageBox;
	if($("#read"+messageBox).prop("checked")){
		data+= "&read="+"F";
	}
	
	$.ajax({
		url : "/home/noticePaging",
		data : data,
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
		$("#messageList"+messageBox).children().remove();
	}
	
	$("#paging"+messageBox).html(tag);
}

function getList(page){
	
	var data = "nowPage="+page+"&messageBox="+messageBox;
	if($("#read"+messageBox).prop("checked")){
		data+= "&read="+"F";
	}
	
	$.ajax({
		url : "/home/selectMessage",
		data : data,
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
	$result = $(result);
	
	// 표 내용
	$result.each(function(idx, val){			
		tag += "<li><input type='checkbox' value='"+val.nonotice+"'/></li>";
		
		if(messageBox == 2){
			if(val.read == 'T' ){
				tag += "<li>"+val.userid+"</li>";
				tag += "<li class='wordcut' onclick='viewMsg(title)' title='"+val.nonotice+"' >"+val.msg+"</li>";
				tag += "<li>"+val.writedate+"</li>";
			}else if(val.read =='F'){
				tag += "<li class='readYet'>"+val.userid+"</a></li>";
				tag += "<li class='wordcut readYet' onclick='viewMsg(title)' title='"+val.nonotice+"'>"+val.msg+"</li>";
				tag += "<li class='readYet'>"+val.writedate+"</li>";
			}
		}else{
			if(val.read == 'T' ){
				if(messageBox == 1){
					tag += "<li onclick='popMsgSend(title)' title='"+val.idsend+"'>"+val.idsend+"</li>";		
				}else {
					tag += "<li>"+val.idsend+"</li>";
				}
				tag += "<li class='wordcut' onclick='viewMsg(title)' title='"+val.nonotice+"'>"+val.msg+"</li>";
				tag += "<li>"+val.writedate+"</li>";
			}else if(val.read =='F'){
				tag += "<li onclick='readMsg(title);' class='readYet' title='"+val.nonotice+"'>"+val.idsend+"</li>";
				tag += "<li onclick='readMsg(title); viewMsg(title)' class='wordcut readYet' title='"+val.nonotice+"'>"+val.msg+"</li>";
				tag += "<li onclick='readMsg(title);' class='readYet' title='"+val.nonotice+"'>"+val.writedate+"</li>";
			}
		}
	});
	$("#messageList"+messageBox).html(tag);
}

function readMsg(title){
	var nonotice = title;
	
	$.ajax({
		url : "/home/messageRead",
		data : "nonotice="+nonotice,
		success : function(result){
			if(result == 1){
				$("#messageList"+messageBox+">li").each(function(){
					if(this.getAttribute('title') == nonotice){
						$(this).removeClass('readYet');
					}
				});
			}
		}, error : function(err){
			console.log(err);
		}
	});
}

function viewMsg(title){
	var nonotice = title;
	
	var x = event.pageX + 'px';
	var y = event.pageY + 'px';
	
	$(".modal").css({
		top : y,
		left : x
	});
	
	$result.each(function(i, val){
		if(val.nonotice == nonotice){
			if(messageBox == 1 || messageBox == 3){
				$("#msgId").text(val.idsend);
			}else{
				$("#msgId").text(val.userid);
			}
			$("#msgView").html(val.msg);
		}
	});
	
	$("#dialog").modal('show');
}

function deleteMsg(nonotice){
	$.ajax({
		url : "/home/deleteMsg",
		data : "nonotice="+nonotice,
		success : function(result){
			if(result == 1){
				movePage(nowPage);
			}
		}, error : function(err){
			console.log(err);
		}
	});
}
// 메세지 저장하기 ++ 통신으로 메세지 보내기
function sendMsg(noboard, receiver, type){
	var receiver = receiver;
	var sender = $("#logId").val();
	
	console.log(receiver);
	console.log(sender);
	console.log(type);
	
	var noboard = noboard;
	var msg ="";
	var socketMsg = "";
	if(type == 1){
		msg = "<a href='/home/View?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 승인하였습니다.</a>";
		socketMsg = "confirm,"+receiver+","+sender+","+noboard;
	}else if(type == 2){
		msg = "<a href='/home/View?noboard="+noboard+"'>"+ sender + "님이 " + noboard + "번 투어 참가를 취소처리 하였습니다.</a>";
		socketMsg = "revert,"+receiver+","+sender+","+noboard;
	}else if(type == 3){
		msg = "<a href='/home/View?noboard="+noboard+"'>" + noboard + "번 투어가 불참 처리되었습니다.</a>";
		socketMsg = "absent,"+receiver+","+sender+","+noboard;
	}else if(type == 4){
		msg = "<a href='/home/View?noboard="+noboard+"'>"+ noboard + "번 투어가 완료되었습니다.</a>";
		socketMsg = "complete,"+receiver+","+sender+","+noboard;
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

function popMsgSend(userid){
	
	if($("#logId").val()== "" || $("#logId").val() == null){
		toast("쪽지 보내기는 회원만 이용 가능합니다.",1500);	
		return false;	
	}
	if(userid == 'admin' || userid == $("#logId").val()){
		return false
	}
	
	window.open('/home/sendMsg?userid='+userid, 'msg', 'width=425px, height=360px, left =200px, top=200px, resizable=0');	
}