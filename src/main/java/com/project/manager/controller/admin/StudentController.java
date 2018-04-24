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
	 * commonCode 가져오기
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
	 * 전체 학생 리스트 불러오기
	 * del_yn='n'인 학생만
	 */
	@RequestMapping(value="/listAllStudent.do")
	public @ResponseBody ModelAndView listAllStudent(HttpServletRequest request){
		
		System.out.println(">>>>>>>>listAllStudent called");		
		
		List<HashMap<String,Object>> listAllStudent = studentService.listAllStudent();
		
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		// 공통코드 호출을 위한 자료구조.
		
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
	 * 검색 
	 * '특정 키워드'에 따른 학생 리스트 불러오기
	 * form.id = seachKeywordForm
	 * 
	 */
	@RequestMapping(value="/searchKeywordStudent.do")
	public @ResponseBody List<HashMap<String, Object>> searchKeywordStudent(HttpServletRequest request){
		
		String searchCategory 	= request.getParameter("searchCategory"	);
		String searchContent 	= request.getParameter("searchContent"	);
		
		//파라미터로 넘어온 변수명에 해당하는 컬럼명으로 매핑됨 ( stuNum -> STU_NUM )
		searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("searchCategory", searchCategory);
		map.put("searchContent"	, searchContent	);
		
		return studentService.searchKeywordStudent(map);
	}
	
	
	/*
	 * 검색 
	 * '범위'에 따른 학생 리스트 불러오기
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
		
		
		//파라미터로 넘어온 변수명에 해당하는 컬럼명으로 매핑됨 ( stuNum -> STU_NUM )
		//searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("stuNumber"		, stuNumber		);
		map.put("stuGender"		, stuGender		);
		map.put("stuEnterance"	, stuEnterance	);
		map.put("stuAuthority"	, stuAuthority	);
		
		return studentService.searchScopeStudent(map);
	}
	
	//학생 개인 정보 불러오기.
	@RequestMapping(value="/getStudent.do")
	public @ResponseBody List<HashMap<String, Object>> getStudent (HttpServletRequest request){
		
		String stuNumber = request.getParameter("stuNumber");
		
		HashMap<String,String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		
		return studentService.getStudent(map);
	}
	
	
	
	//======================================================================================================
	//========================= INSERT METHODS  ============================================================
	//======================================================================================================
		
	
	//학생 개인 경험 인서트 하기.
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
	 * 학생 추가하기
	 */
	
	@RequestMapping(value="/insertStudent.do")
	public @ResponseBody HashMap<String,String> insertStudent(HttpServletRequest request) {
		
		//학생 기본정보
		HashMap<String,String> InfoMap = new HashMap<String,String>();
		InfoMap.put("stuNumber", request.getParameter("stuNumber").trim());
		InfoMap.put("stuName", request.getParameter("stuName").trim());
		InfoMap.put("stuPassword", request.getParameter("stuBirthday").trim()); //비밀번호는 생년월일로 넣어줌
		InfoMap.put("stuBirthday", request.getParameter("stuBirthday").trim());
		InfoMap.put("stuGender", request.getParameter("stuGender").trim());
		InfoMap.put("stuPhone", request.getParameter("stuPhone").trim());
		InfoMap.put("stuEmail", request.getParameter("stuEmail").trim());
		InfoMap.put("stuEnterance", request.getParameter("stuEnterance").trim());
		InfoMap.put("stuAuthority", request.getParameter("stuAuthority").trim());
		
		//학생회비 정보
		HashMap<String,String> feeMap = new HashMap<String,String>();
		feeMap.put("stuNumber", request.getParameter("stuNumber").trim());
		feeMap.put("feeTotalAmount", request.getParameter("feeTotalAmount").trim());
		feeMap.put("feePaidAmount", request.getParameter("feePaidAmount").trim());
		feeMap.put("feePaidMethod", request.getParameter("feePaidMethod").trim());
		feeMap.put("feePaidStatus", request.getParameter("feePaidStatus").trim());
		feeMap.put("feeContent", request.getParameter("feeContent").trim());
		
		//학생 기본정보, 학생회비 정보 DB연결
		int InfoResult = studentService.insertStudentInfo(InfoMap);
		int feeResult = studentService.insertStudentFee(InfoMap);
		
		HashMap<String,String> map = new HashMap<String,String>();

		if(InfoResult!=0 && feeResult!=0) { //둘다 입력을 성공할 경우
			map.put("result", "학생 추가를 완료하였습니다.");
		} else {
			map.put("result", "학생 추가를 실패하였습니다.");
		}
		return map;
	
	}
	
	/*
	 * 학생 정보 수정하기
	 * 
	 * 1) 학번(PK)이 바뀔 경우
	 * 2) 학번을 제외한 내용만 바뀔 경우
	 */
	public int updateStudent(HttpServletRequest request) {
		return 0;
	}
	
	/*
	 * 학생 삭제하기 (del_yn= 'n' -> 'y')
	 */
	public int deleteStudent(HttpServletRequest request) {
		return 0;
	}
	
	
	
	
}
