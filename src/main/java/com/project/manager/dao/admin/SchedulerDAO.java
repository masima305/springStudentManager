package com.project.manager.dao.admin;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository 
public class SchedulerDAO {
	
	private static final Logger logger = LoggerFactory.getLogger(SchedulerDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
	
	//모든 스케줄 가져오기
	public List<HashMap<String, Object>> listAllScheduler(){
		System.out.println(">>>>>>>>listAllScheduler DAO called");	
		return this.sqlSession.selectList("scheduler.listAllScheduler");
	}
	

	//=====================================================================================================
	//=========================  INSERT METHODS  ============================================================
	//=====================================================================================================
	
	//스케줄 추가
	public int insertScheduler(HashMap<String,String> map){
		System.out.println(">>>>>>>>insertScheduler DAO called");
		return this.sqlSession.insert("scheduler.insertScheduler",map);
	}
	
	//=====================================================================================================
	//=========================  UPDATE METHODS  ============================================================
	//=====================================================================================================
	
	//스케줄 수정
	public int updateScheduler(HashMap<String,String> map){
		System.out.println(">>>>>>>>updateScheduler DAO called");
		return this.sqlSession.update("scheduler.updateScheduler",map);
	}

	//=====================================================================================================
	//=========================  DELETE METHODS  ============================================================
	//=====================================================================================================
	
	//스케줄 삭제
	public int deleteScheduler(HashMap<String,String> map){
		System.out.println(">>>>>>>>deleteScheduler DAO called");
		return this.sqlSession.delete("scheduler.deleteScheduler",map);
	}
	
}
