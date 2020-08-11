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
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 캘린더
	@Override
	public List<PersonalCalVO> fullCalendar() {
		
		List<PersonalCalVO> perCalvo = dao.fullCalendar();
		
		return perCalvo;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 추가
	@Override
	public int insertFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.insertFullCalendar(paraMap);
		
		return n;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 수정
	@Override
	public int updateFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.updateFullCalendar(paraMap);
		
		return n;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 삭제
	@Override
	public int deleteFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.deleteFullCalendar(paraMap);
		
		return n;
	}

	// 관리자 메인페이지(회사 일정 캘린더) - 회사 일정 캘린더
	@Override
	public List<CompanyCalVO> adminFullCalendar() {

		List<CompanyCalVO> comCalvo = dao.adminFullCalendar();
		
		return comCalvo;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가
	@Override
	public int insertAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.insertAdminCalendar(paraMap);
		
		return n;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	@Override
	public int updateAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.updateAdminCalendar(paraMap);
		
		return n;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	@Override
	public int deleteAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.deleteAdminCalendar(paraMap);
		
		return n;
	}

	
	

	
	

	


	

}
