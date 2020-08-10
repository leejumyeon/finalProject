package com.spring.groupware.commonVO;

public class MessengerRoomVO { //메신저 그룹 VO
	private String roomNumber; // 그룹번호
	private String fk_employee_seq; // 참가자 사원번호
	private String employee_name; // 참가자 사원명
	private String regDate; // 추가날짜
	
	
	public String getRoomNumber() {
		return roomNumber;
	}
	
	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
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
	
	public String getRegDate() {
		return regDate;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
	
}
