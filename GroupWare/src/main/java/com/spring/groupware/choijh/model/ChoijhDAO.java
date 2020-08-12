package com.spring.groupware.choijh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

@Repository
public class ChoijhDAO implements InterChoijhDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	@Override
	public List<EmployeesVO> allEmployeeView(String employee_seq) {
		List<EmployeesVO> empList = sqlsession.selectList("messenger.allEmployeeView", employee_seq);
		return empList;
	}

	// 채팅 방 존재유무 조회하기
	@Override
	public String roomExist(HashMap<String, String> map) {
		String roomNumber = sqlsession.selectOne("messenger.roomExist", map);
		return roomNumber;
	}

	// 채팅 방번호 채번해오기
	@Override
	public int getRoomNumber() {
		int roomNum = sqlsession.selectOne("messenger.getRoomNumber");
		return roomNum;
	}

	// 채팅방 생성
	@Override
	public void createRoom(HashMap<String, String> map) {
		sqlsession.insert("messenger.createRoom_S", map);
		sqlsession.insert("messenger.createRoom_R", map);
	}

	// 채팅방 내용 읽어오기
	@Override
	public List<MessengerVO> contentView(String roomNumber) {
		List<MessengerVO> msgList = sqlsession.selectList("messenger.contentView", roomNumber);
		return msgList;
	}

	// 채팅방 글쓰기
	@Override
	public int goWriteMsg(HashMap<String, String> map) {
		int n = sqlsession.insert("messenger.goWriteMsg", map);
		return n;
	}

	// 대화목록 보여주기
	@Override
	public List<HashMap<String, String>> msgRoomListView(String employee_seq) {
		List<HashMap<String, String>> mapList = sqlsession.selectList("messenger.msgRoomListView", employee_seq);
		return mapList;
	}

	// 채팅 방 삭제하기
	@Override
	public int roomDelete(HashMap<String, String> map) {
		int n = sqlsession.delete("messenger.roomDelete",map);
		return n;
	}
	
}
