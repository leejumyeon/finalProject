package com.spring.groupware.leejm.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MailDAO {
	@Autowired 
	private SqlSessionTemplate sqlsession;
}
