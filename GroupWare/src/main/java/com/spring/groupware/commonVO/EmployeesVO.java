package com.spring.groupware.commonVO;

public class EmployeesVO {
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
	private String grade; // 권한등급
	
	// 사수 컬럼 필요?? //
	// 개인정보(나이, 성별, 생년월일) 필요?? //
	
	// 생성자 //
	public EmployeesVO() {}
	public EmployeesVO(String employee_seq, String employee_name,String employee_id, String employee_pw, String email, String phone,
			String status_name, String hire_date, String fire_date, String position_name, String department_name,
			String grade) {
		this.employee_seq = employee_seq;
		this.employee_name = employee_name;
		this.employee_id = employee_id;
		this.employee_pw = employee_pw;
		this.email = email;
		this.phone = phone;
		this.status_name = status_name;
		this.hire_date = hire_date;
		this.fire_date = fire_date;
		this.position_name = position_name;
		this.department_name = department_name;
		this.grade = grade;
	}
	
	// employee_seq //
	public String getEmployee_seq() {
		return employee_seq;
	}
	public void setEmployee_seq(String employee_seq) {
		this.employee_seq = employee_seq;
	}
	
	// employee_name //
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	
	// employee_id //
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	
	// employee_pw //
	public String getEmployee_pw() {
		return employee_pw;
	}
	public void setEmployee_pw(String employee_pw) {
		this.employee_pw = employee_pw;
	}
	
	// email //
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	// phone //
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	// status_name //
	public String getStatus_name() {
		return status_name;
	}
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	
	// hire_date //
	public String getHire_date() {
		return hire_date;
	}
	public void setHire_date(String hire_date) {
		this.hire_date = hire_date;
	}
	
	// fire_date //
	public String getFire_date() {
		return fire_date;
	}
	public void setFire_date(String fire_date) {
		this.fire_date = fire_date;
	}
	
	// position_name //
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	
	// department_name //
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	
	// grade //
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	
	
}
