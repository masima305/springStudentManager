package com.project.manager.service.admin;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.manager.dao.admin.FeeDAO;

@Service
public class FeeService {

	@Autowired
	FeeDAO feeDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(FeeService.class);
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> listAllFee(){
		
		logger.info(">>>>>>>>listAllFee Service called");
		List<HashMap<String, Object>> list = null;
		
		try {
			list = feeDAO.listAllFee();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	

	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> searchKeywordFee(HashMap<String,String> map){
		
		logger.info(">>>>>>>>searchKeywordFee Service called");
		List<HashMap<String, Object>> list = null;
		
		try {
			list = feeDAO.searchKeywordFee(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> searchScopeFee(HashMap<String,String> map){
		
		logger.info(">>>>>>>>searchScopeFee Service called");
		List<HashMap<String, Object>> list = null;
		
		try {
			list = feeDAO.searchScopeFee(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int updateFee(HashMap<String,String> map){
		
		logger.info(">>>>>>>>updateFee Service called");
		int result = 0;
		
		try {
			result = feeDAO.updateFee(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
