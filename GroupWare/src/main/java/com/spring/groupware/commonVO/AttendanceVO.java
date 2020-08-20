package com.spring.groupware.commonVO;

public class AttendanceVO { // 출퇴근 테이블
	private String fk_employee_seq; // 사원번호
	private String employee_name; // 사원명(employees_table이랑 join)
	private String position_name; // 직책명(position_table이랑 join)
	private String department_name; // 부서명(department_table이랑 join)
	private String onTime; // 출근시간(년-월-일 시-분-초)
	private String offTime;	// 퇴근시간(년-월-일 시-분-초)
	public String getFk_employee_seq() {
		return fk_employee_seq;
	}
	public void setFk_employee_seq(String fk_employee_seq) {
		this.fk_employee_seq = fk_employee_seq;
	}
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	public String getOnTime() {
		return onTime;
	}
	public void setOnTime(String onTime) {
		this.onTime = onTime;
	}
	public String getOffTime() {
		return offTime;
	}
	public void setOffTime(String offTime) {
		this.offTime = offTime;
	}
	
	
	
}
