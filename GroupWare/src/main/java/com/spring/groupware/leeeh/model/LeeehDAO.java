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

}
