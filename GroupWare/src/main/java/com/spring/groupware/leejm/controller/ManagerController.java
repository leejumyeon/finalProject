package com.spring.groupware.leejm.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.metadata.GenericTableMetaDataProvider;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leejm.service.InterManagerService;


@Controller
public class ManagerController {
	
	@Autowired
	private InterManagerService service;	
	
	// ---------------------------------- 공지 사항 / FAQ시작 -------------------------------------------------------
	
	// 관리자 - 게시글 관리(FAQ 리스트)페이지[글목록]
	@RequestMapping(value="/manager/board/faqList.top")
	public String managerFaqList(HttpServletRequest request) {
		
		List<BoardVO> boardvoList = service.managerFaqList();
		
		request.setAttribute("boardvoList", boardvoList);
		
		return "admin/board/faqList.tiles3";
	}
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글목록] 
	@RequestMapping(value="/manager/board/noticeList.top")
	public String managerNoticeList(HttpServletRequest request) {
		
		List<BoardVO> boardvoList = service.managerNoticeList();
			
		request.setAttribute("boardvoList", boardvoList);
				
		return "admin/board/noticeList.tiles3";
	}

		
	// ---------------------------------- 공지 사항 / FAQ 끝 -------------------------------------------------------
	
		
	// 관리자-게시글 관리(공지사항 상세보기)페이지 이동
	@RequestMapping(value="/manager/board/noticeDetail.top")
	public ModelAndView managerNoticeDetail(ModelAndView mav, HttpServletRequest request) {
		String board_seq = request.getParameter("board_seq");
		BoardVO board = service.boardDetail(board_seq);
		
		if(board!=null) {
			List<AttachFileVO> fileList = service.boardFileList(board_seq);
			mav.addObject("fileList",fileList);
		}
		
		mav.addObject("board",board);
		mav.setViewName("admin/board/noticeDetail.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(공지사항 수정하기)페이지 이동
	@RequestMapping(value="/manager/board/noticeUpdate.top")
	public ModelAndView managerNoticeUpdate(ModelAndView mav, HttpServletRequest request) {
		String board_seq = request.getParameter("board_seq");
		BoardVO board = service.boardDetail(board_seq);
		
		if(board!=null) {
			List<AttachFileVO> fileList = service.boardFileList(board_seq);
			mav.addObject("fileList",fileList);
		}
		
		mav.addObject("board",board);
		mav.setViewName("admin/board/noticeUpdate.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(FAQ 수정하기)페이지 이동
	@RequestMapping(value="/manager/board/faqUpdate.top")
	public ModelAndView managerFaqUpdate(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/faqUpdate.tiles3");
		return mav;
	}

	
	// 관리자-재무 관리(급여내역)페이지 이동
	@RequestMapping(value="/manager/finance/salaryList.top")
	public ModelAndView managerSalaryList(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/finance/salaryList.tiles3");
		return mav;
	}
	
	// 관리자-재무 관리(매출내역)페이지 이동
	@RequestMapping(value="/manager/finance/salesList.top")
	public ModelAndView managerSalesList(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/finance/salesList.tiles3");
		return mav;
	}
	
}
