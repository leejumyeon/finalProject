package com.spring.groupware.cha.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.cha.model.ChaInterDAO;
import com.spring.groupware.commonVO.PersonalCalVO;

@Service
public class ChaService implements ChaInterService {
	
	@Autowired
	private ChaInterDAO dao;
	
	// 회사 일정 캘린더
	@Override
	public List<PersonalCalVO> fullCalendar() {
		
		List<PersonalCalVO> perCalvo = dao.fullCalendar();
		
		return perCalvo;
	}

}
