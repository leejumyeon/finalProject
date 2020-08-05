package com.spring.groupware.choijh.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.choijh.service.InterChoijhService;

@Controller
public class ChoijhController {

	@Autowired
	private InterChoijhService service;
	
	@RequestMapping(value="/messenger/view.top")
	public ModelAndView messengerView(ModelAndView mav, HttpServletRequest request) {
		
	//	HttpSession session = request.getSession();
	//	session.getAttribute("");
		
	//	mav.addObject("", attributeValue)
		mav.setViewName("messenger/messenger.tiles1");
		
		return mav;
	}
	
}
