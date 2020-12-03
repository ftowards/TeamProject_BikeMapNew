package com.bikemap.home.saveMyRoute;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SaveMyRouteController {

	public SqlSession sqlSession;

	
	public SqlSession getSqlSession() {
		return sqlSession;
	}

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@RequestMapping("/myRoute")
	public String myRoute() {
		return "/saveMyRoute/myRoute";
	}
	
	
}
