package com.bikemap.home.tour;

import java.util.List;

public interface TourDaoImp {
	
	//게시판 목록보기(전체레코드선택)
	public List<TourVO> selectAllTour(PagingVO vo);
	
	//총 레코드 수
	public int getTotalTourRecord(PagingVO vo);
	
	//게시판 목록보기 (검색 결과)
	public List<TourVO> selectTour(PagingVO vo);
	
	//검색 레코드 수 구하기
	public int getTourRecord(PagingVO vo);
	
	//레코드 추가 -글쓰기
	public int tourInsert(TourVO vo);
	
	//게시판 글보기(레코드 하나 선택)
	public TourVO tourSelect(int noboard);
	
	// 투어 마지막 번호 얻어오기
	public int lastTourNo(String userid);
	
	// 투어 리스트 추가하기
	public int insertTourComplist(ComplistVO vo);
	
	// 투어 참가 여부 확인하기
	public String checkTourComplist(ComplistVO vo);
	
	// 투어 참가 취소하기
	public int cancelTour(ComplistVO vo);
	
	// 투어 참가자 리스트 가져오기
	public List<ComplistVO> selectTourComplist(int noboard);
	
	// 데드라인 확인
	public String getDeadline(int noboard);
	

}
