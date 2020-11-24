package com.bikemap.home.tour;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class TourController {
	
	public SqlSession sqlSession ;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

		
	@RequestMapping("/tourList")
	public String boardList(PagingVO vo, Model model
			, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="onePageRecord", required=false)String onePageRecord) {
		
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		List<TourVO> list = dao.selectAllTour(vo);
		
		int totalRecord = dao.getTotalTourRecord();
		if (nowPage == null && onePageRecord == null) {
			nowPage = "1";
			onePageRecord = "8";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (onePageRecord == null) { 
			onePageRecord = "8";
		}
		vo = new PagingVO(totalRecord, Integer.parseInt(nowPage), Integer.parseInt(onePageRecord));
		
		model.addAttribute("paging", vo);
		model.addAttribute("viewAll",dao.selectAllTour(vo));
		return "tour/tourList";
	}
																							
	
	
	
	// 글쓰기 폼 이동
	@RequestMapping("/tourWriteForm")
	public String tourBoardWrite() {
		return "/tour/tourWriteForm";
	}
	// 글쓰기 등록 , produces="application/text;charset=UTF-8"
	@RequestMapping(value="/tourWriteFormOk", method=RequestMethod.POST)
	@ResponseBody
	public int tourWriteFormOk(TourVO vo ,HttpServletRequest req, HttpSession ses) {
		vo.setIp(req.getRemoteAddr());
		vo.setUserid((String)ses.getAttribute("logId"));
		
		TourDaoImp dao = sqlSession.getMapper(TourDaoImp.class);
		
		int result=0;
		try {
			result = dao.tourInsert(vo);
		
		}catch(Exception e) {
			e.getStackTrace();
		}

		return result;
	}
	
}
