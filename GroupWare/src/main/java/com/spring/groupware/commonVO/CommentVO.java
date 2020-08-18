package com.spring.groupware.commonVO;

public class CommentVO {
	private String comment_seq; //댓글 번호
	private String fk_board_seq; // 게시글 번호(그룹번호)
	private String fk_employee_seq; // 작성자 번호
	private String employee_name; // 작성자 이름(employees_table이랑 join)
	private String readCnt; // 조회수
	private String content; // 내용
	private String status; // 글상태(1:보존, 0:삭제)
	private String regDate; // 작성날짜
	private String parent_seq; // 상위 댓글(계층형)
	private String depthno; // 답글형 댓글일 경우 상위 글 보다 들여쓰기 하기 위한 용도
	public String getFk_userid;
	
	public String getComment_seq() {
		return comment_seq;
	}
	public void setComment_seq(String comment_seq) {
		this.comment_seq = comment_seq;
	}
	public String getFk_board_seq() {
		return fk_board_seq;
	}
	public void setFk_board_seq(String fk_board_seq) {
		this.fk_board_seq = fk_board_seq;
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
	public String getReadCnt() {
		return readCnt;
	}
	public void setReadCnt(String readCnt) {
		this.readCnt = readCnt;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	public String getParent_seq() {
		return parent_seq;
	}
	public void setParent_seq(String parent_seq) {
		this.parent_seq = parent_seq;
	}
	public String getDepthno() {
		return depthno;
	}
	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}
	public String getGetFk_userid() {
		return getFk_userid;
	}
	public void setGetFk_userid(String getFk_userid) {
		this.getFk_userid = getFk_userid;
	}
	
}

