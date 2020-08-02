package com.spring.groupware.commonVO;

public class DocumentVO {
	private String document_seq; // 결재 문서번호
	private String fk_employee_seq; // 결재 신청자 사원번호
	private String employee_name; // 결재 신청자 사원명
	private String position_name; // 결재 신청자 직책명
	private String department_name; // 결재 신청자 부서명
	private String subject; // 결재 문서제목
	private String content; // 결재 문서내용(html?)
	private String regDate; // 결재 신청날짜
	private String approver; // 결재자(이름? id?)
	private String parent_approver; // 상위 결재자(이름? id?)
	private String status; // 결재 상태(승인, 미승인, 반려)
	private String document_category; // 결재문서 항목번호
	private String category_name; // 결재문서 항목명
	
	// 결재승인 날짜 필요?? //
	// 결재자와 상위 결재자 이름만이 아니라 부서 직책 필요?? //
	// 3명 결재 = 3개 행?? //
}
