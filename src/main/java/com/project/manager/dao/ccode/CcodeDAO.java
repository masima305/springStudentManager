package com.project.manager.dao.ccode;

import java.util.HashMap;
import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CcodeDAO {
	
	@Autowired
	SqlSession sqlSession;
	
private static final Logger logger = LoggerFactory.getLogger(CcodeDAO.class);

	public List<HashMap<String, Object>> listAllCommon(){
		List<HashMap<String, Object>> list = sqlSession.selectList("common.listAllCommon");
		return list;
	}
	
	
}
