package com.spring.groupware.choijh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groupware.choijh.model.InterChoijhDAO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

@Service
public class ChoijhService implements InterChoijhService {

	@Autowired 
	private InterChoijhDAO dao;

	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	@Override
	public List<EmployeesVO> allEmployeeView(String employee_seq) {
		List<EmployeesVO> empList = dao.allEmployeeView(employee_seq);
		return empList;
	}

	
	// 채팅 방 존재유무 조회하기
	@Override
	public String roomExist(HashMap<String, String> map) {
		String roomNumber = dao.roomExist(map);
		return roomNumber;
	}


	// 방번호 채번해오기
	@Override
	public int getRoomNumber() {
		int roomNum =dao.getRoomNumber();
		return roomNum;
	}

	
	// 채팅방 생성
	@Override
	public void createRoom(HashMap<String, String> map) {		
		dao.createRoom(map);
	}


	// 채팅방 내용 읽어오기 
	@Override
	public List<MessengerVO> contentView(String roomNumber) {
		List<MessengerVO> msgList = dao.contentView(roomNumber);
		return msgList;
	}


	// 채팅방 글쓰기
	@Override
	public int goWriteMsg(HashMap<String, String> map) {
		int n = dao.goWriteMsg(map);
		return n;
	}


	// 대화목록 보여주기
	@Override
	public List<HashMap<String, String>> msgRoomListView(HashMap<String,String> map) {
		List<HashMap<String, String>> mapList = dao.msgRoomListView(map);
		return mapList;
	}
	

	// 채팅 방 삭제하기
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public int roomDelete(HashMap<String, String> map) {
		
		dao.roomOutMsgInsert(map); // 채팅방 나갈시 메시지 띄우기
		
		int n = dao.roomDelete(map);
		return n;
	}


	// 그룹채팅 방 생성하기(자신)
	@Override
	public int groupChattRoomCreate_My(HashMap<String, Object> map) {
		int n = dao.groupChattRoomCreate_My(map);
		return n;
	}


	// 그룹채팅 방 생성하기(상대방)
	@Override
	public int groupChattRoomCreate_Other(HashMap<String, Object> map) {
		int m = dao.groupChattRoomCreate_Other(map);
		return m;
	}


	// 대화방을 나간 방번호 조회하기
	@Override
	public List<HashMap<String, String>> selectCnt(String employee_seq) {
		List<HashMap<String,String>> cntMapList = dao.selectCnt(employee_seq);
		return cntMapList;
	}

	

	
	
	
}
