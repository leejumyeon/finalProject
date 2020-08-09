package com.spring.groupware.leejm.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.EmployeesVO;

public interface InterMailDAO {

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	List<EmployeesVO> searchReceive(HashMap<String, String> paraMap);

}
