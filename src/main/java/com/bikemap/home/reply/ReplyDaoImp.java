package com.bikemap.home.reply;

import java.util.List;


public interface ReplyDaoImp {

	//댓글 추가
	public int replyInsert(ReplyVO vo);
	
	//댓글 보기
	public List<ReplyVO> replyAllSelect(int noboard);
	
	//총 레코드 수
	public int getTotalReplyRecord();

}
