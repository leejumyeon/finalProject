package com.spring.groupware.seongsu.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

public class SeongsuController {

	@RequestMapping(value="/add.action")
	public ModelAndView write(HttpServletRequest request, ModelAndView mav) {
		
		String fk_seq = request.getParameter("fk_seq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("groupno", groupno);
		mav.addObject("depthno", depthno);
		
		mav.setViewName("board/add.tiles1");
		
		return mav;
	}
	
}
