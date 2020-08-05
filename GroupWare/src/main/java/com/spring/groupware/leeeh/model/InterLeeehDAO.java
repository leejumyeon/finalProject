package com.spring.groupware.leeeh.model;

import java.util.HashMap;

import com.spring.groupware.commonVO.EmployeesVO;

public interface InterLeeehDAO {

	EmployeesVO isUserExist(HashMap<String, String> paraMap);	// 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기

	String getMaxOfEmployeeId(String hireDate);	// 사원 발급을 하기위해 사원 ID에서 max값을 가져오기
	
}
