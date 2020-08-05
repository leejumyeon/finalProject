package com.spring.groupware.commonVO;

public class PersonalCalVO {//개인일정 VO
	private String calendar_seq; //일정 번호
	private String fk_employee_seq; //일정을 갖는 사원번호
	private String title; //일정 제목
	private String content; //일정 내용
	private String startDate; //일정 시작날짜
	private String endDate; //일정 종료날짜
	private String color; //색상
	
	public PersonalCalVO() {}
	
	public PersonalCalVO(String calendar_seq, String fk_employee_seq, String title, String content, String startDate,
			String endDate, String color) {
		this.calendar_seq = calendar_seq;
		this.fk_employee_seq = fk_employee_seq;
		this.title = title;
		this.content = content;
		this.startDate = startDate;
		this.endDate = endDate;
		this.color = color;
	}
	
	public String getCalendar_seq() {
		return calendar_seq;
	}
	public void setCalendar_seq(String calendar_seq) {
		this.calendar_seq = calendar_seq;
	}
	public String getFk_employee_seq() {
		return fk_employee_seq;
	}
	public void setFk_employee_seq(String fk_employee_seq) {
		this.fk_employee_seq = fk_employee_seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	
	
}
