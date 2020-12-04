package com.bikemap.home.notice;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class NoticeController {
	
public SqlSession sqlSession ;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Autowired
	DataSourceTransactionManager transactionManager;
	
	// 메세지 저장하기
	@RequestMapping("/insertNotice")
	@ResponseBody
	public int insertNotice(NoticeVO vo) {
		int result = 0;
		NoticeDaoImp dao = sqlSession.getMapper(NoticeDaoImp.class);
		try {
			result = dao.insertNotice(vo);
		}catch(Exception e) {
			System.out.println("메세지 입력 에러 " + e.getMessage());
		}
		return result;
	}
}
