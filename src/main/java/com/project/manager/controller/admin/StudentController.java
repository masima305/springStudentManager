package com.project.manager.controller.admin;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.project.manager.service.admin.StudentService;
import com.project.manager.service.ccode.CcodeService;

@Controller
public class StudentController {

	@Autowired
	StudentService studentService;
	
	@Autowired
	CcodeService ccodeService;
	
	private static final Logger logger = LoggerFactory.getLogger(StudentController.class);
	
	/*
	 * 전체 학생 리스트 불러오기
	 * del_yn='n'인 학생만
	 */
	@RequestMapping(value="/listAllStudent.do")
	public @ResponseBody ModelAndView listAllStudent(HttpServletRequest request){
		System.out.println(">>>>>>>>listAllStudent called");		
		List<HashMap<String,Object>> listAllStudent = studentService.listAllStudent();
		HashMap<String,List<HashMap<String, Object>>> listAllCommonMap = ccodeService.listAllCommon();
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("listAllStudent",listAllStudent);
		mv.addObject("listAllCommonMap",listAllCommonMap);
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
		
		String searchCategory = request.getParameter("searchCategory");
		String searchContent = request.getParameter("searchContent");
		
		//파라미터로 넘어온 변수명에 해당하는 컬럼명으로 매핑됨 ( stuNum -> STU_NUM )
		searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("searchCategory", searchCategory);
		map.put("searchContent", searchContent);
		
		
		List<HashMap<String,Object>> searchKeywordStudentList = studentService.searchKeywordStudent(map);
		
		return searchKeywordStudentList;
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
		String stuGender = request.getParameter("stuGender");
		String stuEnterance = request.getParameter("stuEnterance");
		String stuAuthority = request.getParameter("stuAuthority");
		
		
		//파라미터로 넘어온 변수명에 해당하는 컬럼명으로 매핑됨 ( stuNum -> STU_NUM )
		//searchCategory = ccodeService.CCODENAMEMAP.get(searchCategory);
		
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("stuNumber", stuNumber);
		map.put("stuGender", stuGender);
		map.put("stuEnterance", stuEnterance);
		map.put("stuAuthority", stuAuthority);
		
		
		List<HashMap<String,Object>> searchScopeStudentList = studentService.searchScopeStudent(map);
		
		return searchScopeStudentList;
	}
	
	
	
	/*
	 * 학생 추가하기
	 */
	public int insertStudent(HttpServletRequest request) {
		return 0;
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
