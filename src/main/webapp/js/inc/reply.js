	$(function(){
		
		var nowPage = 1;
		// 페이지 로딩 시 실행
		movePage(1);
		
		//===============댓글쓰기 200자 제한================
		$("#replyWrite").keyup(function(){
			var commentBox = $(this).val();
		    $('#cntSPAN').text(getBytes(commentBox)); 
		});

		//===================댓글 쓰기==============================================
		//댓글이 있는지 없는지 확인
		$("#replyForm").submit(function(){
			if($("#replyWrite").val()==""){
				toast("댓글 내용을 입력해주세요.", 1500);
				return false;
			}
			
			//데이터 구하기
			var url ="/home/replyWriteOk";
			var params = $("#replyForm").serialize();
				params += "&noboard="+$("#noboard").val();

			$.ajax({
				url:url
				,data:params
				,success:function(result){
					movePage(1);
					$("#replyWrite").val("");
					sendMsgReply();
				},error:function(){
					console.log("댓글쓰기 에러 발생..");
				}
			});
			return false;
		});
		
		$("input[name=order]").on('change',function(){
			movePage(nowPage);
		});

	});
	////////////////// 펑션 ///////////////////////
	
	// 메세지 저장하기 ++ 통신으로 메세지 보내기
	function sendMsgReply(){
		var receiver = $("#userid").text();
		if(receiver == null || receiver ==""){
			receiver = $("#userid").val();
		}
		
		var sender = $("#logId").val();
		
		if(receiver == sender){
			return false;
		}
		
		var noboard = $("#noboard").val();
		var type = 1;
		var msg = "<a href='/home/routeSearchView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 루트에 댓글을 달았습니다.</a>";
		var socketMsg = "routeReply,"+receiver+","+sender+","+noboard;

		var viewPage = location.href ;
		
		if(viewPage.indexOf("tour")>0){
			msg = "<a href='/home/tourView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 투어에 댓글을 달았습니다.</a>";
			socketMsg = "tourReply,"+receiver+","+sender+","+noboard;
		}else if(viewPage.indexOf("review")>0){
			msg = "<a href='/home/reviewView?noboard="+noboard+"' target='_blank'>"+ sender + "님이 " + noboard + "번 후기에 댓글을 달았습니다.</a>";
			socketMsg = "reviewReply,"+receiver+","+sender+","+noboard;
		}
		
		var data = "userid="+receiver+"&idsend="+sender+"&msg="+msg;
		
		$.ajax({
			url : "/home/insertNotice",
			data : data,
			success : function(result){
				socket.send(socketMsg);		
			},error : function(err){
				console.log(err);
			}
		})
	}
	
	function getBytes(str){
	    var cnt = 0;
	    for(var i =0; i<str.length;i++) {
	        cnt += (str.charCodeAt(i) >128) ? 2 : 1;
	    }
	    return cnt;
	}
	
	// 페이징 리스트 만들기
	function setPaging(vo){
		// 이전 페이징 삭제

		if(vo.totalRecord == 0){
			return false;
		}
		
		nowPage = vo.nowPage;
		var tag = "<ul>";
		
		if(vo.nowPage != 1){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage -1)+");'>Prev</a></li>";
		}
		
		for(var i = vo.startPageNum ; i <= vo.startPageNum+vo.onePageNumCount -1 ; i++){
			if(vo.totalPage >= i){
				if(vo.nowPage == i){
					tag += "<li style='color:#00B0B0; font-weight:600;'>"+i+"</li>";
				}else{
					tag += "<li><a href='javascript:movePage("+i+")' style='color:black;'>"+i+"</a></li>";
				}
			}
		}
		if(vo.nowPage != vo.totalPage){
			tag += "<li><a href='javascript:movePage("+(vo.nowPage +1)+")'>Next</a></li>"
		}
		tag+="</ul>";
		
		$("#replyPaging").html(tag);
		$("#totalRecord").text(vo.totalRecord);
	}
	
	//==================댓글 리스트 구하기=================
	
	function replyListSelect(page){
		
		var url ="/home/replyList" ;
		var params ="noboard="+$("#noboard").val();
			params += "&nowPage="+page+"&order="+$("input[name=order]:checked").val();
			
		$.ajax({
			url:url
			,data:params
			,success:function(result){
				var $result = $(result);
				var tag="";
				$result.each(function(i,v){
					// 댓글 보이는 창
					tag += "<ul id='reply"+v.noreply+"' class='replyList replyView'>";
					tag += "<div><img src='/home/img/img_reply/p.png' style='width:70px; float:left;'></div><li style='color:rgb(64,64,64)' onclick='popMsgSend(title)' title='"+v.userid+"' ><b>"+ v.userid+"</b>";
					tag += "<br/><span>"+v.writedate+"</li><li>";
				
					if(v.userid==$("#logId").val()){
						tag+="<input type='button' class='replyDel' value='삭제' onclick='delReply("+v.noreply+");'/>";
						tag+="<input type='button' class='replyEdit' value='수정' onclick='editReply("+v.noreply+");'/>";
					}
					
					tag +="</li><li>"+v.reply+"</li></ul>";
					// 댓글 수정 창
					tag += "<ul id='replyEdit"+v.noreply+"' class = 'replyListEdit' style='display:none;'>";
					tag += "<li><textarea maxlength='100' placeholder=' 주제와 무관한 댓글, 악플은 삭제될 수 있습니다.' >"+v.reply+"</textarea>";
					tag += "<li><input type='button' class='replyDel' value='취소' onclick='editCancle("+v.noreply+")'style='float:right;'/>";
					tag += "<input type='button' class='replyEdit' value='확인' onclick='editOk("+v.noreply+")'style='float:right;'/></li></ul><hr class='replyHr'/>";
				});
				$("#replyList").html(tag);
			},error:function(){
				console.log("댓글 선택 에러 발생....");
			}
		
		});
	}
	
	// 페이지 이동
	function movePage(page){
		
		// 페이징 먼저 변경
		var url = "/home/replyPaging";
		var params="noboard="+$("#noboard").val();
			params += "&nowPage="+page+"&order="+$("input[name=order]:checked").val();
			
		$.ajax({
			type : 'POST',
			url : url,
			data : params,
			success : function(result){
				setPaging(result);
			},error : function(){
				console.log("페이징 오류");
			}
		});
		replyListSelect(page);
	}
	
	// 댓글 삭제하기
	function delReply(noreply){		
		toastConfirm("삭제하시겠습니까?", function(){
			
			var url = "/home/delReply";
			var data = "noreply="+noreply;
			
			$.ajax({
				type : 'POST',
				url : url,
				data : data,
				success : function(result){
					console.log(result);
					if(result == 1){
						movePage(1);
					}else{
						toast("댓글 삭제 오류입니다.<br/>다시 시도해주세요.", 1500);
					}
				},error : function(){
					console.log("댓글 삭제 오류");
				}
			});
			return false;
		});
	}
	
	// 댓글 수정하기 1. 수정폼 전환
	function editReply(noreply){
		$("#reply"+noreply).css("display","none");
		$("#replyEdit"+noreply).css("display","block");
	}
	
	// 댓글 수정하기 2. 취소
	function editCancle(noreply){
		$("#reply"+noreply).css("display","block");
		$("#replyEdit"+noreply).css("display","none");
	}
	
	// 댓글 수정하기 3. 확인
	function editOk(noreply){
		var txt = $("#replyEdit"+noreply).children().children("textarea").val()
		if(txt ==""){
			toast("수정할 댓글 내용을 입력해주세요.", 1500);
			return false;
		}		
		var url = "/home/updateReply";
		var data = "reply="+txt+"&noreply="+noreply;
		
		$.ajax({
			type : 'POST',
			url : url,
			data : data,
			success : function(result){
				if(result == 1){
					movePage(1);
				}
			},error : function(){
				console.log("댓글 수정 오류");
			}
		});
	}
	
	// 쪽지창 열기
//쪽지창 열기
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