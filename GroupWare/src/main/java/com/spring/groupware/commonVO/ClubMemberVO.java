package com.spring.groupware.commonVO;

public class ClubMemberVO { //동호회 명단 VO
	private String member_seq; // 명단 번호
	private String fk_club; // 가입한 동호회 번호
	private String club_name; // 가입한 동호회명
	private String status; // 상태(0:일반, 1:회장)
	private String regDate; // 가입날짜
	private String fk_employee_seq; // 사원번호
	private String employee_name; // 사원명(employees_table이랑 join)
	private String position_name; // 직책명(position_table이랑 join)
	private String department_name; // 부서명(department_table이랑 join)
	private String groupno; //문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
	
	public ClubMemberVO() {}
	
	public ClubMemberVO(String member_seq, String fk_club, String club_name, String status, String regDate,
			String fk_employee_seq, String employee_name, String position_name, String department_name, String groupno,
			String documentStatus) {
		super();
		this.member_seq = member_seq;
		this.fk_club = fk_club;
		this.club_name = club_name;
		this.status = status;
		this.regDate = regDate;
		this.fk_employee_seq = fk_employee_seq;
		this.employee_name = employee_name;
		this.position_name = position_name;
		this.department_name = department_name;
		this.groupno = groupno;
		this.documentStatus = documentStatus;
	}
	public String getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(String member_seq) {
		this.member_seq = member_seq;
	}
	public String getFk_club() {
		return fk_club;
	}
	public void setFk_club(String fk_club) {
		this.fk_club = fk_club;
	}
	public String getClub_name() {
		return club_name;
	}
	public void setClub_name(String club_name) {
		this.club_name = club_name;
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
