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

	// 회사 일정
	List<CompanyCalVO> adminFullCalendar();

	
	
	
	
	
	
	
	

	


}
