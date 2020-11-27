package com.bikemap.home.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ReivewController {

	public SqlSession sqlSession;
	
	public SqlSession getSqlSessin() {
		return sqlSession;
		
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		
	}
	
	//후기 게시판 목록
//	@RequestMapping("/reviewView")
//	public String ReviewView() {
//		return "review/reviewView";
//	}
//	
	
	//후기 게시판 보기
	@RequestMapping("/reviewList")
	public String ReviewList() {
		return "review/reviewList";
	}
	
	//글쓰기 폼 이동
	@RequestMapping("/reviewWriteForm")
	public String ReviewWriteForm() {
		return "review/reviewWriteForm";
	}
	
	//글쓰기 전체 레코드 선택
	@RequestMapping("/reviewView")
	public ModelAndView reviewAllRecord() {
			ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
			List<ReviewVO> list = dao.reviewAllRecord();
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("list", list);
			mav.setViewName("review/reviewView");
		
		return mav;
	}
	
	
	
	
	//레코드 추가 글쓰기
	@RequestMapping(value="/reviewWriteFormOk", method=RequestMethod.POST, produces="application/text;charset=UTF-8")
	public String reviewWriteFormOk(ReviewVO vo, HttpSession ses, HttpServletRequest req) {
		vo.setIp(req.getRemoteAddr());
		vo.setUserid((String)ses.getAttribute("logId"));
		
		vo.setIp(req.getRemoteAddr());
		
		System.out.println(111);
		
		System.out.println(vo.getUserid());
		System.out.println(vo.getSubject());
		System.out.println(vo.getContent());
		System.out.println(vo.getIp());
		
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = 0;
		
		System.out.println(result);
		
		try {
			result = dao.reviewInsert(vo);
			System.out.println(vo.getContent());
		}catch(Exception e) {
			System.out.println("후기 글쓰기 에러 " + e.getMessage());
		}
		return "review/reviewList";
	}
}
	
