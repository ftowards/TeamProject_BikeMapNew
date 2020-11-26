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
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		List<AdminRegistVO>list = dao.registAllRecord();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("list", list);
		mav.setViewName("admin/adminUserTable");
		return mav;
	}
	
	//정지추가
	@RequestMapping(value="/adminUser/userSuspendOk", method=RequestMethod.POST)
	public ModelAndView userSuspendOk(AdminSuspendVO vo) {
		
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		int result = dao.suspendInsert(vo);
		ModelAndView mav = new ModelAndView();
		
		if(result>0) {
			mav.setViewName("redirectAttributes");
		}else {
			mav.setViewName("admin/result");
		}
		return mav;
	}
	
	//정지 수정 및 삭제
	@RequestMapping(value="/adminUser/userSuspendEditOk", method=RequestMethod.POST)
	public ModelAndView userSuspendUpdateOk(AdminSuspendVO vo) {
		AdminDaoImp dao = sqlSession.getMapper(AdminDaoImp.class);
		int result = dao.suspendUpdate(vo);
		ModelAndView mav = new ModelAndView();
		if(result>0) {//업데이트
			mav.setViewName("redirect:adminUser");
		}else {
			mav.setViewName("board/result");
		}
		return mav;
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
