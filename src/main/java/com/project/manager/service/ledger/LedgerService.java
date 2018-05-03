package com.project.manager.service.ledger;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.manager.dao.ledger.LedgerDAO;

@Service
public class LedgerService {

	@Autowired
	LedgerDAO ledgerDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(LedgerService.class);
	
	
	
	public HashMap<String,List<HashMap<String,Object>>> ledgerForm(){
		
		System.out.println(">>>>>>>>ledgerInsert Service called");
		
		//장부 카테고리 불러오기
		List<HashMap<String,Object>> ledgerCate = ledgerDAO.listLedgerCate();
		
		//지금 날짜를 알아내서 직전월의 잔액을 알아온다.
		HashMap<String, Object> curMonth = new HashMap();
		curMonth.put("lastMonth", getLastMonth());
		curMonth.put("thisMonth", getThisMonth());
		
		String balance = (String) ledgerDAO.getLastMonthBalance(curMonth).get("LEDG_MONTH_BALANCE"); // 받아온 바로 이전달의 잔액
		
		//장부 리스트를 쭉 받아온다.
		List<HashMap<String,Object>> ledgerList = ledgerDAO.listThisMonthLedger(curMonth);
		
		
		//리턴할 새 자료형을 선언해준다.
		HashMap<String,List<HashMap<String,Object>>> CateAndList = 
				new HashMap<String,List<HashMap<String,Object>>>();
	
		
		
		//잔액 상태에서 리스트에 있는 항목들을 하나씩 연산 한 뒤 완성된 표의 형태로 만들어서 자료형에 담는다.
		//complete list메소드가 그 역할을 한다.
		ledgerList = completeList(ledgerList , balance);
		
		
		
		//여기서 최대한 완성된 표를 만들어서 하나의 자료로 압축시킨뒤 컨트롤러에 보낸다.
		
		CateAndList.put("ledgerCate", ledgerCate);
		CateAndList.put("ledgerCate", ledgerList);
		
		return CateAndList; //return category list and three of latest ledger list.;

	}
	
	//--------------------------------------------------------------------------------
	//---------------------------------  TOOL METHOD  --------------------------------	
	//--------------------------------------------------------------------------------	
	
	//잔액과 리스트를 넣어주면 완성된 리스트를 만들어서 리턴해준다.
	public List<HashMap<String,Object>> completeList( List<HashMap<String,Object>> inputList, String balance){
		System.out.println("---------지금 잔액 : "+balance+"-----------");
		for (int i = 0; i < inputList.size(); i++) {
			System.out.println("---------"+i+"번 거래-----------");
			System.out.println("타입 : "+inputList.get(i).get("LEDG_TRADE_TYPE"));
			System.out.println("어마운트 : "+inputList.get(i).get("LEDG_AMOUNT"));
			balance = calculateBalance((String)inputList.get(i).get("LEDG_AMOUNT"),(String)inputList.get(i).get("LEDG_TRADE_TYPE"),balance);
			System.out.println("잔액 : "+balance);
		}
		
		
		
		
		
		return null;
	}
	
	//장부 금액, 계산방법(1:입금, 2:출금), 잔액을 넣어주면 계산된 잔액이 나온다.
	public String calculateBalance(String calculateAmount, String calculateMethod, String calculateBalance){
		int Amount = Integer.valueOf(calculateAmount);
		int balance = Integer.valueOf(calculateBalance);
		if(calculateMethod.equals("1")){
			balance += Amount;
		}
		else if(calculateMethod.equals("2")){
			balance -= Amount;
		}
		return String.valueOf(balance);
	}
	
	//메소드 실행 시간에서 1달 전을 YYYYMM형태로 return해준다.
	public String getLastMonth() {
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCal = Calendar.getInstance();
		
		currentCal.add(currentCal.DATE, 0);
		String year = Integer.toString(currentCal.get(Calendar.YEAR));
		String month = df.format(currentCal.get(Calendar.MONTH));
		String day = df.format(currentCal.get(Calendar.DAY_OF_MONTH));
	
		return ""+year+month;
	}
	public String getThisMonth() {
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCal = Calendar.getInstance();
		
		currentCal.add(currentCal.DATE, 0);
		String year = Integer.toString(currentCal.get(Calendar.YEAR));
		String month = df.format(currentCal.get(Calendar.MONTH)+1);
		String day = df.format(currentCal.get(Calendar.DAY_OF_MONTH));
	
		return ""+year+month;
	}
}
