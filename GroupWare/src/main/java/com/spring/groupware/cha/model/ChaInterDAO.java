package com.spring.groupware.cha.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

public interface ChaInterDAO {
	
	// 개인 일정 캘린더
	List<PersonalCalVO> fullCalendar();

	// 회사 일정 캘린더
	List<CompanyCalVO> adminFullCalendar();
	
	// 일정추가
	int insertFullCalendar(HashMap<String, String> paraMap);
	
	
	


}
