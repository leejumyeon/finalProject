package com.spring.groupware.leejm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.leejm.model.InterAdditionalDAO;

@Service
public class AdditionalService implements InterAdditionalService {
	@Autowired
	InterAdditionalDAO dao;
}
