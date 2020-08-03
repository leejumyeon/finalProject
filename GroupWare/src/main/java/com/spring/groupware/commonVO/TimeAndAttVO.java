package com.spring.groupware.commonVO;

public class TimeAndAttVO { //근태관리VO
	private String ta_seq; // 근태관리 행 번호
	private String fk_employee_seq; // 대상 사원 번호
	private String employee_name; // 대상 사원명(employees_table이랑 join)
	private String position_name; // 대상 직책명(position_table이랑 join)
	private String department_name; // 대상 부서명(department_table이랑 join)
	private String attendance; // 출결점수
	private String attitude; // 태도점수
	private String performance; // 업무성과 점수
	private String reason; //사유
	private String regDate; // 등록날짜
	private String manager; // 기안자(이름)
	private String groupno; //문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
}
