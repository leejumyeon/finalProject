package com.spring.groupware.choijh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.choijh.model.InterChoijhDAO;

@Service
public class ChoijhService implements InterChoijhService {

	@Autowired 
	private InterChoijhDAO dao;
	
	
}
