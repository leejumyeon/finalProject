package com.spring.groupware.leejm.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AdditionalController {
	
	@ResponseBody
	@RequestMapping(value="/messenger/open.top", produces = "text/plain;charset=UTF-8")
	public String messengerOpen(HttpServletRequest request) {
		String messengerStatus = request.getParameter("messengerStatus");
		System.out.println("메신저 클릭");
		HttpSession session = request.getSession();
		if("messengerClose".equals(messengerStatus)) {
			session.removeAttribute("messenger");
		}
		else {
			session.setAttribute("messenger", true);
		}
		return "";
	}
}
