package com.bikemap.home.tourReply;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bikemap.home.tour.PagingVO;
import com.bikemap.home.tour.TourVO;

@Controller
public class TourReplyController {
			
	public SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//============댓글쓰기==========================================
	@RequestMapping(value="/tourReplyWriteOk", method=RequestMethod.GET)
	@ResponseBody
	public int tourReplyInsert(TourReplyVO vo, HttpSession ses) {
		TourReplyDaoImp dao = sqlSession.getMapper(TourReplyDaoImp.class);
		
		vo.setUserid((String)ses.getAttribute("logId"));
		
		return dao.tourReplyInsert(vo);	
	}
	
	//=============댓글보기&페이징==========================================
	@RequestMapping("/tourReplyList")
	@ResponseBody
	public List<TourReplyVO> tourReplyAllSelect(int noboard) {
		
		
	//	System.out.println(noboard);
		TourReplyDaoImp dao = sqlSession.getMapper(TourReplyDaoImp.class);

		
		
		return dao.tourReplyAllSelect(noboard);
		
		
		
		
		
	
	}
	
	
	
}
