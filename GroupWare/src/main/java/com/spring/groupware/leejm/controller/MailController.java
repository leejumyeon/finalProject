package com.spring.groupware.leejm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@RequestMapping(value="/test.top")
	public ModelAndView test(ModelAndView mav) {
		mav.setViewName("board/detailBoard.tiles1");
		return mav;
	}
	
	// 메일 리스트 페이지 이동(받은 메일함, 보낸 메일함, 전체 메일함, 내게 쓴 메일함)
	@RequestMapping(value="/mail/list.top")
	public ModelAndView mailList(ModelAndView mav, HttpServletRequest request) {
		String type = request.getParameter("type");
		HttpSession session = request.getSession();
		EmployeesVO emp = (EmployeesVO)session.getAttribute("loginEmployee");
		
		HashMap<String, String>paraMap = new HashMap<>();
		paraMap.put("type", type);
		paraMap.put("loginSeq", emp.getEmployee_seq());
		
		String currentPageNo = request.getParameter("currentPageNo");
		if(currentPageNo == null || currentPageNo.trim().isEmpty()) {
			currentPageNo = "1";
		}
		paraMap.put("currentPageNo", currentPageNo);
		
		String searchWord = request.getParameter("searchWord");
		String searchType = request.getParameter("searchType");
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
			searchType = "";
		}
		paraMap.put("searchWord", searchWord);
		paraMap.put("searchType", searchType);
		
		
		
		
		List<MailVO> mailList = service.mailList(paraMap);
		
		if("receive".equals(type)) {
			mav.addObject("mailhamType","받은메일");
		}
		else if("send".equals(type)) {
			mav.addObject("mailhamType","보낸메일");
		}
		
		else if("mine".equals(type)) {
			mav.addObject("mailhamType","내게 쓴 메일");
		}
		
		else if("read".equals(type)) {
			mav.addObject("mailhamType","안 읽은 메일");
		}
		
		else if("attach".equals(type)) {
			mav.addObject("mailhamType","첨부파일 있는 메일");
		}
		
		else if("search".equals(type)) {
			
		}
		
		mav.addObject("mailList",mailList);
		mav.setViewName("mail/mailList.tiles2");
		
		return mav;
	}
	
	// 메일 쓰기 페이지 이동(메일쓰기, 내게쓰기)
	@RequestMapping(value="/mail/write.top")
	public ModelAndView mailWrite(ModelAndView mav, HttpServletRequest request) {
		String writeType = request.getParameter("type");
		if("normal".equals(writeType)) { // 메일쓰기 버튼 클릭 해서 입장할 경우
			
		}
		else if("reply".equals(writeType)) { // 답장버튼 클릭해서 입장할 경우
			mav.addObject("receive","특정상대 메일");
		}
		else if("mine".equals(writeType)) {
			HttpSession session = request.getSession();
			EmployeesVO emp = (EmployeesVO)session.getAttribute("loginEmployee");
			mav.addObject("receive",emp);
		}
		
		mav.setViewName("mail/mailWrite.tiles2");
		return mav;
	}
	
	@RequestMapping(value="mail/mailSend.top")
	public ModelAndView mailSend(ModelAndView mav, MultipartHttpServletRequest mrequest) {
		HttpSession session = mrequest.getSession();
		EmployeesVO empVO = (EmployeesVO)session.getAttribute("loginEmployee");
		String sendSeq = empVO.getEmployee_seq();
		String[] receiveArr = mrequest.getParameterValues("receiveSeq");
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
			receiveMail.setFk_employee_seq(receiveArr[0]);
			receiveMail.setContent(content);
			receiveMail.setSubject(subject);
			receiveMail.setStatus("1");
			receiveMail.setReadStatus("0");
		}
		else {
			sendMail.setStatus("2"); //내게 쓰기 상태
		}
		
		
		// 메일 그룹번호 채번하기
		String mail_groupno = service.getMail_groupno();
		mail_groupno = String.valueOf(Integer.parseInt(mail_groupno)+1);
		sendMail.setMail_groupno(mail_groupno);
		receiveMail.setMail_groupno(mail_groupno);
		
		
		if(!attachList.isEmpty()) {
			String root = session.getServletContext().getRealPath("/");
			String sendPath = root + "resources" + File.separator + "sendFiles";
			String newSendFileName = "";
			String receivePath = root + "resources" + File.separator + "receiveFiles";
			String newReceiveFileName = "";
			
			for(int i=0; i<attachList.size(); i++) {
				
				byte[] bytes = null;
				
				long fileSize = 0;
				
				try {
					bytes = attachList.get(i).getBytes();
					// getBytes() 메소드는 첨부된 파일(attach)을 바이트단위로 파일을 다 읽어오는 것이다. 
					// 예를 들어, 첨부한 파일이 "강아지.png" 이라면
					// 이 파일을 WAS(톰캣) 디스크에 저장시키기 위해 byte[] 타입으로 변경해서 올린다.
					
					newSendFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), sendPath);
					if(!"mine".equals(sendType)) {
						newReceiveFileName = fileManager.doFileUpload(bytes, attachList.get(i).getOriginalFilename(), receivePath);
					}
					// 위의 것이 파일 올리기를 해주는 것이다.
					// attach.getOriginalFilename() 은 첨부된 파일의 파일명(강아지.png)이다.
					
					System.out.println(">>>> 확인용 newFileName ==> " + newSendFileName);
			
				/*
				 	3. BoardVO boardvo 에 fileName 값과 orgFileName 값과 fileSize 값을 넣어주기	 	
				*/
					fileSize = attachList.get(i).getSize();
					
					if(i==0) {
						sendMail.setFileName1(newSendFileName);
						sendMail.setOrgFileName1(attachList.get(i).getOriginalFilename());
						sendMail.setFileSize1(String.valueOf(fileSize));
						
						if(receiveMail != null) {
							receiveMail.setFileName1(newSendFileName);
							receiveMail.setOrgFileName1(attachList.get(i).getOriginalFilename());
							receiveMail.setFileSize1(String.valueOf(fileSize));
						}
						
					}
					else if(i==1) {
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
						sendMail.setFileName3(newReceiveFileName);
						sendMail.setOrgFileName3(attachList.get(i).getOriginalFilename());
						sendMail.setFileSize3(String.valueOf(fileSize));
						
						if(receiveMail != null) {
							receiveMail.setFileName3(newReceiveFileName);
							receiveMail.setOrgFileName3(attachList.get(i).getOriginalFilename());
							receiveMail.setFileSize3(String.valueOf(fileSize));
						}
						
					}
					// WAS(톰캣)에 저장될 파일명(20200725092715353243254235235234.png)
							
								
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				
			}
			
		} // end of if(!attachList.isEmpty())-------------------------------------------------
		
		mailList.add(sendMail);
		
		if(receiveMail!=null) {
			mailList.add(receiveMail);
			
			// 받는 사람 복수일 경우
			if(receiveArr.length>1) {
				for(int i=0; i<receiveArr.length; i++) {
					if(i>0) {
						receiveMail.setFk_employee_seq(receiveArr[i]);
						mailList.add(receiveMail);
					}
				}
			}
		}
		
		
		int count = mailList.size();
		int n = 0;
		System.out.println("입력할 행의 수:"+count);
		try{
			n = service.mailSend(mailList);
		}catch(Throwable e) {
			e.printStackTrace();
		}
		
		mav.setViewName("mail/mailList.tiles2");
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
		mav.setViewName("mail/mailRead.tiles2");
		return mav;
	}
	
	// 스마트 에디터 사진첨부 //
	@RequestMapping(value="/image/photoUpload.action", method={RequestMethod.POST})
	public String photoUpload(PhotoVO photovo, MultipartHttpServletRequest req) {
	    
	String callback = photovo.getCallback();
	String callback_func = photovo.getCallback_func();
	String file_result = "";
	    
	if(!photovo.getFiledata().isEmpty()) {
	   // 파일이 존재한다라면
			
		/*
		   1. 사용자가 보낸 파일을 WAS(톰캣)의 특정 폴더에 저장해주어야 한다.
		   >>>> 파일이 업로드 되어질 특정 경로(폴더)지정해주기
		        우리는 WAS 의 webapp/resources/files 라는 폴더로 지정해준다.
		 */
			
		// WAS 의 webapp 의 절대경로를 알아와야 한다. 
		HttpSession session = req.getSession();
		String root = session.getServletContext().getRealPath("/"); 
		String path = root + "resources"+File.separator+"photo_upload";
		// path 가 첨부파일들을 저장할 WAS(톰캣)의 폴더가 된다. 
			
		System.out.println(">>>> 확인용 path ==> " + path); 
		// >>>> 확인용 path ==> C:\springworkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\Board\resources\photo_upload  
			
			
		// 2. 파일첨부를 위한 변수의 설정 및 값을 초기화한 후 파일올리기
		String newFileName = "";
		// WAS(톰캣) 디스크에 저장할 파일명 
			
		byte[] bytes = null;
		// 첨부파일을 WAS(톰캣) 디스크에 저장할때 사용되는 용도 
						
		try {
			bytes = photovo.getFiledata().getBytes(); 
			// getBytes()는 첨부된 파일을 바이트단위로 파일을 다 읽어오는 것이다. 
			/* 2-1. 첨부된 파일을 읽어오는 것
	  		        첨부한 파일이 강아지.png 이라면
				이파일을 WAS(톰캣) 디스크에 저장시키기 위해
				byte[] 타입으로 변경해서 받아들인다.
			*/ 
			
                        // 2-2. 이제 파일올리기를 한다.
			String original_name = photovo.getFiledata().getOriginalFilename();
			//  photovo.getFiledata().getOriginalFilename() 은 첨부된 파일의 실제 파일명(문자열)을 얻어오는 것이다. 
			newFileName = fileManager.doFileUpload(bytes, original_name, path);
				
			// System.out.println(">>>> 확인용 newFileName ==> " + newFileName); 

			int width=fileManager.getImageWidth(path+File.separator+newFileName);
			 
                        if(width>600)
			   width=600;
	
			String CP = req.getContextPath();
			file_result += "&bNewLine=true&sFileName="+newFileName+"&sWidth="+width+"&sFileURL="+CP+"/resources/photo_upload/"+newFileName; 
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		} else {
			// 파일이 존재하지 않는다라면
			file_result += "&errstr=error";
		}
	    
		return "redirect:" + callback + "?callback_func="+callback_func+file_result;
	}
}
