package com.spring.groupware.leeeh.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leeeh.model.InterLeeehDAO;

@Service
public class LeeehService implements InterLeeehService {

	@Autowired
	private InterLeeehDAO dao;

	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@Override
	public EmployeesVO isUserExist(HashMap<String, String> paraMap) {

		EmployeesVO loginEmployee = dao.isUserExist(paraMap);
		
		return loginEmployee;
	}


}
