var nowPage = 1;
//검색 기능
$(function(){
	nowPage = $("input[name=nowPage]").val();
	console.log(nowPage);
	
	// 페이지 로딩 시 전체 리스트 불러오기
	movePage(nowPage);
	
	// 검색
	$("#searchReview").submit(function(){
		if($("#searchBarReview").val() == ""){
			toast("검색어를 입력하세요.", 1500);
			return false;
		};
		movePage(1);
		return false;
	});
	
	$("input[name=orderReview]").on('change',function(){
		movePage(nowPage);
	});
});



// 펑션 ////////////////////////////////

// 페이지 이동
function movePage(page){
	
	// 페이징 먼저 변경
	var url = "/home/searchReviewPaging";
	var data = "nowPage="+page+"&searchType="+$("#searchTypeReview").val()+"&searchWord="+$("#searchBarReview").val();
 		data += "&order="+$("input[name=orderReview]:checked").val();
		
 		console.log(data);
 		
	$.ajax({
		url : url,
		data : data,
		success : function(result){
			if(result.totalRecord <= 0){
				toast("검색 결과가 없습니다.",1500);
			}else{
				$("input[name=searchType]").val($("#searchTypeReview").val())
				$("input[name=searchWord]").val($("#searchBarReview").val())
				$("input[name=order]").val($("input[name=orderReview]:checked").val());
				
				setPaging(result, data);
				$("input[name=nowPage]").val(result.nowPage);	
			}
		},error : function(){
			console.log("페이징 오류");
		}
	});
}

// 페이징 리스트 만들기
function setPaging(vo, data){
	var tag = "<ul>";
	
	if(vo.nowPage != 1){
		tag += "<li><a href='javascript:movePage("+(vo.nowPage -1)+")'> Prev </a></li>";
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
	
	tag += "</ul>";
	$("#paging").html(tag);
	
	getList(data);
}


function getList(data){
	//리스트 데이터 검색
	url = "/home/searchReview";
	$.ajax({
		url : url,
		data : data,
		success : function(result){
			console.log(result);
			makeReviewlist(result);
		}, error : function(){
			console.log("페이지 + 검색 결과 호출 에러");
		}
	});
}

//리뷰 리스트 만들기

function makeReviewlist(result){
		
	var $result = $(result);
		var listTag = "";
		$result.each(function(i, val){
			listTag += "<li class='reviewContents'><div class = 'left'>";
			listTag += "<img src='"+val.thumbnailImg+"' onclick='goReviewView(title);' title = '"+val.noboard+"'/></div>";
			listTag += "<div class='right'><ul onclick='goReviewView(title);' title ='"+val.noboard+"'>";
			listTag += "<li id='subtitle' class='wordCut subject_title'>"+val.subject+"</li>";
			listTag += "<li class='subject_Hitcount'>Hit "+val.hit+" / 추천 "+val.thumbup+" / 비추천 "+val.thumbdown+"</li>";
			
			var contentText = val.content.replace(/(<([^>]+)>)/ig, "").replaceAll("&nbsp;" ,"");
			listTag += "<li class='paragraph' style='width : calc(100% - 20px);' id='reviewtext'>"+contentText+"</li>";
			listTag += "<li class='userid'><img src='/home/img/img_Review/review.png'/>"+val.userid+"님의 생생한 후기</li>";
			listTag += "<li class='writedate'>"+val.writedate+"</li></ul></div></li>";
		});
	$("#reviewBoard").html(listTag);
}

function goReviewView(noboard){
	$("input[name=noboard]").val(noboard);	
	$("#pagingVO").submit();
}

function goWriteForm(){
	
	$.ajax({
		url: "/home/checkTourcnt",
		success : function(result){
			if(result < 1){
				toast("투어 참가 횟수가 1회 미만일 경우 리뷰를 작성할 수 없습니다.");
			}else {
				location.href='/home/reviewWriteForm';
			}
		},error : function(err){
			console.log(err);
		}
	});
}