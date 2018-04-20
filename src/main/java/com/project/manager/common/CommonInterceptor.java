package com.project.manager.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class CommonInterceptor extends HandlerInterceptorAdapter{

	private static final Logger logger = LoggerFactory.getLogger(CommonInterceptor.class);
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	
		logger.info("loginCheck 세션의 유무 확인");
		System.out.println("loginCheck intercepter 진입");
		
		try {
			//loginCheck 세션이 없는경우 로그인페이지로 이동
			if(request.getSession().getAttribute("loginCheck")==null) { 
				response.sendRedirect("/"); 
				return false;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
			
		return true; 
	}
}
