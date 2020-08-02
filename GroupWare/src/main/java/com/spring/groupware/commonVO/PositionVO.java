package com.spring.groupware.commonVO;

public class PositionVO {
	private String position_seq; // 직책 번호
	private String position_name; // 직책명
	private String position_salary; // 직책 급여
	
	public PositionVO() {}
	
	public PositionVO(String position_seq, String position_name, String position_salary) {
		this.position_seq = position_seq;
		this.position_name = position_name;
		this.position_salary = position_salary;
	}

	// position_seq //
	public String getPosition_seq() {
		return position_seq;
	}

	public void setPosition_seq(String position_seq) {
		this.position_seq = position_seq;
	}

	
	// position_name //
	public String getPosition_name() {
		return position_name;
	}

	public void setPosition_name(String position_name) {
		this.position_name = position_name;
	}

	
	// position_salary //
	public String getPosition_salary() {
		return position_salary;
	}

	public void setPosition_salary(String position_salary) {
		this.position_salary = position_salary;
	}
	
	
	
	
}
