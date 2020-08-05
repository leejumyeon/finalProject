package com.spring.groupware.leeeh.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.AES256;
import com.spring.common.EncryptMyKey;
import com.spring.common.Sha256;
import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leeeh.service.InterLeeehService;

@Controller
public class LeeehController {

	@Autowired
	private InterLeeehService service;
	
	private String key = EncryptMyKey.KEY;
	
	private AES256 aes = null;
	
	// === 로그인 페이지 보여주기 === //
	@RequestMapping(value="/login.top", method= {RequestMethod.GET})
	public ModelAndView goLogin(ModelAndView mav) {
		
		mav.setViewName("login.notiles");
		
		return mav;
	}
	
	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@RequestMapping(value="/login.top", method= {RequestMethod.POST})
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String employee_id = request.getParameter("employee_id");
		String employee_pw = request.getParameter("employee_pw");
		
		employee_pw = Sha256.encrypt(employee_pw);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_pw", employee_pw);
		
		EmployeesVO loginEmployee = service.isUserExist(paraMap);
		
		boolean isLogin = false;

		if(loginEmployee != null) {
			
			HttpSession session = request.getSession();
			session.setAttribute("loginEmployee", loginEmployee);
			
			String grade = loginEmployee.getGrade();
			
			if("1".equals(grade)) {
				
				mav.setViewName("redirect:/main.top");
			}
			else {
				
				mav.setViewName("redirect:/twoChoice.top");
			}
		}
		else {
			
			mav.addObject("isLogin", isLogin);
			mav.setViewName("login.notiles");
		}
		
		return mav;
	}
	
	// === 사원발급 페이지 보여주기 === //
	@RequestMapping(value="/idIssued.top", method= {RequestMethod.GET})
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
		max = (intMax < 10)? "0" + intMax : String.valueOf(intMax);

		employee_id = "TOP-" + hireDate + "-" + max;
		
		Random rnd = new Random();
		
		String employee_pw= "";
		
		char randchar = ' ';
		for(int i=0; i<1; i++) {
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			employee_pw += randchar;
		}
		
		int randnum = 0;
		for(int i=0; i<3; i++) {
			randnum = rnd.nextInt(9 - 0 + 1) + 0;
			employee_pw += randnum;
		}
		
		randchar = ' ';
		for(int i=0; i<1; i++) {
			randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
			employee_pw += randchar;
		}
		
		randnum = 0;
		for(int i=0; i<3; i++) {
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
	@RequestMapping(value="/idIssued.top", method= {RequestMethod.POST})
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
	@RequestMapping(value="/twoChoice.top")
	public ModelAndView twoChoice(ModelAndView mav) {
		
		mav.setViewName("twoChoice.notiles");
		
		return mav;
	}
	
	// === 문서 결재 페이지로 이동하기 === //
	@RequestMapping(value="/documentPayment.top")
	public ModelAndView goDocumentPayment(ModelAndView mav) {
		
		mav.setViewName("documentPayment.tiles1");
		
		return mav;
	}
	
	// === 문서 결재 페이지에서 문서 작성 페이지로 이동 === //
	@RequestMapping(value="/writeDocument.top", method = {RequestMethod.GET})
	public ModelAndView writeDocument(ModelAndView mav) {
		
		mav.setViewName("documentWrite.tiles1");
		
		return mav;
	}
	
}
