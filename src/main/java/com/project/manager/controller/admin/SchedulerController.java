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
		
		int dbresult = schedulerService.insertScheduler(map);
		
		HashMap<String, String> result = new HashMap<String,String>();
		
		if(dbresult > 0) {
			result.put("message","일정 입력 성공");
		} else {
			result.put("message","일정 입력 실패");
		}
		
		return result;
	}
	
	
	//======================================================================================================
	//========================= UPDATE METHODS  ============================================================
	//======================================================================================================
		
	
/*	@RequestMapping(value="/updateScheduler.do")
	public @ResponseBody int updateScheduler (HttpServletRequest request){

		System.out.println(">>>>>>>>updateScheduler called");
		
		String stuNumber 	= request.getParameter("stuNumber"		);
		String stuName 		= request.getParameter("stuName"		);
		String stuBirthday 	= request.getParameter("stuBirthday"	);
		String stuPhone 	= request.getParameter("stuPhone"		);
		String stuEmail 	= request.getParameter("stuEmail"		);
		String stuGender 	= request.getParameter("stuGender"		);
		String stuAuthority = request.getParameter("stuAuthority"	);
		String stuEnterance = request.getParameter("stuEnterance"	);
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		
		map.put("stuNumber"	  	, stuNumber		);
		map.put("stuName"	  	, stuName		);
		map.put("stuBirthday"	, stuBirthday	);
		map.put("stuPhone"	  	, stuPhone		);
		map.put("stuEmail"	  	, stuEmail		);
		map.put("stuGender"	  	, stuGender		);
		map.put("stuAuthority"	, stuAuthority	);
		map.put("stuEnterance"	, stuEnterance	);
		
		return studentService.updateStudent(map);
	}
	
	//======================================================================================================
	//========================= DELETE METHODS  ============================================================
	//======================================================================================================
		
	
	@RequestMapping(value="/deleteScheduler.do")
	public String deleteScheduler(HttpServletRequest request) {
		System.out.println(">>>>>>>>deleteScheduler called");
		
		String stuNumber 	= request.getParameter("stuNumber");
		String logReason 	= request.getParameter("logReason");
		
		System.out.println(stuNumber);
		System.out.println(logReason);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		map.put("logReason", logReason);
		
		studentService.deleteStudent(map);
		
		return "redirect:adminMain";
	}*/
	
	
}
