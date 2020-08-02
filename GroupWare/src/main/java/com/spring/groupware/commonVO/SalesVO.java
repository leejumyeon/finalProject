package com.spring.groupware.commonVO;

public class SalesVO {
	private String sales_seq; //매출 번호
	private String sales_title; //매출 제목
	private String sales_price; //매출 가격(단가? / 총가?)
	private String sales_count;// 매출 물품 개수
	private String reason;// 매출 사유 = 내용
	private String fk_department_seq;// 매출 부서번호
	private String department_name;// 매출 부서명
	private String regDate; //매출 날짜
}
