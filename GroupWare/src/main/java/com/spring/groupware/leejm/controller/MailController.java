package com.spring.groupware.leejm.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.spring.common.FileManager;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MailVO;
import com.spring.groupware.commonVO.PhotoVO;
import com.spring.groupware.leejm.service.InterMailService;

@Controller
public class MailController {
	@Autowired
	private InterMailService service;
	
	@Autowired
	private FileManager fileManager;
	
	
	// 메일 리스트 페이지 이동(받은 메일함, 보낸 메일함, 전체 메일함, 내게 쓴 메일함)
	@RequestMapping(value="/mail/list.top")
	public ModelAndView mailList(ModelAndView mav, HttpServletRequest request) {
		String type = request.getParameter("type");
		String readStatus = request.getParameter("read");
		String[] selectCheck = request.getParameterValues("selectCheck");
		
		if(readStatus == null || readStatus.trim().isEmpty()) {
			readStatus = "0";
		}
		
		if(selectCheck != null) {
			for(String select : selectCheck) {
				System.out.println(select);
			}
			mav.addObject("selectCheck",selectCheck);
		}
		
		
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO)session.getAttribute("loginEmployee");
		
		HashMap<String, String>paraMap = new HashMap<>();
		paraMap.put("type", type);
		paraMap.put("loginSeq", emp.getEmployee_seq());
		
		String str_currentPageNo = request.getParameter("currentShowPageNo");
		
		String searchWord = request.getParameter("searchWord");
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		paraMap.put("searchWord", searchWord);
		System.out.println(type+"/"+searchWord);
		// 먼저 총 게시물 건수(totalCount)를 구해와야 한다.
		// 총 게시물 건수(totalCount)는 검색조건이 있을 때와 없을때로 나뉘어진다.
		int totalCount = 0;        // 총게시물 건수
		int sizePerPage = 15;      // 한 페이지당 보여줄 게시물 건수
		int currentShowPageNo = 0; // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정함.
		int totalPage = 0;         // 총 페이지 수(웹브라우저상에 보여줄 총 페이지 개수, 페이지바) 
		
		int startRno = 0;          // 시작 행번호
		int endRno = 0;            // 끝 행번호
		
		totalCount = service.getTotalCount(paraMap);
		
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		
		if(str_currentPageNo == null || str_currentPageNo.trim().isEmpty()) {
			currentShowPageNo = 1;
		}else {	
			try {
				currentShowPageNo = Integer.parseInt(str_currentPageNo); 
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
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
		
		// === #119. 페이지바 만들기 === //
		String pageBar = "<ul style='list-style: none; text-align:center;'>";
		
		int blockSize = 10;
		
		
		int loop = 1;
		/*
		    loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수[ 지금은 10개(== blockSize) ] 까지만 증가하는 용도이다.
		*/
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		System.out.println("총 게시글 수:"+totalCount+"/ pageNo:"+pageNo+"/ currentPage:"+currentShowPageNo);
		
		// 리스트 조회 //
		List<MailVO> mailList = service.mailList(paraMap);
		
		String url = request.getContextPath()+"/mail/list.top";
		
		// === [이전] 만들기 === 
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"&type="+type+"'>[이전]</a></li>";
		}
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"&type="+type+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo++;
			
		}// end of while------------------------------
		
		
		// === [다음] 만들기 ===
		if( !(pageNo > totalPage) ) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchWord="+searchWord+"&currentShowPageNo="+pageNo+"&type="+type+"'>[다음]</a></li>";
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
		
		if(searchWord.trim().isEmpty()) {
			if("receive".equals(type)) {
				mav.addObject("mailhamType","받은메일");
			}
			else if("send".equals(type)) {
				mav.addObject("mailhamType","보낸메일");
			}
			
			else if("mine".equals(type)) {
				mav.addObject("mailhamType","내게 쓴 메일");
			}
			
			else if("noRead".equals(type)) {
				mav.addObject("mailhamType","안 읽은 메일");
			}
			
			else if("attach".equals(type)) {
				mav.addObject("mailhamType","첨부파일 있는 메일");
			}
			
			else if("del".equals(type)) {
				mav.addObject("mailhamType","휴지통");
			}
			
			else if("all".equals(type)) {
				mav.addObject("mailhamType","전체메일");
			}
		}else {
			mav.addObject("mailhamType","메일 검색");
		}
		
		System.out.println("결과물 수 : "+mailList.size());
		
		if(request.getParameter("msg")!=null && !request.getParameter("msg").trim().isEmpty()) {
			mav.addObject("msg",request.getParameter("msg"));
		}
		
		mav.addObject("searchWord",searchWord);
		mav.addObject("mailList",mailList);
		mav.addObject("total",totalCount);
		mav.addObject("type",type);
		mav.addObject("readStatus",readStatus);
		mav.setViewName("mail/mailList.tiles2");
		
