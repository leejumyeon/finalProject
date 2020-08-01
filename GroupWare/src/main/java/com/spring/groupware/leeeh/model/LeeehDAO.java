package com.spring.groupware.leeeh.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LeeehDAO implements InterLeeehDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

}
