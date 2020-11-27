package com.bikemap.home.admin;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class AdminController {
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
	public ModelAndView adminUser() {
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		AdminPagingVO pagingVO = new AdminPagingVO();
		try {	
			int totalRecord = dao.searchTotalRecord();
			pagingVO.setTotalRecord(totalRecord);
			List<AdminRegistVO>list = dao.selectRegistAll(null);//처음에는 검색어 없으므로 그냥 널값넣어준다.
			mav.addObject("list", list);
			mav.addObject("pagingVO", pagingVO);	
		}catch(Exception e) {
			System.out.println("회원 검색 화면 호출 에러"+e.getMessage());
		}	
		mav.setViewName("admin/adminUserTable");
		return mav;
	}
	//회원관리 선택화면 출력
	@RequestMapping("/adminSearchUser")
	public ModelAndView adminUser(AdminSearchVO vo) {//검색할 항목, 검색어 가져옴
		ModelAndView mav = new ModelAndView();
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		//검색한 항목의 페이징처리
		AdminPagingVO pagingVO = new AdminPagingVO();
		try {	
			int selectRecord = dao.searchRecord(vo); //검색할 항목으로 검색된 페이지 수 구함
			pagingVO.setTotalRecord(selectRecord);
			List<AdminRegistVO>list = dao.selectRegistAll(vo);
			list = dao.selectRegistAll(vo);
			mav.addObject("list", list);				
			mav.addObject("pagingVO", pagingVO);	
		}catch(Exception e) {
			System.out.println("회원 검색 화면 호출 에러"+e.getMessage());
		}	
		mav.setViewName("admin/adminUserTable");
			return mav;
		}
	
	//정지추가
	@RequestMapping(value="/userSuspendOk", method=RequestMethod.POST)
	@ResponseBody
	public AdminSuspendVO userSuspendOk(AdminSuspendVO vo) {
		AdminSuspendVO Avo = null;
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		int result = dao.suspendInsert(vo);
		if(result>0) {
			Avo = dao.getEndday(vo);
		}
		//System.out.println(Avo.getEnddayStr()+"    log");
		return Avo;
	}
<<<<<<< HEAD
	//정지 수정 및 삭제
=======
	

	//정지 수정
>>>>>>> 6443ccd246dac840a4ea185dd19b1bed0a7c4efc
	@RequestMapping(value="/userSuspendUpdateOk", method=RequestMethod.POST)
	@ResponseBody
	public AdminSuspendVO userSuspendUpdateOk(AdminSuspendVO vo) {
		AdminSuspendVO Avo = null;
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		int result = dao.suspendUpdate(vo);
		if(result>0) {
			Avo = dao.getEndday(vo);
		}
		return Avo;
	}
	
	//동행찾기패널
	@RequestMapping("/adminPartner")
	public String adminPartner() {
		return "admin/adminPartnerTable";
	}
	//1대1문의패널
	@RequestMapping("/adminQuestion")
	public String admingQuestion() {
		return "admin/adminQuestionTable"; 
	}
	//리뷰패널
	@RequestMapping("/adminReview")
	public String adminReview() {
		return "admin/adminReviewTable";
	}
	
	@RequestMapping("/adminReplyWrite")
	public String adminReplyWrite() {
		return "admin/adminReplyWrite";
	}
	
	//유저 항목
	
	
}
