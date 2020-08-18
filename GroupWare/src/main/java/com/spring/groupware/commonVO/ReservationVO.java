package com.spring.groupware.commonVO;

public class ReservationVO { // 예약 신청VO
	private String reservation_seq;		// 예약번호
	private String fk_employee_seq;		// 예약 신청자
	private String employee_name;		// 신청자 사원명(employees_table이랑 join)
	private String position_name;		// 신청자 직책명(position_table이랑 join)
	private String department_name;		// 신청자 부서명(department_table이랑 join)
	private String fk_roomNumber;		// 예약장소 번호(회의실 번호)
	private String roomName;			// 예약장소 이름(회의실 이름)
	private String startDate;			// 사용시작 시간(년-월-일 시-분-초)
	private String endDate;				// 사용종료 시간(년-월-일 시-분-초)
	private String head_seq;			// 예약 대표자(사원번호)
	private String head_name;			// 예약 대표자 사원명(head값과 employees_table이랑 join)
	private String head_position;		// 예약 대표자 직책
	private String head_department;		// 예약 대표자 부서
	private String memberCount;			// 사용 인원
	private String reason;				// 사유
	private String status;				// 승인상태(0: 승인대기중, 1: 승인완료)	
	private String regDate;				// 예약날짜
	
	
	// 생성자
	public ReservationVO() {}
	public ReservationVO(String reservation_seq, String fk_employee_seq, String employee_name, String position_name,
			String department_name, String fk_roomNumber, String roomName, String startDate, String endDate,
			String head_seq, String head_name, String head_position, String head_department, String memberCount,
			String reason, String status, String regDate) {
		super();
		this.reservation_seq = reservation_seq;
		this.fk_employee_seq = fk_employee_seq;
		this.employee_name = employee_name;
		this.position_name = position_name;
		this.department_name = department_name;
		this.fk_roomNumber = fk_roomNumber;
		this.roomName = roomName;
		this.startDate = startDate;
		this.endDate = endDate;
		this.head_seq = head_seq;
		this.head_name = head_name;
		this.head_position = head_position;
		this.head_department = head_department;
		this.memberCount = memberCount;
		this.reason = reason;
		this.status = status;
		this.regDate = regDate;
	}
	
	
	// Getter & Setter
	public String getReservation_seq() {
		return reservation_seq;
	}
	
	public void setReservation_seq(String reservation_seq) {
		this.reservation_seq = reservation_seq;
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
	
	public String getFk_roomNumber() {
		return fk_roomNumber;
	}
	
	public void setFk_roomNumber(String fk_roomNumber) {
		this.fk_roomNumber = fk_roomNumber;
	}
	
	public String getRoomName() {
		return roomName;
	}
	
	public void setRoomName(String roomName) {
		this.roomName = roomName;
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
	
	public String getHead_seq() {
		return head_seq;
	}
	
	public void setHead_seq(String head_seq) {
		this.head_seq = head_seq;
	}
	
	public String getHead_name() {
		return head_name;
	}
	
	public void setHead_name(String head_name) {
		this.head_name = head_name;
	}
	
	public String getHead_position() {
		return head_position;
	}
	
	public void setHead_position(String head_position) {
		this.head_position = head_position;
	}
	
	public String getHead_department() {
		return head_department;
	}
	
	public void setHead_department(String head_department) {
		this.head_department = head_department;
	}
	
	public String getMemberCount() {
		return memberCount;
	}
	
	public void setMemberCount(String memberCount) {
		this.memberCount = memberCount;
	}
	
	public String getReason() {
		return reason;
	}
	
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	public String getStatus() {			
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}

	public String getRegDate() {
		return regDate;
	}
	
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
}
