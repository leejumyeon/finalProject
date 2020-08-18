package com.spring.groupware.cha.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

public interface ChaInterService {
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 캘린더
	List<PersonalCalVO> fullCalendar();
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 추가
	int insertFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정수정
	int updateFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정삭제
	int deleteFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(동호회) - 뿌리기
	List<HashMap<String,String>> club(HashMap<String, String> paraMap);

	// 관리자 메인페이지(회사 일정 캘린더) - 일정
	List<CompanyCalVO> adminFullCalendar();
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가
	int insertAdminCalendar(HashMap<String, String> paraMap);
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	int updateAdminCalendar(HashMap<String, String> paraMap);
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	int deleteAdminCalendar(HashMap<String, String> paraMap);
	
	

	
	
	
	
	
	
	
	

	


}
