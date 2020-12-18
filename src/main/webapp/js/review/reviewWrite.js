$(function(){
		CKEDITOR.replace('content',{
			height:600,
			extraPlugins: 'easyimage',
		    cloudServices_tokenUrl: 'https://76760.cke-cs.com/token/dev/fb98221c99f6d4fccf45b51c839a7d022ad90ab2f9dfbc25f02ecdc03d98',
		    cloudServices_uploadUrl: 'https://76760.cke-cs.com/easyimage/upload/',
		});
	
	$("#writeform").submit(function(){
		CKEDITOR.instances.content.updateElement();
		
		if($("#subject").val()==""){
			toast("제목을 입력하세요.",1500);
			return false;		
		}
		
		if(CKEDITOR.instances.content.getData()==""){
			toast("글내용을 입력하세요.",1500);
			return false;
		}

		var url = "/home/reviewWriteFormOk";
		var params = $("#writeform").serialize();
		
		$.ajax({
			type : 'POST',
			url : url,
			data : params,
			success : function(result) {
				console.log(result);
				if(result>0){
					toast("글이 등록되었습니다.",1500)
					setTimeout(function(){location.href="/home/reviewList";},1500);
				}else{
					toast("글등록이 실패하였습니다.");
					}
				},error:function(){
					console.log("글쓰기 오류");
				}
			});
			return false;	
		});
	});