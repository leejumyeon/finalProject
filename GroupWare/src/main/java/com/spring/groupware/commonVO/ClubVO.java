package com.spring.groupware.commonVO;

public class ClubVO { // 동호회VO
	private String club_seq; // 동호회 번호
	private String club_name; // 동호회명
	private String regDate; // 동호회 생성 날짜
	private String club_info; // 동호회 설명
	private String representative_img; // 동호회 대표 이미지
	
	public String getClub_seq() {
		return club_seq;
	}
	public void setClub_seq(String club_seq) {
		this.club_seq = club_seq;
	}
	public String getClub_name() {
		return club_name;
	}
	public void setClub_name(String club_name) {
		this.club_name = club_name;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getClub_info() {
		return club_info;
	}
	public void setClub_info(String club_info) {
		this.club_info = club_info;
	}
	public String getRepresentative_img() {
		return representative_img;
	}
	public void setRepresentative_img(String representative_img) {
		this.representative_img = representative_img;
	}
	
	
}
