package com.project.manager.service.ledger;

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
		//ledgerCate call..
		List<HashMap<String,Object>> ledgerCate = ledgerDAO.listLedgerCate();
		
		
		//three latest ledger list call..
		List<HashMap<String,Object>> ledgerList = ledgerDAO.listLedger();
		
		//concat those two data
		
		
		//여기서 최대한 완성된 표를 만들어서 보내줘야 한다.
		
		HashMap<String,List<HashMap<String,Object>>> CateAndList = 
					new HashMap<String,List<HashMap<String,Object>>>();
		
		CateAndList.put("ledgerCate", ledgerCate);
		CateAndList.put("ledgerCate", ledgerList);
		
		return CateAndList; //return category list and three of latest ledger list.;

	}
	
	
	
}
