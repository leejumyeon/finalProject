package com.spring.groupware.cha.model;

import java.util.List;

import com.spring.groupware.commonVO.PersonalCalVO;

public interface ChaInterDAO {
	
	// 회사 일정 캘린더
	List<PersonalCalVO> fullCalendar();

}
