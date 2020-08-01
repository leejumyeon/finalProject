package com.spring.groupware.leeeh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.leeeh.model.InterLeeehDAO;

@Service
public class LeeehService implements InterLeeehService {

	@Autowired
	private InterLeeehDAO dao;


}
