package com.spring.groupware.commonVO;

public class AlbumVO {// album게시글 VO(리스트, 상세페이지, 수정시에 사용)]
	private String album_seq; // album게시글 번호
	private String album_category; // album게시글 번호
	private String category_name; // album게시글 항목 (album_category랑 join)
	private String fk_employee_seq; // 작성자 사원 번호
	private String employee_name; // 작성자명 (employees_table이랑 join)
	private String employee_id; // 작성자ID (employees_table이랑 join)
	private String subject; // 제목
	private String content; // 내용(이미지 포함)
	private String regDate; // 작성날짜
	
	private String previousseq;      // 이전글번호
	private String previoussubject;  // 이전글제목
	private String nextseq;          // 다음글번호
	private String nextsubject;      // 다음글제목
	
	public String getAlbum_seq() {
		return album_seq;
	}
	
	public void setAlbum_seq(String album_seq) {
		this.album_seq = album_seq;
	}
	
	public String getCategory_name() {
		return category_name;
	}

	public String getAlbum_category() {
		return album_category;
	}

	public void setAlbum_category(String album_category) {
		this.album_category = album_category;
	}

	public void setCategory_name(String category_name) {
		this.category_name = category_name;
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
	
	
}
