package com.spring.groupware.cha.controller;

import java.util.ArrayList;
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

import com.spring.groupware.cha.service.ChaInterService;
import com.spring.groupware.commonVO.PersonalCalVO;

@Controller
public class ChaController {
	
	@Autowired
	private ChaInterService service; // 의존객체
	
	// 개인 일정 캘린더
	@ResponseBody
	@RequestMapping(value="/fullCalendar.top", produces="text/plain;charset=UTF-8")
	public String fullCalendar() {
		
		List<PersonalCalVO> perCalvo =  service.fullCalendar();
						
		JSONArray jsonArr = new JSONArray();
		
		for(PersonalCalVO personalCalVO : perCalvo) {
			
			JSONObject jsObj = new JSONObject();
			
			jsObj.put("_id", personalCalVO.getCalendar_seq()); 			
			jsObj.put("title", personalCalVO.getTitle());
			jsObj.put("description", personalCalVO.getContent());
			jsObj.put("start", personalCalVO.getStartDate());
			jsObj.put("end", personalCalVO.getEndDate());
			jsObj.put("backgroundColor", personalCalVO.getColor());
			jsObj.put("type", "카테고리1");
			jsObj.put("username", "다현");
			jsObj.put("textColor", "#ffffff");
			jsObj.put("allDay", false);
			
			jsonArr.put(jsObj);
			
		}
						
		return jsonArr.toString();
		
	}
	
	// 캘린더 뷰페이지
	@RequestMapping(value="/viewFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String viewFullCalendar() {
		
		return "fullCalendarKakaoBook/fullCalendar";
	}
	
	// 캘린더 일정 추가
	@RequestMapping(value="/insertCalendar.top")
	public String insertCalendar(HttpServletRequest request) {
		
		String employee_id = request.getParameter("_id");
		
		System.out.println(employee_id);
		
		JSONObject jsObj = new JSONObject();
		
		return jsObj.toString();
	}
	
	// ------------------------------선을 중심으로 윗 부분 캘린더 모음 ----------------------------------------------
	
	// 카카오북
	@RequestMapping(value="/kakaoBook.top", produces="text/plain;charset=UTF-8")
	public String kakaoBook() {
		
		return "fullCalendarKakaoBook/kakaoBook";
		
	}
	
	// ------------------------------선을 중심으로 윗 부분 책검색 모음 ----------------------------------------------
	
	// 공지 사항
	@RequestMapping(value="/Notice.top", produces="text/plain;charset=UTF-8")
	public String Notice() {
		
		return "Notice/Notice";
		
	}
	

}
