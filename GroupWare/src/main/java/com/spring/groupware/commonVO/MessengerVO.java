package com.spring.groupware.commonVO;

public class MessengerVO {//메신저 내용VO
	private String message_seq; // 대화번호
	private String content; // 대화 내용
	private String regDate; // 작성날짜
	private String status; // 대화상태(1:존재, 0:삭제)
	private String fk_roomNumber; // 대화방 번호
	private String fk_employee_seq; // 발신자 사원번호
	private String employee_name; // 발신자 사원명(employees_table이랑 join)
	
}
