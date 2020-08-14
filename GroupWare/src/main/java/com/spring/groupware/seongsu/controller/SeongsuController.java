package com.spring.groupware.seongsu.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SeongsuController {
		
	@RequestMapping(value="/board.top")
	public ModelAndView goBoardPage(ModelAndView mav) {
		
		mav.setViewName("/board/board.tiles1");
		
		return mav;
	}
		
	@RequestMapping(value="/detailboard.top")
	public ModelAndView requiredLogin_detailboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/detailboard.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/write.top")
	public ModelAndView requiredLogin_write(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/write.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/list.top")
	public ModelAndView requiredLogin_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/list.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/update.top")
	public ModelAndView requiredLogin_update(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/update.tiles1");
		
		return mav;
	}
	
	
	
	
}	
	
