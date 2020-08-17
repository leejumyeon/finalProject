package com.spring.groupware.commonVO;

import org.springframework.web.multipart.MultipartFile;

public class DocumentVO { // 결재문서VO
	
	private String document_seq; // 결재 문서번호
	private String fk_employee_seq; // 결재 신청자 사원번호
	private String employee_name; // 결재 신청자 사원명
	private String position_name; // 결재 신청자 직책명
	private String department_name; // 결재 신청자 부서명
	private String subject; // 결재 문서제목
	private String content; // 결재 문서내용(png파일)
	private String regDate; // 결재 신청날짜
	private String approver_seq; // 결재자 사원번호
	private String approver_name; // 결재자 명(employees_table이랑 join)
	private String approver_position; // 결재자 직책(position_table이랑 join)
	private String approver_department; // 결재자 부서(department_table이랑 join)
	private String parent_approver; // 상위 결재자(seq)
	private String status; // 결재 상태(승인, 미승인, 반려)
	private String document_category; // 결재문서 항목번호
	private String category_name; // 결재문서 항목명
	private String approveDate; //결재 날짜
	private String groupno; // 문서 일련 번호
	
	private String fileName;
	private String orgFileName;
	private String fileSize;
	
	private MultipartFile attach;
	
	public DocumentVO() {}

	public DocumentVO(String document_seq, String fk_employee_seq, String employee_name, String position_name,
			String department_name, String subject, String content, String regDate, String approver_seq,
			String approver_name, String approver_position, String approver_department, String parent_approver,
			String status, String document_category, String category_name, String approveDate, String groupno,
			String fileName, String orgFileName, String fileSize, MultipartFile attach) {
		this.document_seq = document_seq;
		this.fk_employee_seq = fk_employee_seq;
		this.employee_name = employee_name;
		this.position_name = position_name;
		this.department_name = department_name;
		this.subject = subject;
		this.content = content;
		this.regDate = regDate;
		this.approver_seq = approver_seq;
		this.approver_name = approver_name;
		this.approver_position = approver_position;
		this.approver_department = approver_department;
		this.parent_approver = parent_approver;
		this.status = status;
		this.document_category = document_category;
		this.category_name = category_name;
		this.approveDate = approveDate;
		this.groupno = groupno;
		this.fileName = fileName;
		this.orgFileName = orgFileName;
		this.fileSize = fileSize;
		this.attach = attach;
	}

	public String getDocument_seq() {
		return document_seq;
	}

	public void setDocument_seq(String document_seq) {
		this.document_seq = document_seq;
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

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getApprover_seq() {
		return approver_seq;
	}

	public void setApprover_seq(String approver_seq) {
		this.approver_seq = approver_seq;
	}

	public String getApprover_name() {
		return approver_name;
	}

	public void setApprover_name(String approver_name) {
		this.approver_name = approver_name;
	}

	public String getApprover_position() {
		return approver_position;
	}

	public void setApprover_position(String approver_position) {
		this.approver_position = approver_position;
	}

	public String getApprover_department() {
		return approver_department;
	}

	public void setApprover_department(String approver_department) {
		this.approver_department = approver_department;
	}

	public String getParent_approver() {
		return parent_approver;
	}

	public void setParent_approver(String parent_approver) {
		this.parent_approver = parent_approver;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDocument_category() {
		return document_category;
	}

	public void setDocument_category(String document_category) {
		this.document_category = document_category;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}

	public String getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(String approveDate) {
		this.approveDate = approveDate;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public String getGroupno() {
		return groupno;
	}

	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	
}
