$(function(){
	CKEDITOR.replace('content',{
		height:600 ,
		extraPlugins: 'easyimage',
	    cloudServices_tokenUrl: 'https://76760.cke-cs.com/token/dev/fb98221c99f6d4fccf45b51c839a7d022ad90ab2f9dfbc25f02ecdc03d98',
	    cloudServices_uploadUrl: 'https://76760.cke-cs.com/easyimage/upload/'
	});
	
	$("#writeform").submit(function(){
		CKEDITOR.instances.content.updateElement();
		
		if($("input[name=subject]").val() == ""){
			toast("제목을 입력하세요.",1500);
			return false
		}
		
		if(CKEDITOR.instances.content.getData()==""){
			toast("글내용을 입력하세요.",1500);
			return false;
		}
		
		$.ajax({
			type : 'post',
			url : '/home/reviewEditOk',
			data : $("#writeform").serialize(),
			success : function(result){
				if(result > 0){
					toast("수정 완료되었습니다.", 1500);
					setTimeout(function(){location.href="/home/reviewView?noboard="+$("#noboard").val();},1500);
				}else{
					toast("후기 수정 오류입니다.");
				}
			},error : function(err){
				console.log(err);
			}
		});
		
		return false;
	});
});