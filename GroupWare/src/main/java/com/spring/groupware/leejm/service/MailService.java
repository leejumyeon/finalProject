package com.spring.groupware.leejm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leejm.model.InterMailDAO;

@Service
public class MailService implements InterMailService{
	@Autowired
	private InterMailDAO dao;

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	@Override
	public List<EmployeesVO> searchReceive(HashMap<String, String>paraMap) {
		List<EmployeesVO> receiveList = dao.searchReceive(paraMap);
		return receiveList;
	}
}
