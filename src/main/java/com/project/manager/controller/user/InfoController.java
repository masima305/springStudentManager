package com.project.manager.controller.user;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.manager.service.ccode.CcodeService;
import com.project.manager.service.user.InfoService;

@Controller
public class InfoController {
	
	@Autowired
	InfoService infoService;
	
	@Autowired
	CcodeService ccodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(InfoController.class);
	
	
	//---------------------------------------------------------------
	//------------------------로그인 체크--------------------------------
	// .go 는 인터셉터 적용 제외
	
	@RequestMapping(value="loginCheck.go")
	public String loginCheck(HttpServletRequest request, HttpServletRequest response) {
		
		String stuNumber = request.getParameter("stuNumber").trim();
		String stuPassword = request.getParameter("stuPassword").trim();
		String url="redirect:/";
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
	
		//학번에 따른 '비밀번호','접근권한' 가져오기
		HashMap<String, Object> loginMap = infoService.loginCheck(map);
		
		//학번과 비밀번호가 일치하는 경우
		if(stuPassword.equals(loginMap.get("STU_PASSWORD"))) { 
		//getUser.do 로 파라미터랑 같이 보내기

			request.setAttribute("stuNumber", stuNumber); 
			
			//세션 생성
			HttpSession session = request.getSession();
			session.setAttribute("loginCheck", stuNumber); 					  //비밀번호
			session.setAttribute("stuAuthority",loginMap.get("STU_AUTHORITY")); //접근권한
			
			url="forward:/getUser.do";
		} else {
		//로그인 실패시 home.jsp(루트)로 리다이렉트
		}
		
		return url;
	}
	
	//로그아웃
	@RequestMapping(value="logout.go")
	public String logout(HttpServletRequest request, HttpServletRequest response) {
		
		request.getSession().setAttribute("loginCheck", null);
		return "redirect:/";
	}
	
	
	//---------------------------------------------------------------
	//-----------------------studentMain-----------------------------
	
	//학생 개인 정보 불러오기
	@RequestMapping(value="/getUser.do")
	public @ResponseBody ModelAndView getUser (HttpServletRequest request){
		
	
		String stuNumber = request.getParameter("stuNumber");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		
		List<HashMap<String, Object>> studentInfo = infoService.getUser(map);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("studentInfo", studentInfo);
		mv.setViewName("main/studentMain");
		return mv;
	}
		
	
	
	
	
}
