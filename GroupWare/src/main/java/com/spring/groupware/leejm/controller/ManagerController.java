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
	
	// 관리자-결재 관리(문서함)페이지 이동
	@RequestMapping(value="/manager/approval/documentList.top")
	public ModelAndView managerDocumentList(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/approval/documentList.tiles3");
		return mav;
	}
	
	// 관리자-결재 관리(문서함-상세)페이지 이동
	@RequestMapping(value="/manager/approval/documentDetail.top")
	public ModelAndView managerDocumentDetail(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/approval/documentDetail.tiles3");
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
	
	// 관리자-인사 관리(인사고과)페이지 이동
	@RequestMapping(value="/manager/HR/review.top")
	public ModelAndView managerHRreview(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/HR/review.tiles3");
		return mav;
	}
	
	// 관리자-인사 관리(사원정보-리스트)페이지 이동
	@RequestMapping(value="/manager/HR/list.top")
	public ModelAndView managerHRlist(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/HR/list.tiles3");
		return mav;
	}
		
	// 관리자-인사 관리(사원정보-상세)페이지 이동
	@RequestMapping(value="/manager/HR/detail.top")
	public ModelAndView managerHRdetail(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/HR/detail.tiles3");
		return mav;
	}
	
	
}
