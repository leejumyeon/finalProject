package com.spring.groupware.hyemin.controller;

import java.io.File;
import java.util.ArrayList;
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
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MailVO;
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
		
	
	// === 관리자 - 게시글 관리(공지사항 리스트)작성페이지 - 완료(관리자) === //
	@RequestMapping(value="/manager/board/noticeInsert.top", method= {RequestMethod.POST})
	public ModelAndView managerNoticeInsert(ModelAndView mav, MultipartHttpServletRequest mrequest){
		
		HttpSession session = mrequest.getSession();
		String fk_employee_seq = ((EmployeesVO) session.getAttribute("loginEmployee")).getEmployee_seq();
		String fk_category_num = mrequest.getParameter("fk_category_num");
		String subject = mrequest.getParameter("subject");
		String content = mrequest.getParameter("content");
		List<MultipartFile> attachList = mrequest.getFiles("attach");
		
		System.out.println("attachList:"+attachList.size());
		
		List<AttachFileVO> attachfileList = new ArrayList<AttachFileVO>(); //결과물 list
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("fk_employee_seq", fk_employee_seq);
		paraMap.put("fk_category_num", fk_category_num);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		// DB에서 작업한 결과 저장용
		int n = 0; 
		
		// 글번호 채번하기
		int fk_board_seq = service.getBoard_seq();
		paraMap.put("fk_board_seq", fk_board_seq);
		
		// 글 작성
		n = service.managerNoticeInsert(paraMap);
		
		String msg = "";
		String loc = mrequest.getContextPath()+"/manager/board/boardWrite.top";
		
		if(n == 1) {
			if(!attachList.isEmpty()) {
				String root = session.getServletContext().getRealPath("/");
				String path = root + "resources" + File.separator + "freeboard";
				String fileName = "";
				
				int cnt = 0;
				
				for(int i=0; i<attachList.size(); i++) {
					if(!attachList.get(i).isEmpty()) {
						System.out.println("파일 업로드");
						byte[] bytes = null;
						long fileSize = 0;
						
						try {
							bytes = attachList.get(i).getBytes();
							// getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다. 
							// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
							// 이 파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
							
							fileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
							
							// 위의 것이 파일 올리기를 해주는 것이다.
							// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
							
							System.out.println(">>>> 확인용 fileName ==> " + fileName);
							
						//	3. AttachFileVO attachfilevo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기
							
							fileSize = attachList.get(i).getSize();
							AttachFileVO attachfilevo = new AttachFileVO();
							
							attachfilevo.setFk_board_seq(Integer.toString(fk_board_seq));
							attachfilevo.setFileName(fileName);
							attachfilevo.setOrgFileName(attachList.get(i).getOriginalFilename());
							attachfilevo.setFileSize(String.valueOf(fileSize));
							
							attachfileList.add(attachfilevo);

						} catch (Exception e) {
							e.printStackTrace();
						}
					}// end of if(!attachList.get(i).isEmpty()) {}----------------
				}// end of for(int i=0; i<attachList.size(); i++) {}--------------------
				
				int count = attachfileList.size();
				int m = 0;
				try{
					for(AttachFileVO attachFile:attachfileList) {
						// 파일 첨부하기
						m += service.managerNoticeFileInsert(attachFile);
					}
					
					if(m == count) {
						msg = "게시글 작성에 성공했습니다.";
					}
					else {
						msg = "게시글 작성에 실패했습니다.";
					}
				}catch(Throwable e) {
					e.printStackTrace();
				}
				
			}// end of if(!attachList.isEmpty()) {}-------------------------------------
			
			else {
				msg = "게시글 작성에 성공했습니다.";
			}
			
		}
		
		mav.addObject("message", msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		return mav;
		
	}
	
}














