package com.project.manager.controller.admin;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.project.manager.service.admin.StudentService;
import com.project.manager.service.ccode.CcodeService;

@Controller
public class StudentController {

	@Autowired
	StudentService studentService;
	
	@Autowired
	CcodeService ccodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(StudentController.class);
	
	
	//=====================================================================================================
	//=========================  READ METHODS  ============================================================
	//=====================================================================================================
	
	
	
	/*
	 * commonCode 媛��졇�삤湲�
	 */
	@RequestMapping(value="/getCommonCode.do")
	public @ResponseBody ModelAndView getCommonCode(HttpServletRequest request) {
		
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		Gson gson = new Gson();
		String listAllCommonGson = gson.toJson(listAllCommonMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllCommonMap"		, listAllCommonMap	 );
		mv.addObject("listAllCommonGson"	, listAllCommonGson	 );
		
		mv.setViewName("contents/studentInsert");
		
		return mv;
	}
	
	
	/*
	 * �쟾泥� �븰�깮 由ъ뒪�듃 遺덈윭�삤湲�
	 * del_yn='n'�씤 �븰�깮留�
	 */
	@RequestMapping(value="/listAllStudent.do")
	public @ResponseBody ModelAndView listAllStudent(HttpServletRequest request){
		
		System.out.println(">>>>>>>>listAllStudent called");		
		
		List<HashMap<String,Object>> listAllStudent = studentService.listAllStudent();
		
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		// 怨듯넻肄붾뱶 �샇異쒖쓣 �쐞�븳 �옄猷뚭뎄議�.
		
		Gson gson = new Gson();
		String listAllCommonGson = gson.toJson(listAllCommonMap);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllStudent"		, listAllStudent	 );
		mv.addObject("listAllCommonMap"		, listAllCommonMap	 );
		mv.addObject("listAllCommonGson"	, listAllCommonGson	 );
		
		mv.setViewName("contents/studentList");
		
		return mv;
	}
	
	/*
	 * 寃��깋 
	 * '�듅�젙 �궎�썙�뱶'�뿉 �뵲瑜� �븰�깮 由ъ뒪�듃 遺덈윭�삤湲�
	 * form.id = seachKeywordForm
	 * 
	 */
	@RequestMapping(value="/searchKeywordStudent.do")
	public @ResponseBody List<HashMap<String, Object>> searchKeywordStudent(HttpServletRequest request){
		
		String searchCategory 	= request.getParameter("searchCategory"	);
		String searchContent 	= request.getParameter("searchContent"	);
		
		//�뙆�씪誘명꽣濡� �꽆�뼱�삩 蹂��닔紐낆뿉 �빐�떦�븯�뒗 而щ읆紐낆쑝濡� 留ㅽ븨�맖 ( stuNum -> STU_NUM )
		searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("searchCategory", searchCategory);
		map.put("searchContent"	, searchContent	);
		
		return studentService.searchKeywordStudent(map);
	}
	
	
	/*
	 * 寃��깋 
	 * '踰붿쐞'�뿉 �뵲瑜� �븰�깮 由ъ뒪�듃 遺덈윭�삤湲�
	 * form.id = searchScopeForm
	 * 
	 */
	@RequestMapping(value="/searchScopeStudent.do")
	public @ResponseBody List<HashMap<String, Object>> searchScopeStudent(HttpServletRequest request){
		
		String stuNumber = request.getParameter("stuNumber");
		
		if(!stuNumber.equals("null")) {
			stuNumber+="%";
		}
		
		
		String stuGender 	= request.getParameter("stuGender"		);
		String stuEnterance = request.getParameter("stuEnterance"	);
		String stuAuthority = request.getParameter("stuAuthority"	);
		
		
		//�뙆�씪誘명꽣濡� �꽆�뼱�삩 蹂��닔紐낆뿉 �빐�떦�븯�뒗 而щ읆紐낆쑝濡� 留ㅽ븨�맖 ( stuNum -> STU_NUM )
		//searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("stuNumber"		, stuNumber		);
		map.put("stuGender"		, stuGender		);
		map.put("stuEnterance"	, stuEnterance	);
		map.put("stuAuthority"	, stuAuthority	);
		
		return studentService.searchScopeStudent(map);
	}
	
	//�븰�깮 媛쒖씤 �젙蹂� 遺덈윭�삤湲�.
	@RequestMapping(value="/getStudent.do")
	public @ResponseBody List<HashMap<String, Object>> getStudent (HttpServletRequest request){
		
		String stuNumber = request.getParameter("stuNumber");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		
		return studentService.getStudent(map);
	}
	
	//�븰踰� �쑀�슚�꽦 泥댄겕�븯湲�
	@RequestMapping(value="/checkStuNumber.do")
	public @ResponseBody HashMap<String, String> checkStuNumber (HttpServletRequest request){
		
		String stuNumber = request.getParameter("stuNumber");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		
		HashMap<String,Object> checkStuNumber = studentService.checkStuNumber(map);
		HashMap<String,String> result = new HashMap<String,String>(); 
		
		if(checkStuNumber != null) { //媛숈� �븰踰덉씠 議댁옱�븯�뒗 寃쎌슦 1�쓣 蹂대깂
			result.put("result", "1"); 
		} else {
			result.put("result", "0"); //媛숈� �븰踰덉씠 議댁옱�븯吏� �븡�뒗 寃쎌슦 0�쓣 蹂대깂
		}
		
		System.out.println(checkStuNumber);
		System.out.println((String)result.get("result"));
		
		return result;
	}
	
	
	//======================================================================================================
	//========================= INSERT METHODS  ============================================================
	//======================================================================================================
		
	
	//�븰�깮 媛쒖씤 寃쏀뿕 �씤�꽌�듃 �븯湲�.
	@RequestMapping(value="/insertExperience.do")
	public @ResponseBody int insertExperience (HttpServletRequest request){

		System.out.println(">>>>>>>>insertExperience Controller called");
		
		String stuNumber 	= request.getParameter("stuNumber"	);
		String expYear 		= request.getParameter("expYear"	);
		String expSemester	= request.getParameter("expSemester");
		String expContent	= request.getParameter("expContent"	);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber"	  , stuNumber	);
		map.put("expYear"	  , expYear		);
		map.put("expSemester" , expSemester	);
		map.put("expContent"  , expContent	);
		
		return studentService.insertExperience(map);
	}
	
	
	
	/*
	 * �븰�깮 異붽��븯湲�
	 */
	
	@RequestMapping(value="/insertStudent.do")
	public @ResponseBody HashMap<String,String> insertStudent(HttpServletRequest request) {
		
		//�븰�깮 湲곕낯�젙蹂�
		HashMap<String,String> infoMap = new HashMap<String,String>();
		infoMap.put("stuNumber", request.getParameter("stuNumber").trim());
		infoMap.put("stuName", request.getParameter("stuName").trim());
		
		//�깮�뀈�썡�씪 �삎�떇 議곗젙(YYYY-MM-DD => YYYYDDMM)
		String stuBirthday =  (String)request.getParameter("stuBirthday").trim();
		
		stuBirthday = stuBirthday.substring(0,4) + stuBirthday.substring(5,7) + stuBirthday.substring(8,10);
		
		infoMap.put("stuBirthday"	, stuBirthday);
		infoMap.put("stuPassword"	, stuBirthday); //鍮꾨�踰덊샇�뒗 �깮�뀈�썡�씪濡� �꽔�뼱以�
		infoMap.put("stuGender"		, request.getParameter("stuGender" 		).trim());
		infoMap.put("stuPhone"		, request.getParameter("stuPhone" 		).trim());
		infoMap.put("stuEmail"		, request.getParameter("stuEmail"  		).trim());
		infoMap.put("stuEnterance"	, request.getParameter("stuEnterance"	).trim());
		infoMap.put("stuAuthority"	, request.getParameter("stuAuthority"	).trim());
		
		//�븰�깮�쉶鍮� �젙蹂�
		
		//�엯湲덈궇吏� �삎�떇 議곗젙(YYYY-MM-DD => YYYYDDMM)
		String feePaidDate =  (String)request.getParameter("feePaidDate").trim();
		
		//입금날짜가 빈값이 아닐경우 형식 변환
		if(feePaidDate.length() > 0) {
			feePaidDate = feePaidDate.substring(0,4) + feePaidDate.substring(5,7) + feePaidDate.substring(8,10);
		}
		
		infoMap.put("feePaidDate", feePaidDate);
		infoMap.put("feeTotalAmount",request.getParameter("feeTotalAmount"	).trim());
		infoMap.put("feePaidAmount" ,request.getParameter("feePaidAmount"	).trim());
		infoMap.put("feePaidMethod"	,request.getParameter("feePaidMethod"	).trim());
		infoMap.put("feePaidStatus"	,request.getParameter("feePaidStatus"	).trim());
		infoMap.put("feeContent"	,request.getParameter("feeContent"	 	).trim());
		
		
		
		//�븰�깮 湲곕낯�젙蹂�, �븰�깮�쉶鍮� �젙蹂� DB�뿰寃�
		int InfoResult = studentService.insertStudentInfo(infoMap);

		//-------------------------------------------------------------
		HashMap<String,String> map = new HashMap<String,String>();

		if(InfoResult!=0) { //�몮�떎 �엯�젰�쓣 �꽦怨듯븷 寃쎌슦
			map.put("result", "�븰�깮 異붽�瑜� �셿猷뚰븯���뒿�땲�떎.");
		} else {
			map.put("result", "�븰�깮 異붽�瑜� �떎�뙣�븯���뒿�땲�떎.");
		}
		return map;
	}
	//======================================================================================================
	//========================= UPDATE METHODS  ============================================================
	//======================================================================================================
		
	
	@RequestMapping(value="/updateStudent.do")
	public @ResponseBody int updateStudent (HttpServletRequest request){

		System.out.println(">>>>>>>>updateStudentController called");
		
		String stuNumber 	= request.getParameter("stuNumber"		);
		String stuName 		= request.getParameter("stuName"		);
		String stuBirthday 	= request.getParameter("stuBirthday"	);
		String stuPhone 	= request.getParameter("stuPhone"		);
		String stuEmail 	= request.getParameter("stuEmail"		);
		String stuGender 	= request.getParameter("stuGender"		);
		String stuAuthority = request.getParameter("stuAuthority"	);
		String stuEnterance = request.getParameter("stuEnterance"	);
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		
		map.put("stuNumber"	  	, stuNumber		);
		map.put("stuName"	  	, stuName		);
		map.put("stuBirthday"	, stuBirthday	);
		map.put("stuPhone"	  	, stuPhone		);
		map.put("stuEmail"	  	, stuEmail		);
		map.put("stuGender"	  	, stuGender		);
		map.put("stuAuthority"	, stuAuthority	);
		map.put("stuEnterance"	, stuEnterance	);
		
		return studentService.updateStudent(map);
	}
	
	//======================================================================================================
	//========================= DELETE METHODS  ============================================================
	//======================================================================================================
		
	
	@RequestMapping(value="/deleteStudent.do")
	public String deleteStudent(HttpServletRequest request) {
		System.out.println(">>>>>>>>deleteStudentController called");
		
		String stuNumber 	= request.getParameter("stuNumber");
		String logReason 	= request.getParameter("logReason");
		
		System.out.println(stuNumber);
		System.out.println(logReason);
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		map.put("logReason", logReason);
		
		studentService.deleteStudent(map);
		
		return "redirect:adminMain";
	}
	
	
	
	
}
