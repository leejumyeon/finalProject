package com.spring.groupware.commonVO;

public class SalesVO { // 매출VO
	private String sales_seq; //매출 번호
	private String sales_title; //매출 제목
	private String sales_price; //매출 가격(단가)
	private String sales_count;// 매출 물품 개수
	private String reason;// 매출 사유 = 내용
	private String fk_department_seq;// 매출 부서번호
	private String department_name;// 매출 부서명
	private String regDate; //매출 날짜
	private String groupno; //문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
	private String sales_total; //매출 가격(개수 * 단가)
	
	public String getSales_seq() {
		return sales_seq;
	}
	public void setSales_seq(String sales_seq) {
		this.sales_seq = sales_seq;
	}
	public String getSales_title() {
		return sales_title;
	}
	public void setSales_title(String sales_title) {
		this.sales_title = sales_title;
	}
	public String getSales_price() {
		return sales_price;
	}
	public void setSales_price(String sales_price) {
		this.sales_price = sales_price;
	}
	public String getSales_count() {
		return sales_count;
	}
	public void setSales_count(String sales_count) {
		this.sales_count = sales_count;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
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
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
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
	public String getSales_total() {
		return sales_total;
	}
	public void setSales_total(String sales_total) {
		this.sales_total = sales_total;
	}
	
	
	
	
}
