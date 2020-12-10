package com.bikemap.home.tour;

import java.util.List;

import javax.servlet.http.HttpSession;

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
	public TourVO tourSelect(PagingVO vo);
	
	// 투어 마지막 번호 얻어오기
	public int lastTourNo(String userid);
	
	// 투어 참가 인원 확인하기
	public int checkTourRoom(int noboard);
	
	// 투어 리스트 추가하기
	public int insertTourComplist(ComplistVO vo);
	
	// 투어 참가 여부 확인하기
	public String checkTourComplist(ComplistVO vo);
	
	// 투어 참가 취소하기
	public int cancelTour(ComplistVO vo);
	
	// 투어 참가 승인하기
	public int confirmComplist(ComplistVO vo);
	
	// 투어 결석 처리하기
	public int absentTour(ComplistVO vo);
	
	// 투어 완료 처리하기
	public int completeTour(int noboard);
	
	// 투어 평가자 대상 리스트 가져오기
	public List<String> selectCompleteList(int noboard);
	
	// 투어 좋아요 평가 리스트 만들기
	public int insertEvalList(int noboard, String userid, String objId);
	
	// 투어 참가 횟수 늘리기
	public int addTourcnt(String userid);
	
	// 투어 좋아요 평가 리스트 가져오기
	public List<ComplistVO> selectEvallist(ComplistVO vo);
	
	// 투어 참가자 좋아요 평가 여부 반영하기
	public int updateEvallist(ComplistVO vo);
	
	// 좋아요 평가하기
	public int addHeart(String userid);
	
	// 투어 참가자 리스트 가져오기
	public List<ComplistVO> selectTourComplist(int noboard);
	
	// 데드라인 확인
	public String getDeadline(int noboard);
	
	// 내가 주최하는 투어 레코드 수 확인
	public int getMytourRecordCount(TourListPagingVO vo);
	
	// 내가 참가하는 투어 레코드 수 확인
	public int getApplytourRecordCount(TourListPagingVO vo);
	
	// 내가 주최하는 투어 리스트
	public List<TourlistVO> selectMytourList(TourListPagingVO vo);
	
	// 내가 참가하는 투어 리스트
	public List<TourlistVO> selectApplytourList(TourListPagingVO vo);
	
	//동행찾기 여행 상태 확인(게시글 삭제)
	public int selectTourCompState(int noboard);
	
	//참여동행 인원 확인
	public int selectComplistChk(int board);
	
	// 게시글 삭제
	public int deleteTourView(int noboard,String userid);
	
	//참여리스트 가져오기(본인제외)
	public List<String> selectComplistExceptLogId(int noboard,String userid);
	
	
	//게시글 수정(정보 불러오기)
	public TourVO tourEditSelect(int noboard,String userid);
	
	// 게시글 수정하기
	public int updateTourView(TourVO vo);

}
