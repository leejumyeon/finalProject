package com.spring.groupware.junghm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.junghm.model.InterHyeminDAO;

// === #31. Service 선언 ===
@Service
public class HyeminService implements InterHyeminService {

	// === #34. 의존객체 주입하기(DI) ===
	@Autowired
	private InterHyeminDAO dao;
	
}
