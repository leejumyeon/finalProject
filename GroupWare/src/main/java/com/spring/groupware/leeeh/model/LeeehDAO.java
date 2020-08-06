package com.spring.groupware.leeeh.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.DepartmentVO;
import com.spring.groupware.commonVO.DocumentCategoryVO;
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

	// === 사원 발급을 하기 위해 부서리스트를 가져오기 === //
	@Override
	public List<DepartmentVO> departmentList() {

		List<DepartmentVO> departmentList = sqlsession.selectList("leeeh.departmentList");
		
		return departmentList;
	}

	// === 사원발급에서 테이블에 집어 넣기 === //
	@Override
	public void insertEmployeeTable(HashMap<String, String> paraMap) {

		sqlsession.insert("leeeh.insertEmployeeTable", paraMap);
	}

	// === 문서 결재 카테고리 알아오기 === //
	@Override
	public List<DocumentCategoryVO> documentCategoryList() {

		List<DocumentCategoryVO> documentCategoryList = sqlsession.selectList("leeeh.documentCategoryList");
		
		return documentCategoryList;
	}

	// === 문서 결재를 하기위해 문서번호에서 max값을 가져오기 === //
	@Override
	public String getMaxOfGroupno(String regDate) {

		String max = sqlsession.selectOne("leeeh.getMaxOfGroupno", regDate);
		
		return max;
	}

}
