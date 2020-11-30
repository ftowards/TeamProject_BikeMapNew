package com.bikemap.home.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

	
	
	//레코드 한개 선택 - 글 보기
	@RequestMapping("/reviewList")
	public ModelAndView reviewSelect(int noboard) {
		ReviewDaoImp dao =  sqlSession.getMapper(ReviewDaoImp.class);
		
//		dao.hitCount(no);
		ReviewVO vo = dao.reviewSelect(noboard);
		
			
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo",vo);
		mav.setViewName("review/reviewList");
		
		return mav;
	}

	//글쓰기 폼 수정
	@RequestMapping("/reviewEdit")
	public ModelAndView reviewEdit(int noboard) {
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		ReviewVO vo = dao.reviewSelect(noboard);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("vo", vo);
		mav.setViewName("review/reviewEdit");
		
		return mav;
	}
	
	

	//글 수정 확인
	@RequestMapping(value="/reviewEditOk", method=RequestMethod.POST)
	public ModelAndView reviewEditOk(ReviewVO vo, HttpSession ses) {
		vo.setUserid((String)ses.getAttribute("userid"));
		
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = dao.reviewUpdate(vo);
		
		ModelAndView mav = new ModelAndView();
		if(result>0) {
			mav.addObject("noboard", vo.getNoboard());
			mav.setViewName("redirect:reviewList");
		
		}else {
			mav.setViewName("review/reviewResult");
				
		}
			return mav;
	}
	
	//글삭제 폼
	@RequestMapping("/reviewDel")
	
	public ModelAndView reviewDel(int noboard, HttpSession ses) {
		ReviewDaoImp dao = sqlSession.getMapper(ReviewDaoImp.class);
		int result = dao.reviewDelete(noboard,(String)ses.getAttribute("userid"));
		
		ModelAndView mav = new ModelAndView();
		if(result>0) {
			mav.setViewName("redirect: ReviewView");
			
		}else {
			mav.setViewName("review/reviewResult");
			
		}
		return mav;
		
	}
}
	
	
	
	



	







