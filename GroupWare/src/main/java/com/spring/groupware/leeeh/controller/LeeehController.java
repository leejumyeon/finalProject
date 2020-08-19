package com.spring.groupware.leeeh.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.AES256;
import com.spring.common.EncryptMyKey;
import com.spring.common.FileManager;
import com.spring.common.Sha256;
import com.spring.groupware.commonVO.ClubVO;
import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.DocumentCategoryVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.TimeAndAttVO;
import com.spring.groupware.commonVO.TripVO;
import com.spring.groupware.leeeh.service.InterLeeehService;

@Controller
public class LeeehController {

	@Autowired
	private InterLeeehService service;
	
	@Autowired
	private FileManager filemanager;

	private String key = EncryptMyKey.KEY;

	private AES256 aes = null;

	// === 로그인 페이지 보여주기 === //
	@RequestMapping(value = "/login.top", method = { RequestMethod.GET })
	public ModelAndView goLogin(ModelAndView mav) {
		
		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);
		
		String sysdate = year + ". " + strMonth + ". " + strDay;
		
		List<TripVO> tripEmployeeList = service.getTripList();
		
		if(tripEmployeeList != null) {
			
			for(TripVO tvo : tripEmployeeList) {
				
				String employee_seq = tvo.getFk_employee_seq();
				
				if(sysdate.equals(tvo.getTrip_start())) {

					if("1".equals(tvo.getTrip_category())
					|| "2".equals(tvo.getTrip_category())
					|| "3".equals(tvo.getTrip_category())
					|| "4".equals(tvo.getTrip_category())
					|| "5".equals(tvo.getTrip_category())) {

						service.getUpdateEmployeeStatusVacation(employee_seq);
					}
					else {
						
						service.getUpdateEmployeeStatusBusiness(employee_seq);
					}
				}
				else if(sysdate.equals(tvo.getTrip_end())) {
					
					service.getUpdateEmployeeStatusDefault(employee_seq);
				}
			}
			
		}

		List<EmployeesVO> fireEemployeeList = service.employeeList();
		
		if(fireEemployeeList != null) {
			
			for(EmployeesVO evo : fireEemployeeList) {
				
				String employee_seq = evo.getEmployee_seq();
				
				if(sysdate.equals(evo.getFire_date())) {
					
					service.getUpdateEmployeeStatusFire(employee_seq);
				}
			}
			
		}

		mav.setViewName("login.notiles");

