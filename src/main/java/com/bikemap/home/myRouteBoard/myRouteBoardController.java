package com.bikemap.home.myRouteBoard;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class myRouteBoardController {

	public SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@RequestMapping("/mySavedRouteBoard")
	public String myRouteBoardList() {
		return "myRouteBoard/mySavedRouteBoard";
	}
	
}
