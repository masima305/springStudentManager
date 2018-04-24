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

import com.project.manager.dao.admin.StudentDAO;

@Service
public class StudentService {

	@Autowired
	StudentDAO studentDAO;
	
	private static final Logger logger = LoggerFactory.getLogger(StudentService.class);
	
	
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
		
	
	public List<HashMap<String, Object>> listAllStudent(){
		
		System.out.println(">>>>>>>>listAllStudent Service called");	
		return studentDAO.listAllStudent();
	}
	
	public List<HashMap<String, Object>> searchKeywordStudent(HashMap<String,String> map){
		
		System.out.println(">>>>>>>>searchKeywordStudent Service called");
		return studentDAO.searchKeywordStudent(map);
	}
	
	
	public List<HashMap<String, Object>> searchScopeStudent(HashMap<String,String> map){
		
		System.out.println(">>>>>>>>searchScopeStudent Service called");
		return studentDAO.searchScopeStudent(map);
	}
	
	public List<HashMap<String, Object>> getStudent(HashMap<String,String> map){
		//학생 개인정보와 학생 이력정보를 따로 가지고온다.
		
		System.out.println(">>>>>>>>getStudent Service called");
		List<HashMap<String, Object>> studentInfo= studentDAO.getStudentBasic(map);
		HashMap<String,String> studentExpCount = studentDAO.getStudentExpCount(map);
		
		String cnt = String.valueOf(studentExpCount.get("EXP_CNT"));
		int cnt_num = Integer.parseInt(cnt);
		
		if (cnt_num > 0) {
			System.out.println(">>>>>>>>Exp List detected");
			List<HashMap<String, Object>> studentExp= studentDAO.getStudentExp(map);
			studentInfo.addAll(studentExp);
		}else {
			studentInfo.get(0).put("EXP_YEAR","없음");
			studentInfo.get(0).put("EXP_SEMESTER","없음");
			studentInfo.get(0).put("EXP_CONTENT","없음");
		}
		return studentInfo;
	}
	
	//=====================================================================================================
	//=========================  INSERT METHODS  ============================================================
	//=====================================================================================================
		
	
	//학생 기본 정보 추가
	public int insertStudentInfo(HashMap<String,String> map) {
		System.out.println(">>>>>>>>insertStudentInfo Service called");
		return studentDAO.insertStudentInfo(map);
	}
	
	//학생회비 정보 추가
	public int insertStudentFee(HashMap<String,String> map) {
		System.out.println(">>>>>>>>insertStudentFee Service called");
		return studentDAO.insertStudentFee(map);
	}
	
	//학생 경력 추가
	public int insertExperience(HashMap<String,String> map){
		System.out.println(">>>>>>>>insertExperience Service called");
		return studentDAO.insertExperience(map);
	}
	
	
	public int updateStudent(HashMap<String,String> map) {
		return 0;
	}
	
	public int deleteStudent(HashMap<String,String> map) {
		return 0;
	}
}
