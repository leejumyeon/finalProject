package com.spring.groupware.commonVO;

public class MailVO {//메일함 VO
	private String mail_seq; // 메일 번호
	private String fk_employee_seq; // 수신 또는 발신 사원 번호
	private String mail_groupno; // 송/수신 그룹번호
	private String email; // 수신 또는 발신 사원 이메일(employees_table이랑 join)
	private String subject; // 메일 제목
	private String content; // 메일 내용
	private String fileName1; // 메일 첨부파일명1
	private String orgFileName1; // 메일 첨부파일 원래파일명1
	private String fileSize1; // 첨부파일 크기1
	private String fileName2; // 메일 첨부파일명2
	private String orgFileName2; // 메일 첨부파일 원래파일명2
	private String fileSize2; // 첨부파일 크기2
	private String fileName3; // 메일 첨부파일명3
	private String orgFileName3; // 메일 첨부파일 원래파일명3
	private String fileSize3; // 첨부파일 크기3
	private String status; //발신 / 수신 상태(1:발신 0:수신)
	private String readStatus; //읽은 상태 유무(0:미독, 1:기독)
	private String mailStatus; //삭제유무상태(1:보존, 0:삭제)
	private String regDate; //작성 날짜
	
	private String employee_name;
	private String position_name;
	private String department_name;
	
	// 보낸 메일함, 받은 메일함 모두 제목 내용 보여주는것은 똑같고 수신 발신 이메일만 다르게 적용)
	
	public String getMail_seq() {
		return mail_seq;
	}
	public void setMail_seq(String mail_seq) {
		this.mail_seq = mail_seq;
	}
	
	public String getFk_employee_seq() {
		return fk_employee_seq;
	}
	public void setFk_employee_seq(String fk_employee_seq) {
		this.fk_employee_seq = fk_employee_seq;
	}
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getFileName1() {
		return fileName1;
	}
	public void setFileName1(String fileName1) {
		this.fileName1 = fileName1;
	}
	
	public String getOrgFileName1() {
		return orgFileName1;
	}
	public void setOrgFileName1(String orgFileName1) {
		this.orgFileName1 = orgFileName1;
	}
	
	public String getFileSize1() {
		return fileSize1;
	}
	public void setFileSize1(String fileSize1) {
		this.fileSize1 = fileSize1;
	}
	
	public String getFileName2() {
		return fileName2;
	}
	public void setFileName2(String fileName2) {
		this.fileName2 = fileName2;
	}
	
	public String getOrgFileName2() {
		return orgFileName2;
	}
	public void setOrgFileName2(String orgFileName2) {
		this.orgFileName2 = orgFileName2;
	}
	
	public String getFileSize2() {
		return fileSize2;
	}
	public void setFileSize2(String fileSize2) {
		this.fileSize2 = fileSize2;
	}
	
	public String getFileName3() {
		return fileName3;
	}
	public void setFileName3(String fileName3) {
		this.fileName3 = fileName3;
	}
	
	public String getOrgFileName3() {
		return orgFileName3;
	}
	public void setOrgFileName3(String orgFileName3) {
		this.orgFileName3 = orgFileName3;
	}
	
	public String getFileSize3() {
		return fileSize3;
	}
	public void setFileSize3(String fileSize3) {
		this.fileSize3 = fileSize3;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getReadStatus() {
		return readStatus;
	}
	public void setReadStatus(String readStatus) {
		this.readStatus = readStatus;
	}
	
	public String getMailStatus() {
		return mailStatus;
	}
	public void setMailStatus(String mailStatus) {
		this.mailStatus = mailStatus;
	}
	
	public String getMail_groupno() {
		return mail_groupno;
	}
	public void setMail_groupno(String mail_groupno) {
		this.mail_groupno = mail_groupno;
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
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	
	
	
}