		return mav;
	}

	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@ResponseBody
	@RequestMapping(value = "/loginEnd.top", produces = "text/plain;charset=UTF-8", method = {RequestMethod.GET})
	public String loginEnd(HttpServletRequest request) {

		String employee_id = request.getParameter("employee_id");
		String employee_pw = request.getParameter("employee_pw");

		employee_pw = Sha256.encrypt(employee_pw);

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_pw", employee_pw);

		EmployeesVO loginEmployee = service.isUserExist(paraMap);
		
		JSONObject jsObj = new JSONObject();

		if (loginEmployee != null) {

			HttpSession session = request.getSession();
			session.setAttribute("loginEmployee", loginEmployee);
			
			jsObj.put("isLogin", "1");
			jsObj.put("grade", loginEmployee.getGrade());

		}
		else {
			
			jsObj.put("isLogin", "0");
		}
		
		return jsObj.toString();
	}

	// === 사원발급 페이지 보여주기 === //
	@RequestMapping(value = "/idIssued.top", method = { RequestMethod.GET })
	public ModelAndView idIssued(ModelAndView mav) {

		String employee_id = "";

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String hireDate = String.valueOf(year) + strMonth + strDay;
		String max = service.getMaxOfEmployeeId(hireDate);

		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		employee_id = "TOP-" + hireDate + "-" + max;

		Random rnd = new Random();

		String employee_pw = "";

		char randchar = ' ';
		for (int i = 0; i < 1; i++) {
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			employee_pw += randchar;
		}

		int randnum = 0;
		for (int i = 0; i < 3; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			employee_pw += randnum;
		}

		randchar = ' ';
		for (int i = 0; i < 1; i++) {
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			employee_pw += randchar;
		}

		randnum = 0;
		for (int i = 0; i < 3; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			employee_pw += randnum;
		}

		String email = "";

		email = employee_id + "@topgroupware.com";

		List<DepartmentVO> departmentList = service.departmentList();

		mav.addObject("employee_id", employee_id);
		mav.addObject("employee_pw", employee_pw);
		mav.addObject("email", email);
		mav.addObject("departmentList", departmentList);
		mav.setViewName("admin/HR/idIssued.tiles3");

		return mav;
	}

	// === 사원발급에서 테이블에 집어 넣기 === //
	@RequestMapping(value = "/idIssued.top", method = { RequestMethod.POST })
	public ModelAndView idIssued(ModelAndView mav, HttpServletRequest request) {

		String employee_id = request.getParameter("employee_id");
		String employee_pw = request.getParameter("employee_pw");
		String employee_name = request.getParameter("employee_name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String detailaddress = request.getParameter("detailaddress");
		String extraaddress = request.getParameter("extraaddress");
		String gender = request.getParameter("gender");
		String birthday = request.getParameter("birthday");
		String position_seq = request.getParameter("position_seq");
		String department_seq = request.getParameter("department_seq");

		employee_pw = Sha256.encrypt(employee_pw);

		try {
			aes = new AES256(key);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		try {
			phone = aes.encrypt(phone);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}

		birthday = birthday.substring(0, 3) + birthday.substring(6, 7) + birthday.substring(10);

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_pw", employee_pw);
		paraMap.put("employee_name", employee_name);
		paraMap.put("email", email);
		paraMap.put("phone", phone);
		paraMap.put("postcode", postcode);
		paraMap.put("address", address);
		paraMap.put("detailaddress", detailaddress);
		paraMap.put("extraaddress", extraaddress);
		paraMap.put("gender", gender);
		paraMap.put("birthday", birthday);
		paraMap.put("position_seq", position_seq);
		paraMap.put("department_seq", department_seq);

		service.insertEmployeeTable(paraMap);

		mav.setViewName("redirect:/manager/HR/list.top");
		return mav;
	}

	// === 선택 페이지 보여주기 === //
	@RequestMapping(value = "/twoChoice.top")
	public ModelAndView twoChoice(ModelAndView mav) {

		mav.setViewName("twoChoice.notiles");

		return mav;
	}

	// === 메인 페이지 보여주기 === //
	@RequestMapping(value = "/main.top")
	public ModelAndView main(ModelAndView mav) {

		mav.setViewName("main.tiles1");

		return mav;
	}

	@ResponseBody
	@RequestMapping(value="/getIsAttendance.top", produces = "text/plain;charset=UTF-8")
	public String getIsAttendance(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");

		String fk_employee_seq = loginEmployee.getEmployee_seq();
		
		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String onTime = String.valueOf(year) + ". " + strMonth + ". " + strDay;
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("onTime", onTime);
		
		String employee_seq = service.getIsAttendance(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("employee_seq", employee_seq);
		
		return jsObj.toString();
	}
	// === 문서 결재 페이지로 이동하기 === //
	@RequestMapping(value = "/documentPayment.top")
	public ModelAndView goDocumentPayment(ModelAndView mav, HttpServletRequest request) {

		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		String fk_employee_seq = loginEmployee.getEmployee_seq();
		
		List<DocumentVO> regDocumentList = service.regDocumentList(fk_employee_seq);
		
		List<DocumentVO> aproDocumentList = service.aproDocumentList(fk_employee_seq);

		mav.addObject("regDocumentList", regDocumentList);
		mav.addObject("aproDocumentList", aproDocumentList);
		mav.setViewName("document/documentPaymentList.tiles1");

		return mav;
	}
	
	// === 문서 내용 페이지로 이동하기 === //
	@RequestMapping(value = "/documentContent.top")
	public ModelAndView goDocumentContent(ModelAndView mav, HttpServletRequest request) {

		String document_seq = request.getParameter("document_seq");
		
		HashMap<String, String> documentContent = service.goDocumentContent(document_seq);
		
		String groupno = documentContent.get("groupno");
		
		List<DocumentVO> approverList = service.getApproverList(groupno);

		mav.addObject("documentContent", documentContent);
		mav.addObject("approverList", approverList);
		mav.setViewName("document/documentContent.notiles");

		return mav;
	}
	
	// === 신청 완료된 문서 List 불러오기(AJAX) === //
	@ResponseBody
	@RequestMapping(value="/comDocumentList.top", produces = "text/plain;charset=UTF-8")
	public String comDocumentList(HttpServletRequest request) {
		
		String statusValue = request.getParameter("statusValue");
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		String fk_employee_seq = loginEmployee.getEmployee_seq();
		
		List<DocumentVO> comDocumentList = new ArrayList<>();
		
		if("0".equals(statusValue)) {
			
			comDocumentList = service.allComDocumentList(fk_employee_seq);
		}
		else if("1".equals(statusValue)) {
			
			comDocumentList = service.senComDocumentList(fk_employee_seq);
		}
		else if("2".equals(statusValue)) {
			
			comDocumentList = service.recComDocumentList(fk_employee_seq);
		}
		
		JSONArray jsArr = new JSONArray();
		
		for(DocumentVO docuvo : comDocumentList) {
			
			JSONObject jsObj = new JSONObject();
			jsObj.put("document_seq", docuvo.getDocument_seq());
			jsObj.put("groupno", docuvo.getGroupno());
			jsObj.put("subject", docuvo.getSubject());
			jsObj.put("regDate", docuvo.getRegDate());
			jsObj.put("employee_name", docuvo.getEmployee_name());
			jsObj.put("category_name", docuvo.getCategory_name());
			
			jsArr.put(jsObj);
		}
		
		return jsArr.toString();
	}

	// === 문서 결재 페이지에서 문서 작성 페이지로 이동 === //
	@RequestMapping(value = "/writeDocument.top", method = { RequestMethod.GET })
	public ModelAndView writeDocument(ModelAndView mav) {

		List<DocumentCategoryVO> documentCategoryList = service.documentCategoryList();

		List<DepartmentVO> departmentList = service.departmentList();

		mav.addObject("documentCategoryList", documentCategoryList);
		mav.addObject("departmentList", departmentList);
		mav.setViewName("document/documentWrite.tiles1");

		return mav;
	}

	// === 부서에 따른 사원 정보 불러오기  === //
	@ResponseBody
	@RequestMapping(value = "/showMemberByDepartment.top", produces = "text/plain;charset=UTF-8")
	public String showMemberByDepartment(HttpServletRequest request) {

		String seq = request.getParameter("seq");
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		String employee_seq = loginEmployee.getEmployee_seq();
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("employee_seq", employee_seq);

		List<EmployeesVO> employeesByDepartList = service.showMemberByDepartment(paraMap);

		JSONArray jsArr = new JSONArray();

		for (EmployeesVO evo : employeesByDepartList) {

			JSONObject jsObj = new JSONObject();
			jsObj.put("employee_seq", evo.getEmployee_seq());
			jsObj.put("employee_name", evo.getEmployee_name());
			jsObj.put("position_name", evo.getPosition_name());

			jsArr.put(jsObj);
		}

		return jsArr.toString();
	}
	
	// === 클릭한 사원들 결재선에 올리기 === //
	@ResponseBody
	@RequestMapping(value = "/approvalList.top", produces = "text/plain;charset=UTF-8")
	public String approvalList(HttpServletRequest request) {
		
		String seq = request.getParameter("seq");
		
		String[] seqArr = seq.split(",");
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("seqArr", seqArr);
		
		List<EmployeesVO> approvalList = service.approvalList(paraMap);
		
		JSONArray jsArr = new JSONArray();
		
		for(EmployeesVO evo : approvalList) {
			
			JSONObject jsObj = new JSONObject();
			jsObj.put("employee_name", evo.getEmployee_name());
			jsObj.put("position_name", evo.getPosition_name());
			
			jsArr.put(jsObj);
		}
		
		return jsArr.toString();
	}
	

	// === 문서 결재 형식 불러오기 시작 === //
	@RequestMapping(value = "vacationDocument.top")
	public ModelAndView vacationDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		List<DepartmentVO> departmentList = service.departmentList();
		
		List<HashMap<String, String>> tripCatList = service.tripCatListOfVacation();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.addObject("tripCatList", tripCatList);
		mav.setViewName("/documentList/vacationDocument");
		return mav;
	}

	@RequestMapping(value = "businessTripDocument.top")
	public ModelAndView businessTripDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		List<DepartmentVO> departmentList = service.departmentList();
		
		List<HashMap<String, String>> tripCatList = service.tripCatListOfBusiness();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.addObject("tripCatList", tripCatList);
		mav.setViewName("/documentList/businessTripDocument");
		return mav;
	}

	@RequestMapping(value = "salesDocument.top")
	public ModelAndView salesDocument(ModelAndView mav, HttpServletRequest request) {


		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		List<DepartmentVO> departmentList = service.departmentList();
		
		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.setViewName("/documentList/salesDocument");
		return mav;
	}

	@RequestMapping(value = "equipmentDocument.top")
	public ModelAndView equipmentDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;
		
		List<DepartmentVO> departmentList = service.departmentList();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.setViewName("/documentList/equipmentDocument");
		return mav;
	}

	@RequestMapping(value = "projectStartDocument.top")
	public ModelAndView projectStartDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;
		
		List<DepartmentVO> departmentList = service.departmentList();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.setViewName("/documentList/projectStartDocument");
		return mav;
	}

	@RequestMapping(value = "projectStopDocument.top")
	public ModelAndView projectStopDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.setViewName("/documentList/projectStopDocument");
		return mav;
	}

	@RequestMapping(value = "projectEndDocument.top")
	public ModelAndView projectEndDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.setViewName("/documentList/projectEndDocument");
		return mav;
	}

	@RequestMapping(value = "retirementDocument.top")
	public ModelAndView retirementDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;
		
		List<DepartmentVO> departmentList = service.departmentList();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.setViewName("/documentList/retirementDocument");
		return mav;
	}

	@RequestMapping(value = "employeeTADocument.top")
	public ModelAndView employeeTADocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.setViewName("/documentList/employeeTADocument");
		return mav;
	}

	@RequestMapping(value = "makeClubDocument.top")
	public ModelAndView makeClubDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.setViewName("/documentList/makeClubDocument");
		return mav;
	}

	@RequestMapping(value = "clubMemberDocument.top")
	public ModelAndView clubMemberDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;
		
		List<DepartmentVO> departmentList = service.departmentList();
		
		List<ClubVO> clubList = service.clubList();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("departmentList", departmentList);
		mav.addObject("clubList", clubList);
		mav.setViewName("/documentList/clubMemberDocument");
		return mav;
	}

	@RequestMapping(value = "deleteClubDocument.top")
	public ModelAndView deleteClubDocument(ModelAndView mav, HttpServletRequest request) {

		Calendar currentDate = Calendar.getInstance();
		int year = currentDate.get(Calendar.YEAR);
		int month = (currentDate.get(Calendar.MONTH) + 1);
		String strMonth = (month < 10) ? "0" + month : String.valueOf(month);

		int day = currentDate.get(Calendar.DATE);
		String strDay = day < 10 ? "0" + day : String.valueOf(day);

		String regDate = String.valueOf(year) + strMonth + strDay;

		String max = service.getMaxOfGroupno(regDate);
		int intMax = (Integer.parseInt(max)) + 1;
		max = (intMax < 10) ? "0" + intMax : String.valueOf(intMax);

		String groupno = "TOP" + regDate + max;

		regDate = String.valueOf(year) + ". " + strMonth + ". " + strDay;
		
		List<ClubVO> clubList = service.clubList();

		mav.addObject("groupno", groupno);
		mav.addObject("regDate", regDate);
		mav.addObject("clubList", clubList);
		mav.setViewName("/documentList/deleteClubDocument");
		return mav;
	}
	// === 문서 결재 형식 불러오기 끝 === //
	
	// === 문서 결재 페이지에서 문서 작성 결과 === //
	@RequestMapping(value = "/documentWriteEnd.top", method = { RequestMethod.POST })
	public ModelAndView documentWriteEnd(ModelAndView mav, DocumentVO dvo, HttpServletRequest request) {

		String documentCategory = request.getParameter("documentCategory");
		String contentImage = request.getParameter("contentImage");
		
		contentImage = contentImage.replaceAll("data:image/png;base64,", "");
		
		byte[] file = Base64.decodeBase64(contentImage);
		
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		
		String path = root + "resources" + File.separator + "files";
		
		String contentsName = "";
		
		try {
			contentsName = filemanager.doFileUpload(file, "image.png", path);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String allEmployeeSeq = request.getParameter("allEmployeeSeq");
		
		String[] seqArr = allEmployeeSeq.split(",");
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("seqArr", seqArr);
		
		List<EmployeesVO> approvalList = service.approvalList(paraMap);
		
		MultipartFile attach = dvo.getAttach();
		
		if( !attach.isEmpty() ) {
			
			String newFileName = "";
			long fileSize = 0;
			byte[] bytes = null;
			
			try {
				bytes = attach.getBytes();
				
				newFileName = filemanager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				
				dvo.setFileName(newFileName);
				
				dvo.setOrgFileName(attach.getOriginalFilename());
				
				fileSize = attach.getSize();
				dvo.setFileSize(String.valueOf(fileSize));
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		else {
			
			dvo.setFileName("");
		}

		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		dvo.setFk_employee_seq(loginEmployee.getEmployee_seq());
		dvo.setDocument_category(documentCategory);
		dvo.setContent(contentsName);
		dvo.setParent_approver("");
		
		for(EmployeesVO empvo : approvalList) {
			
			dvo.setApprover_seq(empvo.getEmployee_seq());
			service.insertDocumentTable(dvo);
			
			dvo.setParent_approver(empvo.getEmployee_seq());
		}
		
		if("1".equals(documentCategory)) {
			
			String trip_category = request.getParameter("trip_category");
			String groupno = request.getParameter("groupno");
			String reason = request.getParameter("reason");
			String trip_start = request.getParameter("trip_start");
			String trip_end = request.getParameter("trip_end");
			String fk_employee_seq = loginEmployee.getEmployee_seq();
			
			paraMap.put("trip_category", trip_category);
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("trip_start", trip_start);
			paraMap.put("trip_end", trip_end);
			paraMap.put("fk_employee_seq", fk_employee_seq);
			
			service.insertTripTableOfVacation(paraMap);
		
		}
		else if("2".equals(documentCategory)) {
			
			String trip_category = request.getParameter("trip_category");
			String groupno = request.getParameter("groupno");
			String reason = request.getParameter("reason");
			String trip_start = request.getParameter("trip_start");
			String trip_end = request.getParameter("trip_end");
			String triplocation = request.getParameter("triplocation");
			String fk_employee_seq = loginEmployee.getEmployee_seq();
			
			paraMap.put("trip_category", trip_category);
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("trip_start", trip_start);
			paraMap.put("trip_end", trip_end);
			paraMap.put("triplocation", triplocation);
			paraMap.put("fk_employee_seq", fk_employee_seq);
			
			service.insertTripTableOfBusiness(paraMap);
			
		}
		else if("3".equals(documentCategory)) {
			
			String[] sales_titleArr = request.getParameterValues("sales_title");
			String[] sales_countArr = request.getParameterValues("sales_count");
			String[] priceArr = request.getParameterValues("price");
			String groupno = request.getParameter("groupno");
			String reason = request.getParameter("reason");
			String fk_department_seq = request.getParameter("department_seq");
			String sales_subject = request.getParameter("sales_subject");
			
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("fk_department_seq", fk_department_seq);
			
			for(int i = 0; i < sales_titleArr.length; i++) {
				
				paraMap.put("sales_title", sales_subject + sales_titleArr[i]);
				paraMap.put("sales_count", sales_countArr[i]);
				paraMap.put("price", priceArr[i]);
				
				service.insertSalesTable(paraMap);
			}
			
		}
		else if("4".equals(documentCategory)) {

			String[] equipment_nameArr = request.getParameterValues("equipment_name");
			String[] unitArr = request.getParameterValues("unit");
			String[] equipment_priceArr = request.getParameterValues("equipment_price");
			String[] equipment_countArr = request.getParameterValues("equipment_count");
			String[] purchaseDateArr = request.getParameterValues("purchaseDate");
			String fk_department_seq = request.getParameter("department_seq");
			String groupno = request.getParameter("groupno");
			String reason = request.getParameter("reason");
			
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("fk_department_seq", fk_department_seq);
			
			for(int i = 0; i < equipment_nameArr.length; i++) {
				
				paraMap.put("equipment_name", equipment_nameArr[i]);
				paraMap.put("unit", unitArr[i]);
				paraMap.put("equipment_price", equipment_priceArr[i]);
				paraMap.put("equipment_count", equipment_countArr[i]);
				paraMap.put("purchaseDate", purchaseDateArr[i]);
				
				service.insertEquipmentTable(paraMap);
			}
			
		}
		else if("5".equals(documentCategory)) {
			
			String project_seq = service.getProjectSeq();
			String groupno = request.getParameter("groupno");
			String project_name = request.getParameter("project_name");
			String content = request.getParameter("content");
			String term = request.getParameter("term");
			String startDate = request.getParameter("startDate");
			String manager = loginEmployee.getPosition_name() + " " + loginEmployee.getEmployee_name();
			String memberCount = request.getParameter("memberCount");
			String downPayment = request.getParameter("downPayment");
			String middlePayment = request.getParameter("middlePayment");
			String completionPayment = request.getParameter("completionPayment");
			
			paraMap.put("project_seq", project_seq);
			paraMap.put("groupno", groupno);
			paraMap.put("project_name", project_name);
			paraMap.put("content", content);
			paraMap.put("term", term);
			paraMap.put("startDate", startDate);
			paraMap.put("manager", manager);
			paraMap.put("memberCount", memberCount);
			paraMap.put("downPayment", downPayment);
			paraMap.put("middlePayment", middlePayment);
			paraMap.put("completionPayment", completionPayment);
			
			service.insertProjectTable(paraMap);
			
			String[] department_seqArr = request.getParameterValues("department_seq");
			String[] position_seqArr = request.getParameterValues("position_seq");
			String[] employee_nameArr = request.getParameterValues("employee_name");
			
			for(int i = 0; i < department_seqArr.length; i++) {
				
				paraMap.put("department_seq", department_seqArr[i]);
				paraMap.put("position_seq", position_seqArr[i]);
				paraMap.put("employee_name", employee_nameArr[i]);
				
				String employee_seq = service.getEmployeeSeq(paraMap);
				
				paraMap.put("employee_seq", employee_seq);
				
				service.insertProjectMemberTable(paraMap);
			}
			
		}
		else if("6".equals(documentCategory)) {
			
			String project_name = request.getParameter("project_name");
			String term = request.getParameter("term");
			String reason = request.getParameter("reason");
			String middlePayment = request.getParameter("middlePayment");
			
			paraMap.put("project_name", project_name);
			paraMap.put("term", term);
			paraMap.put("reason", reason);
			paraMap.put("middlePayment", middlePayment);
			
			service.updateProjectTable(paraMap);
			 
		}
		else if("7".equals(documentCategory)) {
			
			String project_name = request.getParameter("project_name");
			String term = request.getParameter("term");
			String content = request.getParameter("content");
			String completionPayment = request.getParameter("completionPayment");
			
			paraMap.put("project_name", project_name);
			paraMap.put("term", term);
			paraMap.put("content", content);
			paraMap.put("completionPayment", completionPayment);
			
			service.updateProjectTableEnd(paraMap);
		}
		else if("8".equals(documentCategory)) {
			
			String department_seq = request.getParameter("department_seq");
			String position_seq = request.getParameter("position_seq");
			String employee_name = request.getParameter("employee_name");
			
			paraMap.put("department_seq", department_seq);
			paraMap.put("position_seq", position_seq);
			paraMap.put("employee_name", employee_name);
			
			String fk_employee_seq = service.getEmployeeSeq(paraMap);
			String groupno = request.getParameter("groupno");
			String reason = request.getParameter("reason");
			String interviewer_seq = loginEmployee.getEmployee_seq();
			String interview_content = request.getParameter("interview_content");
			String fire_date = request.getParameter("fire_date");
			
			paraMap.put("fk_employee_seq", fk_employee_seq);
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("interviewer_seq", interviewer_seq);
			paraMap.put("interview_content", interview_content);
			paraMap.put("fire_date", fire_date);
			
			service.insertFireTable(paraMap);
			
		}
		else if("9".equals(documentCategory)) {
			
			String employee_id = request.getParameter("employee_id");
			
			String fk_employee_seq = service.getEmployeeSeqByEmployeeId(employee_id);
			String groupno = request.getParameter("groupno");
			String reason = request.getParameter("reason");
			String attendance = request.getParameter("attendance");
			String attitude = request.getParameter("attitude");
			String performance = request.getParameter("performance");
			String manager = loginEmployee.getEmployee_seq();
			
			paraMap.put("fk_employee_seq", fk_employee_seq);
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("attendance", attendance);
			paraMap.put("attitude", attitude);
			paraMap.put("performance", performance);
			paraMap.put("manager", manager);
			
			service.insertTATable(paraMap);
			
		}
		else if("10".equals(documentCategory)) {
			
			String groupno = request.getParameter("groupno");
			String club_name = request.getParameter("club_name");
			String club_info = request.getParameter("club_info");
			
			paraMap.put("club_name", club_name);
			paraMap.put("club_info", club_info);
			paraMap.put("groupno", groupno);

			String newFileName = "";
			byte[] bytes = null;
			
			try {
				bytes = attach.getBytes();
				
				newFileName = filemanager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				
				paraMap.put("newFileName", newFileName);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			String club_seq = service.getClubSeq();
			
			paraMap.put("club_seq", club_seq);

			service.insertClubTable(paraMap);
			
			String fk_employee_seq = loginEmployee.getEmployee_seq();
			
			paraMap.put("fk_employee_seq", fk_employee_seq);
			
			service.insertClubMemberTableOfManager(paraMap);
			
		}
		else if("11".equals(documentCategory)) {
			
			String club_seq = request.getParameter("club_seq");
			String groupno = request.getParameter("groupno");
			
			paraMap.put("club_seq", club_seq);
			paraMap.put("groupno", groupno);
			
			String[] department_seqArr = request.getParameterValues("department_seq");
			String[] position_seqArr = request.getParameterValues("position_seq");
			String[] employee_nameArr = request.getParameterValues("employee_name");
			
			for(int i = 0; i < department_seqArr.length; i++) {
				
				paraMap.put("department_seq", department_seqArr[i]);
				paraMap.put("position_seq", position_seqArr[i]);
				paraMap.put("employee_name", employee_nameArr[i]);
				
				String employee_seq = service.getEmployeeSeq(paraMap);
				
				paraMap.put("employee_seq", employee_seq);
				
				service.insertClubMemberTable(paraMap);
			}

		}
		else if("12".equals(documentCategory)) {
			
			String club_seq = request.getParameter("club_seq");
			String groupno = request.getParameter("groupno");
			
			paraMap.put("club_seq", club_seq);
			paraMap.put("groupno", groupno);
			
			service.deleteClub(paraMap);
		}
		
		mav.setViewName("redirect:/documentPayment.top");
		return mav;
	}
	
	// === 결재 반려하기 버튼을 눌렀을 경우 === //
	@RequestMapping(value="/documentRejected.top", method={RequestMethod.POST})
	public ModelAndView documentRejected(ModelAndView mav, HttpServletRequest request) {
		
		String documentSeq = request.getParameter("documentSeq");
		
		String[] document_seqArr = documentSeq.split(",");
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("document_seqArr", document_seqArr);
		
		service.updateStatusDocmenetTable(paraMap);
		
		List<DocumentVO> documentVOList = service.getDocumentList(paraMap);
		
		for(DocumentVO docuvo : documentVOList) {
			
			String groupno = docuvo.getGroupno();
			
			String category_seq = docuvo.getDocument_category();
			
			if("1".equals(category_seq)) {
				
				service.deleteTripTable(groupno);
			}
			else if("2".equals(category_seq)) {
				
				service.deleteTripTable(groupno);
			}
			else if("3".equals(category_seq)) {
				
				service.deleteSalesTable(groupno);
			}
			else if("4".equals(category_seq)) {
				
				service.deleteEquipmentTable(groupno);
			}
			else if("5".equals(category_seq)) {
				
				service.deleteProjectTable(groupno);
			}
			else if("8".equals(category_seq)) {
				
				service.deleteFireTable(groupno);
			}
			else if("9".equals(category_seq)) {
				
				service.deleteTATable(groupno);
			}
			else if("10".equals(category_seq)) {
				
				service.deleteClubTable(groupno);
			}
			else if("11".equals(category_seq)) {
				
				service.deleteClubMemberTable(groupno);
			}
		}
		
		mav.setViewName("redirect:/documentPayment.top");
		return mav;
	}
	
	// === 결재 완료하기 버튼을 눌렀을 경우 === //
	@RequestMapping(value="/documentAccepted.top", method={RequestMethod.POST})
	public ModelAndView documentAccepted(ModelAndView mav, HttpServletRequest request) {
		
		String documentSeq = request.getParameter("documentSeq");
		
		String[] document_seqArr = documentSeq.split(",");
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("document_seqArr", document_seqArr);
		
		service.updateStatusDocmenetTable2(paraMap);
		
		List<DocumentVO> documentVOList = service.getDocumentList2(paraMap);
		
		for(DocumentVO docuvo : documentVOList) {
			
			String groupno = docuvo.getGroupno();
			
			paraMap.put("groupno", groupno);
			paraMap.put("document_category", docuvo.getDocument_category());
			
			if("12".equals(docuvo.getDocument_category())) {
				service.deleteClubTable(groupno);
			}
			else {
				
				System.out.println(paraMap.get("document_category"));
				service.updateDocumentStatus(paraMap);
				
				if("10".equals(docuvo.getDocument_category())) {
					
					service.updateClubManager(paraMap);
				}
			}
			
			if("8".equals(docuvo.getDocument_category())) {
				
				service.updateFireDate(paraMap);
				
			}
		}
		
		mav.setViewName("redirect:/documentPayment.top");
		return mav;
	}
	
	// === 관리자-인사 관리(사원정보-리스트)페이지 이동 === //
	@RequestMapping(value="/manager/HR/list.top")
	public ModelAndView managerHRlist(ModelAndView mav, HttpServletRequest request) {
		
		List<EmployeesVO> allEmployeeList = service.getAllEmployeeList();
		
		mav.addObject("allEmployeeList", allEmployeeList);
		mav.setViewName("admin/HR/list.tiles3");
		return mav;
	}
	
	
	// === 회원 정보 수정 페이지로 이동 === //
	@RequestMapping(value="/employeeUpdate.top", method = {RequestMethod.GET})
	public ModelAndView employeeUpdate(ModelAndView mav, HttpServletRequest request) {
		
		String employee_seq = request.getParameter("employee_seq");
		
		EmployeesVO oneEmployee = service.getOneEmployee(employee_seq);
		
		Random rnd = new Random();

		String employee_pw = "";

		char randchar = ' ';
		for (int i = 0; i < 1; i++) {
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			employee_pw += randchar;
		}

		int randnum = 0;
		for (int i = 0; i < 3; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			employee_pw += randnum;
		}

		randchar = ' ';
		for (int i = 0; i < 1; i++) {
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			employee_pw += randchar;
		}

		randnum = 0;
		for (int i = 0; i < 3; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			employee_pw += randnum;
		}
		
		try {
			aes = new AES256(key);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		try {
			
			oneEmployee.setPhone(aes.decrypt(oneEmployee.getPhone()));
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		mav.addObject("oneEmployee", oneEmployee);
		mav.addObject("employee_pw", employee_pw);
		mav.setViewName("idUpdate.notiles");
		return mav;
	}

	// === 사원 정보 수정 페이지로 이동 === //
	@RequestMapping(value="/employeeUpdate.top", method = {RequestMethod.POST})
	public ModelAndView employeeUpdateEnd(ModelAndView mav, HttpServletRequest request) {
		
		String employee_id = request.getParameter("employee_id");
		String employee_pw = request.getParameter("employee_pw");
		String phone = request.getParameter("phone");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String detailaddress = request.getParameter("detailaddress");
		String extraaddress = request.getParameter("extraaddress");
		String position_seq = request.getParameter("position_seq");
		
		employee_pw = Sha256.encrypt(employee_pw);

		try {
			aes = new AES256(key);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		try {
			phone = aes.encrypt(phone);
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_pw", employee_pw);
		paraMap.put("phone", phone);
		paraMap.put("postcode", postcode);
		paraMap.put("address", address);
		paraMap.put("detailaddress", detailaddress);
		paraMap.put("extraaddress", extraaddress);
		paraMap.put("position_seq", position_seq);
		
		service.employeeUpdate(paraMap);
		
		String message = "사원 정보를 수정했습니다.";
		String loc = request.getContextPath() + "/manager/HR/list.top";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		return mav;
	}
	
	// === 사원 grade 변경하기 === //
	@ResponseBody
	@RequestMapping(value = "/updateGrade.top", method = {RequestMethod.POST})
	public String updateGrade(HttpServletRequest request) {
		
		String employee_seq = request.getParameter("employee_seq");
		String grade = request.getParameter("grade");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_seq", employee_seq);
		paraMap.put("grade", grade);
		
		boolean flag = false;
				
		int result = service.updateGrade(paraMap);
		
		if(result > 0) {
			
			flag = true;
		}
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("flag", flag);
		
		return jsObj.toString();
	}

	// === 사원 department 변경하기 === //
	@ResponseBody
	@RequestMapping(value = "/updateDepartment.top", method = {RequestMethod.POST})
	public String updateDepartment(HttpServletRequest request) {
		
		String employee_seq = request.getParameter("employee_seq");
		String fk_department = request.getParameter("fk_department");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_seq", employee_seq);
		paraMap.put("fk_department", fk_department);
		
		boolean flag = false;
				
		int result = service.updateDepartment(paraMap);
		
		if(result > 0) {
			
			flag = true;
		}
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("flag", flag);
		
		return jsObj.toString();
	}

	// === 사원 grade 변경하기 === //
	@ResponseBody
	@RequestMapping(value = "/updatePosition.top", method = {RequestMethod.POST})
	public String updatePosition(HttpServletRequest request) {
		
		String employee_seq = request.getParameter("employee_seq");
		String fk_position = request.getParameter("fk_position");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_seq", employee_seq);
		paraMap.put("fk_position", fk_position);
		
		boolean flag = false;
				
		int result = service.updatePosition(paraMap);
		
		if(result > 0) {
			
			flag = true;
		}
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("flag", flag);
		
		return jsObj.toString();
	}
	
	// === 관리자-인사 관리(인사고과)페이지 이동 === //
	@RequestMapping(value="/manager/HR/review.top")
	public ModelAndView managerHRreview(ModelAndView mav, HttpServletRequest request) {
		
		List<TimeAndAttVO> TAList = service.getTAList();
		
		mav.addObject("TAList", TAList);
		mav.setViewName("admin/HR/review.tiles3");
		return mav;
	}
	
	// 관리자-결재 관리(결재현황)페이지 이동
	@RequestMapping(value="/manager/approval/approvalList.top")
	public String managerDocumentList(HttpServletRequest request) {
		
		List<DocumentVO> allDocumentList = service.allDocumentList();
		
		request.setAttribute("allDocumentList", allDocumentList);
		
		return "admin/approval/approvalList.tiles3";
		
	}
	
	// === 관리자-결재관리(문서함) 페이지 이동 === //
	@RequestMapping(value="/manager/approval/documentList.top")
	public String managerApprovalList(HttpServletRequest request ) {
		
		List<DocumentVO> allComDocumentList = service.getAllComDocumentList();
		
		request.setAttribute("allComDocumentList", allComDocumentList);
		
		return "admin/approval/documentList.tiles3";
	}
	
	// === 관리자 문서함에서 삭제하면 휴지통으로 이동 === //
	@RequestMapping(value="/updateStatusDocumentDelete.top")
	public ModelAndView updateStatusDocumentDelete(ModelAndView mav, HttpServletRequest request) {
		
		String groupno = request.getParameter("groupno");
		String[] groupnoArr = groupno.split(",");

		for(int i = 0; i < groupnoArr.length; i++) {
			
			service.updateDocumentTableStatus(groupnoArr[i]);
			
		}
		
		mav.setViewName("redirect:/manager/approval/garbage.top");
		
		return mav;
	}
	
	// === 관리자-결재 관리(휴지통)페이지 이동 === //
	@RequestMapping(value="/manager/approval/garbage.top")
	public String managerGarbage(HttpServletRequest request) {
		
		List<DocumentVO> delDocumentList = service.delDocumentList();
		
		request.setAttribute("delDocumentList", delDocumentList);
		
		return "admin/approval/garbage.tiles3";
	}
	
	// === 휴지통에서 문서 복구하기 === //
	@RequestMapping(value="/rollbackDocument.top")
	public ModelAndView rollbackDocument(ModelAndView mav, HttpServletRequest request) {
		
		String groupno = request.getParameter("groupno");
		
		String[] groupnoArr = groupno.split(",");
		
		for(int i = 0; i < groupnoArr.length; i++) {
			
			service.rollbackDocument(groupnoArr[i]);
		}
		
		mav.setViewName("/manager/approval/documentList.top");
		
		return mav;
	}

	// === 휴지통에서 문서 영구삭제하기 === //
	@RequestMapping(value="/shiftDelDocument.top")
	public ModelAndView shiftDelDocument(ModelAndView mav, HttpServletRequest request) {
		
		String groupno = request.getParameter("groupno");
		
		String[] groupnoArr = groupno.split(",");
		
		for(int i = 0; i < groupnoArr.length; i++) {
			
			service.shiftDelDocument(groupnoArr[i]);
		}
		
		mav.setViewName("/manager/approval/documentList.top");
		
		return mav;
	}
	
	// === 동호회 신청 페이지 만들기 === //
	@RequestMapping(value="/clubRequest.top")
	public ModelAndView clubRequest(ModelAndView mav) {
		
		List<HashMap<String, String>> clubList = service.allClubList();
		
		mav.addObject("clubList", clubList);
		mav.setViewName("clubRequest/clubRequest.tiles1");
		
		return mav;
	}
	
	// === 문서 결재 알람을 위해 cnt 알아오기 === //
	@ResponseBody
	@RequestMapping(value="/document/newPaymentFind.top", produces="text/plain;charset=UTF-8")
	public String newPaymentFind(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		String fk_employee_seq = loginEmployee.getEmployee_seq();
				
		int result = service.getCntOfPayment(fk_employee_seq);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("result", result);
		
		return jsObj.toString();
	}
	
	// === 출근하기 팝업 띄우기 === //
	@RequestMapping(value="/getOnTime.top")
	public ModelAndView getOnTime(ModelAndView mav) {
		
		mav.setViewName("getOnTime.notiles");
		return mav;
	}
	
	// === 출근 확인 버튼을 누르면 출근 테이블에 집어넣기 === //
	@ResponseBody
	@RequestMapping(value="/insertAttendanceTable.top", produces="text/plain;charset=UTF-8")
	public String insertAttendanceTable(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		String fk_employee_seq = loginEmployee.getEmployee_seq();
		
		int result = service.insertAttendanceTable(fk_employee_seq);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("result", result);
		
		return jsObj.toString();
		
	}
	
	// === 퇴근하기 팝업 띄우기 === //
	@RequestMapping(value="/getOffTime.top")
	public ModelAndView getOffTime(ModelAndView mav) {
		
		mav.setViewName("getOnTime.notiles");
		return mav;
	}
	
	
	// === 출근 확인 버튼을 누르면 출근 테이블에 집어넣기 === //
	@ResponseBody
	@RequestMapping(value="/updateAttendanceTable.top", produces="text/plain;charset=UTF-8")
	public String updateAttendanceTable(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		String fk_employee_seq = loginEmployee.getEmployee_seq();
		
		int result = service.updateAttendanceTable(fk_employee_seq);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("result", result);
		
		return jsObj.toString();
		
	}
	
	// === 인사고과 저번달 고과와 이번달 고과, 사유 얻어오기 === //
	@ResponseBody
	@RequestMapping(value="/detailTAList.top", produces="text/plain;charset=UTF-8")
	public String detailTAList(HttpServletRequest request) {
		
		String fk_employee_seq = request.getParameter("fk_employee_seq");
		String ta_seq = request.getParameter("ta_seq");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("ta_seq", ta_seq);
		
		TimeAndAttVO detailTA = service.getDetailTA(paraMap);
		
		JSONObject jsObj = new JSONObject();
		jsObj.put("previousattitude", detailTA.getPreviousattitude());
		jsObj.put("previousattendance", detailTA.getPreviousattendance());
		jsObj.put("previousperformance", detailTA.getPreviousperformance());
		jsObj.put("attitude", detailTA.getAttitude());
		jsObj.put("attendance", detailTA.getAttendance());
		jsObj.put("performance", detailTA.getPerformance());
		jsObj.put("reason", detailTA.getReason());
		
		return jsObj.toString();
	}
}
