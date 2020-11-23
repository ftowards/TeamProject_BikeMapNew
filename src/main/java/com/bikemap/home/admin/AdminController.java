package com.bikemap.home.admin;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


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
	
	@RequestMapping("/adminUserTable")	//회원관리패널
	public String adminUser() {
		return "admin/adminUserTable";
	}
	@RequestMapping("/adminPartnerTable")//동행찾기패널
	public String adminPartner() {
		return "admin/adminPartnerTable";
	}
	@RequestMapping("/adminQuestionTable")//1대1문의패널
	public String admingQuestion() {
		return "admin/adminQuestionTable"; 
	}
	@RequestMapping("/adminReviewTable")//리뷰패널
	public String adminReview() {
		return "admin/adminReviewTable";
	}
	
	@RequestMapping("/adminReplyWrite")//
	public String adminReplyWrite() {
		return "admin/adminReplyWrite";
	}
	
	
	
}
