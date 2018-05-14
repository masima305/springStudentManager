package com.project.manager.service.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.project.manager.dao.admin.StudentDAO;

@Service
public class StudentService {

	@Autowired
	StudentDAO studentDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(StudentService.class);
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
		
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> listAllStudent(){
		
		logger.info(">>>>>>>>listAllStudent Service called");	
		List<HashMap<String, Object>> list = null;
		
		try {
			list = studentDAO.listAllStudent();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> searchKeywordStudent(HashMap<String,String> map){
		
		logger.info(">>>>>>>>searchKeywordStudent Service called");
		List<HashMap<String, Object>> list = null;
		
		try {
			list = studentDAO.searchKeywordStudent(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> searchScopeStudent(HashMap<String,String> map){
		
		logger.info(">>>>>>>>searchScopeStudent Service called");
		List<HashMap<String, Object>> list = null;
		
		try {
			list = studentDAO.searchScopeStudent(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public List<HashMap<String, Object>> getStudent(HashMap<String,String> map){
		//학생 개인정보와 학생 이력정보를 따로 가지고온다.
		
		logger.info(">>>>>>>>getStudent Service called");
		
		List<HashMap<String, Object>> studentInfo = null;
		HashMap<String,String> studentExpCount = null;
		List<HashMap<String, Object>> studentExp;
		
		try {
			studentInfo = studentDAO.getStudentBasic(map);
			studentExpCount = studentDAO.getStudentExpCount(map);
			
			String cnt = String.valueOf(studentExpCount.get("EXP_CNT"));
			int cnt_num = Integer.parseInt(cnt);
			
			//학생의 경력이 하나라도 있는경우
			if (cnt_num > 0) {
				System.out.println(">>>>>>>>Exp List detected");
				studentExp = new ArrayList<HashMap<String, Object>>();
				studentExp = studentDAO.getStudentExp(map);
				studentInfo.addAll(studentExp);
			}else { //경력이 없는 경우 '없음'으로 출력
				studentInfo.get(0).put("EXP_YEAR","없음");
				studentInfo.get(0).put("EXP_SEMESTER","없음");
				studentInfo.get(0).put("EXP_CONTENT","없음");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return studentInfo;
	}
	
	//학번 유효성 체크하기
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public HashMap<String,Object> checkStuNumber (HashMap<String,String> map){
		
		logger.info(">>>>>>>>checkStuNumber Service called");
		HashMap<String,Object> result = new HashMap<String,Object> ();
		
		try {
			result = studentDAO.checkStuNumber(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	//=====================================================================================================
	//=========================  INSERT METHODS  ============================================================
	//=====================================================================================================
		
	
	//학생 기본 정보 추가
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} ) 
	public int insertStudentInfo(HashMap<String,String> map) {
		
		logger.info(">>>>>>>>insertStudentInfo Service called");
		int resultA = 0;
		int resultB = 0;
		
		try {
			 resultA = studentDAO.insertStudentInfo(map);
			 resultB = studentDAO.insertStudentFee(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return resultA * resultB;
	}
	
	//학생 경력 추가
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int insertExperience(HashMap<String,String> map){
		
		logger.info(">>>>>>>>insertExperience Service called");
		int result = 0;
		
		try {
			result = studentDAO.insertExperience(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return result;
	}
	
	//=====================================================================================================
	//=========================  UPDATE METHODS  ============================================================
	//=====================================================================================================
		
	//학생 정보 수정
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int updateStudent(HashMap<String,String> map) {
		
		logger.info(">>>>>>>>updateStudent Service called");
		int result = 0;
		
		try {
			result = studentDAO.updateStudent(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return result;
		
	}
	
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int deleteStudent(HashMap<String,String> map) {
		
		//학생 '삭제로그 추가'
		logger.info(">>>>>>>>deleteStudent Service called");
		int insertResult = 0;
		int deleteResult = 0;
		
		try {
			insertResult = studentDAO.insertDeleteLog(map);
			deleteResult = studentDAO.deleteStudent(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
			
		return deleteResult;
	}
	

	//학생 경력 삭제
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor={Exception.class} )
	public int deleteExperience(HashMap<String,String> map) {
		
		logger.info(">>>>>>>>deleteExperience Service called");
		int result = 0;
		
		try {
			result = studentDAO.deleteExperience(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
