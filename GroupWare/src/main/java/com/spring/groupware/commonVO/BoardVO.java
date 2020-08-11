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
}
