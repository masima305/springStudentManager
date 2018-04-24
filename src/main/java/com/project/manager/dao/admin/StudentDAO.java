package com.project.manager.dao.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
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
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
	
	
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
	
	public List<HashMap<String, Object>> searchScopeStudent(HashMap<String,String> map){
		System.out.println(">>>>>>>>searchScopeStudent DAO called");
		return this.sqlSession.selectList("student.searchScopeStudent",map);
	}
	
	public List<HashMap<String, Object>> getStudentBasic(HashMap<String,String> map){
		System.out.println(">>>>>>>>getStudentBasic DAO called");
		return this.sqlSession.selectList("student.getStudentBasic",map);
	}
	public List<HashMap<String, Object>> getStudentExp(HashMap<String,String> map){
		System.out.println(">>>>>>>>getStudentExp DAO called");
		return this.sqlSession.selectList("student.getStudentExp",map);
	}
	public HashMap<String, String> getStudentExpCount(HashMap<String,String> map){
		System.out.println(">>>>>>>>getStudentExpCount DAO called");
		return this.sqlSession.selectOne("student.getStudentExpCount",map);
	}
	
	//=====================================================================================================
	//=========================  INSERT METHODS  ============================================================
	//=====================================================================================================
	
	//학생 '기본 정보' 추가
	public int insertStudentInfo(HashMap<String,String> map){
		System.out.println(">>>>>>>>insertStudentInfo DAO called");
		return this.sqlSession.insert("student.insertStudentInfo",map);
	}
	
	//학생 '회비' 정보 추가
	public int insertStudentFee(HashMap<String,String> map){
		System.out.println(">>>>>>>>insertStudentFee DAO called");
		return this.sqlSession.insert("student.insertStudentFee",map);
	}
	
	//학생 '경력' 사항 추가
	public int insertExperience(HashMap<String,String> map){
		System.out.println(">>>>>>>>insertExperience DAO called");
		return this.sqlSession.insert("student.insertExperience",map);
	}
	
	//=====================================================================================================
	//=========================  UPDATE METHODS  ============================================================
	//=====================================================================================================
	
	//학생 '경력' 사항 추가
	public int updateStudent(HashMap<String,String> map){
		System.out.println(">>>>>>>>updateStudnet DAO called");
		
		System.out.println(map.get("stuNumber"));
		System.out.println(map.get("stuName"));
		System.out.println(map.get("stuBirthday"));
		System.out.println(map.get("stuPhone"));
		System.out.println(map.get("stuEmail"));
		System.out.println(map.get("stuGender"));
		System.out.println(map.get("stuAuthority"));
		System.out.println(map.get("stuEnterance"));
		
		
	
		return 0; //this.sqlSession.insert("student.insertExperience",map);
	}
	
}
