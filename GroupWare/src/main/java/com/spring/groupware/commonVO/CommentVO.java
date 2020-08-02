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
}
