package com.bikemap.home.review;

import java.util.List;

import com.bikemap.home.review.ReviewVO;

public interface ReviewDaoImp {


	//전체 레코드 선택
	public List<ReviewVO> reviewAllRecord();
	
	//레코드 추가 - 글쓰기
	public int reviewInsert(ReviewVO vo);
	
}
