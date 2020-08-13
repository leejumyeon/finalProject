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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.groupware.choijh.service.InterChoijhService;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

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
	@RequestMapping(value="goChatting", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
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
		
	
	// 채팅방 내용 읽어오기 
	@ResponseBody
	@RequestMapping(value="contentView.top", produces="text/plain;charset=UTF-8")
	public String contentView(HttpServletRequest request) {
		
		String roomNumber = request.getParameter("roomNumber");
		
		List<MessengerVO> msgList = service.contentView(roomNumber);
		
		JSONArray jsArr = new JSONArray();
		
		for(MessengerVO msg : msgList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("message_seq", msg.getMessage_seq());
			jsonObj.put("fk_roomNumber", msg.getFk_roomNumber());
			jsonObj.put("fk_employee_seq", msg.getFk_employee_seq());
			jsonObj.put("employee_name", msg.getEmployee_name());
			jsonObj.put("content", msg.getContent());
			jsonObj.put("status", msg.getStatus());
			jsonObj.put("regDate", msg.getRegDate());
			jsArr.put(jsonObj);
		} 
		
		return jsArr.toString();
	}
	
	
	// 채팅방 글 쓰기
	@ResponseBody
	@RequestMapping(value="goWriteMsg.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String goWriteMsg(HttpServletRequest request) {
		
		String roomNumber = request.getParameter("roomNumber");
		String content = request.getParameter("content");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		HashMap<String,String> map = new HashMap<>();
		
		map.put("roomNumber", roomNumber);
		map.put("content", content);
		map.put("sEmployee_seq", sEmployee_seq);
		
		int n = service.goWriteMsg(map);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 대화목록 보여주기 
	@ResponseBody
	@RequestMapping(value="msgRoomListView.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	public String msgRoomListView(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		String Employee_seq = loginEmployee.getEmployee_seq();
		
		List<HashMap<String,String>> mapList = service.msgRoomListView(Employee_seq);
		
		JSONArray jsArr = new JSONArray();
		
		for(HashMap<String,String> map : mapList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("roomNumber", map.get("roomNumber"));
			jsonObj.put("fk_employee_seq", map.get("fk_employee_seq"));
			jsonObj.put("employee_name", map.get("employee_name"));
			jsonObj.put("content", map.get("content"));
			jsonObj.put("regDate", map.get("regDate"));
			jsonObj.put("cnt", map.get("cnt"));
		
			jsArr.put(jsonObj);
		} 
		
		return jsArr.toString();
	}
	
	
	// 채팅 방 삭제하기
	@ResponseBody
	@RequestMapping(value="roomDelete.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String roomDelete(HttpServletRequest request) {
		
		String roomNumber = request.getParameter("roomNumber");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		HashMap<String,String> map = new HashMap<>();
		map.put("roomNumber", roomNumber);
		map.put("sEmployee_seq", sEmployee_seq);
		
		int n = service.roomDelete(map);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 그룹채팅 방 생성하기
	@ResponseBody
	@RequestMapping(value="goGroupChattRoomCreate.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String goGroupChattRoomCreate(HttpServletRequest request) {
		
		String allEmpSeq = request.getParameter("allEmpSeq");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		String[] allEmpSeqArr = allEmpSeq.split(",");
		
		// 채번해오기
		int roomNum = service.getRoomNumber();
		String roomNumber = String.valueOf(roomNum);
		
		HashMap<String, Object> map = new HashMap<>();	
		map.put("roomNumber", roomNumber);
		map.put("allEmpSeqArr", allEmpSeqArr);
		map.put("sEmployee_seq", sEmployee_seq);

		int n = service.groupChattRoomCreate(map);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return "";
	}
		
	
	
}
