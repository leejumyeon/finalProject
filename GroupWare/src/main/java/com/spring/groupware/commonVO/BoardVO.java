package com.spring.groupware.commonVO;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO { //게시글 VO
	private String board_seq; //게시글 번호
	private String fk_category_num; //게시글 카테고리 번호
	private String category_name; //게시글 카테고리 명
	private String subject; //게시글 제목
	private String content; //게시글 내용(이미지 포함)
	private String readCnt; //게시글 조회수
	private String regDate; //게시글 등록날짜
	private String fk_employee_seq; //작성자 번호
	private String employee_name; // 작성자 사원명
	private String employee_id; //작성자 사원ID
	private String status; //게시글 상태
	private String commentCnt; //댓글 수	
	
	
	
	public BoardVO() {}
	
	public BoardVO(String board_seq, String fk_category_num, String category_name, String subject, String content,
			String readCnt, String regDate, String fk_employee_seq, String employee_name, String employee_id,
			String status, String commentCnt) {
		super();
		this.board_seq = board_seq;
		this.fk_category_num = fk_category_num;
		this.category_name = category_name;
		this.subject = subject;
		this.content = content;
		this.readCnt = readCnt;
		this.regDate = regDate;
		this.fk_employee_seq = fk_employee_seq;
		this.employee_name = employee_name;
		this.employee_id = employee_id;
		this.status = status;
		this.commentCnt = commentCnt;
	}

	public String getBoard_seq() {
		return board_seq;
	}

	public void setBoard_seq(String board_seq) {
		this.board_seq = board_seq;
	}

	public String getFk_category_num() {
		return fk_category_num;
	}

	public void setFk_category_num(String fk_category_num) {
		this.fk_category_num = fk_category_num;
	}

	public String getCategory_name() {
		return category_name;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
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

	public String getReadCnt() {
		return readCnt;
	}

	public void setReadCnt(String readCnt) {
		this.readCnt = readCnt;
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

	public String getEmployee_id() {
		return employee_id;
	}

	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(String commentCnt) {
		this.commentCnt = commentCnt;
	}
	
	
	
	
	
	
	
}
