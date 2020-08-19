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
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	/*
		=== #148. 파일을 첨부하도록 VO 수정하기
			먼저, 오라클에서 tblBoard 테이블에 3개 컬럼(fileName, orgFilename, fileSize)을 추가한 다음에 아래의 작업을 한다.
	*/
	private String fileName;		// WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
	private String orgFilename;		// 진짜 파일명(강아지.png)  // 사용자가 파일을 업로드 하거나 파일을 다운로드할 때 사용되는 파일명 
	private String fileSize;		// 파일크기
	
	private MultipartFile attach;	// form 태그에서 type="file" 인 파일을 받아서 저장되는 필드이다. 진짜 파일 ==> WAS(톰캣) 디스크에 저장됨.
	// !!!!!! MultipartFile attach 는 오라클 데이터베이스 tblBoard 테이블의 컬럼이 아니다.!!!!!!  
	// jsp 파일에서 input type="file" 인 name 의 이름(attach)과 동일해야만 파일첨부가 가능해진다.!!!!
	
	
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

	public String getPreviousseq() {
		return previousseq;
	}

	public void setPreviousseq(String previousseq) {
		this.previousseq = previousseq;
	}

	public String getPrevioussubject() {
		return previoussubject;
	}

	public void setPrevioussubject(String previoussubject) {
		this.previoussubject = previoussubject;
	}

	public String getNextseq() {
		return nextseq;
	}

	public void setNextseq(String nextseq) {
		this.nextseq = nextseq;
	}

	public String getNextsubject() {
		return nextsubject;
	}

	public void setNextsubject(String nextsubject) {
		this.nextsubject = nextsubject;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
}
