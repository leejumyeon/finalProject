package com.spring.groupware.leejm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.groupware.leejm.service.LeeService;

@Controller
public class LeeController {
	@Autowired
	private LeeService service;
}
