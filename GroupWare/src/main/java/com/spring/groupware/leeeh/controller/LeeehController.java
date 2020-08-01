package com.spring.groupware.leeeh.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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
	
	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@RequestMapping(value="/login.top", method= {RequestMethod.POST})
	public ModelAndView loginEnd(ModelAndView mav, HttpServletRequest request) {
		
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("id", id);
		paraMap.put("passwd", passwd);
		
	//	service.isUserExist(paraMap);

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
		
		mav.setViewName("writeDocument.tiles1");
		
		return mav;
	}
	
}
