package com.spring.groupware.commonVO;

public class MessengerVO {//메신저 내용VO
	private String message_seq; // 대화번호
	private String content; // 대화 내용
	private String regDate; // 작성날짜
	private String status; // 대화상태(1:존재, 0:삭제)
	private String fk_roomNumber; // 대화방 번호
	private String fk_employee_seq; // 발신자 사원번호
	private String employee_name; // 발신자 사원명(employees_table이랑 join)
	
	
	public String getMessage_seq() {
		return message_seq;
	}
	
	public void setMessage_seq(String message_seq) {
		this.message_seq = message_seq;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getRegDate() {
		return regDate;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getFk_roomNumber() {
		return fk_roomNumber;
	}
	
	public void setFk_roomNumber(String fk_roomNumber) {
		this.fk_roomNumber = fk_roomNumber;
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
	
	
	
}
