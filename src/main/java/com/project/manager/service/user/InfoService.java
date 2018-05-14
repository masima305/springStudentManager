package com.project.manager.service.user;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.project.manager.dao.user.InfoDAO;


@Service
public class InfoService {

	@Autowired
	InfoDAO infoDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(InfoService.class);
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public HashMap<String,Object> loginCheck(HashMap<String,String> map){
		
		logger.info(">>>>>>>>loginCheck Service called");
		HashMap<String,Object> result = null;
		
		try {
			result = infoDAO.loginCheck(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> getUser(HashMap<String,String> map){
		//학생 개인정보와 학생 이력정보를 따로 가지고온다.
		
		logger.info(">>>>>>>>getUser Service called");
		
		List<HashMap<String, Object>> studentInfo = null; 	//학생 개인정보
		HashMap<String,String> studentExpCount = null; 		//학생 이력 개수
		List<HashMap<String, Object>> studentExp = null; 	//학생 이력
		
		try {
			studentInfo = infoDAO.getUserBasic(map);
			studentExpCount = infoDAO.getUserExpCount(map);
			
			String cnt = String.valueOf(studentExpCount.get("EXP_CNT"));
			int cnt_num = Integer.parseInt(cnt);
			
			//학생 이력이 존재하는 경우
			if (cnt_num > 0) {
				logger.info(">>>>>>>>Exp List detected");
				studentExp = infoDAO.getUserExp(map);
				studentInfo.addAll(studentExp);
			}else {
				studentInfo.get(0).put("EXP_YEAR"	 ,"없음");
				studentInfo.get(0).put("EXP_SEMESTER","없음");
				studentInfo.get(0).put("EXP_CONTENT" ,"없음");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		return studentInfo;
	}
}
