package com.spring.groupware.commonVO;

public class ReservationVO {//예약 신청VO
	private String reservation_seq; //예약번호
	private String fk_employee_seq; //예약 신청자
	private String employee_name; // 신청자 사원명(employees_table이랑 join)
	private String position_name; // 신청자 직책명(position_table이랑 join)
	private String department_name;// 신청자 부서명(department_table이랑 join)
	private String fk_roomNumber;// 예약장소 번호(회의실 번호)
	private String roomName;// 예약장소 이름(회의실 이름)
	private String startDate;// 사용시작 시간(년-월-일 시-분-초)
	private String endDate;// 사용종료 시간(년-월-일 시-분-초)
	private String head_seq;// 예약 대표자(사원번호)
	private String head_name;// 예약 대표자 사원명(head값과 employees_table이랑 join)
	private String head_position; // 예약 대표자 직책
	private String head_department; // 예약 대표자 부서
	private String memberCount;// 사용 인원
	private String reason;// 사유
	private String status;// 승인상태
	// head 대표자에 해당하는 사원번호, 직책, 부서 등등 필요?? //
}
