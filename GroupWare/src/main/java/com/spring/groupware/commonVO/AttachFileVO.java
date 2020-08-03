package com.spring.groupware.commonVO;

public class AttachFileVO { //게시글 첨부파일VO
	private String file_seq; //첨부파일 번호
	private String fk_board_seq; // 게시글 번호
	private String fileName; // 업로드 파일명
	private String orgFileName; // 기존 파일명
	private String fileSize; // 파일크기

}
