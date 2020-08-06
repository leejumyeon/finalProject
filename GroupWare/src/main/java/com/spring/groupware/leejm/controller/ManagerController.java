package com.spring.groupware.leejm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.leejm.service.MailService;

@Controller
public class ManagerController {
	
	@Autowired
	private MailService service;
	
	// 관리자-예약관리 페이지 이동
	@RequestMapping(value="/manager/reservation.top")
	public ModelAndView managerReservation(ModelAndView mav) {
		mav.setViewName("admin/reservation.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(공지사항 리스트)페이지 이동
	@RequestMapping(value="/manager/board/noticeList.top")
	public ModelAndView managerNoticeList(ModelAndView mav) {
		mav.setViewName("admin/board/noticeList.tiles3");
		return mav;
	}
	
	
}
