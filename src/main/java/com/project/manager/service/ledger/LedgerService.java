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
		List<HashMap<String,Object>> ledgerList = ledgerDAO.listLedger();
		
				
				
		//three latest ledger list call..
		
		
		//concat those two data
		
		return null; //ledgerDAO.loginCheck(map);
	
	
	}
	
}
