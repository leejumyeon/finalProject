package com.spring.groupware.cha.model;

import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.PersonalCalVO;

@Repository
public class ChaDAO implements ChaInterDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	@Override
	public List<PersonalCalVO> fullCalendar() {
		
		List<PersonalCalVO> perCalvo = sqlsession.selectList("cha.fullCalendar");
		
		return perCalvo;
	}

}
