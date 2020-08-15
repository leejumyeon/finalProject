package com.spring.groupware.commonVO;

public class TripVO { // 휴가/출장VO
	private String trip_seq; // 휴가/출장 번호
	private String trip_category; // 휴가/출장 항목
	private String category_name; // 휴가/출장 항목명(trip_category랑 join)
	private String reason; // 휴가/출장 사유
	private String trip_start; // 휴가/출장 시작날짜(년-월-일)
	private String trip_end; // 휴가/출장 복귀날짜(년-월-일)
	private String fk_employee_seq; // 휴가/출장 대상 사원번호
	private String employee_name; // 휴가/출장 대상 사원명(employees_table이랑 join) 
	private String position_name; // 휴가/출장 대상 사원직책(position_table이랑 join)
	private String department_name; // 휴가/출장 대상 사원부서명(department_table이랑 join)
	private String groupno; //문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)

	public String getTrip_seq() {
		return trip_seq;
	}
	public void setTrip_seq(String trip_seq) {
		this.trip_seq = trip_seq;
	}
	public String getTrip_category() {
		return trip_category;
	}
	public void setTrip_category(String trip_category) {
		this.trip_category = trip_category;
	}
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public String getTrip_start() {
		return trip_start;
	}
	public void setTrip_start(String trip_start) {
		this.trip_start = trip_start;
	}
	public String getTrip_end() {
		return trip_end;
	}
	public void setTrip_end(String trip_end) {
		this.trip_end = trip_end;
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
	
	
}
