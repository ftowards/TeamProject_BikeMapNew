package com.bikemap.home.admin;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bikemap.home.review.ReviewVO;
import com.bikemap.home.route.RouteVO;
import com.bikemap.home.tour.TourVO;

@Controller
public class AdminController {
	@Autowired
	SqlSession sqlSession;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	//회원관리전체리스트
	@RequestMapping("/adminUser")
	public ModelAndView adminUser(AdminPagingVO vo) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);

		try {	
			vo.setTotalRecord(dao.searchRegistRecord(vo));
			List<AdminRegistVO> list = dao.selectRegistAll(vo);

			mav.addObject("type", "user");
			mav.addObject("list", list);
			mav.addObject("pagingVO", vo);	
		}catch(Exception e) {
			System.out.println("회원 검색 화면 호출 에러111"+e.getMessage());
		}	
		mav.setViewName("admin/adminUserTable");
		return mav;
	}
	@RequestMapping(value="/adminUserAjax", method=RequestMethod.POST)
	@ResponseBody
	public List<AdminRegistVO> adminUserAjax(AdminPagingVO vo) {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<AdminRegistVO>list = new ArrayList<AdminRegistVO>();
		try {	
			vo.setTotalRecord(dao.searchRegistRecord(vo));
			list = dao.selectRegistAll(vo);		
		}catch(Exception e) {
			System.out.println("회원 검색 화면 호출 에러"+e.getMessage());
		}	
		return list;
	}
	//정지추가
	@RequestMapping(value="/userSuspendOk", method=RequestMethod.POST)
	@ResponseBody
	public AdminSuspendVO userSuspendOk(AdminSuspendVO vo) {
		AdminSuspendVO Avo = null;
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		
		try{
			if(dao.suspendInsert(vo) > 0) {
				Avo = dao.getEndday(vo);
			}
		}catch(Exception e) {
			System.out.println("회원 정지 처리 에러 " + e.getMessage());
		}
		return Avo;
	}
	
	@RequestMapping(value="/userSuspendUpdateOk", method=RequestMethod.POST)
	@ResponseBody
	public AdminSuspendVO userSuspendUpdateOk(AdminSuspendVO vo) {
		AdminSuspendVO Avo = null;
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		
		try {
			if( dao.suspendUpdate(vo) > 0) {
				Avo = dao.getEndday(vo);
			}
		}catch(Exception e) {
			System.out.println("회원 정지 수정 에러 " +  e.getMessage());
		}
		return Avo;
	}
	
	//루트패널
	@RequestMapping("/adminRoute")
	public ModelAndView adminRoute(AdminPagingVO vo) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		try {	
			vo.setTotalRecord(dao.searchRouteRecord(vo));
			List<RouteVO> list = dao.routeAllRecord(vo);
			
			mav.addObject("type", "route");
			mav.addObject("list", list);
			mav.addObject("pagingVO", vo);	
		}catch(Exception e) {
			System.out.println("리뷰 검색 화면 호출 에러"+e.getMessage());
		}	
		mav.setViewName("admin/adminRouteTable");
		return mav;
	}
	
	@RequestMapping(value="/adminRouteAjax", method=RequestMethod.POST)
	@ResponseBody
	public List<RouteVO> adminRouteAjax(AdminPagingVO vo) {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<RouteVO>list = new ArrayList<RouteVO>();
		try {	
			vo.setTotalRecord(dao.searchRouteRecord(vo));
			list = dao.routeAllRecord(vo);		
		}catch(Exception e) {
			System.out.println("리뷰 검색 aJax 화면 호출 에러111"+e.getMessage());
		}	
		return list;
	}
	
	//동행찾기패널
	@RequestMapping("/adminTour")
	public ModelAndView adminTour(AdminPagingVO vo) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		try {	
			vo.setTotalRecord(dao.searchTourRecord(vo));
			List<TourVO> list = dao.tourAllRecord(vo);
			
			mav.addObject("type", "tour");
			mav.addObject("list", list);
			mav.addObject("pagingVO", vo);	
		}catch(Exception e) {
			System.out.println("회원 검색 화면 호출 에러111"+e.getMessage());
		}	
		mav.setViewName("admin/adminTourTable");
		return mav;
	}
	@RequestMapping(value="/adminTourAjax", method=RequestMethod.POST)
	@ResponseBody
	public List<TourVO> adminTourAjax(AdminPagingVO vo) {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<TourVO>list = new ArrayList<TourVO>();
		try {	
			vo.setTotalRecord(dao.searchTourRecord(vo));
			list = dao.tourAllRecord(vo);		
		}catch(Exception e) {
			System.out.println("투어 검색 화면 호출 에러111"+e.getMessage());
		}	
		return list;
	}	
	
	//리뷰패널
	@RequestMapping("/adminReview")
	public ModelAndView adminReview(AdminPagingVO vo) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
	
		try {	
			List<ReviewVO> list;
			if(vo.getSearchType()!=null||vo.getSearchType()!="") {
				vo.setTotalRecord(dao.searchReviewRecord(vo));
				list = dao.reviewAllRecord(vo);
			}else {
				vo.setTotalRecord(dao.reviewTotalRecord());
				list = dao.reviewAllRecord(null);//처음에는 검색어 없으므로 그냥 널값넣어준다.
			}
			
			mav.addObject("type", "review");
			mav.addObject("list", list);
			mav.addObject("pagingVO", vo);	
		}catch(Exception e) {
			System.out.println("리뷰 검색 화면 호출 에러"+e.getMessage());
		}	
		mav.setViewName("admin/adminReviewTable");
		return mav;
	}

	@RequestMapping(value="/adminReviewAjax", method=RequestMethod.POST)
	@ResponseBody
	public List<ReviewVO> adminReviewAjax(AdminPagingVO vo) {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<ReviewVO>list = new LinkedList<ReviewVO>();
		try {	
			vo.setTotalRecord(dao.searchReviewRecord(vo));
			list = dao.reviewAllRecord(vo);		
		}catch(Exception e) {
			System.out.println("리뷰 검색 aJax 화면 호출 에러111"+e.getMessage());
		}	
		return list;
	}	
	
	//1대1문의패널
	@RequestMapping("/adminQna")
	public ModelAndView adminQna(AdminPagingVO vo) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		try {	
			//전체 답변테이블 구하기
			vo.setTotalRecord(dao.searchQnaRecord(vo));

			List<AdminQnaVO>list = dao.selectQnaAll(vo);//처음에는 검색어 없으므로 그냥 널값넣어준다.
			mav.addObject("type", "qna");
			mav.addObject("list", list);
			mav.addObject("pagingVO", vo);	
		}catch(Exception e) {
			System.out.println("회원 답변테이블 호출 에러111"+e.getMessage());
		}	
		mav.setViewName("admin/adminQnaTable");
		return mav;
	}

	@RequestMapping(value="/adminQnaAjax", method=RequestMethod.POST)
	@ResponseBody
	public List<AdminQnaVO> adminQnaAjax(AdminPagingVO vo) {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<AdminQnaVO>list = new ArrayList<AdminQnaVO>();
		try {	
			vo.setTotalRecord(dao.searchQnaRecord(vo));
			list = dao.selectQnaAll(vo);		
		}catch(Exception e) {
			System.out.println("회원 답변테이블 Ajax 화면 호출 에러111"+e.getMessage());
		}	
		return list;
	}	
	
	//1대1 문의 답변 패널
	//1대1 문의 답변완료인 경우 답변 수정페이지로 이동한다.
	//-> 헤더 글자바꾸기, 원래 답변 보여주기정도로.
	@RequestMapping("/adminQnaWrite")
	public ModelAndView adminQnaWrite(int noqna) {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		try {
			AdminQnaVO vo = dao.selectQna(noqna);
			vo.setNoqna(noqna);
			mav.addObject("vo", vo);
		}catch(Exception e) {
			System.out.println("1대1문의 답변 패널 로딩오류 "+e.getMessage());
		}	
		mav.setViewName("admin/adminQnaWrite");
		return mav;
	}
	@RequestMapping(value="/adminQnaWriteOk", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView adminQnaWriteOk(AdminQnaVO vo) {
		
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		
		try {
			dao.qnaUpdate(vo);
			mav.setViewName("redirect:adminQna");
		}catch(Exception e) {
			System.out.println("1대1문의 답변 제출 오류"+e.getMessage());
		}
		return mav;
	}

	//페이징
	@RequestMapping(value="/adminPaging", method=RequestMethod.POST)
	@ResponseBody
	public AdminPagingVO adminPaging(AdminPagingVO paging) {
	
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		try {
			String type = paging.getType();
			
			int totalRecord = 0;
			if(type.equals("user")) {
				totalRecord = dao.searchRegistRecord(paging);				
			}else if(type.equals("tour")) {
				totalRecord = dao.searchTourRecord(paging);
			}else if(type.equals("qna")) {
				totalRecord = dao.searchQnaRecord(paging);
			}else if(type.equals("review")) {
				totalRecord = dao.searchReviewRecord(paging);
			}else if(type.equals("route")) {
				totalRecord = dao.searchRouteRecord(paging);
			}
			paging.setTotalRecord(totalRecord);
				
		}catch(Exception e) {
			System.out.println("페이징에러"+e.getMessage());
		}
		return paging;
	}
}
