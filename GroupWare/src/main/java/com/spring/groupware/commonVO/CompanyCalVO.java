package com.spring.groupware.commonVO;

public class CompanyCalVO {//회사일정VO
	private String comCalendar_seq; //일정 번호
	private String title; //일정 제목
	private String content; //일정 내용
	private String startDate; //일정 시작날짜
	private String endDate; //일정 종료날짜
	private String backgroundColor; //색상
	private String fk_department_seq; //부서번호
	private String department_name; //부서명
	private String calendar_category; //회사일정 항목번호
	private String category_name; //회사일정 항목 이름

	public String getComCalendar_seq() {
		return comCalendar_seq;
	}
	public void setComCalendar_seq(String comCalendar_seq) {
		this.comCalendar_seq = comCalendar_seq;
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
	public String getBackgroundColor() {
		return backgroundColor;
	}
	public void setBackgroundColor(String backgroundColor) {
		this.backgroundColor = backgroundColor;
	}
	public String getFk_department_seq() {
		return fk_department_seq;
	}
	public void setFk_department_seq(String fk_department_seq) {
		this.fk_department_seq = fk_department_seq;
	}
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	public String getCalendar_category() {
		return calendar_category;
	}
	public void setCalendar_category(String calendar_category) {
		this.calendar_category = calendar_category;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	
}
