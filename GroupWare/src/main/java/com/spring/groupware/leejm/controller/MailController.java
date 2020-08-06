package com.spring.groupware.leejm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.leejm.service.MailService;

@Controller
public class MailController {
	@Autowired
	private MailService service;
	
	@RequestMapping(value="/test.top")
	public ModelAndView test(ModelAndView mav) {
		mav.setViewName("home.tiles3");
		return mav;
	}
	
	// 메일 리스트 페이지 이동(받은 메일함, 보낸 메일함, 전체 메일함, 내게 쓴 메일함)
	@RequestMapping(value="/mail/list.top")
	public ModelAndView mailList(ModelAndView mav, HttpServletRequest request) {
		String type = request.getParameter("type");
		
		HttpSession session = request.getSession();
		session.setAttribute("test", "yes");
		
		if("receive".equals(type)) {
			mav.addObject("mailhamType","받은메일함");
		}
		else if("send".equals(type)) {
			mav.addObject("mailhamType","보낸메일함");
		}
		
		mav.setViewName("mail/mailList.tiles2");
		
		return mav;
	}
	
	// 메일 쓰기 페이지 이동(메일쓰기, 내게쓰기)
	@RequestMapping(value="/mail/write.top")
	public ModelAndView mailWrite(ModelAndView mav, HttpServletRequest request) {
		String writeType = request.getParameter("type");
		if("normal".equals(writeType)) { // 메일쓰기 버튼 클릭 해서 입장할 경우
			mav.addObject("receive","공백값");
		}
		else if("reply".equals(writeType)) { // 답장버튼 클릭해서 입장할 경우
			mav.addObject("receive","특정상대 메일");
		}
		
		mav.setViewName("mail/mailWrite.tiles2");
		return mav;
	}
	
	// 메일 읽기 페이지 이동
	@RequestMapping(value="/mail/read.top")
	public ModelAndView mailRead(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("mail/mailRead.tiles2");
		return mav;
	}
}
