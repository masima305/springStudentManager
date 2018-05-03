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
		String curMonth = getCurrentMonth();
		
		
		
		
		//장부 리스트를 쭉 받아온다.
		List<HashMap<String,Object>> ledgerList = ledgerDAO.listLedger();
		
		
		//리턴할 새 자료형을 선언해준다.
		
		//잔액 상태에서 리스트에 있는 항목들을 하나씩 연산 한 뒤 완성된 표의 형태로 만들어서 자료형에 담는다.
		
		
		//여기서 최대한 완성된 표를 만들어서 하나의 자료로 압축시킨뒤 컨트롤러에 보낸다.
		HashMap<String,List<HashMap<String,Object>>> CateAndList = 
					new HashMap<String,List<HashMap<String,Object>>>();
		
		CateAndList.put("ledgerCate", ledgerCate);
		CateAndList.put("ledgerCate", ledgerList);
		
		return CateAndList; //return category list and three of latest ledger list.;

	}
	
	//--------------------------------------------------------------------------------
	//---------------------------------  TOOL METHOD  --------------------------------	
	//--------------------------------------------------------------------------------	
	
	public String getCurrentMonth() {
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCal = Calendar.getInstance();
		
		currentCal.add(currentCal.DATE, 0);
		String year = Integer.toString(currentCal.get(Calendar.YEAR));
		String month = df.format(currentCal.get(Calendar.MONTH)+1);
		String day = df.format(currentCal.get(Calendar.DAY_OF_MONTH));
	
		return ""+year+month;
	}
}
