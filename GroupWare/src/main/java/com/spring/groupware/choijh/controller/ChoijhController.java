package com.spring.groupware.choijh.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.groupware.choijh.service.InterChoijhService;
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

@Controller
public class ChoijhController {

	@Autowired
	private InterChoijhService service;
	
	@Autowired
	private FileManager fileManager;
	
	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	@ResponseBody
	@RequestMapping(value="allEmployeeView.top", produces="text/plain;charset=UTF-8")
	public String allEmployeeView(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		
		String employee_seq = loginEmployee.getEmployee_seq();
		
		List<EmployeesVO> empList = service.allEmployeeView(employee_seq);
		
		JSONArray jsArr = new JSONArray();
		
		for(EmployeesVO emp : empList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("employee_seq", emp.getEmployee_seq());
			jsonObj.put("employee_name", emp.getEmployee_name());
			jsonObj.put("position_name", emp.getPosition_name());
			jsonObj.put("department_name", emp.getDepartment_name());
			jsArr.put(jsonObj);
		}
		
		return jsArr.toString();
	}
	
	
	// 채팅 방 생성하기
	@ResponseBody
	@RequestMapping(value="goChatting", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String goChatting(HttpServletRequest request) {
		
		String rEmployee_seq = request.getParameter("rEmployee_seq");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		HashMap<String,String> map = new HashMap<>();
		map.put("rEmployee_seq", rEmployee_seq);
		map.put("sEmployee_seq", sEmployee_seq);
		
		// 채팅 방 존재유무 조회하기 
		String roomNumber = service.roomExist(map);
		
		JSONObject jsonObj = new JSONObject();
		
		if(roomNumber == null) { // 채팅방이 존재하지 않을 경우
			
			// 방번호 채번해오기
			int roomNum = service.getRoomNumber();
			map.put("roomNum", String.valueOf(roomNum));
			
			jsonObj.put("roomNumber", roomNum);
			
			// 채팅방 생성
			service.createRoom(map);
			
		}
		else { // 채팅방이 존재 할 경우 
			jsonObj.put("roomNumber", roomNumber);
		}
		
		return jsonObj.toString();
	}
		
	
	// 채팅방 내용 읽어오기 
	@ResponseBody
	@RequestMapping(value="contentView.top", produces="text/plain;charset=UTF-8")
	public String contentView(HttpServletRequest request) {
		
		String roomNumber = request.getParameter("roomNumber");
		
		List<MessengerVO> msgList = service.contentView(roomNumber);
		
		JSONArray jsArr = new JSONArray();
		
		for(MessengerVO msg : msgList) {
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("message_seq", msg.getMessage_seq());
			jsonObj.put("fk_roomNumber", msg.getFk_roomNumber());
			jsonObj.put("fk_employee_seq", msg.getFk_employee_seq());
			jsonObj.put("employee_name", msg.getEmployee_name());
			jsonObj.put("content", msg.getContent());
			jsonObj.put("status", msg.getStatus());
			jsonObj.put("regDate", msg.getRegDate());
			jsArr.put(jsonObj);
		} 
		
		return jsArr.toString();
	}
	
	
	// 채팅방 글 쓰기
	@ResponseBody
	@RequestMapping(value="goWriteMsg.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String goWriteMsg(HttpServletRequest request) {
		
		String roomNumber = request.getParameter("roomNumber");
		String content = request.getParameter("content");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		HashMap<String,String> map = new HashMap<>();
		
		map.put("roomNumber", roomNumber);
		map.put("content", content);
		map.put("sEmployee_seq", sEmployee_seq);
		
		int n = service.goWriteMsg(map);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 대화목록 보여주기 
	@ResponseBody
	@RequestMapping(value="msgRoomListView.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.GET})
	public String msgRoomListView(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		String Employee_seq = loginEmployee.getEmployee_seq();
		
		List<HashMap<String,String>> cntMapList = service.selectCnt(Employee_seq); // 대화방을 나간 방번호 조회하기
		
		HashMap<String,String> map = new HashMap<>();
		map.put("Employee_seq", Employee_seq);
		
		List<HashMap<String,String>> mapList = new ArrayList<>();
		
		JSONArray jsArr = new JSONArray();
		
		for(HashMap<String,String> cntMap : cntMapList) {
			
			if( cntMap.get("cnt").equals("1") ) { // 상대방이 채팅방을 나간 경우
				
				map.put("roomNumber", cntMap.get("roomNumber"));
				
				mapList = service.msgRoomListView(map); // 대화목록 보여주기
				
				for(HashMap<String,String> m : mapList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("roomNumber", m.get("roomNumber"));
					jsonObj.put("fk_employee_seq", m.get("fk_employee_seq"));
					jsonObj.put("employee_name", m.get("employee_name"));
					jsonObj.put("content", m.get("content"));
					jsonObj.put("regDate", m.get("regDate"));
					jsonObj.put("cnt", m.get("cnt"));
					
					jsArr.put(jsonObj);
				}
			}
			else { 
				
				map.put("roomNumber", cntMap.get("roomNumber"));
				mapList = service.msgRoomListView(map); // 대화목록 보여주기
				
				for(HashMap<String,String> m : mapList) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("roomNumber", m.get("roomNumber"));
					jsonObj.put("fk_employee_seq", m.get("fk_employee_seq"));
					jsonObj.put("employee_name", m.get("employee_name"));
					jsonObj.put("content", m.get("content"));
					jsonObj.put("regDate", m.get("regDate"));
					jsonObj.put("cnt", m.get("cnt"));
					
					jsArr.put(jsonObj);
				}
			}
		
		}// end of for(HashMap<String,String> cnt : cntMap)----------------
		
		return jsArr.toString();
	}
	
	
	// 채팅 방 삭제하기
	@ResponseBody
	@RequestMapping(value="roomDelete.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String roomDelete(HttpServletRequest request) {
		
		String roomNumber = request.getParameter("roomNumber");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		
		HashMap<String,String> map = new HashMap<>();
		map.put("roomNumber", roomNumber);
		map.put("sEmployee_seq", sEmployee_seq);
		map.put("employee_name", loginEmployee.getEmployee_name());
		map.put("content", loginEmployee.getEmployee_name()+" 님이 채팅방에 나가셨습니다.");
		
		int n = service.roomDelete(map);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 그룹채팅 방 생성하기
	@ResponseBody
	@RequestMapping(value="goGroupChattRoomCreate.top", produces="text/plain;charset=UTF-8", method= {RequestMethod.POST})
	public String goGroupChattRoomCreate(HttpServletRequest request) {
		
		String allEmpSeq = request.getParameter("allEmpSeq");
		String sEmployee_seq = request.getParameter("sEmployee_seq");
		
		String[] allEmpSeqArr = allEmpSeq.split(",");
		
		// 채번해오기
		int roomNum = service.getRoomNumber();
		String roomNumber = String.valueOf(roomNum);
		
		HashMap<String, Object> map = new HashMap<>();	
		map.put("roomNumber", roomNumber);
		map.put("sEmployee_seq", sEmployee_seq);

		int n = service.groupChattRoomCreate_My(map); // 그룹채팅 방 생성하기(자신) 
		
		int m = 0;
		for(int i=0; i<allEmpSeqArr.length; i++) {
			map.put("allEmpSeq", allEmpSeqArr[i]);
			m = service.groupChattRoomCreate_Other(map); // 그룹채팅 방 생성하기(자신) 
		}
		
		System.out.println("m : " + m + " n : " + n);
		  
		if(m*n == 0) { // 자신과 상대방 둘중 하나라도 방 생성이 안된경우
			roomNumber = "-1";
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("roomNumber", roomNumber);
		
		return jsonObj.toString();
	}
	
		
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 자유 게시판 //
	
	
	// 자유 게시판 글 보여주기
	@RequestMapping(value="/freeboard/list.top")
	public ModelAndView list(ModelAndView mav) {
		
		List<BoardVO> boardList = service.boardlistView(); // 게시판 글 보여주기
		
		mav.addObject("boardList", boardList);
		
		mav.setViewName("freeboard/list.tiles1");
		
		return mav;
	}
	
	
	// 자유게시판 글쓰기 폼페이지 보여주기
	@RequestMapping(value="/freeboard/write.top")
	public ModelAndView write(ModelAndView mav) {
		mav.setViewName("freeboard/write.tiles1");
		return mav;
	}
	
	
	// 자유게시판 글쓰기완료 
	@RequestMapping(value="/freeboard/writeEnd.top", method= {RequestMethod.POST})
	public String writeEnd(HttpServletRequest request, BoardVO bvo, MultipartHttpServletRequest mrequest) throws Exception {
		
		List<MultipartFile> fileList = mrequest.getFiles("attach");
		
		int n = 0;
		
		if(fileList.size() == 0) { // 첨부파일 없는 경우
			n = service.add(bvo); // 자유게시판 글쓰기(첨부파일이 없는 경우) 
		}
		else {	// 첨부파일 있는 경우
			
			int num = service.getBordNum(); // 자유게시판 글번호 채번해오기
			String number = String.valueOf(num);
			
			bvo.setBoard_seq(number);

			n = service.add_withFile(bvo); // 글쓰기(첨부파일이 있는 경우)
			
			for(MultipartFile attach : fileList) {
				
				//  === !!! 첨부파일이 있는지 없는지 알아오기 시작 !!! ===
					if(!attach.isEmpty()) { // 첨부파일이 있는경우
						HttpSession session = mrequest.getSession();
						String root = session.getServletContext().getRealPath("/");
						String path = root + "resources" + File.separator +"freeboard";
						
						String newFileName = "";
						
						byte[] bytes = null;
						
						long fileSize = 0;
						
						AttachFileVO attachvo = new AttachFileVO();
						attachvo.setFk_board_seq(number);
						
						try {
							bytes = attach.getBytes();

							newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
							
							attachvo.setFileName(newFileName);
						
							attachvo.setOrgFileName(attach.getOriginalFilename());
							
							fileSize = attach.getSize();
							attachvo.setFileSize(String.valueOf(fileSize));
							
						} catch (IOException e) {
							e.printStackTrace();
						}
						
						service.addFile(attachvo); // 자유게시판 첨부파일 테이블 insert하기
						
					}
				//  === !!! 첨부파일이 있는지 없는지 알아오기 끝 !!! ===

				}// end of for(MultipartFile attach : fileList)------------------
			
		}
		
		if(n==1) { // 글쓰기 성공
			return "redirect:/freeboard/list.top";
		}
		else { // 글쓰기 실패
			return "redirect:/freeboard/write.top";
		}
		
	}
	
	
	// 게시글 상세보기 페이지 보여주기 
	@RequestMapping(value="/freeboard/detailView.top", method = {RequestMethod.GET})
	public ModelAndView detailView(ModelAndView mav, HttpServletRequest request) {
		
		String board_seq = request.getParameter("board_seq");
		
		BoardVO bvo = service.detailView(board_seq);
		
		List<AttachFileVO> attachvoList = service.getfileView(board_seq); // 해당게시글의 첨부파일 읽어오기 
		
		if(attachvoList.size() != 0) { // 파일첨부가 있을 경우
			mav.addObject("attachvoList",attachvoList);
		}
		
		mav.addObject("bvo", bvo);
		
		mav.setViewName("freeboard/detailboard.tiles1");
		
		return mav;
	}
	

	// 자유게시판 첨부파일 다운로드
	@RequestMapping(value="/freeboard/download.top")
	public void download(HttpServletRequest request, HttpServletResponse response, AttachFileVO attachvo) {
	
		   String fileName = attachvo.getFileName(); 
		   // 202007250930481985323774614.png 와 같은 것이다.
		   // 이것이 바로 WAS(톰캣) 디스크에 저장된 파일명이다.
			
		   String orgFilename = attachvo.getOrgFileName(); 
		   // 강아지.png 처럼 다운받을 사용자에게 보여줄 파일명.
			
			
		   // 첨부파일이 저장되어 있는 
		   // WAS(톰캣)의 디스크 경로명을 알아와야만 다운로드를 해줄수 있다. 
		   // 이 경로는 우리가 파일첨부를 위해서
		   //    /addEnd.action 에서 설정해두었던 경로와 똑같아야 한다.
		   // WAS 의 webapp 의 절대경로를 알아와야 한다. 
		   HttpSession session = request.getSession();
			
		   String root = session.getServletContext().getRealPath("/"); 
		   String path = root + "resources"+File.separator+"freeboard";
		   // path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
			
		   // **** 다운로드 하기 **** //
		   // 다운로드가 실패할 경우 메시지를 띄워주기 위해서
		   // boolean 타입 변수 flag 를 선언한다.
		   boolean flag = false;
			
		   flag = fileManager.doFileDownload(fileName, orgFilename, path, response);
		   // 다운로드가 성공이면 true 를 반납해주고,
		   // 다운로드가 실패이면 false 를 반납해준다.
			
		   if(!flag) {
			   // 다운로드가 실패할 경우 메시지를 띄워준다.
				
			   response.setContentType("text/html; charset=UTF-8"); 
			   PrintWriter writer = null;
				
			   try {
				   writer = response.getWriter();
				   // 웹브라우저상에 메시지를 쓰기 위한 객체생성.
			   } catch (IOException e) {
					
			   }
				
			   writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");       
				
		   }
		
	}

	
	// 글 삭제하기
	@RequestMapping(value="/freeboard/del.top", method = {RequestMethod.POST})
	public String del(HttpServletRequest request) {
		
		String board_seq = request.getParameter("board_seq");
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		String Employee_seq = loginEmployee.getEmployee_seq();
		
		BoardVO bvo = service.detailView(board_seq);
		
		if(Employee_seq != null && bvo.getFk_employee_seq().equals(Employee_seq)) { // 로그인한 사용자가 자신의 글을 삭제 할 경우
			
			int n = service.del(board_seq);
			
			if(n > 0) { // 글 삭제 성공 시 
				String message = "글이 삭제 되었습니다.";
				String loc = request.getContextPath()+"/freeboard/list.top";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
			}
		}
		else if(!bvo.getFk_employee_seq().equals(Employee_seq)) {
			String message = "다른 사용자의 글은 삭제 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		}
		
		return "msg";
	}
	
	
	// 글 수정 폼 보여주기
	@RequestMapping(value="/freeboard/editView.top")
	public String editView(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		String Employee_seq = loginEmployee.getEmployee_seq();
		
		String board_seq = request.getParameter("board_seq");
		
		BoardVO bvo = service.detailView(board_seq);
		
		if(Employee_seq == null || !bvo.getFk_employee_seq().equals(Employee_seq)) { // 로그인한 사용자가 다른 사용자의 글을 수정할 경우
			String message = "다른 사용자의 글은 수정 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			return "msg";
		}
		
		request.setAttribute("bvo", bvo);
		
		return "freeboard/edit.tiles1";
	}
	
	
	// 글 수정 하기 
	@RequestMapping(value="/freeboard/edit.top")
	public String edit(HttpServletRequest request, BoardVO bvo) {
		
		int n = service.edit(bvo); // 자유게시판 글 수정 하기 
		
		if(n == 1) { // 글 수정이 완료 된 경우
			String message = "글이 수정 되었습니다.";
			String loc = request.getContextPath()+"/freeboard/list.top";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		}
		else {
			String message = "글 수정이 실패했습니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
		}
		
		return "msg";
	}

	
	// 댓글 쓰기 
	@RequestMapping(value="/freeboard/goCommentWrite.top")
	public String goCommentWrite(HttpServletRequest request) {
		
		String board_seq = request.getParameter("board_seq");
		String commentContent = request.getParameter("commentContent");
		
		return "";
	}
	
	
	
	
	
	
	
	
	
	
}
