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
		
	@RequestMapping(value="/detailAlbum.top")
	public ModelAndView requiredLogin_detailboard(HttpServletRequest request, ModelAndView mav) {
		
		String album_seq = request.getParameter("album_seq");
		
		AlbumVO detailAlbum = service.getDetailAlbum(album_seq);
		
		mav.addObject("detailAlbum", detailAlbum);
		mav.setViewName("album/detailAlbum.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/write.top")
	public ModelAndView requiredLogin_write(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		List<HashMap<String, String>> albumCategory = service.getAlbumCategory();
		
		mav.addObject("albumCategory", albumCategory);
		mav.setViewName("album/write.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/album/writeEnd.top", method = {RequestMethod.POST})
	public ModelAndView writeEnd(ModelAndView mav, HttpServletRequest request) {
		
		String album_category = request.getParameter("album_category");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
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
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("statusValue", statusValue);
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);

		int totalCount = 0;   		// 총 게시물 건수 
		int sizePerPage = 10; 		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정 
		int totalPage = 0; 			// 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		totalCount = service.getTotalCount(paraMap);
		
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		
		if(str_currentShowPageNo == null) {
			// 게시판에 보여지는 초기화면
			
			currentShowPageNo = 1;
			// 즉, 초기화면인 /freeboard/list.top 은 /freeboard/list.top?currentShowPageNo=1 로 하겠다는 말이다.
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) { // user가 get방식으로 currentShowPageNo=asdfasdfasdf 로 장난 친 경우 
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 

		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		List<AlbumVO> albumList = service.getAlbumList(paraMap);
		
		String pageBar = "<ul id='pageBarUl' style='list-style:none;'>";
		
		int blockSize = 10;
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a onclick='getAlbumList(" + statusValue + ", " + searchType + "," + searchWord + ", " + (pageNo-1) + ")'>[이전]</a></li>";
		}
		
		while( !( loop > blockSize || pageNo > totalPage)) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:blue; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a onclick='getAlbumList(" + statusValue + ", " + searchType + "," + searchWord + ", " + pageNo + ")'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo ++;
		}// end of while --------------------------------------
		
		
		// === [다음] 만들기 ===
		if( !(pageNo > totalPage) ) { // 맨 마지막으로 빠져나온것이 아니라면 [다음]을 보인다.
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a onclick='getAlbumList(" + statusValue + ", " + searchType + "," + searchWord + ", " + pageNo + ")'>[다음]</a></li>";
		}
		
		pageBar += "</ul>";
		
		JSONArray jsArr = new JSONArray();
		
		for(AlbumVO avo : albumList) {
			
			JSONObject jsObj = new JSONObject();
			jsObj.put("album_seq", avo.getAlbum_seq());
			jsObj.put("category_name", avo.getCategory_name());
			jsObj.put("subject", avo.getSubject());
			jsObj.put("employee_name", avo.getEmployee_name());
			jsObj.put("employee_id", avo.getEmployee_id());
			jsObj.put("regDate", avo.getRegDate());
			
			jsArr.put(jsObj);
		}
		
		JSONObject jsObj2 = new JSONObject();
		jsObj2.put("AlbumList", jsArr);
		jsObj2.put("pageBar", pageBar);
		
		return jsObj2.toString();
	}
	
	// == 수정 페이지로 이동 == //
	@RequestMapping(value="/updateAlbum.top")
	public ModelAndView updateAlbum(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String album_seq = request.getParameter("album_seq");
		
		AlbumVO detailAlbum = service.getDetailAlbum(album_seq);
		
		mav.addObject("detailAlbum", detailAlbum);
		mav.setViewName("album/update.tiles1");
		
		return mav;
	}
	
	// == 앨범 수정하기 == //
	@RequestMapping(value="/album/updateEnd.top", method= {RequestMethod.POST})
	public ModelAndView updateEnd(ModelAndView mav, HttpServletRequest request) {
		
		String album_seq = request.getParameter("album_seq");
		String album_category = request.getParameter("album_category");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("album_seq", album_seq);
		paraMap.put("album_category", album_category);
		paraMap.put("subject", subject);
		paraMap.put("content", content);

		service.updateEnd(paraMap);
		
		mav.setViewName("redirect:/list.top");
		return mav;
	}
	
	// == 앨범 삭제하기 == //
	@RequestMapping(value="/deleteAlbum.top")
	public ModelAndView deleteAlbum(ModelAndView mav, HttpServletRequest request) {
		
		String album_seq = request.getParameter("album_seq");
		
		service.deleteAlbum(album_seq);
		
		mav.setViewName("redirect:/list.top");
		return mav;
	}
}