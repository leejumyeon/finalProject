package com.spring.groupware.hyemin.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.ReservationVO;
import com.spring.groupware.hyemin.service.InterHyeminService;

// === #30. 컨트롤러 선언 ===
@Component
@Controller
public class HyeminController {	

	// === #35. 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired
	private InterHyeminService service;
	
	
	
	// === #150. 파일업로드 및 다운로드를 해주는 FileManager 클래스 의존객체 주입하기(DI: Dependency Injection) ===
	@Autowired	// Type에 따라 알아서 Bean 을 주입해준다.
	private FileManager fileManager;
	
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

	
	// === 게시글 관리(공지사항 리스트)작성페이지 - 뷰단(관리자) === //
	@RequestMapping(value="/manager/board/boardWrite.top")
	public ModelAndView managerBoardWrite(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/boardWrite.tiles3");
		return mav;
	}
		
/*	// === 관리자 - 게시글 관리(공지사항 리스트)작성페이지 - 완료(관리자) === //
	@RequestMapping(value="/manager/board/noticeInsert.top", method= {RequestMethod.POST})
	public String managerNoticeInsert(HttpServletRequest request, MultipartHttpServletRequest mrequest, BoardVO boardvo){
		
		HttpSession session = request.getSession();
		String loginEmployee = ((EmployeesVO) session.getAttribute("loginEmployee")).getEmployee_seq();
		String boardType = request.getParameter("boardType");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		
		HashMap<String, String> paraMap = new HashMap<>();
				
		paraMap.put("loginEmployee", loginEmployee);
		paraMap.put("subject", subject);
		paraMap.put("content", content);		
		
	//	=== 사용자가 쓴 글에 파일이 첨부되어 있는 것인지 아니면 파일첨부가 안 된 것인지 구분을 지어주어야 한다.
		
	//	=== !!! 첨부파일이 있는지 없는지 알아오기 시작 !!! ===
		MultipartFile attach = boardvo.getAttach();
		if( !attach.isEmpty() ) {
			// attach(첨부파일)가 비어있지 않다면(즉, 첨부파일이 있는 경우라면)
			
		
		 	1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		 	>>> 파일이 업로드 될 특정 경로(폴더)지정해주기
		 		우리는 WAS의 webapp/resources/files 라는 폴더로 지정해준다.		 		
		
			// WAS의 webapp 의 절대경로를 알아와야 한다.
			HttpSession msession = mrequest.getSession();
			String root = msession.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator + "files";
				File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
			 	운영체제가 Windows 라면 File.separator 는 "\" 이고,
			 	운영체제가 UNIX, Linux 라면 File.separator 는 "/" 이다.
			 
			
			// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
			System.out.println("~~~~ 확인용 path => " + path);
			// ~~~~ 확인용 path => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\files
			
		
		 	2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기		 	
		
			String newFileName = "";
			// WAS(톰캣)의 디스크에 저장될 파일명
			
			byte[] bytes = null;
			// 첨부파일을 WAS(톰캣)의 디스크에 저장할 때 사용되는 용도
			
			long fileSize = 0;
			// 파일크기를 읽어오기 위한 용도
			
			try {
				bytes = attach.getBytes();
				// getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다. 
				// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
				// 이 파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				// 위의 것이 파일 올리기를 해주는 것이다.
				// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
				
				System.out.println(">>>> 확인용 newFileName ==> " + newFileName);
		
			
			 	3. BoardVO boardvo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기	 	
			
//				boardvo.setFileName(newFileName);
				// WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
				
//				boardvo.setOrgFilename(attach.getOriginalFilename());
				// 게시판 페이지에서 첨부된 파일명(강아지.png)을 보여줄 때 및
				// 사용자가 파일을 다운로드할 때 사용되는 파일명
				
				fileSize = attach.getSize();
//				boardvo.setFileSize(String.valueOf(fileSize));
				// 게시판 페이지에서 첨부한 파일의 크기를 보여줄 때 사용하는 것으로서 String 타입으로 변경해서 저장함.			
							
			} catch (Exception e) {
				e.printStackTrace();
			}
						
		}		
	//	=== !!! 첨부파일이 있는지 없는지 알아오기 끝 !!! ===	
		
		int n = 0;
		if( attach.isEmpty() ) {
			// 첨부파일이 없는 경우라면
//			n = service.managerNoticeInsert(boardvo);
		}	
		else {
			// 첨부파일이 있는 경우라면
//			n = service.managerNoticeInsertWithFile(paraMap);	
		}		

		if (n == 1) {
			return "redirect:/admin/board/boardWrite.top";			
		}		
		
	}*/
	
	// 관리자 - 예약관리(반려)
	@RequestMapping(value="/manager/rejectRoom.top")
	public ModelAndView rejectRoom(ModelAndView mav, HttpServletRequest request) {
		String reservation_seq = request.getParameter("reservation_seq");
		
		service.rejectRoom(reservation_seq);
		
		mav.setViewName("redirect:/manager/reservation.top");
		
		return mav;
	}
}
