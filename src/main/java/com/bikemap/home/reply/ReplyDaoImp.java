package com.bikemap.home.reply;

import java.util.List;


public interface ReplyDaoImp {

	//댓글 추가
	public int replyInsert(ReplyVO vo);
	
	//댓글 보기
	public List<ReplyVO> replyAllSelect(ReplyPagingVO vo);
	
	//총 레코드 수
	public int getTotalReplyRecord(ReplyPagingVO vo);
	
	//댓글 삭제
	public int delReply(ReplyVO vo);
	
	//댓글 수정
	public int updateReply(ReplyVO vo);

}
