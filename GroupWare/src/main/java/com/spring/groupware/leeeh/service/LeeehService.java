package com.spring.groupware.leeeh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.DepartmentVO;
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

	// === 사원 발급을 하기위해 사원 ID에서 max값을 가져오기 === //
	@Override
	public String getMaxOfEmployeeId(String hireDate) {

		String max = dao.getMaxOfEmployeeId(hireDate);
		
		return max;
	}

	// === 사원 발급을 하기 위해 부서리스트를 가져오기 === //
	@Override
	public List<DepartmentVO> departmentList() {

		List<DepartmentVO> departmentList = dao.departmentList();
		
		return departmentList;
	}

	// === 사원발급에서 테이블에 집어 넣기 == //
	@Override
	public void insertEmployeeTable(HashMap<String, String> paraMap) {

		dao.insertEmployeeTable(paraMap);
	}


}
