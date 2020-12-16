package com.bikemap.home.notice;

import java.util.List;

import com.bikemap.home.admin.AdminQnaVO;

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
	
	// 메세지 내용 불러오기
	public NoticeVO messageView(NoticeVO vo);
	
	// 문의 카테고리 가져오기
	public List<QnaTypeVO> selectQnaType();
	
	// 문의하기
	public int insertQna(QnaVO vo);
	
	// 문의사항 페이징 전체 레코드 
	public int selectQnaRecord(QnaPagingVO vo);
	
	// 문의사항 리스트 구하기
	public List<QnaVO> selectQnaList(QnaPagingVO vo);
	
	// 문의사항 삭제
	public int deleteQna(int nonotice);
	
	// 미확인 알림 확인
	public int getReadYetMsg(String userid);
}
