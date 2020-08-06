package com.spring.groupware.choijh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.choijh.model.InterChoijhDAO;
import com.spring.groupware.commonVO.EmployeesVO;

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

	
	
	
}
