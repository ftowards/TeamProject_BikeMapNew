package com.bikemap.home.reply;


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
		
		System.out.println(vo.getNoboard());
		
		return dao.replyInsert(vo);	
	}
	
	//=============댓글보기&페이징==========================================
	@RequestMapping("/replyList")
	@ResponseBody
	public List<ReplyVO> replyAllSelect(int noboard) {
		
		
	//	System.out.println(noboard);
		ReplyDaoImp dao = sqlSession.getMapper(ReplyDaoImp.class);

		
		
		return dao.replyAllSelect(noboard);
		
		
		
		
		
	
	}
	
	
	
}
