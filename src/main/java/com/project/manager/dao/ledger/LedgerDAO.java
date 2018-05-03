package com.project.manager.dao.ledger;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LedgerDAO {

		@Autowired
		SqlSession sqlSession;
		
		//=====================================================================================================
		//=========================  READ METHODS  ============================================================
		//=====================================================================================================
		
		public List<HashMap<String, Object>> listLedgerCate(){
			System.out.println(">>>>>>>>listLedgerCate DAO called");	
			return this.sqlSession.selectList("ledger.listLedgerCate");
		}
		public List<HashMap<String, Object>> listLedger(){
			System.out.println(">>>>>>>>listLedger DAO called");	
			return this.sqlSession.selectList("ledger.listThreeLatestLedger");
		}
		public HashMap<String, Object> getLastMonthBalance(HashMap<String, String> map){
			System.out.println(">>>>>>>>getLastMonthBalance DAO called");	
			return this.sqlSession.selectOne("ledger.getLastMonthBalance",map);
		}
}
