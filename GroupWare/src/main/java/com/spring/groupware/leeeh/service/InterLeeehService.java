package com.spring.groupware.leeeh.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.EmployeesVO;

public interface InterLeeehService {

	EmployeesVO isUserExist(HashMap<String, String> paraMap);	// 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기

	String getMaxOfEmployeeId(String hireDate);	// 사원 발급을 하기위해 사원 ID에서 max값을 가져오기

	List<DepartmentVO> departmentList();	// 사원 발급을 하기 위해 부서리스트를 가져오기

	void insertEmployeeTable(HashMap<String, String> paraMap);	// 사원발급에서 테이블에 집어 넣기

}
