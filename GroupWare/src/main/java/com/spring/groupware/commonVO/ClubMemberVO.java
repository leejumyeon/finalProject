package com.spring.groupware.commonVO;

public class ClubMemberVO { //동호회 명단 VO
	private String member_seq; // 명단 번호
	private String fk_club; // 가입한 동호회 번호
	private String club_name; // 가입한 동호회명
	private String status; // 상태(0:일반, 1:회장)
	private String regDate; // 가입날짜
	private String fk_employee_seq; // 사원번호
	private String employee_name; // 사원명(employees_table이랑 join)
	private String position_name; // 직책명(position_table이랑 join)
	private String department_name; // 부서명(department_table이랑 join)
	private String groupno; //문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
}
