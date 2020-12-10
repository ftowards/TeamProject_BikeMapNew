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
		var toast = $("#toast");
    	toast.addClass("reveal");
    	toast.html(msg);
    	
    	var click = '$("#toast").removeClass("reveal")';
    	if(time == null || time == 'undefined'){
    		var tag = "<br><input type='button' class='mintBtn' value='닫기' onclick='"+click+"'/>";
    		toast.append(tag);
		}else {
			setTimeout(function(){
				toast.removeClass("reveal");
			}, time);
		}
	}
	
	function toastConfirm(msg, callback) {
		var toast = $("#toastConfirm");
    	toast.addClass("reveal");
    	$("#toastConfirmMsg").html(msg);
    	
    	$("#toastConfirm").children(".btn").click(function(){
    		$("#toastConfirm").removeClass("reveal");
    		if(typeof callback != 'undefined' && callback){
    			if(typeof callback == 'function'){
    				callback();
    			}
    		}
    	});
   	}	
   	
   	function searchRegion(title){
   		var obj = $("#searchRegion");
   		
   		var tag = "<input type='hidden' name='searchKey' value='region'/>";
   			tag += "<input type='hidden' name='searchWord' value='"+title+"'/>";
   			
   		obj.html(tag);
   		obj.submit();
   		
   	}