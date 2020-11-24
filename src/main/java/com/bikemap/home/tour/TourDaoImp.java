package com.bikemap.home.tour;

import java.util.List;

public interface TourDaoImp {


//게시판 목록보기(전체레코드선택)
public List<TourVO> selectAllTour(PagingVO vo);

//총 레코드 수
public int getTotalTourRecord();

//레코드 추가 -글쓰기
public int tourInsert(TourVO vo);
}
