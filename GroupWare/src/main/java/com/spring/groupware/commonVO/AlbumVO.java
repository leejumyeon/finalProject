package com.spring.groupware.commonVO;

public class AlbumVO {// album게시글 VO(리스트, 상세페이지, 수정시에 사용)
	private String album_seq; // album게시글 번호
	private String category_name; // album게시글 항목 (album_category랑 join)
	private String employee_name; // 작성자명 (employees_table이랑 join)
	private String employee_id; // 작성자ID (employees_table이랑 join)
	private String subject; // 제목
	private String content; // 내용(이미지 포함)
	
	
	
}
