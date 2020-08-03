package com.spring.groupware.commonVO;

public class ProjectMemberVO { //프로젝트 명단VO
	private String projectMember_seq; // 프로젝트 명단 번호
	private String fk_project_seq; // 프로젝트 번호
	private String project_name; // 프로젝트 명
	private String fk_employee_seq; // 참가 사원번호
	private String employee_name; // 사원명(employees_table이랑 join)
	private String position_name; // 참가 사원직책(position_table이랑 join)
	private String department_name; // 참가 사원부서(department_table이랑 join)
}
