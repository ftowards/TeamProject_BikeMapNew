package com.bikemap.home.notice;

import java.util.List;

public interface NoticeDaoImp {
	
	// 메세지 추가하기
	public int insertNotice(NoticeVO vo);

	// 받은 쪽지함 페이징할 전체 레코드 수 구하기 
	public int selectMessageRecord(NoticePagingVO vo);
	
	// 쪽지함 리스트 구하기
	public List<NoticeVO> selectMsgList(NoticePagingVO vo);
	
	// 메세지 읽음 처리
	public int readMessage(int nonotice); 
	
	// 메세지 삭제
	public int deleteMessage(int nonotice); 

}
