package com.spring.groupware.commonVO;

public class ClubMemberVO {
	private String member_seq; // 명단 번호
	private String fk_club; // 가입한 동호회 번호
	private String club_name; // 가입한 동호회명
	private String status; // 상태(0:일반, 1:회장)
	private String regDate; // 가입날짜
	private String fk_employee_seq; // 사원번호
	private String employee_name; // 사원명(employees_table이랑 join)
}
