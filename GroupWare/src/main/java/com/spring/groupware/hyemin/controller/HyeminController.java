package com.spring.groupware.hyemin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.groupware.hyemin.service.InterHyeminService;

// === #30. 컨트롤러 선언 ===
@Component
@Controller
public class HyeminController {	

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterHyeminService service;
	
	@RequestMapping(value = "/test/hmTest.top")
	public String hmTest() {

		return "test/hmTest";
		// /WEB-INF/views/test/hmTest.jsp 페이지를 만들어야 한다.
	}
	
}
