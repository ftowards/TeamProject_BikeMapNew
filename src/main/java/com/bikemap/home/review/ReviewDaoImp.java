package com.bikemap.home.review;

import java.util.List;

import com.bikemap.home.route.RoutePagingVO;
import com.bikemap.home.route.RouteVO;


public interface ReviewDaoImp {


	//전체 레코드 선택
	public List<ReviewVO> reviewAllRecord(ReviewPagingVO pagingVO);
	
	//레코드 추가 - 글쓰기
	public int reviewInsert(ReviewVO vo);
	
	//레코드 1개 선택
	public ReviewVO reviewSelect(int noboard);
	
	//조회수 증가
	public int hitCount(int noboard);

	//글수정
	public int reviewUpdate(ReviewVO vo);

	//글삭제
	public int reviewDelete(int noboard, String userid);
	
	// 페이징할 레코드  숫자 구하기
	public int searchTotalRecord(ReviewPagingVO vo);
	
	// 추천 리뷰 호출하기
	public List<ReviewVO> selectRecommendReview();
	
	//추천수 
	public int chkAlreadyReviewRate(ReviewVO vo);
	
	// 리뷰 평가
	public int setThumb(ReviewVO vo);
	
	// 리뷰 평가한 기록 남기기
	public int insertReviewrate(ReviewVO vo);
	
	// 리뷰글 관리자 추천하기
	public int scrapReview(int noboard);
	
	// 리뷰글 관리자 추천 해제하기
	public int releaseReview(int noboard);
	
	// 이전글 다음글 세팅
	public int getPrevNext(ReviewPagingVO vo);
	
	public ReviewVO selectPrevNext(ReviewPagingVO vo);
	
	// 추천 비추천 호출
	public ReviewVO selectReviewThumb(int noboard);
	
}
