package com.spring.groupware.hyemin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.commonVO.ReservationVO;
import com.spring.groupware.hyemin.service.InterHyeminService;

// === #30. 컨트롤러 선언 ===
@Component
@Controller
public class HyeminController {	

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterHyeminService service;
	
	@RequestMapping(value = "/reservation/reserveRoom.top")
	public ModelAndView hmTest(ModelAndView mav) {
		
		mav.setViewName("reservation/reserveRoom.tiles1");
		// /WEB-INF/views/rsvt/rsvtRoom.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
	
	
	// === 예약 가능한 시간 조회(Ajax) ===
	@ResponseBody
	@RequestMapping(value = "/showPossibleTime.top", produces = "text/plain;charset=UTF-8")
	public String select_possibleTime(HttpServletRequest request) {

		String fk_roomNumber = request.getParameter("fk_roomNumber");
		String rsvtDate = request.getParameter("rsvtDate");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_roomNumber", fk_roomNumber);
		paraMap.put("rsvtDate", rsvtDate);
		
		List<ReservationVO> rsvtvoList = service.select_possibleTime(paraMap);

		JSONArray jsonArr = new JSONArray();

		for (ReservationVO vo : rsvtvoList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("employee_name", vo.getEmployee_name());
			jsonObj.put("startDate", vo.getStartDate());
			jsonObj.put("endDate", vo.getEndDate());
			jsonObj.put("status", vo.getStatus());

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();

	}
	
	
	// === 검색어 입력 시 자동글 완성하기 3 ===
	@ResponseBody
	@RequestMapping(value = "/headSearchShow.top", produces = "text/plain;charset=UTF-8")
	public String headSearchShow(HttpServletRequest request) {
		
		String searchHead = request.getParameter("searchHead");
		
		List<HashMap<String, String>> headList = service.headSearchShow(searchHead);
		
		JSONArray jsonArr = new JSONArray();		
		
		if (headList != null) {
			for(HashMap<String, String> head : headList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("employee_seq", head.get("employee_seq"));
				jsonObj.put("searchResult", head.get("searchResult"));
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}

	
	// === 회의실 예약하기(insert) === //
	@RequestMapping(value = "/reserveRoomEnd.top", method = { RequestMethod.POST })
	public ModelAndView reserveRoomEnd(ModelAndView mav, HttpServletRequest request) {
		
		String fk_employee_seq = request.getParameter("fk_employee_seq");
		String fk_roomNumber = request.getParameter("fk_roomNumber");
		String roomName = request.getParameter("roomName");
		String rsvtDate = request.getParameter("rsvtDate");
		String startTimeH = request.getParameter("startTimeH");
		String endTimeH = request.getParameter("endTimeH");
		String startDate = rsvtDate + " " + startTimeH;
		String endDate = rsvtDate + " " + endTimeH;
		String head_seq = request.getParameter("head_seq");
		String memberCount = request.getParameter("memberCount");
		String reason = request.getParameter("reason");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("fk_roomNumber", fk_roomNumber);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("head_seq", head_seq);
		paraMap.put("memberCount", memberCount);
		paraMap.put("reason", reason);
		
		service.reserveRoomEnd(paraMap);
		
		String message = "회의실: " + roomName + " / 예약일: " + rsvtDate + " / 예약시간: " + startTimeH + " - " + endTimeH + "\\n예약이 완료되었습니다.";
		String loc = request.getContextPath() + "/reservation/reserveRoom.top";
		
		mav.addObject("message", message);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");

		return mav;
	}
	
	
	// === 예약 관리 페이지(관리자) === //	
	@RequestMapping(value = "/manager/reservation.top")
	public String reservation(HttpServletRequest request) {

		return "admin/reservation.tiles3";
		// /WEB-INF/views/tiles3/admin/reservation.jsp 페이지를 만들어야 한다.
	}
	
	
	// === 예약 신청 현황 조회(관리자)(Ajax) === //
	@ResponseBody
	@RequestMapping(value = "/manager/waitingReservation.top", produces = "text/plain;charset=UTF-8")
	public String waitingReservation(HttpServletRequest request) {

		String wPlaceType = request.getParameter("wPlaceType");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("wPlaceType", wPlaceType);
		
		List<ReservationVO> rsvtvoList = service.waitingReservation(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if (rsvtvoList != null) {
			for (ReservationVO rsvtvo : rsvtvoList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("reservation_seq", rsvtvo.getReservation_seq());
				jsonObj.put("fk_employee_seq", rsvtvo.getFk_employee_seq());				
				jsonObj.put("employee_name", rsvtvo.getEmployee_name());
				jsonObj.put("position_name", rsvtvo.getPosition_name());
				jsonObj.put("department_name", rsvtvo.getDepartment_name());
				jsonObj.put("fk_roomNumber", rsvtvo.getFk_roomNumber());
				jsonObj.put("roomName", rsvtvo.getRoomName());
				jsonObj.put("startDate", rsvtvo.getStartDate());
				jsonObj.put("endDate", rsvtvo.getEndDate());
				jsonObj.put("head_seq", rsvtvo.getHead_seq());
				jsonObj.put("head_name", rsvtvo.getHead_name());
				jsonObj.put("head_position", rsvtvo.getHead_position());
				jsonObj.put("head_department", rsvtvo.getHead_department());
				jsonObj.put("memberCount", rsvtvo.getMemberCount());
				jsonObj.put("reason", rsvtvo.getReason());
				jsonObj.put("regDate", rsvtvo.getRegDate());				

				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();
	}
	
	
	// === 예약 결과 현황 조회(관리자)(Ajax) === //
	@ResponseBody
	@RequestMapping(value = "/manager/resultReservation.top", produces = "text/plain;charset=UTF-8")
	public String resultReservation(HttpServletRequest request) {
		
		String resultType = request.getParameter("resultType");
		String rPlaceType = request.getParameter("rPlaceType");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("resultType", resultType);
		paraMap.put("rPlaceType", rPlaceType);
		
		List<ReservationVO> rsvtvoList = service.resultReservation(paraMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if (rsvtvoList != null) {
			for (ReservationVO rsvtvo : rsvtvoList) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("reservation_seq", rsvtvo.getReservation_seq());
				jsonObj.put("fk_employee_seq", rsvtvo.getFk_employee_seq());				
				jsonObj.put("employee_name", rsvtvo.getEmployee_name());
				jsonObj.put("fk_roomNumber", rsvtvo.getFk_roomNumber());
				jsonObj.put("roomName", rsvtvo.getRoomName());
				jsonObj.put("startDate", rsvtvo.getStartDate());
				jsonObj.put("endDate", rsvtvo.getEndDate());
				jsonObj.put("head_seq", rsvtvo.getHead_seq());
				jsonObj.put("head_name", rsvtvo.getHead_name());
				jsonObj.put("head_position", rsvtvo.getHead_position());
				jsonObj.put("head_department", rsvtvo.getHead_department());
				jsonObj.put("status", rsvtvo.getStatus());
				jsonObj.put("memberCount", rsvtvo.getMemberCount());
				jsonObj.put("reason", rsvtvo.getReason());
				jsonObj.put("regDate", rsvtvo.getRegDate());				

				jsonArr.put(jsonObj);
			}
		}

		return jsonArr.toString();	
	}
	
	
	// === 예약 승인하기(관리자)(update) === //
	@RequestMapping(value = "/manager/approveRoom.top", method = { RequestMethod.POST })
	public ModelAndView approveRoom(ModelAndView mav, HttpServletRequest request) {
		
		String reservation_seq = request.getParameter("reservation_seq");
		
		service.approveRoom(reservation_seq);

		mav.setViewName("redirect:/manager/reservation.top");
		
		return mav;
	}

}
