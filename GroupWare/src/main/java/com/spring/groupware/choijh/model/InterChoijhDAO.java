package com.spring.groupware.choijh.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

public interface InterChoijhDAO {

	List<EmployeesVO> allEmployeeView(String employee_seq); // 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기

	String roomExist(HashMap<String, String> map); // 채팅 방 존재유무 조회하기

	int getRoomNumber(); // 방번호 채번해오기

	void createRoom(HashMap<String, String> map); // 채팅방 생성

	List<MessengerVO> contentView(String roomNumber); // 채팅방 내용 읽어오기

	int goWriteMsg(HashMap<String, String> map); // 채팅방 글쓰기

	List<HashMap<String, String>> msgRoomListView(String employee_seq); // 대화목록 보여주기
	
}
