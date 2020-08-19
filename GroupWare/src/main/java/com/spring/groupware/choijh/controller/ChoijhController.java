package com.spring.groupware.choijh.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
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
import com.spring.common.MyUtil;
import com.spring.groupware.choijh.service.InterChoijhService;
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CommentVO;
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
	public ModelAndView list(ModelAndView mav, HttpServletRequest request) {
		
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
		
		String url = request.getContextPath()+"/freeboard/list.top";
		
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
			
			bvo = service.detailView(board_seq, employee_seq);
			// 글조회수 증가와 함께 글1개를 조회를 해주는 것
			
			session.removeAttribute("readCountPermission");
			// 중요함!! session 에 저장된 readCountPermission 을 삭제한다.
		}
		else {
			bvo = service.detailViewNoAddCount(board_seq); // 자유게시판 글 조회수 증가 없이 단순히 글1개 조회하기
		}
		
		List<AttachFileVO> attachvoList = service.getfileView(board_seq); // 해당게시글의 첨부파일 읽어오기 
		
		if(attachvoList.size() != 0) { // 파일첨부가 있을 경우
			mav.addObject("attachvoList",attachvoList);
		}
		
		mav.addObject("bvo", bvo);
		mav.addObject("gobackURL", gobackURL);
		
	//	System.out.println(gobackURL);
		
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
		
		BoardVO bvo = service.detailViewNoAddCount(board_seq);
		
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
		
		BoardVO bvo = service.detailViewNoAddCount(board_seq);
		
		if(Employee_seq == null || !bvo.getFk_employee_seq().equals(Employee_seq)) { // 로그인한 사용자가 다른 사용자의 글을 수정할 경우
			String message = "다른 사용자의 글은 수정 불가합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			return "msg";
		}
		
		List<AttachFileVO> attachvoList = new ArrayList<>();
		attachvoList = service.getfileView(board_seq);
		
		request.setAttribute("attachvoListSize", attachvoList.size());
		
		request.setAttribute("bvo", bvo);
		request.setAttribute("attachvoList", attachvoList);
		request.setAttribute("attachvoListSize", attachvoList.size());
		
		return "freeboard/edit.tiles1";
	}
	
	
	// 글 수정 하기 
	@RequestMapping(value="/freeboard/edit.top")
	public String edit(HttpServletRequest request, BoardVO bvo, MultipartHttpServletRequest mrequest) {
		
		String[] orgFileNameList = mrequest.getParameterValues("orgFileName"); 	// 기존 파일명
		String[] file_seqArr = mrequest.getParameterValues("file_seq"); 		// 기존 파일 번호
		String[] fileNameList = mrequest.getParameterValues("fileName"); 		// 기존 파일명(업로드 이름)
		String[] fileSizeList = mrequest.getParameterValues("fileSize"); 		// 기존 파일크기
		
		List<MultipartFile> attachList = mrequest.getFiles("attach"); 			// 기존 파일 (업데이트)
		List<MultipartFile> newAttachList = mrequest.getFiles("newAttach"); 	// 새롭게 추가하는 파일
		
	//	System.out.println("attachList:"+attachList.size()+" / newAttachList:"+newAttachList.size());
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("board_seq", bvo.getBoard_seq());
		paraMap.put("subject", bvo.getSubject());
		paraMap.put("content", bvo.getContent());
		paraMap.put("file_seqArr", file_seqArr);
		
		List<AttachFileVO> uploadFileList = new ArrayList<>(); // 업데이트 되는 또는 추가되는 파일 정보 저장용
		
		int result = 0; //DB에서 작업한 결과 저장용
		
		result = service.edit(bvo); // 자유게시판 글 수정 하기 
		
		// 기존파일 보존할 것들 조회(지운것 수정된것을 제외한 나머지)
		if(attachList != null && !attachList.isEmpty()) { // 유지되거나 업데이트일 경우
			List<String> maintainSeq = new ArrayList<>();
			for(int i=0; i<attachList.size(); i++) {
				if(attachList.get(i).isEmpty()) { // input[name=attach](게시글에 이미 첨부된 파일)태그가 있으면서 값이 null = 현재 상태 유지
					maintainSeq.add(file_seqArr[i]);
					System.out.println("보존할 파일:"+file_seqArr[i]);
				}
				else {
					System.out.println("업데이트 파일:"+file_seqArr[i]);
				}
			}
			paraMap.put("maintainSeq", maintainSeq);
		}
		
		
		List<AttachFileVO> deleteFileList = null;
		deleteFileList = service.deleteFileList(paraMap); // 보존할 것들 이외 삭제할 첨부파일 번호 조회
		for(AttachFileVO deleteFile : deleteFileList) { 
			System.out.println("삭제할 파일:"+deleteFile.getFile_seq());
		}
		
		// 업로드 파일 삭제 및 DB삭제
		HttpSession session = mrequest.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "freeboard";
		
		for(AttachFileVO deleteFile : deleteFileList) {
			try {
				fileManager.doFileDelete(deleteFile.getFileName(), path);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if(deleteFileList != null && !deleteFileList.isEmpty()) {
			paraMap.put("deleteFileList", deleteFileList);
			result += service.deleteFile(paraMap); // DB에서 삭제
		}
		
		
		
		// 업로드할 파일 업로드 및 ListVO에추가
		if(attachList != null && !attachList.isEmpty()) {
			for(int i=0; i<attachList.size(); i++) {
				if(!attachList.get(i).isEmpty()) {// 업데이트 해야하는 첨부파일 업로드
					AttachFileVO attachFile = new AttachFileVO();
					byte[] bytes = null;
					long fileSize = 0;
					try {
						bytes = attachList.get(i).getBytes();
						
						String newFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
						fileSize = attachList.get(i).getSize();
						System.out.println("업데이트할 파일명:"+newFileName);
						attachFile.setFk_board_seq(bvo.getBoard_seq());
						attachFile.setFileName(newFileName);
						attachFile.setFileSize(String.valueOf(fileSize));
						attachFile.setOrgFileName(attachList.get(i).getOriginalFilename());
						
						uploadFileList.add(attachFile);	
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				
			} // end of for(attachList)
		}
		
		if(newAttachList != null && !newAttachList.isEmpty()) {
			// 추가할 파일 업로드 및 ListVO에 추가
			for(int i=0; i<newAttachList.size(); i++) {
				if(!newAttachList.get(i).isEmpty()) {
					AttachFileVO attachFile = new AttachFileVO();
					byte[] bytes = null;
					long fileSize = 0;
					try {
						bytes = newAttachList.get(i).getBytes();
						
						String newFileName = fileManager.doFileUpload(bytes, newAttachList.get(i).getOriginalFilename(), path);
						fileSize = newAttachList.get(i).getSize();
						System.out.println("추가할 파일명:"+newFileName);
						attachFile.setFk_board_seq(bvo.getBoard_seq());
						attachFile.setFileName(newFileName);
						attachFile.setFileSize(String.valueOf(fileSize));
						attachFile.setOrgFileName(newAttachList.get(i).getOriginalFilename());
						
						uploadFileList.add(attachFile);	
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}// end of for(newAttachList)-----------------------------
		}
		
		if(uploadFileList != null && !uploadFileList.isEmpty()) {
			for(AttachFileVO uploadFile : uploadFileList) {
				result += service.insertFile(uploadFile); // 첨부파일 추가
			}
		}
		
		String message = "게시글 수정에 실패했습니다.";
		String loc = mrequest.getContextPath()+"/freeboard/detailView.top?board_seq="+bvo.getBoard_seq();
		
		if(result == (uploadFileList.size()+deleteFileList.size()+1)) {
			message = "게시글 수정에 성공했습니다.";
			loc = mrequest.getContextPath()+"/freeboard/detailView.top?board_seq="+bvo.getBoard_seq();
		}

		request.setAttribute("message", message);
		request.setAttribute("loc", loc);
		
		return "msg";
	}

	
	// 댓글 쓰기 
	@ResponseBody
	@RequestMapping(value="/freeboard/goCommentWrite.top", produces="text/plain;charset=UTF-8")
	public String goCommentWrite(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		
		String Employee_seq = loginEmployee.getEmployee_seq();
		String board_seq = request.getParameter("board_seq");
		String commentContent = request.getParameter("commentContent");
		
		CommentVO cvo = new CommentVO(); 
		cvo.setFk_board_seq(board_seq);
		cvo.setContent(commentContent);
		cvo.setFk_employee_seq(Employee_seq);
		
		int n = service.addComment(cvo); // 댓글 쓰기 및 원글게시물 댓글수 +1 증가
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	// 댓글 내용(페이징처리 o) 보여주기
	@ResponseBody
	@RequestMapping(value="/freeboard/goReadComment.top", produces="text/plain;charset=UTF-8")
	public String goReadComment(HttpServletRequest request) {
		
		String fk_board_seq = request.getParameter("fk_board_seq");
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(currentShowPageNo == null) {
		    currentShowPageNo = "1";
	    }
	   
	    int sizePerPage = 10;	// 한 페이지당 5개의 댓글을 보여줄 것임.
			   
	    int startRno = ((Integer.parseInt(currentShowPageNo) - 1 ) * sizePerPage) + 1;
	    int endRno = startRno + sizePerPage - 1;
		
	//  System.out.println("확인용 : " + fk_board_seq + " , startRno : " + startRno + " , endRno : " + endRno);
	    
	    HashMap<String, String> paraMap = new HashMap<>();
	    paraMap.put("fk_board_seq", fk_board_seq);
	    paraMap.put("startRno", String.valueOf(startRno));
	    paraMap.put("endRno", String.valueOf(endRno));
	    
	//	List<CommentVO> commentList = service.goReadComment(fk_board_seq); // 페이징 처리 안한 댓글 내용 보여주기
	    List<CommentVO> commentList = service.getCommentListPaging(paraMap); // 댓글 내용(페이징처리 o) 보여주기
		
		JSONArray jsonArr = new JSONArray();
		   
	    if(commentList != null) {
		    for(CommentVO cvo : commentList) {
		        JSONObject jsonObj = new JSONObject();
		        jsonObj.put("content", cvo.getContent());
		        jsonObj.put("employee_name", cvo.getEmployee_name());
	   		    jsonObj.put("regDate", cvo.getRegDate());
	   		    jsonObj.put("fk_board_seq", cvo.getFk_board_seq());
	   		    jsonObj.put("comment_seq", cvo.getComment_seq());
	   		    jsonObj.put("depthno", cvo.getDepthno());
	   		   
		        jsonArr.put(jsonObj);
		     }
	    }
	
	    return jsonArr.toString();
	}
	
	
	// 댓글 totalPage 알아오기
    @ResponseBody
    @RequestMapping(value="/freeboard/getCommentTotalPage.top")
    public String getCommentTotalPage(HttpServletRequest request) {
    	
    	String fk_board_seq = request.getParameter("fk_board_seq");
 	   	String sizePerPage = request.getParameter("sizePerPage");
 	   
 	   	HashMap<String, String> paraMap = new HashMap<>();
 	   	paraMap.put("fk_board_seq", fk_board_seq);
 	   
 	   	// 원글 글번호에(parentSeq)에 해당하는 댓글의 총갯수를 알아오기 
 	   	int totalCount = service.getCommentTotalPage(paraMap);
 	   
 	   	// 총페이지수(totalPage) 구하기 
 	   	// 만약에 총 게시물 건수(totalCount)가 23개 이라면
 	   	// 총 페이지수(totalPage)는 5개가 되어야 한다.
 	   	int totalPage = (int) Math.ceil( (double)totalCount / Integer.parseInt(sizePerPage) ); 
 	   	// (double)23/5 ==> 4.6 ==> Math.ceil(4.6) ==> (int)5.0 ==> 5 
 	   	// (double)20/5 ==> 4.0 ==> Math.ceil(4.0) ==> (int)4.0 ==> 4
    
 	   	JSONObject jsonObj = new JSONObject();
 	   	jsonObj.put("totalPage", totalPage);
    	
    	return jsonObj.toString();
    }
	
	
	// 답글쓰기를 눌렀을 시 댓글테이블에 insert(계층형 답글쓰기) 
	@ResponseBody
	@RequestMapping(value="/freeboard/goChildCommentWrite.top", produces="text/plain;charset=UTF-8")
	public String goChildCommentWrite(HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		EmployeesVO loginEmployee = (EmployeesVO)session.getAttribute("loginEmployee");
		
		String Employee_seq = loginEmployee.getEmployee_seq();
		String fk_board_seq = request.getParameter("fk_board_seq");
		String parent_seq = request.getParameter("parent_seq");
		String childCommentContent = request.getParameter("childCommentContent");
		String depthno = request.getParameter("depthno");
		
	//	System.out.println("확인용 : " + Employee_seq + " , " + fk_board_seq + " , " + parent_seq + " , " + childCommentContent);
		
		CommentVO cvo = new CommentVO(); 
		cvo.setFk_board_seq(fk_board_seq);
		cvo.setParent_seq(parent_seq);
		cvo.setFk_employee_seq(Employee_seq);
		cvo.setContent(childCommentContent);
		cvo.setDepthno(depthno);
		
		int n = service.addChildComment(cvo); // 답글쓰기 및 원글게시물 댓글수 +1 증가
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		return jsonObj.toString();
	}
	
	
	
}
