package com.spring.groupware.leejm.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdditionalDAO implements InterAdditionalDAO {
	@Autowired 
	private SqlSessionTemplate sqlsession;
}
