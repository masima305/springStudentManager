package com.project.manager.controller.admin;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.project.manager.service.admin.FeeService;
import com.project.manager.service.ccode.CcodeService;

@Controller
public class FeeController {

	@Autowired
	FeeService feeService;
	
	@Autowired
	CcodeService ccodeService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(FeeController.class);
	
	//------------전체 학생회비 리스트 불러오기.-------------------
	@RequestMapping(value="/listAllFee.do")
	public @ResponseBody ModelAndView listAllFee() {
		ModelAndView mv = new ModelAndView();
		
		List<HashMap<String, Object>> list = feeService.listAllFee();
		HashMap<String,List<HashMap<String, Object>>> listmap = ccodeService.listAllCommon();
		
		Gson gson = new Gson();
		String listAllCommonMap = gson.toJson(listmap);
		
		
		mv.addObject("list", list);
		mv.addObject("listAllCommonMap",listAllCommonMap);

		mv.setViewName("/contents/studentFeeList");
		
		return mv;
	}
}
