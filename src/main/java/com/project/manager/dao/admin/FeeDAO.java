package com.project.manager.dao.admin;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FeeDAO {

	@Autowired
	SqlSession sqlSession;
	
	public List<HashMap<String, Object>> listAllFee(){
		List<HashMap<String, Object>> list= sqlSession.selectList("fee.listAllFee");
		return list;
	}
	
	public List<HashMap<String, Object>> searchKeywordFee(HashMap<String,String> map){
		System.out.println(">>>>>>>>searchKeywordFee DAO called");
		return this.sqlSession.selectList("fee.searchKeywordFee",map);
	}
	
	public List<HashMap<String, Object>> searchScopeFee(HashMap<String,String> map){
		System.out.println(">>>>>>>>searchScopeFee DAO called");
		return this.sqlSession.selectList("fee.searchScopeFee",map);
	}
	
	public int updateFee(HashMap<String,String> map){
		System.out.println(">>>>>>>>updateFee DAO called");
		return this.sqlSession.update("fee.updateFee",map);
	}
	
}
