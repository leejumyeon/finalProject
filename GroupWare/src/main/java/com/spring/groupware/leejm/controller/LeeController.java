package com.spring.groupware.leejm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.leejm.service.LeeService;

@Controller
public class LeeController {
	@Autowired
	private LeeService service;
	
	@RequestMapping(value="/test.top")
	public ModelAndView test(ModelAndView mav) {
		System.out.println("테스트 확인");
		mav.setViewName("home.tiles2");
		return mav;
	}
}
