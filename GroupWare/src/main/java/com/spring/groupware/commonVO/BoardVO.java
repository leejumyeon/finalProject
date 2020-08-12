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
	private String fileName;	// WAS(톰캣)에 저장될 파일명
	private String orgFilename;	// 진짜 파일명
	private String fileSize;	// 파일크기	
	private MultipartFile attach;
	private String seq;
	private String fk_userid;
	private String name;
	private String pw;
	private String readCount;
	private String previousseq;
	private String previoussubject;
	private String nextseq;
	private String nextsubject;
	private String groupno;
	private String fk_seq;
	private String depthno;
	
	public BoardVO() { }
	public BoardVO(String seq, String fk_userid, String name, String subject, String content, String pw,
			String readCount, String regDate, String status, String previousseq, String previoussubject, String nextseq,
			String nextsubject,
			String groupno, String fk_seq, String depthno,
			String fileName, String orgFilename, String fileSize) {
		this.seq = seq;
		this.fk_userid = fk_userid;
		this.name = name;
		this.subject = subject;
		this.content = content;
		this.pw = pw;
		this.readCount = readCount;
		this.regDate = regDate;
		this.status = status;
		this.previousseq = previousseq;
		this.previoussubject = previoussubject;
		this.nextseq = nextseq;
		this.nextsubject = nextsubject;
		this.groupno = groupno;
		this.fk_seq = fk_seq;
		this.depthno = depthno;
		this.fileName = fileName;
		this.orgFilename = orgFilename;
		this.fileSize = fileSize;
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
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public String getOrgFilename() {
		return orgFilename;
	}
	public void setOrgFilename(String orgFilename) {
		this.orgFilename = orgFilename;
	}
	public String getFileSize() {
		return fileSize;
	}
	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	public MultipartFile getAttach() {
		return attach;
	}
	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getFk_userid() {
		return fk_userid;
	}
	public void setFk_userid(String fk_userid) {
		this.fk_userid = fk_userid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getReadCount() {
		return readCount;
	}
	public void setReadCount(String readCount) {
		this.readCount = readCount;
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
	public String getGroupno() {
		return groupno;
	}
	public void setGroupno(String groupno) {
		this.groupno = groupno;
	}
	public String getFk_seq() {
		return fk_seq;
	}
	public void setFk_seq(String fk_seq) {
		this.fk_seq = fk_seq;
	}
	public String getDepthno() {
		return depthno;
	}
	public void setDepthno(String depthno) {
		this.depthno = depthno;
	}
	
}
