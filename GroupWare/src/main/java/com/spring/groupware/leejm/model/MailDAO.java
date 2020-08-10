package com.spring.groupware.leejm.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.EmployeesVO;

@Repository
public class MailDAO implements InterMailDAO{
	@Autowired 
	private SqlSessionTemplate sqlsession;

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	@Override
	public List<EmployeesVO> searchReceive(HashMap<String, String> paraMap) {
		List<EmployeesVO> receiveList = sqlsession.selectList("mail.searchReceive",paraMap);
		return receiveList;
	}
}
