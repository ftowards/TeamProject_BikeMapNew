package com.bikemap.home.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminInterceptor extends HandlerInterceptorAdapter{
	
	//컨트롤러가 호출되기전에 실행된다.
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception{
		//로그인 여부를 확인하여 로그인 된경우 계속 실행하고 로그인이 안된경우 컨트롤러 실행을 중지한다.
		HttpSession ses = request.getSession();
		
		String logStatus = (String)ses.getAttribute("logStatus");
		String logId = (String)ses.getAttribute("logId");

		if(logStatus == null||!logId.equals("admin")) {
			response.sendRedirect(request.getContextPath()+"/");
			return false;
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
