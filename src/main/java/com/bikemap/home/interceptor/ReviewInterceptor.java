package com.bikemap.home.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bikemap.home.regist.RegistDaoImp;
import com.bikemap.home.review.ReviewDaoImp;

public class ReviewInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	SqlSession sqlSession;
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}
	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//컨트롤러가 호출되기전에 실행된다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		HttpSession ses = request.getSession();
		
		String logStatus = (String)ses.getAttribute("logStatus");
		String logId  = (String)ses.getAttribute("logId");
		
		if(logStatus == null||!logStatus.equals("Y")) {
			response.sendRedirect(request.getContextPath()+"/login");
			return false;
		}else if(!logId.equals("admin")){
			RegistDaoImp dao = sqlSession.getMapper(RegistDaoImp.class);
			int result = dao.selectTourcnt(logId);
			if(result < 1) {
				response.sendRedirect(request.getContextPath()+"/reviewList");
				return false;
			}
		}
		return true;
	}
	
	@Override
	//컨트롤러가 실행 후 view페이지로 이동하기전에 호출된다.
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,			
			@Nullable ModelAndView modelAndView)throws Exception {
		
	}
	@Override
	//컨트롤러가 실행 후 호출된다.
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
		@Nullable  Exception ex)throws Exception {
	}
}