		return mav;
	}
	
	// 메일 쓰기 페이지 이동(메일쓰기, 내게쓰기)
	@RequestMapping(value="/mail/write.top")
	public ModelAndView mailWrite(ModelAndView mav, HttpServletRequest request) {
		String writeType = request.getParameter("type");
		if("normal".equals(writeType)) { // 메일쓰기 버튼 클릭 해서 입장할 경우
			
		}
		else if("mine".equals(writeType)) {
			HttpSession session = request.getSession();
			EmployeesVO emp = (EmployeesVO)session.getAttribute("loginEmployee");
			mav.addObject("receive",emp);
		}
		
		mav.setViewName("mail/mailWrite.tiles2");
		return mav;
	}
	
	// 메일 보내기 기능 //
	@RequestMapping(value="/mail/mailSend.top")
	public ModelAndView mailSend(ModelAndView mav, MultipartHttpServletRequest mrequest) {
		HttpSession session = mrequest.getSession();
		EmployeesVO empVO = (EmployeesVO)session.getAttribute("loginEmployee");
		String sendSeq = empVO.getEmployee_seq();
		String[] tempReceiveArr = mrequest.getParameterValues("receiveSeq");
		
		
		List<String> receiveArr = new ArrayList<>();
		boolean flag = false;
		for(int i=0; i<tempReceiveArr.length; i++) {
			for(int j=i+1; j<tempReceiveArr.length; j++) {
				if(tempReceiveArr[i].equals(tempReceiveArr[j])) {
					flag = true;
					break;
				}
			}
			if(!flag) {
				receiveArr.add(tempReceiveArr[i]);
			}
			flag = false;
		}
		
		for(String receiveSeq : receiveArr) {
			System.out.println("확인용 받는 메일번호:"+receiveSeq);
		}
		
		String subject = mrequest.getParameter("subject");
		String content = mrequest.getParameter("content");
		String sendType = mrequest.getParameter("sendType");
		List<MultipartFile> attachList = mrequest.getFiles("fileName");
		List<MailVO> mailList = new ArrayList<>();
		
		// 보내는 메일 VO 생성 //
		MailVO sendMail = new MailVO();
		sendMail.setFk_employee_seq(sendSeq);
		sendMail.setStatus("0"); // 발신 상태
		sendMail.setContent(content);
		sendMail.setSubject(subject);
		sendMail.setReadStatus("1");
		
		MailVO receiveMail = null;
		if(!"mine".equals(sendType)) {
			// 받는 메일 VO 생성 //
			receiveMail = new MailVO();
			receiveMail.setFk_employee_seq(receiveArr.get(0));
			receiveMail.setContent(content);
			receiveMail.setSubject(subject);
			receiveMail.setStatus("1");
			receiveMail.setReadStatus("0");
		}
		else {
			sendMail.setStatus("2"); //내게 쓰기 상태
			sendMail.setReadStatus("0");
		}
		
		
		// 메일 그룹번호 채번하기
		String mail_groupno = service.getMail_groupno();
		mail_groupno = String.valueOf(Integer.parseInt(mail_groupno)+1);
		sendMail.setMail_groupno(mail_groupno);
		
		if(!"mine".equals(sendType)) {
			receiveMail.setMail_groupno(mail_groupno);
		}
		
		
		
		if(!attachList.isEmpty()) {
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator + "mailUpload";
			String newSendFileName = "";
			String newReceiveFileName = "";
			
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
						
						newSendFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
						if(!"mine".equals(sendType)) {
							newReceiveFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
						}
						// 위의 것이 파일 올리기를 해주는 것이다.
						// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
						
						System.out.println(">>>> 확인용 newFileName ==> " + newSendFileName);
						System.out.println(">>>> 확인용 newFileName ==> " + newReceiveFileName);
				
					/*
					 	3. BoardVO boardvo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기	 	
					*/
						fileSize = attachList.get(i).getSize();
						
						if(cnt==0) {
							sendMail.setFileName1(newSendFileName);
							sendMail.setOrgFileName1(attachList.get(i).getOriginalFilename());
							sendMail.setFileSize1(String.valueOf(fileSize));
							
							if(receiveMail != null) {
								receiveMail.setFileName1(newReceiveFileName);
								receiveMail.setOrgFileName1(attachList.get(i).getOriginalFilename());
								receiveMail.setFileSize1(String.valueOf(fileSize));
							}
							
						}
						else if(cnt==1) {
							sendMail.setFileName2(newSendFileName);
							sendMail.setOrgFileName2(attachList.get(i).getOriginalFilename());
							sendMail.setFileSize2(String.valueOf(fileSize));
							
							if(receiveMail != null) {
								receiveMail.setFileName2(newReceiveFileName);
								receiveMail.setOrgFileName2(attachList.get(i).getOriginalFilename());
								receiveMail.setFileSize2(String.valueOf(fileSize));
							}
						}
						else {
							sendMail.setFileName3(newSendFileName);
							sendMail.setOrgFileName3(attachList.get(i).getOriginalFilename());
							sendMail.setFileSize3(String.valueOf(fileSize));
							
							if(receiveMail != null) {
								receiveMail.setFileName3(newReceiveFileName);
								receiveMail.setOrgFileName3(attachList.get(i).getOriginalFilename());
								receiveMail.setFileSize3(String.valueOf(fileSize));
							}
							
						}
						cnt++;
						// WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
								
									
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} // end of if(!attachList.isEmpty())-------------------------------------------------
		
		mailList.add(sendMail);
		
		if(receiveMail!=null) {
			System.out.println("확인용 receiveMail번호"+receiveMail.getFk_employee_seq());
			mailList.add(receiveMail);
			
			if(receiveArr.size()>1) {
				for(int i=0; i<receiveArr.size(); i++) {
					if(i>0) {
						MailVO otherReceive = new MailVO();
						otherReceive.setFk_employee_seq(receiveArr.get(i));
						otherReceive.setSubject(receiveMail.getSubject());
						otherReceive.setContent(receiveMail.getContent());
						otherReceive.setFileName1(receiveMail.getFileName1());
						otherReceive.setOrgFileName1(receiveMail.getOrgFileName1());
						otherReceive.setFileSize1(receiveMail.getFileSize1());
						otherReceive.setFileName2(receiveMail.getFileName2());
						otherReceive.setOrgFileName2(receiveMail.getOrgFileName2());
						otherReceive.setFileSize2(receiveMail.getFileSize2());
						otherReceive.setFileName3(receiveMail.getFileName3());
						otherReceive.setOrgFileName3(receiveMail.getOrgFileName3());
						otherReceive.setFileSize3(receiveMail.getFileSize3());
						otherReceive.setMail_groupno(mail_groupno);
						otherReceive.setStatus(receiveMail.getStatus());
						otherReceive.setReadStatus(receiveMail.getReadStatus());
						
						mailList.add(otherReceive);
					}
				}
			}
			
			for(MailVO mvo:mailList) {
				System.out.println("확인용 메일VO 번호:"+mvo.getFk_employee_seq());
			}
		}
		
		
		int count = mailList.size();
		int n = 0;
		System.out.println("입력할 행의 수:"+count);
		try{
			n = service.mailSend(mailList);
			if(n == count) {
				mav.addObject("result",true);
			}
			else {
				mav.addObject("result",false);
			}
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		mav.setViewName("mail/mailWrite.tiles2");
		return mav;
	}
	
	// 받는 사람 메일 검색 기능
	@ResponseBody
	@RequestMapping(value="/mail/searchReceive.top", produces= "text/plain;charset=UTF-8")
	public String searchReceive(HttpServletRequest request) {
		String keyWord = request.getParameter("keyWord");
		
		HttpSession session = request.getSession();
		EmployeesVO empVO = (EmployeesVO)session.getAttribute("loginEmployee");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("keyWord", keyWord);
		paraMap.put("loginSeq", empVO.getEmployee_seq());
		
		List<EmployeesVO> receiveList = service.searchReceive(paraMap);
		Gson gson = new Gson();
		
		return gson.toJson(receiveList);
	}
	
	// 메일 읽기 페이지 이동
	@RequestMapping(value="/mail/read.top")
	public ModelAndView mailRead(ModelAndView mav, HttpServletRequest request) {
		String mail_seq = request.getParameter("readSeq");
		String type = request.getParameter("type");
		String searchWord = request.getParameter("searchWord");
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(searchWord.trim().isEmpty()) {
			if("receive".equals(type)) {
				mav.addObject("mailhamType","받은메일");
			}
			else if("send".equals(type)) {
				mav.addObject("mailhamType","보낸메일");
			}
			
			else if("mine".equals(type)) {
				mav.addObject("mailhamType","내게 쓴 메일");
			}
			
			else if("noRead".equals(type)) {
				mav.addObject("mailhamType","안 읽은 메일");
			}
			
			else if("attach".equals(type)) {
				mav.addObject("mailhamType","첨부파일 있는 메일");
			}
			
			else if("del".equals(type)) {
				mav.addObject("mailhamType","휴지통");
			}
			
			else if("all".equals(type)) {
				mav.addObject("mailhamType","전체메일");
			}
		}else {
			mav.addObject("mailhamType","메일 검색");
		}
		
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO)session.getAttribute("loginEmployee");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("mail_seq", mail_seq);
		paraMap.put("type", type);
		paraMap.put("searchWord", searchWord);
		paraMap.put("loginSeq", emp.getEmployee_seq());
		
		int totalCount = service.getTotalCount(paraMap);
		mav.addObject("total",totalCount);
		
		System.out.println("mail_seq:"+mail_seq+"/type:"+type+"/searchWord:"+searchWord+"/loginSeq:"+emp.getEmployee_seq());
		
		MailVO mail = null;
		try {
			mail = service.mailRead(paraMap);
			if(mail!= null) {
				MailVO sender = service.mailSenderFind(mail.getMail_groupno());
				List<MailVO> receiver = service.mailReceiverFind(mail.getMail_groupno());
				
				for(MailVO rec : receiver) {
					System.out.println("받는사람:"+rec.getEmployee_name());
				}
				
				mav.addObject("sender",sender);
				mav.addObject("receiver",receiver);
			}
		}catch(Throwable e) {
			e.printStackTrace();
		}
		if(mail != null) {
			mav.addObject("mail",mail);
		}
		mav.addObject("type",type);
		mav.addObject("searchWord",searchWord);
		mav.addObject("mail_seq",mail_seq);
		
		mav.setViewName("mail/mailRead.tiles2");
		return mav;
	}
	
	// 스마트 에디터 사진첨부 //
	@RequestMapping(value="/image/multiplePhotoUpload.top", method={RequestMethod.POST})
	public void photoUpload(HttpServletRequest request, HttpServletResponse response) {
		/*
		 	1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		 	>>> 파일이 업로드 될 특정 경로(폴더)지정해주기
		 	우리는 WAS 의 webapp/resources/photo_upload 라는 폴더로 지정해준다.
		 */
		
		// WAS의 webapp 의 절대경로를 알아와야 한다.
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "photo_upload";
		/*	File.separator 는 운영체제에서 사용하는 폴더와 파일의 구분자이다.
		 	운영체제가 Windows 라면 File.separator 는 "\" 이고,
		 	운영체제가 UNIX, Linux 라면 File.separator 는 "/" 이다.
		 */
		
		// path 가 첨부파일을 저장할 WAS(톰캣)의 폴더가 된다.
		System.out.println("~~~~ 확인용 path => " + path);
		// ~~~~ 확인용 path => C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload
		
		File dir = new File(path);
		if(dir.exists()) {
			dir.mkdirs();
		}
		
		String strURL = "";
		
		try {
			if(!"OPTIONS".equals(request.getMethod().toUpperCase())) {
				String filename = request.getHeader("file-name"); //파일명을 받는다 - 일반 원본파일명
	
				// System.out.println(">>>> 확인용 filename ==> " + filename); 
				// >>>> 확인용 filename ==> berkelekle%ED%8A%B8%EB%9E%9C%EB%94%9405.jpg
		    		
				InputStream is = request.getInputStream();
			/*
				요청 헤더의 content-type이 application/json 이거나 multipart/form-data 형식일 때,
				혹은 이름 없이 값만 전달될 때 이 값은 요청 헤더가 아닌 바디를 통해 전달된다. 
				이러한 형태의 값을 'payload body'라고 하는데 요청 바디에 직접 쓰여진다 하여 'request body post data'라고도 한다.
	
				서블릿에서 payload body는 Request.getParameter()가 아니라 
				Request.getInputStream() 혹은 Request.getReader()를 통해 body를 직접 읽는 방식으로 가져온다. 	
			*/
				String newFilename = fileManager.doFileUpload(is, filename, path);
		    	
				int width = fileManager.getImageWidth(path+File.separator+newFilename);
				
				if(width > 600) {
					width = 600;
				}	
				// System.out.println(">>>> 확인용 width ==> " + width);
				// >>>> 확인용 width ==> 600
				// >>>> 확인용 width ==> 121
		    	
				String CP = request.getContextPath(); // board
				
				strURL += "&bNewLine=true&sFileName="; 
				strURL += newFilename;
				strURL += "&sWidth="+width;
				strURL += "&sFileURL="+CP+"/resources/photo_upload/"+newFilename;
			}
			
			/// 웹브라우저상에 사진 이미지를 쓰기 ///
			PrintWriter out = response.getWriter();
			out.print(strURL);
			System.out.println(strURL);
			
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
	// 파일 다운로드
	@RequestMapping(value="/mail/download.top",method = {RequestMethod.POST})
	public void attachFileDownload(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("fileName");
		String orgFileName = request.getParameter("orgFileName");
		String status = request.getParameter("status");
		
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator + "mailUpload";
		
		
		boolean flag = false;
		flag = fileManager.doFileDownload(fileName, orgFileName, path, response);
		response.setContentType("text/html; charset=UTF-8"); 
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(!flag) {
			// 다운로드가 실패할 경우 메시지를 띄워준다.
			writer.println("<script type='text/javascript'>alert('파일 다운로드가 불가능합니다.!!')</script>");  
			
		}
		else {
			writer.println("<javascript type='text/javascript'>history.go(0)</javascript>"); 
		}
		
		writer.close();
			
	}
	
	// 읽음 or 안읽음 버튼 클릭시 readStatus 업데이트
	@RequestMapping(value="/mail/readUpdate.top")
	public ModelAndView readUpdate(ModelAndView mav, HttpServletRequest request) {
		String read = request.getParameter("read");
		String type = request.getParameter("type");
		String searchWord = request.getParameter("searchWord");
		String[] selectCheck = request.getParameterValues("selectCheck");
		String str_currentPageNo = request.getParameter("currentShowPageNo");
		
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("read", read);
		paraMap.put("selectCheck", selectCheck);
		
		for(String select : selectCheck) {
			System.out.println(select);
		}
		
		
		int n = service.mailReadUpdate(paraMap);
		
		mav.addObject("searchWord",searchWord);
		mav.addObject("type",type);
		mav.addObject("read",read);
		mav.addObject("selectCheck",selectCheck);
		mav.addObject("currentShowPageNo",str_currentPageNo);
		mav.setViewName("redirect:/mail/list.top");
		return mav;
	}
	
	// 메일 휴지통에 이동(선택)
	@RequestMapping(value="/mail/mailDel.top")
	public ModelAndView mailDel(ModelAndView mav, HttpServletRequest request) {
		String[] selectCheck = request.getParameterValues("selectCheck");
		String searchWord = request.getParameter("searchWord");
		String type = request.getParameter("type");
		String str_currentPageNo = request.getParameter("currentShowPageNo");
		
		if(str_currentPageNo == null || str_currentPageNo.trim().isEmpty()) {
			str_currentPageNo = "1";
		}
		
		HashMap<String, String[]> paraMap = new HashMap<>();
		paraMap.put("selectCheck", selectCheck);
		
		int n = service.mailDel(paraMap);
		String msg = "삭제에 실패했습니다.";
		if(n == selectCheck.length) {
			msg = "선택한 메일을 휴지통에 버렸습니다.";
			mav.addObject("msg",msg);
		}
		
		mav.addObject("searchWord",searchWord);
		mav.addObject("type",type);
		mav.addObject("currentShowPageNo",str_currentPageNo);
		mav.setViewName("redirect:/mail/list.top");
		return mav;
	}
	
	// 메일 영구삭제
	@RequestMapping(value="/mail/mailDeletion.top")
	public ModelAndView mailDeletion(ModelAndView mav, HttpServletRequest request) {
		String type = request.getParameter("type");
		String str_currentPageNo = request.getParameter("currentShowPageNo");
		String[] selectCheck = request.getParameterValues("selectCheck");
		
		HashMap<String, String[]> paraMap = new HashMap<>();
		paraMap.put("selectCheck", selectCheck);
		
		// 업로드 파일 삭제과정
		//1. 업로드 경로 지정(send or receive + fileName)
		List<MailVO> deleteFileList = service.deleteFileList(paraMap);
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator;
		
		for(MailVO deleteFile : deleteFileList) {
			if("1".equals(deleteFile.getStatus())) {
				path += "receiveFiles";
			}
			else {
				path += "sendFiles";
			}
			
			try {
				fileManager.doFileDelete(deleteFile.getFileName1(), path); // fileName1삭제
				
				// fileName2가 존재할 경우 fileName2도 삭제
				if(deleteFile.getFileName2()!=null && !deleteFile.getFileName2().trim().isEmpty()) {
					fileManager.doFileDelete(deleteFile.getFileName2(), path);
				}
				
				// fileName3이 존재할 경우 fileName3도 삭제
				if(deleteFile.getFileName3()!=null && !deleteFile.getFileName3().trim().isEmpty()) {
					fileManager.doFileDelete(deleteFile.getFileName3(), path);
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		// DB에서 삭제
		int n = service.mailDeletion(paraMap);
		String msg = "";
		if(n == selectCheck.length) {
			msg = "선택한 메일을 휴지통에서 지웠습니다.";
			
		}
		mav.addObject("msg",msg);
		mav.addObject("type",type);
		mav.addObject("currentShowPageNo",str_currentPageNo);
		mav.setViewName("redirect:/mail/list.top");
		
		return mav;
	}
	
	// 메일 복구
	@RequestMapping(value="/mail/mailRestore.top")
	public ModelAndView mailRestore(ModelAndView mav, HttpServletRequest request) {
		String type = request.getParameter("type");
		String str_currentPageNo = request.getParameter("currentShowPageNo");
		String[] selectCheck = request.getParameterValues("selectCheck");
		
		HashMap<String, String[]> paraMap = new HashMap<>();
		paraMap.put("selectCheck", selectCheck);
		
		for(String check: selectCheck) {
			System.out.println("확인용:"+check);
		}
		
		int n = service.mailRestore(paraMap);
		
		String msg = "메일을 복구하는 도중 오류가 발생했습니다.";
		if(n == selectCheck.length) {
			msg = "선택한 메일을 성공적으로 복구했습니다.";
			
		}
		mav.addObject("msg",msg);
		mav.addObject("type",type);
		mav.addObject("currentShowPageNo",str_currentPageNo);
		mav.setViewName("redirect:/mail/list.top");
		
		return mav;
	}
	
	// 메일 전달or답장 페이지 이동
	@RequestMapping(value="/mail/mailUpdate.top",method= {RequestMethod.GET})
	public ModelAndView mailUpdate(ModelAndView mav, HttpServletRequest request) {
		String mail_seq = request.getParameter("readSeq"); //메일 번호
		String secendType = request.getParameter("secendType"); //메일 타입(전달 or 답장)
		
		System.out.println("mail_seq:"+mail_seq+"/ secendType:"+secendType);
		
		MailVO mail = service.findMail(mail_seq); // 1개 메일 찾기
		
		System.out.println("메일그룹번호"+mail.getMail_groupno());
		
		MailVO sender = service.mailSenderFind(mail.getMail_groupno()); //발신자
		List<MailVO> receiver = service.mailReceiverFind(mail.getMail_groupno()); // 수신자
		
		String origin = "-----Originer Messeage-----<br>";
		origin += "<b>From</b>: \""+sender.getEmployee_name()+"\"("+sender.getEmail()+")<br>";
		origin += "<b>To</b>: ";
		
		for(MailVO receive : receiver) {
			origin += "\""+receive.getEmployee_name()+"\"("+receive.getEmail()+");";
		}
		
		origin += "<br>";
		origin += "<b>Sent</b>: "+mail.getRegDate()+"<br>";
		origin += "<b>subject</b>: "+mail.getSubject() +"<br>";
		
		mav.addObject("origin",origin);
		mav.addObject("secendType",secendType);
		mav.addObject("mail",mail);
		mav.addObject("sender",sender);
		mav.setViewName("mail/mailUpdate.tiles2");
		return mav;
	}
	
	// 메일 답장 or 전달 기능 //
	@RequestMapping(value="/mail/mailReSend.top")
	public ModelAndView mailReSend(ModelAndView mav, MultipartHttpServletRequest mrequest) {
		HttpSession session = mrequest.getSession();
		EmployeesVO empVO = (EmployeesVO)session.getAttribute("loginEmployee");
		String sendSeq = empVO.getEmployee_seq();
		String[] tempReceiveArr = mrequest.getParameterValues("receiveSeq");
		
		
		List<String> receiveArr = new ArrayList<>();
		boolean flag = false;
		for(int i=0; i<tempReceiveArr.length; i++) {
			for(int j=i+1; j<tempReceiveArr.length; j++) {
				if(tempReceiveArr[i].equals(tempReceiveArr[j])) {
					flag = true;
					break;
				}
			}
			if(!flag) {
				receiveArr.add(tempReceiveArr[i]);
			}
			flag = false;
		}
		
		for(String receiveSeq : receiveArr) {
			System.out.println("확인용 받는 메일번호:"+receiveSeq);
		}
		
		String subject = mrequest.getParameter("subject");
		String content = mrequest.getParameter("content");
		String sendType = mrequest.getParameter("sendType");
		List<MultipartFile> newAttachList = mrequest.getFiles("newFileName"); //새롭게 추가
		
		List<MultipartFile> attachList = mrequest.getFiles("file"); //기존에 있던 첨부파일에서 수정한 것들
		String[] fileNameList = mrequest.getParameterValues("fileName"); // 기존 파일명
		String[] orgFileNameList = mrequest.getParameterValues("orgFileName");
		String[] fileSizeList = mrequest.getParameterValues("fileSize");
		
		
		
		
		List<MailVO> mailList = new ArrayList<>();
		
		// 보내는 메일 VO 생성 //
		MailVO sendMail = new MailVO();
		sendMail.setFk_employee_seq(sendSeq);
		sendMail.setStatus("0"); // 발신 상태
		sendMail.setContent(content);
		sendMail.setSubject(subject);
		sendMail.setReadStatus("1");
		
		MailVO receiveMail = null;
		
		// 받는 메일 VO 생성 //
		receiveMail = new MailVO();
		receiveMail.setFk_employee_seq(receiveArr.get(0));
		receiveMail.setContent(content);
		receiveMail.setSubject(subject);
		receiveMail.setStatus("1");
		receiveMail.setReadStatus("0");
		
				
		// 메일 그룹번호 채번하기
		String mail_groupno = service.getMail_groupno();
		mail_groupno = String.valueOf(Integer.parseInt(mail_groupno)+1);
		sendMail.setMail_groupno(mail_groupno);
		
		if(!"mine".equals(sendType)) {
			receiveMail.setMail_groupno(mail_groupno);
		}
		
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "mailUpload";
		String newSendFileName = "";
		String newReceiveFileName = "";
		
		if(!attachList.isEmpty()) {
			for(int i=0; i<attachList.size(); i++) {
				if(!attachList.get(i).isEmpty()) {
					byte[] bytes = null;
					long fileSize = 0;
					
					try {
						bytes = newAttachList.get(i).getBytes();
						// getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다. 
						// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
						// 이 파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
						
						newSendFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
						if(!"mine".equals(sendType)) {
							newReceiveFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), path);
						}
						// 위의 것이 파일 올리기를 해주는 것이다.
						// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
						
						System.out.println(">>>> 확인용 newFileName ==> " + newSendFileName);
				
					/*
					 	3. BoardVO boardvo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기	 	
					*/
						fileSize = newAttachList.get(i).getSize();
						
						if(i==0) {
							sendMail.setFileName1(newSendFileName);
							sendMail.setOrgFileName1(attachList.get(i).getOriginalFilename());
							sendMail.setFileSize1(String.valueOf(fileSize));
							
							receiveMail.setFileName1(newReceiveFileName);
							receiveMail.setOrgFileName1(attachList.get(i).getOriginalFilename());
							receiveMail.setFileSize1(String.valueOf(fileSize));
							
						}
						else if(i==1) {
							sendMail.setFileName2(newSendFileName);
							sendMail.setOrgFileName2(attachList.get(i).getOriginalFilename());
							sendMail.setFileSize2(String.valueOf(fileSize));
							
							receiveMail.setFileName2(newReceiveFileName);
							receiveMail.setOrgFileName2(attachList.get(i).getOriginalFilename());
							receiveMail.setFileSize2(String.valueOf(fileSize));
							
						}
						else {
							sendMail.setFileName3(newSendFileName);
							sendMail.setOrgFileName3(attachList.get(i).getOriginalFilename());
							sendMail.setFileSize3(String.valueOf(fileSize));
							
							receiveMail.setFileName3(newReceiveFileName);
							receiveMail.setOrgFileName3(attachList.get(i).getOriginalFilename());
							receiveMail.setFileSize3(String.valueOf(fileSize));
							
							
						}
											
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				else {
					if(i==0) {
						sendMail.setFileName1(fileNameList[i]);
						sendMail.setOrgFileName1(orgFileNameList[i]);
						sendMail.setFileSize1(fileSizeList[i]);
						
						receiveMail.setFileName1(fileNameList[i]);
						receiveMail.setOrgFileName1(orgFileNameList[i]);
						receiveMail.setFileSize1(fileSizeList[i]);
					}
					else if(i==1) {
						sendMail.setFileName2(fileNameList[i]);
						sendMail.setOrgFileName2(orgFileNameList[i]);
						sendMail.setFileSize1(fileSizeList[i]);
						
						receiveMail.setFileName2(fileNameList[i]);
						receiveMail.setOrgFileName2(orgFileNameList[i]);
						receiveMail.setFileSize2(fileSizeList[i]);
					}
					else if(i==2) {
						sendMail.setFileName1(fileNameList[i]);
						sendMail.setOrgFileName1(orgFileNameList[i]);
						sendMail.setFileSize1(fileSizeList[i]);
						
						receiveMail.setFileName1(fileNameList[i]);
						receiveMail.setOrgFileName1(orgFileNameList[i]);
						receiveMail.setFileSize1(fileSizeList[i]);
					}
				}
				
			}
		}
		
		
		if(!newAttachList.isEmpty()) {
			int cnt = 0;
			
			for(int i=0; i<newAttachList.size(); i++) {
				if(!newAttachList.get(i).isEmpty()) {
					System.out.println("파일 업로드");
					byte[] bytes = null;
					long fileSize = 0;
					
					try {
						bytes = newAttachList.get(i).getBytes();
						// getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다. 
						// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
						// 이 파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
						
						newSendFileName = fileManager.doFileUpload(bytes, newAttachList.get(i).getOriginalFilename(), path);
						if(!"mine".equals(sendType)) {
							newReceiveFileName = fileManager.doFileUpload(bytes, newAttachList.get(i).getOriginalFilename(), path);
						}
						// 위의 것이 파일 올리기를 해주는 것이다.
						// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
						
						System.out.println(">>>> 확인용 newFileName ==> " + newSendFileName);
				
					/*
					 	3. BoardVO boardvo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기	 	
					*/
						fileSize = newAttachList.get(i).getSize();
						
						if(cnt==0) {
							sendMail.setFileName1(newSendFileName);
							sendMail.setOrgFileName1(newAttachList.get(i).getOriginalFilename());
							sendMail.setFileSize1(String.valueOf(fileSize));
							
							receiveMail.setFileName1(newReceiveFileName);
							receiveMail.setOrgFileName1(newAttachList.get(i).getOriginalFilename());
							receiveMail.setFileSize1(String.valueOf(fileSize));
							
						}
						else if(cnt==1) {
							sendMail.setFileName2(newSendFileName);
							sendMail.setOrgFileName2(newAttachList.get(i).getOriginalFilename());
							sendMail.setFileSize2(String.valueOf(fileSize));
							
							receiveMail.setFileName2(newReceiveFileName);
							receiveMail.setOrgFileName2(newAttachList.get(i).getOriginalFilename());
							receiveMail.setFileSize2(String.valueOf(fileSize));
							
						}
						else {
							sendMail.setFileName3(newSendFileName);
							sendMail.setOrgFileName3(newAttachList.get(i).getOriginalFilename());
							sendMail.setFileSize3(String.valueOf(fileSize));
							
							receiveMail.setFileName3(newReceiveFileName);
							receiveMail.setOrgFileName3(newAttachList.get(i).getOriginalFilename());
							receiveMail.setFileSize3(String.valueOf(fileSize));
							
							
						}
						cnt++;
						// WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
								
									
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		} // end of if(!attachList.isEmpty())-------------------------------------------------
		
		mailList.add(sendMail);
		if(receiveMail!=null) {
			System.out.println("확인용 receiveMail번호"+receiveMail.getFk_employee_seq());
			mailList.add(receiveMail);
			
			if(receiveArr.size()>1) {
				for(int i=0; i<receiveArr.size(); i++) {
					if(i>0) {
						MailVO otherReceive = new MailVO();
						otherReceive.setFk_employee_seq(receiveArr.get(i));
						otherReceive.setSubject(receiveMail.getSubject());
						otherReceive.setContent(receiveMail.getContent());
						otherReceive.setFileName1(receiveMail.getFileName1());
						otherReceive.setOrgFileName1(receiveMail.getOrgFileName1());
						otherReceive.setFileSize1(receiveMail.getFileSize1());
						otherReceive.setFileName2(receiveMail.getFileName2());
						otherReceive.setOrgFileName2(receiveMail.getOrgFileName2());
						otherReceive.setFileSize2(receiveMail.getFileSize2());
						otherReceive.setFileName3(receiveMail.getFileName3());
						otherReceive.setOrgFileName3(receiveMail.getOrgFileName3());
						otherReceive.setFileSize3(receiveMail.getFileSize3());
						otherReceive.setMail_groupno(mail_groupno);
						otherReceive.setStatus(receiveMail.getStatus());
						otherReceive.setReadStatus(receiveMail.getReadStatus());
						
						mailList.add(otherReceive);
					}
				}
			}
			
			for(MailVO mvo:mailList) {
				System.out.println("확인용 메일VO 번호:"+mvo.getFk_employee_seq());
			}
		}
		
		
		int count = mailList.size();
		int n = 0;
		System.out.println("입력할 행의 수:"+count);
		try{
			n = service.mailSend(mailList);
			if(n == count) {
				mav.addObject("result",true);
			}
			else {
				mav.addObject("result",false);
			}
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		mav.setViewName("mail/mailWrite.tiles2");
		return mav;
	}
	
	// 사이드에 있는 메일바에 표시할 카운트 수 조회 //
	@ResponseBody
	@RequestMapping(value="/mail/noRead.top", produces="text/plain;charset=UTF-8")
	public String mailNoRead(HttpServletRequest request) {
		String loginSeq = request.getParameter("loginSeq");
		String type="noRead";
		
		HashMap<String, String>paraMap = new HashMap<>();
		paraMap.put("loginSeq", loginSeq);
		paraMap.put("type", type);
		
		
		int noReadCount = service.getTotalCount(paraMap);
		
		type="del";
		paraMap.put("type", type);
		int delCount = service.getTotalCount(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("noReadCount", String.valueOf(noReadCount));
		jsonObj.put("delCount", delCount);
		
		return jsonObj.toString();
	}
	
	//휴지통 비우기 기능
	@ResponseBody
	@RequestMapping(value="/mail/drop.top", produces="text/plain;charset=UTF-8")
	public String mailDrop(HttpServletRequest request) {
		String loginSeq = request.getParameter("loginSeq");
		String type = "del";
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("type", type);
		paraMap.put("loginSeq", loginSeq);
		
		int cnt = service.getTotalCount(paraMap);
		int result = service.mailDrop(loginSeq);
		
		System.out.println("cnt:"+cnt+"/result:"+result);
		
		String msg = "";
		if(cnt == 0) {
			msg = "이미 휴지통이 비워져있습니다.";
		}
		
		else if(cnt == result) {
			msg = "휴지통을 비웠습니다.";
		}
		else {
			msg="휴지통을 비우는데 실패했습니다.";
		}
		
		JSONObject json = new JSONObject();
		json.put("msg", msg);
		return json.toString();
	}
	
	// 1분마다 계속 실행하는 내용(새로온 메일이 있는지 확인)
	@ResponseBody
	@RequestMapping(value="/mail/newMailFind.top",produces="text/plain;charset=UTF-8")
	public String newMailFind(HttpServletRequest request) {
		String type = "noRead";
		String loginSeq = request.getParameter("loginSeq");
		
		HashMap<String, String>paraMap = new HashMap<>();
		paraMap.put("type", type);
		paraMap.put("loginSeq", loginSeq);
		
		int result = service.getTotalCount(paraMap);
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	// 특정 요청 메일 발송 기능(동호회 신청, 예약신청 결과 전송)
	@ResponseBody
	@RequestMapping(value="/mail/requestMail.top",produces="text/plain;charset=UTF-8")
	public String requestMail(HttpServletRequest request) {
		String type = request.getParameter("type"); //동호회 신청 or 예약신청 결과
		String reason = request.getParameter("reason"); //전송할 내용에 사용될 사유
		String receive = request.getParameter("receive"); //전송할 상대(동호회신청=회장 / 예약신청 결과=신청자)
		
		String subject = ""; //전송할 메일의 제목 
		String content = ""; // 전송할 메일의 내용
		
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO)session.getAttribute("loginEmployee");
		
		List<MailVO> mailList = new ArrayList<>();
		
		if("club".equals(type)) { //동호회 신청일 경우의 메일 양식
			String clubName = request.getParameter("clubName"); //전송할 메일 제목
			subject +=clubName+"가입을 희망합니다.";
			content +=clubName+"가입을 희망합니다.<br>";
			content +="신청자 : "+emp.getEmployee_name()+"("+emp.getDepartment_name()+"/"+emp.getPosition_name()+")<br>";
			content +="사유 : "+reason;
			
		}
		else { // 예약신청 결과일 경우의 메일 양식
			
		}
		// 보내는 메일 VO 생성 //
		MailVO sendMail = new MailVO();
		sendMail.setFk_employee_seq(emp.getEmployee_seq());
		sendMail.setStatus("0"); // 발신 상태
		sendMail.setContent(content);
		sendMail.setSubject(subject);
		sendMail.setReadStatus("1");

		// 받는 메일 VO 생성 //
		MailVO receiveMail = new MailVO();
		receiveMail.setFk_employee_seq(receive);
		receiveMail.setContent(content);
		receiveMail.setSubject(subject);
		receiveMail.setStatus("1");
		receiveMail.setReadStatus("0");
		
		mailList.add(sendMail);
		mailList.add(receiveMail);
		
		int count = mailList.size();
		int n = 0;
		System.out.println("입력할 행의 수:"+count);
		
		boolean result = false;
		
		try{
			n = service.mailSend(mailList);
			if(n == count) {
				result = true;
			}
			else {
				result = false;
			}
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		
		return json.toString();
	}
	
	
}
