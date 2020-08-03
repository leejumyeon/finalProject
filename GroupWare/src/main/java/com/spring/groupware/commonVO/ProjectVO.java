package com.spring.groupware.commonVO;

public class ProjectVO { //프로젝트 내용 VO
	private String project_seq; // 프로젝트 번호
	private String project_name; // 프로젝트 명
	private String content; // 프로젝트 내용(?? html?)
	private String term; // 프로젝트 기간
	private String startDate; // 프로젝트 시작 날짜
	private String manager; // 프로젝트 책임자(이름? id?)
	private String memberCount; // 프로젝트 참가 인원수
	private String downPayment; // 계약금
	private String middlePayment; // 중도금
	private String completionPayment; // 완료금
	private String goupno; // 문서결재 테이블과 연동하는 용도
	private String documentStatus; // 연결되어있는 결재문서의 승인상태 값과 연동??(0:결재 진행중, 1:결재완료, 삭제:결재반려)
	// 프로젝트 신청시 project_table에 행 추가
	// 프로젝트 결과시 project_table의 행 업데이트(중도 결과시 term / middlePayment 업데이트 , 완료금 null?)
}
