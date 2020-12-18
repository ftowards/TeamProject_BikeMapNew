<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/home/css/reviewView.css" type="text/css"/>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script>
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
	var url = "<%=request.getContextPath()%>/searchReviewPaging";
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
	// 이전 페이징 삭제
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
	url = "<%=request.getContextPath()%>/searchReview";
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
	console.log(noboard);
	
	$("input[name=noboard]").val(noboard);
	
	console.log($("#pagingVO").serialize());

	$("#pagingVO").submit();
}

function goWriteForm(){
	
	$.ajax({
		url: "/home/checkTourcnt",
		success : function(result){
			if(result < 1){
				toast("투어 참가 횟수가 1회 미만일 경우 리뷰를 작성할 수 없습니다.");
			}else {
				location.href='<%=request.getContextPath()%>/reviewWriteForm';
			}
		},error : function(err){
			console.log(err);
		}
	});
}

</script>
<!-- 후기보기메인 -->
<div class="container">
	<div class="reviewBody">	
		<form class = "search" id="searchReview" name="searchReview">
			<select name="searchTypeReview" id="searchTypeReview">
				<option value="subject">글제목</option>
				<option value="userid">작성자</option>
				<option value="content">내용</option>				
			</select>
			<input type="text" id="searchBarReview" name="searchWordReview"/>
			<input type="submit" class="mint_Btn" style="vertical-align:bottom; margin-left : 10px;"value="검 색"/>
		</form>
		<form id="pagingVO" method="post" action="/home/reviewView" style="diplay:none">
			<input type="hidden" name="nowPage" value="${pagingVO.nowPage }"/>
			<input type="hidden" name="searchType" value="${pagingVO.searchType }"/>
			<input type="hidden" name="searchWord" value="${pagingVO.searchWord }"/>
			<input type="hidden" name="order" value="${pagingVO.order }"/>
			<input type="hidden" name="noboard" value=""/>
		</form>

<!--후기 제목 -->
		<div class= "reviewtitle">
			<ul>
				<li class="title">후기 게시판</li>
				<li class="orderRadio">
				<input type="radio"  name="orderReview" id="orderDesc" value="noboard" <c:if test="${pagingVO.order == 'noboard' }">checked</c:if>/>
					<label for="orderDesc" class="orderBtn">최신순</label>&ensp;|&ensp;
				<input type="radio" name="orderReview" id="orderAsc" value="thumb" <c:if test="${pagingVO.order == 'thumb' }">checked</c:if>/>
					<label for="orderAsc" class="orderBtn">추천순</label></li>
				<li>
				<input type="button" class="gray_Btn" name="reviewWriteBoard" value="글쓰기" onclick="goWriteForm()"></li>
			</ul>
		</div>

<!-- 후기창 게시판 -->
		<hr style='border:1.5px solid black; margin-bottom:0; background-color:black'/>
		<div id="reviewBoard">
			<ul class ="boardlist">
				<c:forEach var="vo" items="${list }">
					<li class="reviewContents">
		<!-- 						후기창 왼쪽 면 -->
						<div class ="left">
							<img src="${vo.thumbnailImg }" onclick="goReviewView(title);" title = "${vo.noboard }"/>
						</div>
		<!-- 						후기창 오른쪽 면 -->
						<div class="right">
							<ul onclick="goReviewView(title);" title = "${vo.noboard }">
								<li id="subtitle" class="wordCut subject_title">${vo.subject }</li>
								<li class="subject_Hitcount">Hit ${vo.hit} / 추천 ${vo.thumbup } / 비추천 ${vo.thumbdown }</li>
								<li class="wordCut" id="reviewtext">${vo.content }</li>
								<li class="userid">
									<img src="<%=request.getContextPath() %>/img/img_Review/review.png"/>
									${vo.userid }님의 생생한 후기
								</li>
								<li class="writedate">${vo.writedate }</li>
							</ul>
						</div>
		 			</li>
		 		</c:forEach>
			</ul>
		</div>
			
<!-- 		=============================페이징============================= -->
		<div id="paging" style='margin:35px auto 120px'>
			<ul>
			<!-- 이전 페이지 -->
				<c:if test="${pagingVO.nowPage != 1 }">
					<li><a href="javascript:movePage(${pagingVO.nowPage-1 })"> Prev </a></li>
				</c:if>
				<c:forEach var="page" begin="${pagingVO.startPageNum }" end="${pagingVO.startPageNum + pagingVO.onePageNumCount -1}">
					<c:if test="${pagingVO.totalPage >= page }">
						<c:if test="${pagingVO.nowPage == page }">
							<li style='color:#00B0B0; font-weight:600;'>${page }</li>
						</c:if>
						<c:if test="${pagingVO.nowPage != page }">
							<li><a href="javascript:movePage(${page })" style='color:black; font-weight:600;'>${page }</a></li>
						</c:if>
					</c:if>
				</c:forEach>
			<!-- 다음 페이지 -->
				<c:if test="${pagingVO.nowPage != pageVO.totalPage }">
					<li><a href="javascript:movePage(${pagingVO.nowPage+1})">Next</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</div>
