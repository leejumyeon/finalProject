package com.spring.groupware.commonVO;

public class TripVO {
	private String trip_seq; // 휴가/출장 번호
	private String trip_category; // 휴가/출장 항목
	private String category_name; // 휴가/출장 항목명(trip_category랑 join)
	private String reason; // 휴가/출장 사유
	private String trip_start; // 휴가/출장 시작날짜(년-월-일)
	private String trip_end; // 휴가/출장 복귀날짜(년-월-일)
	private String fk_employee_seq; // 휴가/출장 대상 사원번호
	private String employee_name; // 휴가/출장 대상 사원명(employees_table이랑 join) 
	private String position_name; // 휴가/출장 대상 사원직책(position_table이랑 join)
	private String department_name; // 휴가/출장 대상 사원부서명(department_table이랑 join)
}
