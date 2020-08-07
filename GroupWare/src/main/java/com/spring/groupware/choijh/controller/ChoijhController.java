package com.spring.groupware.choijh.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.groupware.choijh.service.InterChoijhService;
import com.spring.groupware.commonVO.EmployeesVO;

@Controller
public class ChoijhController {

	@Autowired
	private InterChoijhService service;
	
	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	@ResponseBody
	@RequestMapping(value="allEmployeeView.top", produces="text/plain;charset=UTF-8")
	public String allEmployeeView(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		
		String employee_seq = loginEmployee.getEmployee_seq();
		
		List<EmployeesVO> empList = service.allEmployeeView(employee_seq);
		
		JSONArray jsArr = new JSONArray();
		
		for(EmployeesVO emp : empList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("employee_seq", emp.getEmployee_seq());
			jsonObj.put("employee_name", emp.getEmployee_name());
			jsonObj.put("position_name", emp.getPosition_name());
			jsonObj.put("department_name", emp.getDepartment_name());
			jsArr.put(jsonObj);
		}
		
		return jsArr.toString();
	}
	
	
	// 채팅 방 생성하기
	@ResponseBody
	@RequestMapping(value="goChatting", produces="text/plain;charset=UTF-8")
	public String goChatting(HttpServletRequest request) {
		
		String rEmployee_seq = request.getParameter("rEmployee_seq");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		HashMap<String,String> map = new HashMap<>();
		map.put("rEmployee_seq", rEmployee_seq);
		map.put("sEmployee_seq", sEmployee_seq);
		
		// 채팅 방 존재유무 조회하기 
		String roomNumber = service.roomExist(map);
		
		JSONObject jsonObj = new JSONObject();
		
		if(roomNumber == null) { // 채팅방이 존재하지 않을 경우
			
			// 방번호 채번해오기
			int roomNum = service.getRoomNumber();
			map.put("roomNum", String.valueOf(roomNum));
			
			jsonObj.put("roomNumber", roomNum);
			
			// 채팅방 생성
			service.createRoom(map);
			
		}
		else { // 채팅방이 존재 할 경우 
			jsonObj.put("roomNumber", roomNumber);
		}
		
		return jsonObj.toString();
	}
		
		
	
}
