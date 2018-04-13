package com.project.manager.controller.admin;

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
		mv.addObject("listAllCommonJsonMap",listAllCommonMap);
		mv.addObject("listAllCommonObjectMap",listmap);

		mv.setViewName("/contents/studentFeeList");
		
		return mv;
	}
	
	
	
	/*
	 * 검색 
	 * '특정 키워드'에 따른 학생 리스트 불러오기
	 * form.id = seachKeywordForm
	 * 
	 */
	@RequestMapping(value="/searchKeywordFee.do")
	public @ResponseBody List<HashMap<String, Object>> searchKeywordFee(HttpServletRequest request){
		
		String searchCategory = request.getParameter("searchCategory");
		String searchContent = request.getParameter("searchContent");
		
		//파라미터로 넘어온 변수명에 해당하는 컬럼명으로 매핑됨 ( stuNum -> STU_NUM )
		searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("searchCategory", searchCategory);
		map.put("searchContent", searchContent);
		
		
		List<HashMap<String,Object>> searchKeywordFeeList = feeService.searchKeywordFee(map);
		
		return searchKeywordFeeList;
	}
	
	
	/*
	 * 검색 
	 * '범위'에 따른 학생 리스트 불러오기
	 * form.id = searchScopeForm
	 * 
	 */
	@RequestMapping(value="/searchScopeFee.do")
	public @ResponseBody List<HashMap<String, Object>> searchScopeFee(HttpServletRequest request){
		
		String stuNumber = request.getParameter("stuNumber");
		
		if(!stuNumber.equals("null")) {
			stuNumber+="%";
		}
		
		String feePaidStatus = request.getParameter("feePaidStatus");
		
		
		//파라미터로 넘어온 변수명에 해당하는 컬럼명으로 매핑됨 ( stuNum -> STU_NUM )
		//searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		map.put("feePaidStatus", feePaidStatus);
		
		
		List<HashMap<String,Object>> searchScopeFeeList = feeService.searchScopeFee(map);
		
		return searchScopeFeeList;
	}
	
	
	
	
	
	
	
}
