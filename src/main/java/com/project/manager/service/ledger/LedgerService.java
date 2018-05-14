package com.project.manager.service.ledger;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.manager.dao.ledger.LedgerDAO;

@Service
public class LedgerService {

	@Autowired
	LedgerDAO ledgerDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(LedgerService.class);
	
	//-------------------------------------------------------------------------------------------------
	//---------------------------------  INSERT METHOD  -------------------------------------------------	
	//-------------------------------------------------------------------------------------------------
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int insertLedger(HashMap<String, Object> map){
		
		logger.info(">>>>>>>>ledgerInsert Service called");
		int result = 0;
		
		try {
			result = ledgerDAO.insertLedger(map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int insertLedgerMonthly(HashMap<String, Object> map){
		
		logger.info(">>>>>>>>insertLedgerMonthly Service called");
		int result = 0;
		
		try {
			result = ledgerDAO.insertLedgerMonthly(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	//-------------------------------------------------------------------------------------------------
	//---------------------------------  READ METHOD  -------------------------------------------------	
	//-------------------------------------------------------------------------------------------------	
	
	
	//가장 마지막으로 정산된 항목을 날짜와 금액을 쌍으로 해서 불러낸다.
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public HashMap<String, Object> getLatestMonthBalance(){
		
		HashMap<String, Object> result = null;
		
		try {
			result = ledgerDAO.getLatestMonthBalance();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
		
		
	//지금 저장되어있는 분류 리스트를 뽑아내준다.		
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String,Object>> listLedgerCate(){
		
		logger.info(">>>>>>>>listLedgerCate Service called");
		List<HashMap<String,Object>> LedgerCate = null;
		
		try {
			LedgerCate = ledgerDAO.listLedgerCate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return LedgerCate;
	}
	
	//특정 달의 장부를 가지고 온다.
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public HashMap<String,Object> listMonthlyLedger(String month){
		
		/*
		 * 만드려는 자료 형태 :
		 * 	{
		 * 		ledgMonthBalance 	: 지난달 잔액 값. 	(String) ,
		 * 		ledgerList	: 완성된 이번달 장부	(List<HashMap<String,Object>>)
		 * 		ledgerStat	: 이번달 거래 분석	(HashMap<String,String>) 
		 * 	}
		 * 
		 * */
		
		logger.info(">>>>>>>>listMonthlyLedger Service called");
		//장부 카테고리 불러오기
		
		HashMap<String, Object> result = null;
		
		try {
			
			//마지막으로 정산 완료된 월과 balance를 알아온다.
			result = getLatestMonthBalance();
			
			if(result == null) {
				//TODO : db에 아무런 컬럼이 들어있지 않을때를 처리한다.
			}
			String thisMonth 	= result.get("LEDG_MONTH_DATE"	).toString(); // 가장 마지막으로 정산된 월
			String balance 		= result.get("LEDG_MONTH_BALANCE"	).toString(); // 가장 마지막 월의 정산액
			
			result = new HashMap<String, Object>();
			result.put("thisMonth", getAfterMonth(thisMonth)); //정산완료된 달 그 다음달의 지출 리스트를 뽑아오기 위해
																// 1달 이후를 넣어준다.
			
			//장부 리스트를 쭉 받아온다.
			List<HashMap<String,Object>> ledgerList 
									= ledgerDAO.listThisMonthLedger(result);
			
			//다쓴 hash는 결과값 저장을 위해 비워주자.
			result.clear();
			
			//잔액 상태에서 리스트에 있는 항목들을 하나씩 연산 한 뒤 완성된 표의 형태로 만들어서 자료형에 담는다.
			//complete list메소드가 그 역할을 한다.
			ledgerList = completeList(ledgerList , balance);
			
			//이번달 장부 내역을 분석한다.
			HashMap<String, String> ledgerStat = analyzeList(ledgerList,balance);
				
			//다 담아서 한번에 보낸다.
			result.put("ledgerList"			, ledgerList);		//완성된 장부 리스트
			result.put("ledgMonthBalance"	, balance	);		//지난달 장부상 잔액(이월금액)
			result.put("ledgerStat"			, ledgerStat);		//완성된 분석내역
			result.put("ledgerDate"			, getAfterMonth(thisMonth)); //장부상 날짜(월단위)
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	//특정 여러달의 장부를 한번에 가지고 와서 조건에 맞게 분류한다.
	/*
	 * 검색 조건에는 총 3개가 있는데, 검색 대상 기간, 입출금 여부, 분류별 이렇게 있음.
	 * 디비가 많이 커질 수 있기때문에 일단 검색 대상 기간은 무조건 산정하는걸로 하고,대상 기간안에 있는 입출금 내역을 DB에서 꺼내온다.
	 * 입출금 여부와 분류 여부는 일단 잔액이 보함된 내역서가 완성된 후에 분류를 할 수 있기 때문에 일단 잔액이 포함된 입출금 내역을 완성한 후에
	 * 다시 함수를 거쳐 입출금 여부와 분류별 산정의 조건을 거친 행만 제외하고 나머지를 다 삭제시키는 작업을 해주어야 한다.
	 * 따라서, 기간별 내역은 DB로, 나머지 조건은 JAVA 서비스단에서 실행하여 완성된 테이블을 view에 뿌리는 과정을 거쳐야 한다.
	 *  
	 * */
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public HashMap<String,Object> listSearchMonthlyLedger(HashMap<String,Object> map){
		
		/*
		 * 
		 * 만드려는 자료 형태 :
		 * 	{
		 * 		ledgMonthBalance 	: 기간에서 최초 월의 전액 값. 	(String) ,
		 * 		ledgerList	: 완성된 이번달 장부	(List<HashMap<String,Object>>)
		 * 		ledgerStat	: 이번달 거래 분석	(HashMap<String,String>) 
		 * 	}
		 * 
		 * */
		
		
		logger.info(">>>>>>>>listSearchMonthlyLedger Service called");
		
		String startMonth 			= String.valueOf(map.get("ledgStartMonth")		); 
		String endMonth 			= String.valueOf(map.get("ledgEndMonth")		); 
		String searchLedgCategory 	= String.valueOf(map.get("searchLedgCategory")	);
		String searchLedgTradeType 	= String.valueOf(map.get("searchLedgTradeType")	);
		
		HashMap<String, Object> result = new HashMap<String, Object>();
		
		try {
			
			//장부 카테고리 불러오기
			
			//지금 날짜를 알아내서 직전월의 잔액을 알아온다
			//hash map 이름을 미리 result로 만들어서 재활용하자 메모리 아끼고...
			
			//startMonth ~ endMonth까지 중간에 끼인 기간을 월단위로 만들어서 해줘야함.
			List <String> monthList = makeMonthPeriodList(startMonth,endMonth);
			
			//가공한 자료를 전부 맵에 담아준다.
			result.put("lastMonth"	, getLastMonth(startMonth)	);
			result.put("keywordList", monthList 				);
			
			
			String balance = 												// 받아온 바로 이전달의 잔액
					ledgerDAO.getLastMonthBalance(result).get("LEDG_MONTH_BALANCE").toString(); 
			if(balance == null){
				balance = "0";
			}
			
			//장부 리스트를 쭉 받아온다.
			List<HashMap<String,Object>> ledgerList = ledgerDAO.listMultiMonthLedger(result);
			
			//다쓴 hash는 결과값 저장을 위해 비워주자.
			result.clear();
			
			//잔액 상태에서 리스트에 있는 항목들을 하나씩 연산 한 뒤 완성된 표의 형태로 만들어서 자료형에 담는다.
			//complete list메소드가 그 역할을 한다.
			ledgerList = completeList(ledgerList , balance);
			
			//이번달 장부 내역을 분석한다.
			HashMap<String, String>ledgerStat = analyzeList(ledgerList,balance);
					
			//완성된 표에서 조건들을 다시 한번 거른다.
			ledgerList = selectList(ledgerList, searchLedgCategory,searchLedgTradeType);
			
			result.put("ledgerList"			, ledgerList);		//완성된 장부 리스트
			result.put("ledgMonthBalance"	, balance	);		//지난달 장부상 잔액(이월금액)
			result.put("ledgerStat"			, ledgerStat);		//완성된 분석내역
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	

	//장부 인서트 폼에 보여줄 최근 기록 3개를 보여준다.
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public HashMap<String,List<HashMap<String,Object>>> ledgerForm(){
		
		logger.info(">>>>>>>>ledgerForm Service called");
		
		//리턴할 새 자료형을 선언해준다.
		HashMap<String,List<HashMap<String,Object>>> CateAndList = 
				new HashMap<String,List<HashMap<String,Object>>>();
		
		try {
			
			//장부 카테고리 불러오기
			List<HashMap<String,Object>> ledgerCate = ledgerDAO.listLedgerCate();
			
			//지금 날짜를 알아내서 직전월의 잔액을 알아온다. --X
			/*
			HashMap<String, Object> curMonth = new HashMap<String, Object>();
			curMonth.put("lastMonth", getLastMonth());
			curMonth.put("thisMonth", getThisMonth());
			*/
			//마지막으로 정산 완료된 월과 balance를 알아온다.
			
			HashMap<String, Object> curMonth = getLatestMonthBalance();
			if(curMonth == null) {
				//TODO : db에 아무런 컬럼이 들어있지 않을때를 처리한다.
			}
			String thisMonth 	= curMonth.get("LEDG_MONTH_DATE"	).toString(); // 가장 마지막으로 정산된 월
			String balance 		= curMonth.get("LEDG_MONTH_BALANCE"	).toString(); // 가장 마지막 월의 정산액
			
			curMonth = new HashMap<String, Object>();
			curMonth.put("thisMonth", getAfterMonth(thisMonth)); //정산완료된 달 그 다음달의 지출 리스트를 뽑아오기 위해
																// 1달 이후를 넣어준다.
			
			
			//장부 리스트를 쭉 받아온다.
			List<HashMap<String,Object>> ledgerList 
									= ledgerDAO.listThisMonthLedger(curMonth);
		
			//잔액 상태에서 리스트에 있는 항목들을 하나씩 연산 한 뒤 완성된 표의 형태로 만들어서 자료형에 담는다.
			//complete list메소드가 그 역할을 한다.
			ledgerList = completeList(ledgerList , balance);
			
			//최신 거래내역에서 3개 이전까지의 정보만 필요하기때문에 그정도만 갖고 나갈 수 있도록 정보를 추린다.
			//최신 거래내역이 없을수도 있기 때문에 0일때의 예외처리를 반드시 해준다.
			if(ledgerList.size() > 3 ) {
				ledgerList = ledgerList.subList((ledgerList.size()-3), ledgerList.size());
			}
			
			//여기서 최대한 완성된 표를 만들어서 하나의 자료로 압축시킨뒤 컨트롤러에 보낸다.
			CateAndList.put("ledgerCate", ledgerCate);
			CateAndList.put("ledgerList", ledgerList);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return CateAndList; //return category list and three of latest ledger list.;
	}
	
	//-------------------------------------------------------------------------------------------------
	//---------------------------------  TOOL METHOD (DB 연결 없음)---------------------------------------	
	//-------------------------------------------------------------------------------------------------	
	
	//잔액과 리스트를 넣어주면 완성된 리스트를 만들어서 리턴해준다.
	public List<HashMap<String,Object>> completeList( List<HashMap<String,Object>> inputList, String balance){
		
		for (int i = 0; i < inputList.size(); i++) {
			
			balance = calculateBalance(inputList.get(i).get("LEDG_AMOUNT").toString()
									  ,inputList.get(i).get("LEDG_TRADE_TYPE").toString()
									  ,balance);
			inputList.get(i).put("LEDG_BALANCE", balance); //기존의 표애서 balance컬럼 LEDG_BALANCE를 더해서 return한다.
			
		/*	System.out.println("잔액 : "+balance);*/
			
		}
		
		return inputList;
	}
	
	//완성된 장부 리스트를 분석해서 그 결과를 HashMap형태로 내보내준다.
	public HashMap<String,String> analyzeList( List<HashMap<String,Object>> inputList, String balance){
		
		int totalIncome 	= 0;	//수입 종합
		int totalOutcome 	= 0;	//지출 종합
		int maxIncome 		= 0;	//최대 수입
		int maxOutcome 		= 0;	//최대 지출
		String finalBalance	= "";	//장부상 최종 잔액
		HashMap<String, String> result = new HashMap<String, String> ();
		
		int tempAmount		= 0;	//입출금	임시 변수
		String tempType		= null;	//지출타입 	임시변수
		
		if(inputList.size() != 0) {
		
			//최종 잔액부터 받아두
			finalBalance = String.valueOf(inputList.get(inputList.size()-1).get("LEDG_BALANCE"));
			
			for (int i = 0; i < inputList.size(); i++) {
				
				//반복적인 메서드 사용 방지를 위한 temp변수 사용.
				tempAmount = Integer.parseInt(String.valueOf(inputList.get(i).get("LEDG_AMOUNT")));
				tempType = (String.valueOf(inputList.get(i).get("LEDG_TRADE_TYPE")));
				
				//지출건이면
				if((tempType).equals("1")) {
					//지출 종합에 일단 더해주고
					totalOutcome += tempAmount;
					//최대 지출값보다 크면 갱신
					if(tempAmount > maxOutcome) {
						maxOutcome = tempAmount;
					}
				//수입건이면
				}else if((tempType).equals("2")) {
					//수입 종합에 일단 더해주고
					totalIncome += tempAmount;
					//최대 수입값보다 크면 갱신
					if(tempAmount > maxIncome) {
						maxIncome = tempAmount;
					}
				} 
			}
		}else {
			finalBalance = balance;
		}
		
		result.put("balance"		, balance						);
		result.put("finalBalance"	, finalBalance					);
		result.put("totalIncome"	, Integer.toString(totalIncome)	);
		result.put("totalOutcome"	, Integer.toString(totalOutcome));
		result.put("maxIncome"		, Integer.toString(maxIncome)	);
		result.put("maxOutcome"		, Integer.toString(maxOutcome)	);
		
		return result;
	}
	
	public List<HashMap<String,Object>> selectList( List<HashMap<String,Object>> inputList, String searchLedgCategory, String searchLedgTradeType){
		
		String tempCate = "";
		String tempType = "";
		List<HashMap<String,Object>> outputList = new ArrayList<HashMap<String, Object>>();
		
		//System.out.println("=============================걸름망 진입=============================");
		//System.out.println("카테고리 번호                         :"+searchLedgCategory);
		//System.out.println("입출금 번호                         :"+searchLedgTradeType);
		
		
		for (int i = 0; i < inputList.size(); i++) {
			//System.out.println("=============================라운드 : "+i+"=============================");	
			if(!(searchLedgCategory.equals("")) && (!(searchLedgTradeType.equals("")))) {
				//System.out.println("=============================둘다있네 진입=============================");
				tempType = inputList.get(i).get("LEDG_TRADE_TYPE").toString();
				tempCate = inputList.get(i).get("LEDG_CATEGORY").toString();
				
				if(tempType.equals(searchLedgTradeType )&& tempCate.equals(searchLedgCategory)){
					//System.out.println("=============================둘다맞았네 진입=============================");	
					outputList.add(inputList.get(i));
				}
				
			}else if(searchLedgCategory.equals("") && (!(searchLedgTradeType.equals("")))){
				//System.out.println("=============================입출만있네 진입=============================");
				
				tempType = inputList.get(i).get("LEDG_TRADE_TYPE").toString();
				if(tempType.equals(searchLedgTradeType )){
					outputList.add(inputList.get(i));
				}
				
			}else if(!(searchLedgCategory.equals("")) && (searchLedgTradeType.equals(""))){
				//System.out.println("=============================분류만있네 진입=============================");
				tempCate = inputList.get(i).get("LEDG_CATEGORY").toString();
				if(tempCate.equals(searchLedgCategory)){
					outputList.add(inputList.get(i));
				}
			}else {
				outputList = inputList;
			}
		}
		return outputList;
	}
	
	
	//장부 금액, 계산방법(1:출금, 2:입금), 잔액을 넣어주면 계산된 잔액이 나온다.
	public String calculateBalance(String calculateAmount, String calculateMethod, String calculateBalance){
		
		int Amount 	= Integer.valueOf(calculateAmount	);
		int balance = Integer.valueOf(calculateBalance	);
		if(calculateMethod.equals("1")){
			balance -= Amount;
		}
		else if(calculateMethod.equals("2")){
			balance += Amount;
		}
		return String.valueOf(balance);
	}
	
	//메소드 실행 시간에서 1달 전을 YYYYMM형태로 return해준다.
	public String getLastMonth() {
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCal = Calendar.getInstance();
		
		currentCal.add(currentCal.DATE, 0);
		String year	 = Integer.toString(currentCal.get(Calendar.YEAR) );
		String month = df.format(currentCal.get(Calendar.MONTH)		  );
	
		return ""+year+month;
	}
	
	//파라메터로 들어온값보다 1달 이전의 값을 리턴해 준다.
	public String getLastMonth(String month) {
		
		
		DateFormat dateFormat = new SimpleDateFormat("yyyyMM");
		Date date = null;
		try {
			date = dateFormat.parse(month);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH,-1);
		String result = dateFormat.format(cal.getTime());
		
		return result;
	}
	
	//파라메터로 들어온 값보다 1달 이후의 값을 리턴해 준다.
	public String getAfterMonth(String month) {
		
		
		DateFormat dateFormat = new SimpleDateFormat("yyyyMM");
		Date date = null;
		try {
			date = dateFormat.parse(month);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH,+1);
		String result = dateFormat.format(cal.getTime());
		
		return result;
	}
	
	//메소드를 부른 시점의 달을 리턴해준다.
	public String getThisMonth() {
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCal = Calendar.getInstance();
		
		currentCal.add(currentCal.DATE, 0);
		String year = Integer.toString(currentCal.get(Calendar.YEAR));
		String month = df.format(currentCal.get(Calendar.MONTH)+1);
	
		return ""+year+month;
	}
		
	//startMonth ~ endMonth까지 중간에 끼인 기간을 List형태로 월단위로 만들준다.
	public static List<String> makeMonthPeriodList(String startMonth, String endMonth){
		
		List<String> periodList = new ArrayList<String>();
		
		DateFormat dateFormat = new SimpleDateFormat("yyyyMM");
		
		Date startDate 	= null;
		String tempDate = startMonth;
		
		Calendar cal = Calendar.getInstance();
		
		try {
			periodList.add(tempDate);
			while(!tempDate.equals(endMonth)) {
				startDate	= dateFormat.parse(tempDate);
				cal.setTime(startDate);
				cal.add(Calendar.MONTH,+1);
				tempDate = dateFormat.format(cal.getTime());
				periodList.add(tempDate);
			}
	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return periodList;
	}
}
