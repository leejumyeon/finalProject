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
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동 (0:결재 진행중, 1:결재완료, 삭제:결재반려)
	
	private String previousattitude;
	private String previousattendance;
	private String previousperformance;
	
	public String getTa_seq() {
		return ta_seq;
	}
	
	public void setTa_seq(String ta_seq) {
		this.ta_seq = ta_seq;
	}

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

	public String getAttendance() {
		return attendance;
	}

	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}

	public String getAttitude() {
		return attitude;
	}

	public void setAttitude(String attitude) {
		this.attitude = attitude;
	}

	public String getPerformance() {
		return performance;
	}

	public void setPerformance(String performance) {
		this.performance = performance;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}

	public String getDocumentStatus() {
		return documentStatus;
	}

	public void setDocumentStatus(String documentStatus) {
		this.documentStatus = documentStatus;
	}

	public String getPreviousattitude() {
		return previousattitude;
	}

	public void setPreviousattitude(String previousattitude) {
		this.previousattitude = previousattitude;
	}

	public String getPreviousattendance() {
		return previousattendance;
	}

	public void setPreviousattendance(String previousattendance) {
		this.previousattendance = previousattendance;
	}

	public String getPreviousperformance() {
		return previousperformance;
	}

	public void setPreviousperformance(String previousperformance) {
		this.previousperformance = previousperformance;
	}
	
}
