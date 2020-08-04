package com.spring.groupware.cha.service;

import java.util.List;

import com.spring.groupware.commonVO.PersonalCalVO;

public interface ChaInterService {
	
	// 회사 일정 캘린더
	List<PersonalCalVO> fullCalendar();

}
