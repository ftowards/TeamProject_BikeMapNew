package com.bikemap.home.tourReply;

import java.util.List;

public interface TourReplyDaoImp {

	
//댓글 추가
public int tourReplyInsert(TourReplyVO vo);


//댓글 보기
public List<TourReplyVO> tourReplyAllSelect(int notour);

}
