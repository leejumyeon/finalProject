package com.spring.groupware.commonVO;

public class DepartmentVO {
	private String department_seq; // 부서번호
	private String department_name; // 부서명
	
	// 생성자 //
	public DepartmentVO() {}
	public DepartmentVO(String department_seq, String department_name) {
		super();
		this.department_seq = department_seq;
		this.department_name = department_name;
	}
	
	// department_seq //
	public String getDepartment_seq() {
		return department_seq;
	}
	
	public void setDepartment_seq(String department_seq) {
		this.department_seq = department_seq;
	}
	
	// department_name //
	public String getDepartment_name() {
		return department_name;
	}
	
	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

}
