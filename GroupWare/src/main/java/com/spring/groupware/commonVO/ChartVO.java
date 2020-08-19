package com.spring.groupware.commonVO;

public class ChartVO {
	private String category; //가로항목
	private String project_value; // 값
	private String maintain_value;
	private String laborCost_value;
	
	public String getCategory() {
		return category;
	}
	
	public void setCategory(String category) {
		this.category = category;
	}
	
	public String getProject_value() {
		return project_value;
	}
	
	public void setProject_value(String project_value) {
		this.project_value = project_value;
	}
	
	public String getMaintain_value() {
		return maintain_value;
	}
	
	public void setMaintain_value(String maintain_value) {
		this.maintain_value = maintain_value;
	}
	
	public String getLaborCost_value() {
		return laborCost_value;
	}
	
	public void setLaborCost_value(String laborCost_value) {
		this.laborCost_value = laborCost_value;
	}
	
	
}
