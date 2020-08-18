package com.spring.groupware.leejm.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.common.FileManager;
import com.spring.groupware.leejm.service.InterAdditionalService;
import com.spring.groupware.leejm.service.InterMailService;

@Controller
public class AdditionalController {
	@Autowired
	private InterAdditionalService service;
	
	@Autowired
	private FileManager fileManager;
	
	@ResponseBody
	@RequestMapping(value="/messenger/open.top", produces = "text/plain;charset=UTF-8")
	public String messengerOpen(HttpServletRequest request) {
		String messengerStatus = request.getParameter("messengerStatus");
		System.out.println("메신저 클릭");
		HttpSession session = request.getSession();
		if("messengerClose".equals(messengerStatus)) {
			session.removeAttribute("messenger");
		}
		else {
			session.setAttribute("messenger", true);
		}
		return "";
	}
	
	@RequestMapping(value="/board/download.top",method = {RequestMethod.POST})
	public void attachFileDownload(HttpServletRequest request, HttpServletResponse response) {
		String fileName = request.getParameter("fileName");
		String orgFileName = request.getParameter("orgFileName");
		String file_seq = request.getParameter("file_seq");
		
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root+"resources"+File.separator + "freeboard";
		
		
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
}
