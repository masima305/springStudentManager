package com.project.manager.service.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
	public List<HashMap<String, Object>> listAllScheduler(){
		
		System.out.println(">>>>>>>>listAllScheduler Service called");	
		List<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		try {
			list = schedulerDAO.listAllScheduler();
		} catch (Exception e) {
			//TODO 사용자 에러 정의 
			e.printStackTrace();
		}
		
		return list;
	}
	
	//=====================================================================================================
	//=========================  INSERT METHODS  ============================================================
	//=====================================================================================================
		
	
	//스케줄 추가
	public int insertScheduler(HashMap<String,String> map) {
		System.out.println(">>>>>>>>insertScheduler Service called");
		int result = 0;
		
		try {
			result = schedulerDAO.insertScheduler(map);
		} catch (Exception e) {
			//TODO 사용자 에러 정의 
			e.printStackTrace();
		}
		return result;
	}

	
	//=====================================================================================================
	//=========================  UPDATE METHODS  ============================================================
	//=====================================================================================================
		
	//스케줄 수정
	public int updateScheduler(HashMap<String,String> map) {
		System.out.println(">>>>>>>>updateScheduler Service called");
		int result = 0;
		
		try {
			result = schedulerDAO.updateScheduler(map);
		} catch (Exception e) {
			//TODO 사용자 에러 정의 
			e.printStackTrace();
		}
		return result;
	}

	
	//======================================================================================================
	//========================= DELETE METHODS  ============================================================
	//======================================================================================================
		
	
	//스케줄 삭제
	public int deleteScheduler(HashMap<String,String> map) {
		System.out.println(">>>>>>>>deleteScheduler Service called");
		int result = 0;
		
		try {
			result = schedulerDAO.deleteScheduler(map);
		} catch (Exception e) {
			//TODO 사용자 에러 정의 
			e.printStackTrace();
		}
		return result;
	}
	
}
