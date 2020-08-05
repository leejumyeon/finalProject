package com.spring.groupware.commonVO;

public class ReservationRoomVO { // 회의실VO
	private String roomNumber;		// 회의실 번호
	private String roomName;		// 회의실 이름	
	
	
	// 생성자
	public ReservationRoomVO() {}	
	public ReservationRoomVO(String roomNumber, String roomName) {
		super();
		this.roomNumber = roomNumber;
		this.roomName = roomName;
	}
	

	// Getter & Setter
	public String getRoomNumber() {
		return roomNumber;
	}
	
	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}
	
	public String getRoomName() {
		return roomName;
	}
	
	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

}
