package com.spring.groupware.cha.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

public interface ChaInterDAO {
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 캘린더
	List<PersonalCalVO> fullCalendar();
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 추가
	int insertFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 수정
	int updateFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 삭제
	int deleteFullCalendar(HashMap<String, String> paraMap);

	// 회사 일정 캘린더
	List<CompanyCalVO> adminFullCalendar();

	
	
	
	
	
	


}
