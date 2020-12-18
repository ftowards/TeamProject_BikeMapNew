var socket = null;

$(function(){

	if($("#logId").val() == null || $("#logId").val() ==""){
		return false;
	}
	
	if($("#logId").val() != null && $("#logId").val() !=""){
		sock = new SockJS('/home/echo');
		socket = sock;
	}

	sock.onopen = function(){
		
		var sessionVal = $("#logId").val();
		if(sessionStorage.getItem('key') == null){
			$.ajax({
				url:"/home/chkReadYetMsg",
				success: function(result){
					toastLogin("<a href='/home/messageBox'>새 알람이 "+result+"개 있습니다.</a>");
				}, error : function(err){
					console.log(err);
				}
			});		
			sessionStorage.setItem('key', sessionVal);
		}
		
		console.log("통신 연결 완료");
	}

	sock.onmessage = function(event){
		var data = event.data;
		console.log("받은 데이터 : " + data + "\n");
		toast(data, 1500);
	}
	
	sock.onclose = function(){
		console.log("연결 종료");
	}

	sock.onerror = function(err){
		console.log("통신 장애 " + err);
	}
});

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
	
	function toastLogin(msg, time) {
		var toast = $("#toastLogin");
    	toast.addClass("reveal");
    	$("#toastLoginMsg").html(msg);
    	
    	var click = '$("#toastLogin").removeClass("reveal")';
    	if(time == null || time == 'undefined'){
    		var tag = "<br><input type='button' class='mintBtn' value='닫기' onclick='"+click+"'/>";
    		$("#toastLoginMsg").append(tag);
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
    				cnt ++;
    			}
    		}
    		$("#toastConfirm").removeClass("reveal");
    	});
    	console.log("이미끝남");
   	}	
   	
   	function searchRegion(title){
   		var obj = $("#searchRegion");
   		
   		var tag = "<input type='hidden' name='searchKey' value='region'/>";
   			tag += "<input type='hidden' name='searchWord' value='"+title+"'/>";
   			
   		obj.html(tag);
   		obj.submit();
   	}