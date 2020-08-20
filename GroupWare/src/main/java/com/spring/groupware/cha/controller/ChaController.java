package com.spring.groupware.cha.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.spring.common.MyUtil;
import com.spring.groupware.cha.service.ChaInterService;
import com.spring.groupware.commonVO.AlbumVO;
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.PersonalCalVO;

@Controller
public class ChaController {
	
	@Autowired
	private ChaInterService service; // 의존객체
	
	// ------------------------------마이페이지(개인 일정 캘린더 & 책검색) - 시작 ----------------------------------------------
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 뷰페이지
	@RequestMapping(value="/viewFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String viewFullCalendar() {
		
		return "fullCalendarKakaoBook/fullCalendar.tiles1";
	}
	
	// 마이페이지(개인 일정 캘린더) - 뿌리기
	@ResponseBody
	@RequestMapping(value="/personalFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String fullCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO) session.getAttribute("loginEmployee");
		
		List<PersonalCalVO> perCalvo =  service.fullCalendar(loginEmployee.getEmployee_seq());
						
		JSONArray jsonArr = new JSONArray();
		
		for(PersonalCalVO personalCalVO : perCalvo) {
			
			JSONObject jsObj = new JSONObject();
			
			jsObj.put("_id", personalCalVO.getCalendar_seq()); 			
			jsObj.put("title", personalCalVO.getTitle());
			jsObj.put("description", personalCalVO.getContent());
			jsObj.put("start", personalCalVO.getStartDate());
			jsObj.put("end", personalCalVO.getEndDate());
			jsObj.put("backgroundColor", personalCalVO.getBackgroundColor());
			jsObj.put("type", "카테고리1");
			jsObj.put("username", loginEmployee.getEmployee_name());
			jsObj.put("textColor", "#ffffff");
			jsObj.put("allDay", false);
			
			jsonArr.put(jsObj);
			
		}
						
		return jsonArr.toString();
		
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정추가
	@ResponseBody
	@RequestMapping(value="/insertCalendar.top", produces="text/plain;charset=UTF-8")
	public String insertCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		
	//	System.out.println(employee_id+"/"+title+"/"+content+"/"+endDate+"/"+startDate+"/"+backgroundColor);
		
		HashMap<String, String> paraMap = new HashMap<>();		
		paraMap.put("employee_id", employee_id);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		
		int n = service.insertFullCalendar(paraMap);
											
		JSONObject jsonObj = new JSONObject();
			
		jsonObj.put("n", n);
																															
		return jsonObj.toString();
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 수정
	@ResponseBody
	@RequestMapping(value="/updateCalendar.top", produces="text/plain;charset=UTF-8")
	public String updateCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String calendar_seq = request.getParameter("_id");
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		
	//	System.out.println(employee_id+"/"+calendar_seq+"/"+title+"/"+content+"/"+endDate+"/"+startDate+"/"+backgroundColor);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("calendar_seq", calendar_seq);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		
		int n = service.updateFullCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 삭제
	@ResponseBody
	@RequestMapping(value="/deleteCalendar.top", produces="text/plain;charset=UTF-8")
	public String deleteCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String calendar_seq = request.getParameter("_id");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("calendar_seq", calendar_seq);
		
		int n = service.deleteFullCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
		
	// ------------------------------마이페이지(개인 일정 캘린더 & 책검색) - 끝 ----------------------------------------------
	
	// ------------------------------마이페이지(동호회,예약) - 시작 ----------------------------------------------
	
	// 마이페이지(동호회) - 뿌리기
	@ResponseBody
	@RequestMapping(value="/club.top", produces="text/plain;charset=UTF-8")
	public String club(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();	
		String employee_name = request.getParameter("employee_name");
		
		//System.out.println("사원번호:"+employee_id+"/사원명:"+employee_name);
		
		/*String club_seq = request.getParameter("club_seq");
		String member_seq = request.getParameter("member_seq");
		String club_name = request.getParameter("club_name");
		String club_info = request.getParameter("club_info");
		String status = request.getParameter("status");
		String regDate = request.getParameter("regDate");*/
		
		//System.out.println(employee_name);
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_name", employee_name);
		/*paraMap.put("club_seq", club_seq);
		paraMap.put("member_seq", member_seq);
		paraMap.put("club_name", club_name);
		paraMap.put("club_info", club_info);
		paraMap.put("status", status);
		paraMap.put("regDate", regDate);*/
		
		List<HashMap<String,String>> resultList = service.club(paraMap);
		
		Gson gson = new Gson();
		
		return gson.toJson(resultList);
		
	}
	
	// 마이페이지(동호회) - 팝업창 뷰단
	@RequestMapping(value="/popup.top")
	public String popup(HttpServletRequest request) {
		
		String club_seq = request.getParameter("club_seq");
		
		request.setAttribute("club_seq", club_seq);
		return "club/popup.notiles";
	}
	
	// 마이페이지(동호회) - 팝업창에 해당 동호회 명단 뿌리기
	@ResponseBody
	@RequestMapping(value="/popupList.top", produces="text/plain;charset=UTF-8")
	public String popupList(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String employee_name = request.getParameter("employee_name");
		String club_seq = request.getParameter("club_seq");
		
		//System.out.println(club_seq);
		
		String member_seq = request.getParameter("member_seq");
		String club_name = request.getParameter("club_name");
		String club_info = request.getParameter("club_info");
		String status = request.getParameter("status");
		String regDate = request.getParameter("regDate");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_name", employee_name);
		paraMap.put("club_seq", club_seq);
		paraMap.put("member_seq", member_seq);
		paraMap.put("club_name", club_name);
		paraMap.put("club_info", club_info);
		paraMap.put("status", status);
		paraMap.put("regDate", regDate);
		
		List<HashMap<String,String>> resultList = service.popup(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("resultList", resultList);
		
		return jsonObj.toString();
		
	}
	
	// 마이페이지(예약) - 뿌리기
	@ResponseBody
	@RequestMapping(value="/reservation.top", produces="text/plain;charset=UTF-8")
	public String reservation(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String employee_name = request.getParameter("employee_name");
		String reservation_seq = request.getParameter("reservation_seq");
		String fk_employee_seq = request.getParameter("fk_employee_seq");
		String fk_roomNumber = request.getParameter("fk_roomNumber");
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String head_seq = request.getParameter("head_seq");
		String memberCount = request.getParameter("memberCount");
		String reason = request.getParameter("reason");
		String status = request.getParameter("status");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_name", employee_name);
		paraMap.put("reservation_seq", reservation_seq);
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("fk_roomNumber", fk_roomNumber);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("head_seq", head_seq);
		paraMap.put("memberCount", memberCount);
		paraMap.put("reason", reason);
		paraMap.put("status", status);
		
		List<HashMap<String,String>> reList = service.reservation(paraMap);
		
		JSONObject jsonObj = new JSONObject(); 
		
		jsonObj.put("reList", reList);
		
		return jsonObj.toString();
	}
	
	// ------------------------------마이페이지(동호회,예약) - 끝 ----------------------------------------------
	
	// ------------------------------ 공지사항 및 자주묻는 질문 - 시작  ----------------------------------------------
	
	// 공지 사항
	@RequestMapping(value="/Notice.top", produces="text/plain;charset=UTF-8")
	public String Notice() {
		
		return "Notice/Notice.tiles1";
		
	}
			
	// ------------------------------ 공지사항 및 자주묻는 질문 - 끝  -------------------------------------------------------
	
	// ------------------------------ 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 시작  ----------------------------------------------
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 공지사항
	@ResponseBody
	@RequestMapping(value="/indication.top", produces="text/plain;charset=UTF-8")
	public String indication(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String employee_name = request.getParameter("employee_name");
		String board_seq = request.getParameter("board_seq");	
		String fk_category_num = request.getParameter("fk_category_num");
		
	//	System.out.println(fk_category_num);
		
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String readCnt = request.getParameter("readCnt");
		String regDate = request.getParameter("regDate");
		String fk_employee_seq = request.getParameter("fk_employee_seq");
		String status = request.getParameter("status");
		String commentCnt = request.getParameter("commentCnt");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_name", employee_name);
		paraMap.put("board_seq", board_seq);
		paraMap.put("fk_category_num", fk_category_num);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		paraMap.put("readCnt", readCnt);
		paraMap.put("regDate", regDate);
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("status", status);
		paraMap.put("commentCnt", commentCnt);
		
		List<HashMap<String,String>> resList = service.indication(paraMap);
		
		JSONObject jsonObj = new JSONObject(); 
		
		jsonObj.put("resList", resList);
		
		return jsonObj.toString();
	}
				
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 자유게시판
	@ResponseBody
	@RequestMapping(value="/freedom.top", produces="text/plain;charset=UTF-8")
	public String freedom(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String employee_name = request.getParameter("employee_name");
		String board_seq = request.getParameter("board_seq");	
		String fk_category_num = request.getParameter("fk_category_num");		
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		String readCnt = request.getParameter("readCnt");
		String regDate = request.getParameter("regDate");
		String fk_employee_seq = request.getParameter("fk_employee_seq");
		String status = request.getParameter("status");
		String commentCnt = request.getParameter("commentCnt");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("employee_id", employee_id);
		paraMap.put("employee_name", employee_name);
		paraMap.put("board_seq", board_seq);
		paraMap.put("fk_category_num", fk_category_num);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		paraMap.put("readCnt", readCnt);
		paraMap.put("regDate", regDate);
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("status", status);
		paraMap.put("commentCnt", commentCnt);
		
		List<HashMap<String,String>> resList = service.freedom(paraMap);
		
		JSONObject jsonObj = new JSONObject(); 
		
		jsonObj.put("resList", resList);
		
		return jsonObj.toString();
	}
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 앨범게시판
	@ResponseBody
	@RequestMapping(value="/album.top", produces="text/plain;charset=UTF-8")
	public String album(HttpServletRequest request) {
						
		List<AlbumVO> albumvoList = service.album();
		
		JSONObject jsonObj = new JSONObject(); 
		
		jsonObj.put("albumvoList", albumvoList);
		
		return jsonObj.toString();
		
	}
	
	
	// ------------------------------ 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 끝  ----------------------------------------------
	
	// ------------------------------ 관리자 메인페이지(회사 일정 캘린더) - 시작 ----------------------------------------------
	
	// 관리자 메인페이지(회사 일정 캘린더) -  일반 메인페이지 캘린더 DB값 얻어오기(뿌리기)
	@ResponseBody
	@RequestMapping(value="/adminFullCalendar.top", produces="text/plain;charset=UTF-8")
	public String adminFullCalendar() {
		
		List<CompanyCalVO> comCalvo = service.adminFullCalendar();
		
		JSONArray jsonArr = new JSONArray();
		
		for(CompanyCalVO companyCalVO : comCalvo) {
			
			JSONObject jsObj = new JSONObject();
			
			jsObj.put("_id", companyCalVO.getComCalendar_seq()); 			
			jsObj.put("title", companyCalVO.getTitle());
			jsObj.put("description", companyCalVO.getContent());
			jsObj.put("start", companyCalVO.getStartDate());
			jsObj.put("end", companyCalVO.getEndDate());
			jsObj.put("backgroundColor", companyCalVO.getBackgroundColor());
			jsObj.put("type", companyCalVO.getCategory_name());
			jsObj.put("username", companyCalVO.getDepartment_name());
			jsObj.put("textColor", "#ffffff");
			jsObj.put("allDay", false);
			
			jsonArr.put(jsObj);
			
		}
		
		return jsonArr.toString();
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가	
	@ResponseBody
	@RequestMapping(value="/insertAdminCalendar.top", produces="text/plain;charset=UTF-8")
	public String insertAdminCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		String fk_department_seq = request.getParameter("edit-username");
		String calendar_category = request.getParameter("edit-type");
		
		if("경조사".equals(calendar_category)) {
			
			calendar_category = "1";
		}
		else if("워크샵".equals(calendar_category)) {
			
			calendar_category = "2";
		}
		else if("협력일정".equals(calendar_category)) {
			
			calendar_category = "3";
		}
		else if("채용일정".equals(calendar_category)) {
			
			calendar_category = "4";
		}

		HashMap<String, String> paraMap = new HashMap<>();		
		paraMap.put("employee_id", employee_id);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		paraMap.put("fk_department_seq", fk_department_seq);
		paraMap.put("calendar_category", calendar_category);
		
		int n = service.insertAdminCalendar(paraMap);
											
		JSONObject jsonObj = new JSONObject();
			
		jsonObj.put("n", n);
																															
		return jsonObj.toString();
	}
	
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	@ResponseBody
	@RequestMapping(value="/updateAdminCalendar.top", produces="text/plain;charset=UTF-8")
	public String updateAdminCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String comCalendar_seq = request.getParameter("_id");
		String title = request.getParameter("title");
		String content = request.getParameter("description");
		String startDate = request.getParameter("start");
		String endDate = request.getParameter("end");
		String backgroundColor = request.getParameter("backgroundColor");
		String allDay = request.getParameter("allDay");
		String fk_department_seq = request.getParameter("edit-username");
		String calendar_category = request.getParameter("edit-type");
		
		if("경조사".equals(calendar_category)) {
			
			calendar_category = "1";
		}
		else if("워크샵".equals(calendar_category)) {
			
			calendar_category = "2";
		}
		else if("협력일정".equals(calendar_category)) {
			
			calendar_category = "3";
		}
		else if("채용일정".equals(calendar_category)) {
			
			calendar_category = "4";
		}
		
		HashMap<String, String> paraMap = new HashMap<>();		
		paraMap.put("employee_id", employee_id);
		paraMap.put("comCalendar_seq", comCalendar_seq);
		paraMap.put("title", title);
		paraMap.put("content", content);
		paraMap.put("startDate", startDate);
		paraMap.put("endDate", endDate);
		paraMap.put("backgroundColor", backgroundColor);
		paraMap.put("allDay", allDay);
		paraMap.put("fk_department_seq", fk_department_seq);
		paraMap.put("calendar_category", calendar_category);
		
		int n = service.updateAdminCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	@ResponseBody
	@RequestMapping(value="/deleteAdminCalendar.top", produces="text/plain;charset=UTF-8")
	public String deleteAdminCalendar(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		String employee_id = ((EmployeesVO)session.getAttribute("loginEmployee")).getEmployee_seq();
		String comCalendar_seq = request.getParameter("_id");
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("employee_id", employee_id);
		paraMap.put("comCalendar_seq", comCalendar_seq);
		
		int n = service.deleteAdminCalendar(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	// ------------------------------ 관리자 메인페이지(회사 일정 캘린더) - 끝 ----------------------------------------------

	@RequestMapping(value="/notice.top")
	public ModelAndView mainNoticePage(ModelAndView mav, HttpServletRequest request) {
		
		List<BoardVO> boardList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(searchType == null) {
			searchType = "";
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
		
		int totalCount = 0;   		// 총 게시물 건수 
		int sizePerPage = 10; 		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정 
		int totalPage = 0; 			// 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)
		
		int startRno = 0;			// 시작 행번호
		int endRno = 0;				// 끝 행번호
		
		// 총 게시물 건수(totalCount)
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
		
		boardList = service.boardListSearchWithPaging(paraMap);
		// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
		
		if(!"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		// 페이지바 만들기  //
		String pageBar = "<ul id='pageBarUl' style='list-style:none;'>";
		
		int blockSize = 10;
		// blockSize 는 1개 블럭(토막)당 보여지는 페이지번호의 개수 이다.
		/*
		  	  1  2  3  4  5  6  7  8  9 10  다음 	-- 1개블럭
		   이전  11 12 13 14 15 16 17 18 19 20		-- 1개 블럭
		   이전  21 22 23 24 25 26 27 28 29 30  
		*/
		
		int loop = 1;
		/*
		  	loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[지금은 10개(== blockSize)] 까지만 증가하는 용도이다.
		*/
		
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String url = request.getContextPath()+"/notice.top";
		
		// === [이전] 만들기 ===
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>&lt;&lt;</a></li>";
		}
		
		while( !( loop > blockSize || pageNo > totalPage)) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; border-radius: 5px; color:blue; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo ++;
		}// end of while --------------------------------------
		
		
		// === [다음] 만들기 ===
		if( !(pageNo > totalPage) ) { // 맨 마지막으로 빠져나온것이 아니라면 [다음]을 보인다.
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>&gt;&gt;</a></li>";
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		String gobackURL = MyUtil.getCurrentURL(request);
		
	//	boardList = service.boardlistView(); // 페이징 처리 안한 게시판 글 보여주기
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes"); // 새로고침시 조회 수 증가 방지
		
		mav.addObject("gobackURL", gobackURL);
		mav.addObject("boardList", boardList);
		
		mav.setViewName("Notice/notice.tiles1");
		return mav;
	}
	
	@RequestMapping(value="/detailNotice.top")
	public ModelAndView detailNotice(ModelAndView mav, HttpServletRequest request) {
		
		String board_seq = request.getParameter("board_seq");
		String gobackURL = request.getParameter("gobackURL");
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		
		String employee_seq = null;
		
		if(loginEmployee != null) {
			employee_seq = loginEmployee.getEmployee_seq();
			// employee_seq 는 로그인 되어진 사용자의 employee_seq 이다.
		}
		
		BoardVO bvo = null;
		
		if("yes".equals(session.getAttribute("readCountPermission")) ) {
			// 글목록보기를 클릭한 다음에 특정글을 조회해온 경우이다.
			
			bvo = service.detailNotice(board_seq, employee_seq);
			// 글조회수 증가와 함께 글1개를 조회를 해주는 것
			
			session.removeAttribute("readCountPermission");
			// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
		}
		else {
			bvo = service.detailNoticeNoAddCount(board_seq); // 자유게시판 글 조회수 증가 없이 단순히 글1개 조회하기
		}
		
		List<AttachFileVO> attachvoList = service.getfileView(board_seq); // 해당게시글의 첨부파일 읽어오기 
		
		if(attachvoList.size() != 0) { // 파일첨부가 있을 경우
			mav.addObject("attachvoList",attachvoList);
		}
		
		mav.addObject("bvo", bvo);
		mav.addObject("gobackURL", gobackURL);
		
	//	System.out.println(gobackURL);
		
		mav.setViewName("Notice/noticeDetail.tiles1");
		
		return mav;
	}
}
