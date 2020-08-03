package com.spring.groupware.commonVO;

public class SalesVO { // 매출VO
	private String sales_seq; //매출 번호
	private String sales_title; //매출 제목
	private String sales_price; //매출 가격(단가)
	private String sales_count;// 매출 물품 개수
	private String reason;// 매출 사유 = 내용
	private String fk_department_seq;// 매출 부서번호
	private String department_name;// 매출 부서명
	private String regDate; //매출 날짜
	private String groupno; //문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
}
