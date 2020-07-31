package com.spring.groupware.leeeh.login.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.leeeh.login.service.InterLoginService;

@Controller
public class LoginController {

	@Autowired
	private InterLoginService service;
	
	@RequestMapping(value="/login.top", method= {RequestMethod.GET})
	public ModelAndView goLogin(ModelAndView mav) {
		
		mav.setViewName("login.notiles");
		
		return mav;
	}
	
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
}
