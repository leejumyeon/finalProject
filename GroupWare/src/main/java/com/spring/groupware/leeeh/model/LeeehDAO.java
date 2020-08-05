package com.spring.groupware.leeeh.model;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.EmployeesVO;

@Repository
public class LeeehDAO implements InterLeeehDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	// === 로그인 페이지에서 적은 ID와 비밀번호를 통해 유저가 존재하는지 검사하기 === //
	@Override
	public EmployeesVO isUserExist(HashMap<String, String> paraMap) {

		EmployeesVO loginEmployee = sqlsession.selectOne("leeeh.isUserExist", paraMap);
		
		return loginEmployee;
	}

	// === 사원 발급을 하기위해 사원 ID에서 max값을 가져오기 === //
	@Override
	public String getMaxOfEmployeeId(String hireDate) {

		String max = sqlsession.selectOne("leeeh.getMaxOfEmployeeId", hireDate);
		
		return max;
	}

}
