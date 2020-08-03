package com.spring.groupware.commonVO;

public class EmployeesVO { // 사원정보VO
	private String employee_seq; // 사원번호
	private String employee_name; //사원명
	private String employee_id; // 사원ID
	private String employee_pw; // 사원PW
	private String email; // 사내 이메일
	private String phone; // 핸드폰 번호
	private String status_name; // 회원상태 (employeeStatus_table이랑 join)
	private String hire_date; // 입사날짜
	private String fire_date; // 퇴사날짜
	private String position_name; // 직책명 (position_table이랑 join)
	private String department_name; // 부서명 (department_table이랑 join)
	private String gender; //성별(남, 여)
	private String birthday; //생년월일(YYYYMMDD)
	private String address; //주소
	private String postcode; //우편번호
	private String detailaddress; //상세주소
	private String grade; // 권한등급
	private String club_name; //가입한 동호회 명( ex.동호회1, 동호회2)
	
	
	
	
	
}
