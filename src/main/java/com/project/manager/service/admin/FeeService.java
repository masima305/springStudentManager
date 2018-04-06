package com.project.manager.service.admin;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.project.manager.dao.admin.FeeDAO;

@Service
public class FeeService {

	@Autowired
	FeeDAO feeDAO;
	
	public List<HashMap<String, Object>> listAllFee(){
		List<HashMap<String, Object>> list = feeDAO.listAllFee();
		return list;
	}
}
