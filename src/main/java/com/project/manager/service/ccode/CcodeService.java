package com.project.manager.service.ccode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.project.manager.dao.ccode.CcodeDAO;

@Service
public class CcodeService {

	
	
	
	@Autowired
	CcodeDAO ccodeDAO;
	
	
    public static final HashMap<String, String> CCODENAMEMAP = new HashMap<String, String>();
	
    static {
	    	CCODENAMEMAP.put("stuNumber","STU_NUMBER");
	    	CCODENAMEMAP.put("stuName","STU_NAME");
	    	CCODENAMEMAP.put("stuPhone","STU_PHONE");
	    	CCODENAMEMAP.put("stuEmail","STU_EMAIL");
	    	CCODENAMEMAP.put("stuEnterance","STU_ENTERANCE");
	    	CCODENAMEMAP.put("stuAuthority","STU_AUTHORITY");
	    	CCODENAMEMAP.put("stuGender","STU_GENDER");
	    	CCODENAMEMAP.put("feePaidStatus","FEE_PAID_STATUS");
	    	CCODENAMEMAP.put("feePaidMethod","FEE_PAID_METHOD");
	    }
	

	
	private static final Logger logger = LoggerFactory.getLogger(CcodeService.class);
	
	/*
	 * 
	 * @ common code 사용방법
	 * 
	 * listAllCommonMap 안에 (HashMap) 
	 * commonCategory마다 각각의 리스트(ArrayList)로 담겨있음
	 * 
	 * @ 리스트 키 값 (카테고리+List)
	 * 입학전형 : stuEnteranceList 
	 * 접근권한 : stuAuthorityList
	 * 성별	 : stuGenderList
	 * 학기	 : expsemesterList
	 * 입금방식  : feePaidMethodList
	 * 납부상태  : feePaidStatusList
	 * 
	 * 
	 * @ 컨트롤러에서의 코드
	 * HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
	 * mv.addObject("listAllCommonMap",listAllCommonMap);
	 * 
	 * 
	 * @ view에서의코드
	 * <select name="stuAuthority">
			<c:forEach var="i" items="${listAllCommonMap.stuAuthorityList}">
				<option value="${i.COMMON_CODE}">${i.COMMON_VALUE}</option>
			</c:forEach>	
	 * </select>
	 * 
	 */
	
	
	public HashMap<String,List<HashMap<String, Object>>> listAllCommon(){

		List<HashMap<String, Object>> list = ccodeDAO.listAllCommon();

		List<HashMap<String, Object>> stuEnteranceList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> stuAuthorityList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> stuGenderList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> expsemesterList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> feePaidMethodList = new ArrayList<HashMap<String, Object>>();
		List<HashMap<String, Object>> feePaidStatusList = new ArrayList<HashMap<String, Object>>();


		//common 테이블의 catogory마다  각 리스트만들어 담기  
		for(HashMap<String, Object> item : list) {

			String commonCategoryValue = (String)item.get("COMMON_CATEGORY");

			if(commonCategoryValue.equals("stuEnterance")) {
				stuEnteranceList.add(item);
			}
			if(commonCategoryValue.equals("stuAuthority")) {
				stuAuthorityList.add(item);
			}
			if(commonCategoryValue.equals("stuGender")) {
				stuGenderList.add(item);
			}
			if(commonCategoryValue.equals("expsemester")) {
				expsemesterList.add(item);
			}
			if(commonCategoryValue.equals("feePaidMethod")) {
				feePaidMethodList.add(item);
			}
			if(commonCategoryValue.equals("feePaidStatus")) {
				feePaidStatusList.add(item);
			}
		}

		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = new HashMap<String,List<HashMap<String, Object>>>(); 

		listAllCommonMap.put("stuEnteranceList", stuEnteranceList);
		listAllCommonMap.put("stuAuthorityList", stuAuthorityList);
		listAllCommonMap.put("stuGenderList", stuGenderList);
		listAllCommonMap.put("expsemesterList", expsemesterList);
		listAllCommonMap.put("feePaidMethodList", feePaidMethodList);
		listAllCommonMap.put("feePaidStatusList", feePaidStatusList);


		return listAllCommonMap;
	}



}
