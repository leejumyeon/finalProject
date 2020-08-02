package com.spring.groupware.commonVO;

public class AlbumVO {
	private String album_seq; // album게시글 번호
	private String category_name; // album게시글 항목 (album_category랑 join)
	private String employee_name; // 작성자명 (employees_table이랑 join)
	private String position_name; // 작성자 직책 ( position_table이랑 join)
	private String department_name; // 작성자 부서 (department_table이랑 join)
	private String employee_id; // 작성자ID (employees_table이랑 join)
	private String subject; // 제목
	private String content; // 내용(이미지 포함)
	private String representative_img; // 대표 이미지(리스트로 사용할 것)
	
	// 생성자 //
	public AlbumVO() {}
	public AlbumVO(String album_seq, String category_name, String employee_name, String position_name,
			String department_name, String employee_id, String subject, String content, String representative_img) {
		super();
		this.album_seq = album_seq;
		this.category_name = category_name;
		this.employee_name = employee_name;
		this.position_name = position_name;
		this.department_name = department_name;
		this.employee_id = employee_id;
		this.subject = subject;
		this.content = content;
		this.representative_img = representative_img;
	}
	
	// album_seq //
	public String getAlbum_seq() {
		return album_seq;
	}
	public void setAlbum_seq(String album_seq) {
		this.album_seq = album_seq;
	}
	
	// category_name //
	public String getCategory_name() {
		return category_name;
	}
	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
	
	// employee_name //
	public String getEmployee_name() {
		return employee_name;
	}
	public void setEmployee_name(String employee_name) {
		this.employee_name = employee_name;
	}
	
	// position_name //
	public String getPosition_name() {
		return position_name;
	}
	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}
	
	// department_name //
	public String getDepartment_name() {
		return department_name;
	}
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}
	
	// employee_id //
	public String getEmployee_id() {
		return employee_id;
	}
	public void setEmployee_id(String employee_id) {
		this.employee_id = employee_id;
	}
	
	// subject //
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	// content //
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	// representativ_img //
	public String getRepresentative_img() {
		return representative_img;
	}
	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}
	
	
	
	
}
