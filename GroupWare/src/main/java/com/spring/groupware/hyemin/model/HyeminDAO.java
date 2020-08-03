package com.spring.groupware.hyemin.model;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

//=== #32. DAO 선언 ===
@Repository
public class HyeminDAO implements InterHyeminDAO {

	// === #33. 의존객체 주입하기(DI) ===
//	@Resource
//	private SqlSessionTemplate ;
	
}
