package com.spring.groupware.leeeh.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leeeh.service.InterLeeehService;

@Controller
public class LeeehController {

	@Autowired
	private InterLeeehService service;
	
	// === 로그인 페이지 보여주기 === //
	@RequestMapping(value="/login.top", method= {RequestMethod.GET})
	public ModelAndView goLogin(ModelAndView mav) {
		
		mav.setViewName("login.notiles");
		
		return mav;
	}
	
	@RequestMapping(value="/idIssued.top", method= {RequestMethod.GET})
	public ModelAndView idIssued(ModelAndView mav) {
		
		mav.setViewName("idIssued.tiles2");
		
		return mav;
	}
	
	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@RequestMapping(value="/login.top", method= {RequestMethod.POST})
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String employee_id = request.getParameter("employee_id");
		String employee_pw = request.getParameter("employee_pw");
		
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
	
	// === 선택 페이지 보여주기 === //
	@RequestMapping(value="/twoChoice.top")
	public ModelAndView twoChoice(ModelAndView mav) {
		
		mav.setViewName("twoChoice.notiles");
		
		return mav;
	}
	
	// === 메인 페이지 보여주기 === //
	@RequestMapping(value="/main.top")
	public ModelAndView main(ModelAndView mav) {
		
		mav.setViewName("main.tiles1");
		
		return mav;
	}
	
	// === 관리자 메인 페이지 보여주기 === //
	@RequestMapping(value="/adminMain.top")
	public ModelAndView adminMain(ModelAndView mav) {
		
		mav.setViewName("adminMain.tiles1");
		
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
	
	
	@RequestMapping(value="/vacation.top", method = {RequestMethod.GET})
	public ModelAndView vacation(ModelAndView mav) {
		
		mav.setViewName("vacationDocument.notiles");
		
		return mav;
	}
	
}
