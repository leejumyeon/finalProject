package com.spring.leeeunhan.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.leeeunhan.login.model.InterLoginDAO;

@Service
public class LoginService implements InterLoginService {

	@Autowired
	private InterLoginDAO dao;
}
