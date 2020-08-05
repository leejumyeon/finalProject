package com.spring.groupware.choijh.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.choijh.service.InterChoijhService;

@Controller
public class ChoijhController {

	@Autowired
	private InterChoijhService service;
	
	// 모든 사원정보 불러오기 
	@ResponseBody
	@RequestMapping(value="allEmployeeView.top")
	public ModelAndView allEmployeeView(ModelAndView mav) {
		
		
		return mav;
	}
	
}
