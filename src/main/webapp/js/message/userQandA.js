var board = 1;
var nowPage = 1;
var $result ;

$(function(){
	// 2. 리스트 불러오기
	$("input[name=board]").on('change', function(){
		if($("input[name=board]:checked").val() == 2){
			movePage(nowPage);	
		}
		$("input[name=answer]").prop("checked",false);
	});
	
	$("input[name=answer]").on('change', function(){
		movePage(1);
	});

	
	$("#qnaInsert").submit(function(){
		
		if($("#subject").val() ==""){
			toast("제목을 입력하세요.", 1500);
			return false;
		}
		
		if($("#content").val() ==""){
			toast("내용을 입력하세요.", 1500);
			return false;
		}
		
		var data = $("#qnaInsert").serialize();
		
		console.log(data);
	
		$.ajax({
			url : "/home/insertQna",
			data : data,
			success : function(result){
				if(result == 1){
					toast("문의가 완료되었습니다.", 1500);
					$("#subject").val("");
					$("#content").val("");
				}else{
					toast("문의 오류입니다. 다시 시도해주십시오.",1500);
				}
			},error : function(err){
				console.log(err);
			}
		});
		return false;
	});
	
	$("#chkAll").on('change', function(){
		if($("#chkAll").prop('checked')){
			$("#qnaList input[type=checkbox]").prop("checked", true);
		}else{
			$("#qnaList input[type=checkbox]").prop("checked", false);
		}
	});
	
});

function movePage(page){
	
	nowPage = page;
	var data = "nowPage="+page;
	if($("#answer").prop("checked")){
		data+= "&answer="+"Y";
	}
	
	$.ajax({
		url : "/home/qnaPaging",
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
	
	console.log(result);
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
		tag +="</ul>";
		getList(result.nowPage);
	}else {
		tag +="<li>검색 결과가 없습니다.</li></ul>";
		$("#qnaList").children().remove();
	}
	
	$("#paging").html(tag);
}

function getList(page){
	
	var data = "nowPage="+page;
	if($("#answer").prop("checked")){
		data+= "&answer=Y";
	}

	$.ajax({
		url : "/home/selectQnaList",
		data : data,
		success : function(result){
			console.log(result);
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
		tag += "<li><input type='checkbox' value='"+val.noqna+"'/></li>";
		
		tag += "<li onclick='openUp(title)' title='"+val.noqna+"'>"+val.answer+"</a></li>";
		tag += "<li onclick='openUp(title)' title='"+val.noqna+"'>"+val.typename+"</a></li>";
		tag += "<li class='wordcut' onclick='openUp(title)' title='"+val.noqna+"'>"+val.subject+"</li>";
		tag += "<li class='wordcut' onclick='openUp(title)' title='"+val.noqna+"'>"+val.content+"</li>";
		tag += "<li onclick='openUp(title)' title='"+val.noqna+"'>"+val.writedate+"</li>";
	});
		
	$("#qnaList").html(tag);
}

function openUp(title){
	
	$result.each(function(i, val){
		if(val.noqna == title){
			$("#modalQnatype").val(val.typename);
			$("#modalSubject").val(val.subject);
			$("#modalContent").val(val.content);
			
			if(val.answer == 'Y'){
				$("#modalAnswercontent").val(val.answercontent);
			}else{
				$("#modalAnswercontent").val("답변 전입니다.");
			}
		}
	});
	$("#dialog").modal('show');
}

function deleteQna(){
	$("#qnaList input[type=checkbox]").each(function(i, val){
		if($(this).prop("checked")){

			$.ajax({
				url : "/home/deleteQna",
				data : "noqna="+$(this).val(),
				success : function(result){
					if(result == 1){
						movePage(nowPage);
					}
				}, error : function(err){
					console.log(err);
				}
			});
		}
	});	
}