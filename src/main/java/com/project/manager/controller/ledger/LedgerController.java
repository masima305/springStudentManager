package com.project.manager.controller.ledger;

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
import com.project.manager.service.ccode.CcodeService;
import com.project.manager.service.ledger.LedgerService;

@Controller
public class LedgerController {

	@Autowired
	LedgerService ledgerService;
	
	@Autowired
	CcodeService ccodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(LedgerController.class);
	
	
	
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
	
	
	@RequestMapping(value="/ledgerForm.do")
	public @ResponseBody ModelAndView ledgerForm(HttpServletRequest request) {
		
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		HashMap<String,List<HashMap<String, Object>>> listLedgerForm = ledgerService.ledgerForm();
		
		// 필요한거 : 완성된 장부내역, 공통코드들, 카테고리 목록
		Gson gson = new Gson();
		String listAllCommonGson = gson.toJson(listAllCommonMap);
		
		
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllCommonMap"		, listAllCommonMap	 );
		mv.addObject("listAllCommonGson"	, listAllCommonGson	 );
		
		
		
		
		
		mv.setViewName("contents/ledgerInsert");
		return mv;
	}
	
	
	
	/*
	 * commonCode 媛��졇�삤湲�
	 */
	/*@RequestMapping(value="/getCommonCode.do")
	public @ResponseBody ModelAndView getCommonCode(HttpServletRequest request) {
		
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		Gson gson = new Gson();
		String listAllCommonGson = gson.toJson(listAllCommonMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllCommonMap"		, listAllCommonMap	 );
		mv.addObject("listAllCommonGson"	, listAllCommonGson	 );
		
		mv.setViewName("contents/studentInsert");
		
		return mv;
	}*/
	
	
}
