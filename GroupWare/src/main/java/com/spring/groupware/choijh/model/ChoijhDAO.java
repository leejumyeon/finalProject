package com.spring.groupware.choijh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.EmployeesVO;

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
	
}
