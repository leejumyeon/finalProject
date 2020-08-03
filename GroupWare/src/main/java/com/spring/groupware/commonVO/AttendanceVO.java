package com.spring.groupware.commonVO;

public class AttendanceVO { // 출퇴근 테이블
	private String fk_employee_seq; // 사원번호
	private String employee_name; // 사원명(employees_table이랑 join)
	private String position_name; // 직책명(position_table이랑 join)
	private String department_name; // 부서명(department_table이랑 join)
	private String onTime; // 출근시간(년-월-일 시-분-초)
	private String offTime;	// 퇴근시간(년-월-일 시-분-초)
	
	
	
}
