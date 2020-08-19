package com.spring.groupware.seongsu.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.commonVO.AlbumVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.seongsu.service.InterSeongsuService;

@Controller
public class SeongsuController {
		
	
	@Autowired
	private InterSeongsuService service;
	
	@RequestMapping(value="/board.top")
	public ModelAndView goBoardPage(ModelAndView mav) {
		
		mav.setViewName("/board/board.tiles1");
		
		return mav;
	}
		
	@RequestMapping(value="/detailboard.top")
	public ModelAndView requiredLogin_detailboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/detailboard.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/write.top")
	public ModelAndView requiredLogin_write(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<HashMap<String, String>> albumCategory = service.getAlbumCategory();
		
		mav.addObject("albumCategory", albumCategory);
		mav.setViewName("album/write.tiles1");
		
		return mav;
	}
	
<<<<<<< HEAD
	@RequestMapping(value="/board/write.top")
	public ModelAndView requiredLogin_bdwrite(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("redirect:/list.top");
		
		return mav;
	}	
	
	@RequestMapping(value="/list.top")
	public ModelAndView requiredLogin_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
=======
	@RequestMapping(value="/album/writeEnd.top", method = {RequestMethod.POST})
	public ModelAndView writeEnd(ModelAndView mav, HttpServletRequest request) {
		
		String album_category = request.getParameter("album_category");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
>>>>>>> 2b734dcadc82923839ea526ac96a81b718530fdf
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		String fk_employee_seq = loginEmployee.getEmployee_seq();
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("album_category", album_category);
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		service.insertAlbumTable(paraMap);
		
		mav.setViewName("redirect:/list.top");
		return mav;
	}
	
	@RequestMapping(value="/list.top")
	public ModelAndView requiredLogin_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("album/list.tiles1");
		
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/albumList.top", produces= "text/plain;charset=UTF-8")
	public String albumList(HttpServletRequest request) {
		
		String statusValue = request.getParameter("statusValue");
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("statusValue", statusValue);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		List<AlbumVO> albumList = service.getAlbumList(paraMap);
		
		JSONArray jsArr = new JSONArray();
		
		for(AlbumVO avo : albumList) {
			
			JSONObject jsObj = new JSONObject();
			jsObj.put("category_name", avo.getCategory_name());
			jsObj.put("subject", avo.getSubject());
			jsObj.put("employee_name", avo.getEmployee_name());
			jsObj.put("employee_id", avo.getEmployee_id());
			jsObj.put("regDate", avo.getRegDate());
			
			jsArr.put(jsObj);
		}
		
		return jsArr.toString();
	}
	
	@RequestMapping(value="/update.top")
	public ModelAndView requiredLogin_update(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/update.tiles1");
		
		return mav;
	}
	
}