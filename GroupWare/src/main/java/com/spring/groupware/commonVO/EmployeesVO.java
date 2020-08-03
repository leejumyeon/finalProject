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
	
	public String getEmployee_seq() {
		return employee_seq;
	}
	
	public void setEmployee_seq(String employee_seq) {
		this.employee_seq = employee_seq;
	}
	
	public String getEmployee_name() {
		return employee_name;
	}
	
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	
	public String getEmployee_id() {
		return employee_id;
	}
	
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	
	public String getEmployee_pw() {
		return employee_pw;
	}
	
	public void setEmployee_pw(String employee_pw) {
		this.employee_pw = employee_pw;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getStatus_name() {
		return status_name;
	}
	
	public void setStatus_name(String status_name) {
		this.status_name = status_name;
	}
	
	public String getHire_date() {
		return hire_date;
	}
	
	public void setHire_date(String hire_date) {
		this.hire_date = hire_date;
	}
	
	public String getFire_date() {
		return fire_date;
	}
	
	public void setFire_date(String fire_date) {
		this.fire_date = fire_date;
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
	
	public String getGender() {
		return gender;
	}
	
	public void setGender(String gender) {
		this.gender = gender;
	}
	
	
	public String getBirthday() {
		return birthday;
	}
	
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getPostcode() {
		return postcode;
	}
	
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	
	public String getDetailaddress() {
		return detailaddress;
	}
	
	public void setDetailaddress(String detailaddress) {
		this.detailaddress = detailaddress;
	}
	
	public String getGrade() {
		return grade;
	}
	
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String getClub_name() {
		return club_name;
	}
	
	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}
	
	
	
	
	
}
