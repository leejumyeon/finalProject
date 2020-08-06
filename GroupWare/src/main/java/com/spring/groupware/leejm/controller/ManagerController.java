package com.spring.groupware.leejm.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.groupware.leejm.service.MailService;

@Controller
public class ManagerController {
	
	@Autowired
	private MailService service;
	
	// 관리자-예약관리 페이지 이동
	@RequestMapping(value="/manager/reservation.top")
	public ModelAndView managerReservation(ModelAndView mav) {
		mav.setViewName("admin/reservation.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(공지사항 리스트)페이지 이동
	@RequestMapping(value="/manager/board/noticeList.top")
	public ModelAndView managerNoticeList(ModelAndView mav) {
		mav.setViewName("admin/board/noticeList.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(FAQ 리스트)페이지 이동
	@RequestMapping(value="/manager/board/faqList.top")
	public ModelAndView managerFaqList(ModelAndView mav) {
		mav.setViewName("admin/board/faqList.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(공지사항 상세보기)페이지 이동
	@RequestMapping(value="/manager/board/noticeDetail.top")
	public ModelAndView managerNoticeDetail(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/noticeDetail.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(공지사항 수정하기)페이지 이동
	@RequestMapping(value="/manager/board/noticeUpdate.top")
	public ModelAndView managerNoticeUpdate(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/noticeUpdate.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(FAQ 수정하기)페이지 이동
	@RequestMapping(value="/manager/board/faqUpdate.top")
	public ModelAndView managerFaqUpdate(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/faqUpdate.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(공지글 작성)페이지 이동
	@RequestMapping(value="/manager/board/boardWrite.top")
	public ModelAndView managerBoardWrite(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/boardWrite.tiles3");
		return mav;
	}
	
	// 관리자-게시글 관리(신고글 조회)페이지 이동
	@RequestMapping(value="/manager/board/boardOut.top")
	public ModelAndView managerBoardOut(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/boardOut.tiles3");
		return mav;
	}
	
	// 관리자-결재 관리(결재현황 리스트)페이지 이동
	@RequestMapping(value="/manager/approval/approvalList.top")
	public ModelAndView managerApprovalList(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/approval/approvalList.tiles3");
		return mav;
	}
	
	// 관리자-결재 관리(결재현황 상세)페이지 이동
	@RequestMapping(value="/manager/approval/approvalDetail.top")
	public ModelAndView managerApprovalDetail(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/approval/approvalDetail.tiles3");
		return mav;
	}
	
	// 관리자-결재 관리(휴지통)페이지 이동
	@RequestMapping(value="/manager/approval/garbage.top")
	public ModelAndView managerGarbage(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/approval/garbage.tiles3");
		return mav;
	}
	
}
