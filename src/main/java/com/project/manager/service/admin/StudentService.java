package com.project.manager.service.admin;

import java.util.HashMap;
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
	
	
	public List<HashMap<String, Object>> listAllStudent(){
		System.out.println(">>>>>>>>listAllStudent Service called");	
		
		List<HashMap<String, Object>> list = studentDAO.listAllStudent();
		
		return list;
	}
	
	public List<HashMap<String, Object>> searchStudent(HashMap<String,String> map){
		return null;
	}
	
	public int insertStudent(HashMap<String,String> map) {
		return 0;
	}
	
	public int updateStudent(HashMap<String,String> map) {
		return 0;
	}
	
	public int deleteStudent(HashMap<String,String> map) {
		return 0;
	}
}
