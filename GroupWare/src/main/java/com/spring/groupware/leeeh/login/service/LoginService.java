package com.spring.groupware.leeeh.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.leeeh.login.model.InterLoginDAO;

@Service
public class LoginService implements InterLoginService {

	@Autowired
	private InterLoginDAO dao;
}
