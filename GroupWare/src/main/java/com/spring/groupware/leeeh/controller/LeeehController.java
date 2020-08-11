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

		mav.setViewName("login.notiles");

		return mav;
	}

	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@RequestMapping(value = "/login.top", method = { RequestMethod.POST })
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {

		String employee_id = request.getParameter("employee_id");
		String employee_pw = request.getParameter("employee_pw");

		employee_pw = Sha256.encrypt(employee_pw);

		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_pw", employee_pw);

		EmployeesVO loginEmployee = service.isUserExist(paraMap);

		String isLogin = "0";

		if (loginEmployee != null) {

			HttpSession session = request.getSession();
			session.setAttribute("loginEmployee", loginEmployee);

			String grade = loginEmployee.getGrade();

			if ("1".equals(grade)) {

				mav.setViewName("redirect:/main.top");
			} else {

				mav.setViewName("redirect:/twoChoice.top");
			}
		} else {

			mav.addObject("isLogin", isLogin);
			mav.setViewName("login.notiles");
		}

		return mav;
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
		mav.setViewName("idIssued.notiles");

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

		mav.setViewName("redirect:/idIssued.top");
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
	@RequestMapping(value="/comDocumentList.top")
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

		List<EmployeesVO> employeesByDepartList = service.showMemberByDepartment(seq);

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
			String triplocatioin = request.getParameter("triplocatioin");
			String fk_employee_seq = loginEmployee.getEmployee_seq();
			
			paraMap.put("trip_category", trip_category);
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("trip_start", trip_start);
			paraMap.put("trip_end", trip_end);
			paraMap.put("triplocatioin", triplocatioin);
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
			
			paraMap.put("fk_employee_seq", fk_employee_seq);
			paraMap.put("groupno", groupno);
			paraMap.put("reason", reason);
			paraMap.put("interviewer_seq", interviewer_seq);
			paraMap.put("interview_content", interview_content);
			
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
			String manager = loginEmployee.getPosition_name() + " " + loginEmployee.getEmployee_name();
			
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
			
			String club_name = request.getParameter("club_name");
			String club_info = request.getParameter("club_info");
			
			paraMap.put("club_name", club_name);
			paraMap.put("club_info", club_info);

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
}
