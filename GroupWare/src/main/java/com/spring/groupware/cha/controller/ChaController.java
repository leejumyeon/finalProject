package com.spring.groupware.cha.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.groupware.cha.service.ChaInterService;
import com.spring.groupware.commonVO.PersonalCalVO;

@Controller
public class ChaController {
	
	@Autowired
	private ChaInterService service; // 의존객체
	
	// 회사 일정 캘린더
	@RequestMapping(value="/fullCalendar.top", produces="text/plain;charset=UTF-8")
	public String fullCalendar() {
		
		List<PersonalCalVO> perCalvo =  service.fullCalendar();
						
		JSONArray jsonArr = new JSONArray();
		
		for(PersonalCalVO personalCalVO : perCalvo) {
			
			JSONObject jsObj = new JSONObject();
			
			jsObj.put("calendar_seq", personalCalVO.getCalendar_seq()); 
			jsObj.put("fk_employee_seq", personalCalVO.getFk_employee_seq());
			jsObj.put("title", personalCalVO.getTitle());
			jsObj.put("content", personalCalVO.getContent());
			jsObj.put("startDate", personalCalVO.getStartDate());
			jsObj.put("endDate", personalCalVO.getEndDate());
			jsObj.put("color", personalCalVO.getColor());
			
			jsonArr.put(jsObj);
			
		}
						
		return jsonArr.toString();
		
	}
	
	@RequestMapping(value="/kakaoBook.top", produces="text/plain;charset=UTF-8")
	public String kakaoBook() {
		
		return "fullCalendarKakaoBook/kakaoBook";
		
	}
	
	
	
	

}
