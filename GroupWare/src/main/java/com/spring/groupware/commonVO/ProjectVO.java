package com.spring.groupware.commonVO;

public class ProjectVO {
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
	// 프로젝트 진행 상태 컬럼 필요?? //
	// 프로젝트 신청시 project_table에 행 추가
	// 프로젝트 결과시 project_table의 행 업데이트(중도 결과시 term / middlePayment 업데이트 , 완료금 null?)
}
