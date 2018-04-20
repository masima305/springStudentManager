package com.project.manager.controller.user;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	
	@RequestMapping(value="loginCheck.do")
	public ModelAndView loginCheck(HttpServletRequest request, HttpServletRequest response) {
		
		String stuNumber = request.getParameter("stuNumber");
		String stuPassword = request.getParameter("stuPassword");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
	
		//학번에 따른 비밀번호 가져오기
		HashMap<String, Object> loginMap = infoService.loginCheck(map);
		ModelAndView mv = new ModelAndView();
		
		//학번과 비밀번호가 일치하는 경우
		if(stuPassword.equals(loginMap.get("STU_PASSWORD"))) { 
			mv.addObject("stuNumber",stuNumber);
			mv.setViewName("/getUser.do");
		} else {
			mv.setViewName("home");
		}
		
		
		
		
		return mv;
	}
	
	
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
