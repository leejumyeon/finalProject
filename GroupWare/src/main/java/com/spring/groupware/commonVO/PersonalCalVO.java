package com.spring.groupware.commonVO;

public class PersonalCalVO {//개인일정 VO
	private String calendar_seq; //일정 번호
	private String fk_employee_seq; //일정을 갖는 사원번호
	private String title; //일정 제목
	private String content; //일정 내용
	private String startDate; //일정 시작날짜
	private String endDate; //일정 종료날짜
	private String color; //색상
}
