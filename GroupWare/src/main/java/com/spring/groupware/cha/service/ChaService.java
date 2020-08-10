package com.spring.groupware.cha.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.cha.model.ChaInterDAO;
import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

@Service
public class ChaService implements ChaInterService {
	
	@Autowired
	private ChaInterDAO dao;
	
	// 개인 일정 캘린더
	@Override
	public List<PersonalCalVO> fullCalendar() {
		
		List<PersonalCalVO> perCalvo = dao.fullCalendar();
		
		return perCalvo;
	}

	// 회사 일정 캘린더
	@Override
	public List<CompanyCalVO> adminFullCalendar() {

		List<CompanyCalVO> comCalvo = dao.adminFullCalendar();
		
		return comCalvo;
	}
	
	// 일정추가
	@Override
	public int insertFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.insertFullCalendar(paraMap);
		
		return n;
	}
	
	

	


	

}
