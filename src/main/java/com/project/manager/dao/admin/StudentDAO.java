package com.project.manager.dao.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository 
public class StudentDAO {
	private static final Logger logger = LoggerFactory.getLogger(StudentDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	//------------------------------listAllStudent =
	//------------------------------모든 리스트를 다 가지고 와서 리스트로 만들어서 보냄
	public List<HashMap<String, Object>> listAllStudent(){
		System.out.println(">>>>>>>>listAllStudent DAO called");	
		return this.sqlSession.selectList("student.listAllStudent");
	}
	
	public List<HashMap<String, Object>> searchKeywordStudent(HashMap<String,String> map){
		System.out.println(">>>>>>>>searchKeywordStudent DAO called");
		return this.sqlSession.selectList("student.searchKeywordStudent",map);
	}
	
	
	
	

}
