package com.spring.groupware.cha.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ChaDAO implements ChaInterDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

}
