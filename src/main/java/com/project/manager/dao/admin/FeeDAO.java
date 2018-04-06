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
	
	
}
