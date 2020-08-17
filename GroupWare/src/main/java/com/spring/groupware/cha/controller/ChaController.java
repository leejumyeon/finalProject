package com.spring.groupware.cha.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.spring.groupware.cha.service.ChaInterService;
import com.spring.groupware.commonVO.ClubMemberVO;
import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.PersonalCalVO;

@Controller
public class ChaController {
	
	@Autowired
	private ChaInterService service; // 의존객체
	
	// ------------------------------마이페이지(개인 일정 캘린더 & 책검색) - 시작 ----------------------------------------------
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 뷰페이지
	@RequestMapping(value="/viewFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String viewFullCalendar() {
		
		return "fullCalendarKakaoBook/fullCalendar.tiles1";
	}
	
	// 마이페이지(개인 일정 캘린더) - 뿌리기
	@ResponseBody
	@RequestMapping(value="/personalFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String fullCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		List<PersonalCalVO> perCalvo =  service.fullCalendar();
						
		JSONArray jsonArr = new JSONArray();
		
		for(PersonalCalVO personalCalVO : perCalvo) {
			
			JSONObject jsObj = new JSONObject();
			
			jsObj.put("_id", personalCalVO.getCalendar_seq()); 			
			jsObj.put("title", personalCalVO.getTitle());
			jsObj.put("description", personalCalVO.getContent());
			jsObj.put("start", personalCalVO.getStartDate());
			jsObj.put("end", personalCalVO.getEndDate());
			jsObj.put("backgroundColor", personalCalVO.getBackgroundColor());
			jsObj.put("type", "카테고리1");
			jsObj.put("username", loginEmployee.getEmployee_name());
			jsObj.put("textColor", "#ffffff");
			jsObj.put("allDay", false);
			
			jsonArr.put(jsObj);
			
		}
						
		return jsonArr.toString();
		
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정추가
	@ResponseBody
	@RequestMapping(value="/insertCalendar.top", produces="text/plain;charset=UTF-8")
	public String insertCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		
		System.out.println(employee_id+"/"+title+"/"+content+"/"+endDate+"/"+startDate+"/"+backgroundColor);
		
		HashMap<String, String> paraMap = new HashMap<>();		
		paraMap.put("employee_id", employee_id);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		
		int n = service.insertFullCalendar(paraMap);
											
		JSONObject jsonObj = new JSONObject();
			
		jsonObj.put("n", n);
																															
		return jsonObj.toString();
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 수정
	@ResponseBody
	@RequestMapping(value="/updateCalendar.top", produces="text/plain;charset=UTF-8")
	public String updateCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String calendar_seq = request.getParameter("_id");
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		
		System.out.println(employee_id+"/"+calendar_seq+"/"+title+"/"+content+"/"+endDate+"/"+startDate+"/"+backgroundColor);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("calendar_seq", calendar_seq);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		
		int n = service.updateFullCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 삭제
	@ResponseBody
	@RequestMapping(value="/deleteCalendar.top", produces="text/plain;charset=UTF-8")
	public String deleteCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String calendar_seq = request.getParameter("_id");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("calendar_seq", calendar_seq);
		
		int n = service.deleteFullCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
		
	// ------------------------------마이페이지(개인 일정 캘린더 & 책검색) - 끝 ----------------------------------------------
	
	// 마이페이지(동호회) - 뿌리기
	@ResponseBody
	@RequestMapping(value="/club.top", produces="text/plain;charset=UTF-8")
	public String club(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();	
		String employee_name = request.getParameter("employee_name");
		/*String club_seq = request.getParameter("club_seq");
		String member_seq = request.getParameter("member_seq");
		String club_name = request.getParameter("club_name");
		String club_info = request.getParameter("club_info");
		String status = request.getParameter("status");
		String regDate = request.getParameter("regDate");*/
		
		System.out.println(employee_name);
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_name", employee_name);
		/*paraMap.put("club_seq", club_seq);
		paraMap.put("member_seq", member_seq);
		paraMap.put("club_name", club_name);
		paraMap.put("club_info", club_info);
		paraMap.put("status", status);
		paraMap.put("regDate", regDate);*/
		
		List<HashMap<String,String>> resultList = service.club(paraMap);
		
		Gson gson = new Gson();
		
		return gson.toJson(resultList);
		
	}
	
	
	
	// ------------------------------ 공지사항 및 자주묻는 질문 - 시작  ----------------------------------------------
	
	// 공지 사항
	@RequestMapping(value="/Notice.top", produces="text/plain;charset=UTF-8")
	public String Notice() {
		
		return "Notice/Notice.tiles1";
		
	}
			
	// ------------------------------ 공지사항 및 자주묻는 질문 - 끝  -------------------------------------------------------
	
	// ------------------------------ 관리자 메인페이지(회사 일정 캘린더) - 시작 ----------------------------------------------
	
	// 관리자 메인페이지(회사 일정 캘린더) - 뷰페이지	
	@RequestMapping(value="/adminMain.top")
	public String clup() {
		
		return "admin/adminMain.tiles3";
		
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) -  일반 메인페이지 캘린더 DB값 얻어오기(뿌리기)
	@ResponseBody
	@RequestMapping(value="/adminFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String adminFullCalendar() {
		
		List<CompanyCalVO> comCalvo = service.adminFullCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		for(CompanyCalVO companyCalVO : comCalvo) {
			
			JSONObject jsObj = new JSONObject();
			
			jsObj.put("_id", companyCalVO.getComCalendar_seq()); 			
			jsObj.put("title", companyCalVO.getTitle());
			jsObj.put("description", companyCalVO.getContent());
			jsObj.put("start", companyCalVO.getStartDate());
			jsObj.put("end", companyCalVO.getEndDate());
			jsObj.put("backgroundColor", companyCalVO.getBackgroundColor());
			jsObj.put("type", companyCalVO.getCategory_name());
			jsObj.put("username", companyCalVO.getDepartment_name());
			jsObj.put("textColor", "#ffffff");
			jsObj.put("allDay", false);
			
			jsonArr.put(jsObj);
			
		}
		
		return jsonArr.toString();
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가	
	@ResponseBody
	@RequestMapping(value="/insertAdminCalendar.top", produces="text/plain;charset=UTF-8")
	public String insertAdminCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		String fk_department_seq = request.getParameter("edit-username");
		String calendar_category = request.getParameter("edit-type");
		
		if("경조사".equals(calendar_category)) {
			
			calendar_category = "1";
		}
		else if("워크샵".equals(calendar_category)) {
			
			calendar_category = "2";
		}
		else if("협력일정".equals(calendar_category)) {
			
			calendar_category = "3";
		}
		else if("채용일정".equals(calendar_category)) {
			
			calendar_category = "4";
		}

		HashMap<String, String> paraMap = new HashMap<>();		
		paraMap.put("employee_id", employee_id);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		paraMap.put("fk_department_seq", fk_department_seq);
		paraMap.put("calendar_category", calendar_category);
		
		int n = service.insertAdminCalendar(paraMap);
											
		JSONObject jsonObj = new JSONObject();
			
		jsonObj.put("n", n);
																															
		return jsonObj.toString();
	}
	
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	@ResponseBody
	@RequestMapping(value="/updateAdminCalendar.top", produces="text/plain;charset=UTF-8")
	public String updateAdminCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String comCalendar_seq = request.getParameter("_id");
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		String fk_department_seq = request.getParameter("edit-username");
		String calendar_category = request.getParameter("edit-type");
		
		System.out.println(employee_id+"/"+comCalendar_seq+"/"+title+"/"+content+"/"+endDate+"/"+startDate+"/"+backgroundColor+"/"+fk_department_seq+"/"+calendar_category);
		
		HashMap<String, String> paraMap = new HashMap<>();		
		paraMap.put("employee_id", employee_id);
		paraMap.put("comCalendar_seq", comCalendar_seq);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		paraMap.put("fk_department_seq", fk_department_seq);
		paraMap.put("calendar_category", calendar_category);
		
		int n = service.updateAdminCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	@ResponseBody
	@RequestMapping(value="/deleteAdminCalendar.top", produces="text/plain;charset=UTF-8")
	public String deleteAdminCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String comCalendar_seq = request.getParameter("_id");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("comCalendar_seq", comCalendar_seq);
		
		int n = service.deleteAdminCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// ------------------------------ 관리자 메인페이지(회사 일정 캘린더) - 끝 ----------------------------------------------

}
