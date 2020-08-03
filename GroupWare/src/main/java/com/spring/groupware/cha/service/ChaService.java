package com.spring.groupware.cha.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.cha.model.ChaInterDAO;

@Service
public class ChaService implements ChaInterService {
	
	@Autowired
	private ChaInterDAO dao;

}
