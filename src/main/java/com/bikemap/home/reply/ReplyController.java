package com.bikemap.home.reply;


import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class ReplyController {
			
	public SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//============댓글쓰기==========================================
	@RequestMapping(value="/replyWriteOk", method=RequestMethod.GET)
	@ResponseBody
	public int replyInsert(ReplyVO vo, HttpSession ses) {
		ReplyDaoImp dao = sqlSession.getMapper(ReplyDaoImp.class);
		vo.setUserid((String)ses.getAttribute("logId"));
		int result = 0;
		try {
			result = dao.replyInsert(vo);
		}catch(Exception e) {
			System.out.println("댓글 쓰기 에러 " + e.getMessage());
		}
		
		return result;	
	}
	
	//=============댓글보기==========================================
	@RequestMapping("/replyList")
	@ResponseBody
	public List<ReplyVO> replyAllSelect(ReplyPagingVO vo) {
		ReplyDaoImp dao = sqlSession.getMapper(ReplyDaoImp.class);
		List<ReplyVO> list = new ArrayList<ReplyVO>();
		try {
			int totalReply = dao.getTotalReplyRecord(vo);
			vo.setTotalRecord(totalReply);
			list = dao.replyAllSelect(vo);
		}catch(Exception e) {
			System.out.println("댓글 페이징 에러 " + e.getMessage());
		}
		
		return list;
	}
	
	// 댓글 페이징 
	@RequestMapping(value="/replyPaging", method=RequestMethod.POST)
	@ResponseBody
	public ReplyPagingVO replyPaging(ReplyPagingVO vo) {
		ReplyDaoImp dao = sqlSession.getMapper(ReplyDaoImp.class);
		
		try {
			int totalReply = dao.getTotalReplyRecord(vo);
			vo.setTotalRecord(totalReply);
			
		}catch(Exception e) {
			System.out.println("댓글 페이징 에러 " + e.getMessage());
		}
		return vo;
	}
	
	
	
}
