package com.spring.groupware.commonVO;

public class FireVO { //퇴직 사유 VO
	private String fk_employee_seq; // 퇴사 사원 번호
	private String employee_name; // 퇴사 사원명
	private String position_name; // 퇴사 사원직책
	private String department_name; // 퇴사 사원부서명
	private String reason; // 퇴사 사유
	private String groupno; // 문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
}
