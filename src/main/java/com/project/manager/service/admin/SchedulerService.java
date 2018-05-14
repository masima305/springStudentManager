package com.project.manager.service.admin;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.manager.dao.admin.SchedulerDAO;


@Service
public class SchedulerService {

	@Autowired
	SchedulerDAO schedulerDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(SchedulerService.class);
	
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
		
	
	//모든 스케줄 불러오기
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> listAllScheduler(){
		
		logger.info(">>>>>>>>listAllScheduler Service called");	
		List<HashMap<String, Object>> list = null;
		
		try {
			list = schedulerDAO.listAllScheduler();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	//=====================================================================================================
	//=========================  INSERT METHODS  ============================================================
	//=====================================================================================================
		
	
	//스케줄 추가
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int insertScheduler(HashMap<String,String> map) {
		
		logger.info(">>>>>>>>insertScheduler Service called");
		int result = 0;
		
		try {
			result = schedulerDAO.insertScheduler(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	//=====================================================================================================
	//=========================  UPDATE METHODS  ============================================================
	//=====================================================================================================
		
	//스케줄 수정
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int updateScheduler(HashMap<String,String> map) {
		
		logger.info(">>>>>>>>updateScheduler Service called");
		int result = 0;
		
		try {
			result = schedulerDAO.updateScheduler(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	
	//======================================================================================================
	//========================= DELETE METHODS  ============================================================
	//======================================================================================================
		
	
	//스케줄 삭제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int deleteScheduler(HashMap<String,String> map) {
		
		logger.info(">>>>>>>>deleteScheduler Service called");
		int result = 0;
		
		try {
			result = schedulerDAO.deleteScheduler(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
