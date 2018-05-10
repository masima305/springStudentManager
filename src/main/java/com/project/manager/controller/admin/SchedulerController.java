package com.project.manager.controller.admin;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.project.manager.service.admin.SchedulerService;

@Controller
public class SchedulerController {

	@Autowired
	SchedulerService schedulerService;
	
	private static final Logger logger = LoggerFactory.getLogger(SchedulerController.class);
	
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
	
	
	@RequestMapping(value="/listAllScheduler.do")
	public @ResponseBody ModelAndView listAllStudent(HttpServletRequest request){
		
		System.out.println(">>>>>>>>listAllScheduler called");		
		
		List<HashMap<String, Object>> listAllSchedulerMap = schedulerService.listAllScheduler();
		
		Gson gson = new Gson();
		String listAllSchedulerGson = gson.toJson(listAllSchedulerMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllSchedulerMap"	, listAllSchedulerMap	 );
		mv.addObject("listAllSchedulerGson"	, listAllSchedulerGson	 );
		mv.setViewName("contents/adminCalendar");
		
		return mv;
	}

	
	//======================================================================================================
	//========================= INSERT METHODS  ============================================================
	//======================================================================================================
		
	
	@RequestMapping(value="/insertScheduler.do")
	public @ResponseBody HashMap<String, String> insertScheduler (HttpServletRequest request){

		System.out.println(">>>>>>>>insertScheduler Controller called");
		
		String scheId 		= request.getParameter("scheId"	);
		String scheContent 	= request.getParameter("scheContent");
		String scheStartdate= request.getParameter("scheStartdate");
		String scheEnddate	= request.getParameter("scheEnddate");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("scheId"	  	, scheId		);
		map.put("scheContent"	, scheContent	);
		map.put("scheStartdate" , scheStartdate	);
		map.put("scheEnddate"  	, scheEnddate	);
		
		int dbResult = schedulerService.insertScheduler(map);
		
		HashMap<String, String> result = new HashMap<String,String>();
		
		if(dbResult > 0) {
			result.put("message","일정 입력 성공");
		} else {
			result.put("message","일정 입력 실패");
		}
		
		return result;
	}
	
	
	//======================================================================================================
	//========================= UPDATE METHODS  ============================================================
	//======================================================================================================
		
	
	@RequestMapping(value="/updateScheduler.do")
	public @ResponseBody HashMap<String, String> updateScheduler (HttpServletRequest request){

		System.out.println(">>>>>>>>updateScheduler Controller called");
		
		String scheId 		= request.getParameter("scheId"	);
		String scheContent 	= request.getParameter("scheContent");
		
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("scheId"	  	, scheId		);
		map.put("scheContent"	, scheContent	);
		
		int dbResult = schedulerService.updateScheduler(map);
		
		HashMap<String, String> result = new HashMap<String,String>();
		
		if(dbResult > 0) {
			result.put("message","일정 수정 성공");
		} else {
			result.put("message","일정 수정 실패");
		}
		
		return result;
		
	}
	
	//======================================================================================================
	//========================= DELETE METHODS  ============================================================
	//======================================================================================================
		
	
	@RequestMapping(value="/deleteScheduler.do")
	public @ResponseBody HashMap<String, String> deleteScheduler(HttpServletRequest request) {
		
		System.out.println(">>>>>>>>deleteScheduler Controller called");
		
		String scheId	= request.getParameter("scheId");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("scheId", scheId);
		
		int dbResult = schedulerService.deleteScheduler(map);
		HashMap<String, String> result = new HashMap<String,String>();
		
		if(dbResult > 0) {
			result.put("message","일정 삭제 완료");
		} else {
			result.put("message","일정 삭제 실패");
		}
		
		return result;
	}
	
	
}
