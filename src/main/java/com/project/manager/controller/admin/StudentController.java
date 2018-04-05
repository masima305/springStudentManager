package com.project.manager.controller.admin;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import com.project.manager.service.admin.StudentService;

@Controller
public class StudentController {

	@Autowired
	StudentService studentService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(StudentController.class);
	
	/*
	 * 전체 학생 리스트 불러오기
	 * del_yn='n'인 학생만
	 */
	public List<HashMap<String, Object>> listAllStudent(HttpServletRequest request){
		return null;
	}
	
	/*
	 * 검색 영역,내용에 따른 학생 리스트 불러오기
	 */
	public List<HashMap<String, Object>> searchStudent(HttpServletRequest request){
		return null;
	}
	
	/*
	 * 학생 추가하기
	 */
	public int insertStudent(HttpServletRequest request) {
		return 0;
	}
	
	/*
	 * 학생 정보 수정하기
	 * 
	 * 1) 학번(PK)이 바뀔 경우
	 * 2) 학번을 제외한 내용만 바뀔 경우
	 */
	public int updateStudent(HttpServletRequest request) {
		return 0;
	}
	
	/*
	 * 학생 삭제하기 (del_yn= 'n' -> 'y')
	 */
	public int deleteStudent(HttpServletRequest request) {
		return 0;
	}
	
	
	
	
}