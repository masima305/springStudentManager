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
		List<HashMap<String, Object>> ledgerCate = listLedgerForm.get("ledgerCate");
		List<HashMap<String, Object>> ledgerList = listLedgerForm.get("ledgerList");
		
		
		// 필요한거 : 완성된 장부내역, 공통코드들, 카테고리 목록
		Gson gson = new Gson();
		String listAllCommonGson = gson.toJson(listAllCommonMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllCommonMap"		, listAllCommonMap	 );
		mv.addObject("listAllCommonGson"	, listAllCommonGson	 );
		mv.addObject("ledgerCate"			, ledgerCate);
		mv.addObject("ledgerList"			, ledgerList);
		
		mv.setViewName("contents/ledgerInsert");
		return mv;
	}
	
	@RequestMapping(value="/insertLedger.do")
	public int insertLedger(HttpServletRequest request) {
		
		String ledgDate			= request.getParameter("ledgDate"			);
		String ledgContent		= request.getParameter("ledgContent"		);
		String ledgTradePartner	= request.getParameter("ledgTradePartner"	);
		String ledgCategory		= request.getParameter("ledgCategory");
		String ledgMethod		= request.getParameter("ledgMethod"	);
		String ledgRemark		= request.getParameter("ledgRemark");
		String ledgTradeType 	= "0";
		String ledgAmount		= "0";
		
		
		String ledgDeposit		= request.getParameter("ledgDeposit");
		String ledgWithdrawal	= request.getParameter("ledgWithdrawal");
		if(ledgDeposit.equals("0")){
			ledgTradeType = "2";
			ledgAmount = ledgWithdrawal;
		}else{
			ledgTradeType = "1";
			ledgAmount = ledgDeposit;
		}
		
		
		HashMap<String, Object> map= new HashMap<String, Object>();
		
		map.put("ledgDate" 			, ledgDate			);
		map.put("ledgContent" 		, ledgContent		);
		map.put("ledgTradePartner" 	, ledgTradePartner	);
		map.put("ledgCategory" 		, ledgCategory		);
		map.put("ledgMethod" 		, ledgMethod		);
		map.put("ledgRemark" 		, ledgRemark		);
		map.put("ledgTradeType" 	, ledgTradeType		);
		map.put("ledgAmount" 		, ledgAmount		);
				
		return ledgerService.insertLedger(map);
	
		
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
