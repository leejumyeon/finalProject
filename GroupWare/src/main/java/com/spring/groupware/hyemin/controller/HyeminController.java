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
		String rsvtDate = request.getParameter("rsvtDate");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("fk_roomNumber", fk_roomNumber);
		paraMap.put("rsvtDate", rsvtDate);
		
		List<ReservationVO> rsvtvoList = service.select_possibleTime(paraMap);

		JSONArray jsonArr = new JSONArray();

		for (ReservationVO vo : rsvtvoList) {
			JSONObject jsonObj = new JSONObject();
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

	
}
