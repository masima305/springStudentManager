package com.project.manager.controller.ledger;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	
	//월별 장부의 검색결과를 호출하는 컨트롤러. 키워드(yyyyMM)의 형식에 맞지 않는 값이 들어오거나, 값이 넘어오지 않을 시, default값으로 실행당시 월의 장부들을
	//return한다/ 
	@RequestMapping(value="/listMonthlyLedger.do")
	public @ResponseBody ModelAndView listMonthlyLedger(HttpServletRequest request) {
		
		String searchMonth		= request.getParameter("keyword");
		if(searchMonth == null) {
			DateFormat dateFormat = new SimpleDateFormat("yyyyMM");
			Date date = new Date();
			searchMonth = dateFormat.format(date).toString();  //201611
		}
		
		HashMap<String,Object> map = ledgerService.listMonthlyLedger(searchMonth);
		/*						^
		 *						|
		 * 				map에 들어가있는 자료들 형태....
		 * 
		 * 	{
		 * 		ledgMonthBalance 	: 지난달 잔액 값. 	(String) ,
		 * 		ledgerList			: 완성된 이번달 장부	(List<HashMap<String,Object>>)
		 * 		ledgerStat			: 이번달 거래 분석	(HashMap<String,String>) 
		 *			{
		 *				balance,			= 총계 칸에 들어갈 잔액
		 *				totalIncome,		= 수입합계
		 *				totalOutcome,		= 지출합계
		 *				maxIncome,			= 최대수입건
		 *				maxOutcome,			= 최대지출건
		 *				finalBalance		= 이달 최종 잔액
		 * 			}
		 * }
		 *
		 * */
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("ledgerListData"	, map);
		mv.setViewName("contents/listMonthlyLedger");
		
		return mv;
	}
	
	
	//검색 결과를 월별 결산 형태로 보여줌.
	@RequestMapping(value="/listSearchMonthlyLedger.do")
	public @ResponseBody ModelAndView listSearchMonthlyLedger(HttpServletRequest request) {
		
		String searchMonth		= request.getParameter("keyword");
		
		String searchLedgCategory 	= request.getParameter("searchLedgCategory"	);
		String searchLedgTradeType 	= request.getParameter("searchLedgTradeType");
		String ledgStartMonth 		= request.getParameter("ledgStartMonth"		);
		String ledgEndMonth 		= request.getParameter("ledgEndMonth"		);
		
		HashMap<String,Object> map = new HashMap<String, Object>();
		map.put("searchLedgCategory"	, searchLedgCategory	);
		map.put("searchLedgTradeType"	, searchLedgTradeType 	);
		map.put("ledgStartMonth"		, ledgStartMonth		);
		map.put("ledgEndMonth"			, ledgEndMonth			);
		
		
			map = ledgerService.listSearchMonthlyLedger(map);
		/*   ^
		 *   |
		 * 	 map에 들어가있는 자료들 형태....
		 * 
		 * 	{
		 * 		ledgMonthBalance 	: 지난달 잔액 값. 	(String) ,
		 * 		ledgerList			: 완성된 이번달 장부	(List<HashMap<String,Object>>)
		 * 		ledgerStat			: 이번달 거래 분석	(HashMap<String,String>) 
		 *			{
		 *				balance,			= 총계 칸에 들어갈 잔액
		 *				totalIncome,		= 수입합계
		 *				totalOutcome,		= 지출합계
		 *				maxIncome,			= 최대수입건
		 *				maxOutcome,			= 최대지출건
		 *				finalBalance		= 이달 최종 잔액
		 * 			}
		 * }
		 *
		 * */
		
		ModelAndView mv = new ModelAndView();
		
		mv.addObject("ledgerListData"	, map);
		mv.setViewName("contents/listMonthlyLedger");
		
		return mv;
	}
	
	//장부 년월과 검색란을 표시하는 페이지의 컨트롤러...
	@RequestMapping(value="/listLedger.do")
	public @ResponseBody ModelAndView listLedger(HttpServletRequest request) {
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		List<HashMap<String, Object>> ledgerCate = ledgerService.listLedgerCate();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllCommonMap", listAllCommonMap);
		mv.addObject("ledgerCate", ledgerCate);
		mv.setViewName("contents/ledgerList");
		return mv;

	}
	
	
	
	//인서트 폼에 들어갈 리스트들과 공통코드들을 호출한다.
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
	
	//=====================================================================================================
	//=========================  INSERT	 METHODS  =========================================================
	//=====================================================================================================
		
	@RequestMapping(value="/insertLedger.do")
	public @ResponseBody int insertLedger(HttpServletRequest request) {
		
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
}
