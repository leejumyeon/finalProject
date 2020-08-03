package com.spring.groupware.cha.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.groupware.cha.service.ChaInterService;

@Controller
public class ChaController {
	
	@Autowired
	private ChaInterService service; // 의존객체
	
	@RequestMapping(value="/fullCalendar.top", produces="text/plain;charset=UTF-8")
	public String fullCalendar() {
		
		return "fullCalendarKakaoBook/fullCalendar";
		
	}
	
	@RequestMapping(value="/kakaoBook.top", produces="text/plain;charset=UTF-8")
	public String kakaoBook() {
		
		return "fullCalendarKakaoBook/kakaoBook";
		
	}
	
	
	
	

}
