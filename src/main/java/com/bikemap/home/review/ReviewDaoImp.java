package com.bikemap.home.review;

import java.util.List;


public interface ReviewDaoImp {


	//전체 레코드 선택
	public List<ReviewVO> reviewAllRecord();
	
	//레코드 추가 - 글쓰기
	public int reviewInsert(ReviewVO vo);
	
	//레코드 1개 선택
	public ReviewVO reviewSelect(int noboard);

	//글수정
	public int reviewUpdate(ReviewVO vo);

	//글삭제
	public int reviewDelete(int noboard, String userid);
	
	
}
