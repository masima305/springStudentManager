package com.project.manager.dao.user;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class InfoDAO {

private static final Logger logger = LoggerFactory.getLogger(InfoDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	public HashMap<String,Object> loginCheck(HashMap<String,String> map){
		System.out.println(">>>>>>>>loginCheck DAO called");
		return this.sqlSession.selectOne("userInfo.loginCheck",map);
	}
	
	public List<HashMap<String, Object>> getUserBasic(HashMap<String,String> map){
		System.out.println(">>>>>>>>getUserBasic DAO called");
		return this.sqlSession.selectList("userInfo.getUserBasic",map);
	}
	public List<HashMap<String, Object>> getUserExp(HashMap<String,String> map){
		System.out.println(">>>>>>>>getUserExp DAO called");
		return this.sqlSession.selectList("userInfo.getUserExp",map);
	}
	public HashMap<String, String> getUserExpCount(HashMap<String,String> map){
		System.out.println(">>>>>>>>getUserExpCount DAO called");
		return this.sqlSession.selectOne("userInfo.getUserExpCount",map);
	}
}
