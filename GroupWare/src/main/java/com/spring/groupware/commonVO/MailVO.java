package com.spring.groupware.commonVO;

public class MailVO {
	private String mail_seq; // 메일 번호
	private String fk_employee_seq; // 수신 또는 발신 사원 번호
	private String email; // 수신 또는 발신 사원 이메일(employees_table이랑 join)
	private String subject; // 메일 제목
	private String content; // 메일 내용
	private String fileName1; // 메일 첨부파일명1
	private String orgFileName1; // 메일 첨부파일 원래파일명1
	private String fileSize1; // 첨부파일 크기1
	private String fileName2; // 메일 첨부파일명2
	private String orgFileName2; // 메일 첨부파일 원래파일명2
	private String fileSize2; // 첨부파일 크기2
	private String fileName3; // 메일 첨부파일명3
	private String orgFileName3; // 메일 첨부파일 원래파일명3
	private String fileSize3; // 첨부파일 크기3
	
	// 보낸 메일함, 받은 메일함 모두 제목 내용 보여주는것은 똑같고 수신 발신 이메일만 다르게 적용)
}
