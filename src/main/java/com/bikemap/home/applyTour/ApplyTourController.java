package com.bikemap.home.applyTour;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ApplyTourController {
	
	public SqlSession sqlSession;

	public SqlSession getSqlSession() {
		return sqlSession;
	}

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@RequestMapping("/myApplyTour")
	public String applyTour() {
		return "applyTour/applyTourBoard";
	}
	@RequestMapping("/joinTourBoard")
	public String joinTourBoard() {
		return "applyTour/joinTourBoard";
		
	}
	@RequestMapping("/endTourBoard")
	public String endTourBoard() {
		return "applyTour/endTourBoard";
	}

}
