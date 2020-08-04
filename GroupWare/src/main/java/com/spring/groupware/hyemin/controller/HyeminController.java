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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.commonVO.ReservationRoomVO;
import com.spring.groupware.commonVO.ReservationVO;
import com.spring.groupware.hyemin.service.InterHyeminService;

// === #30. 컨트롤러 선언 ===
@Component
@Controller
public class HyeminController {	

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterHyeminService service;
	
	@RequestMapping(value = "/rsvt/rsvtRoom.top")
	public ModelAndView hmTest(ModelAndView mav) {
		
		mav.setViewName("rsvt/rsvtRoom.tiles1");
		// /WEB-INF/views/rsvt/rsvtRoom.jsp 페이지를 만들어야 한다.
		
		return mav;
	}
	
	// === 예약 가능한 시간 조회(Ajax) ===
	@ResponseBody
	@RequestMapping(value = "/showPossibleTime.top", produces = "text/plain;charset=UTF-8")
	public String select_possibleTime(HttpServletRequest request) {

		String fk_roomNumber = request.getParameter("fk_roomNumber");
		String RsvtDate = request.getParameter("RsvtDate");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_roomNumber", fk_roomNumber);
		paraMap.put("RsvtDate", RsvtDate);
		
		List<ReservationVO> rsvtvoList = service.select_possibleTime(paraMap);

		JSONArray jsonArr = new JSONArray();

		for (ReservationVO vo : rsvtvoList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("fk_roomNumber", vo.getFk_roomNumber());
			jsonObj.put("startDate", vo.getStartDate());
			jsonObj.put("endDate", vo.getEndDate());
			jsonObj.put("status", vo.getStatus());

			jsonArr.put(jsonObj);
		}

		return jsonArr.toString();

	}

	
}
