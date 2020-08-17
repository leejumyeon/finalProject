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
	
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[작성페이지 - 뷰단] 
	@RequestMapping(value="/manager/board/boardWrite.top")
	public ModelAndView managerBoardWrite(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/boardWrite.tiles3");
		return mav;
	}
		
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[작성페이지 - 완료] 
	@RequestMapping(value="/manager/board/noticeInsert.top", method= {RequestMethod.POST})
	public String managerNoticeInsert(HashMap<String, String> paraMap, MultipartHttpServletRequest mrequest){
		
		/*HttpSession session = request.getSession();
		String loginEmployee = ((EmployeesVO) session.getAttribute("loginEmployee")).getEmployee_seq();
		
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
		HashMap<String, String> paraMap = new HashMap<>();
				
		paraMap.put("loginEmployee", loginEmployee);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		
		int n = service.managerNoticeInsert(paraMap);*/
		
		mrequest.getParameter("attach");
			
		return "admin/board/boardWrite.tiles3";
		
	}
		
	// ---------------------------------- 공지 사항 / FAQ 끝 -------------------------------------------------------
	
	
	// ---------------------------------- 결재 관리 시작 ----------------------------------------------
	
		// 관리자-결재 관리(결재현황 리스트)페이지 이동[글목록]
	
		@RequestMapping(value="/manager/approval/documentList.top")
		public String managerApprovalList(HttpServletRequest request ) {
			
			List<DocumentVO> dpmList = service.managerApprovalList();
			
			request.setAttribute("dpmList", dpmList);
			
			//System.out.println(dpmList.get(0).getFileName());
			
			return "admin/approval/documentList.tiles3";
		}
		
		// 관리자-결재 관리(휴지통)페이지 이동
		@RequestMapping(value="/manager/approval/garbage.top")
		public String managerGarbage(HttpServletRequest request) {
			
			return "admin/approval/garbage.tiles3";
		}
		
		// 관리자-결재 관리(문서함)페이지 이동
		@RequestMapping(value="/manager/approval/approvalList.top")
		public String managerDocumentList(HttpServletRequest request) {
			
			return "admin/approval/approvalList.tiles3";
			
		}
		
		// 관리자-결재 관리(결재현황 상세)페이지 이동
		@RequestMapping(value="/manager/approval/approvalDetail.top")
		public ModelAndView managerApprovalDetail(ModelAndView mav, HttpServletRequest request) {
			mav.setViewName("admin/approval/approvalDetail.tiles3");
			return mav;
		}
		
		// 관리자-결재 관리(문서함-상세)페이지 이동
		@RequestMapping(value="/manager/approval/documentDetail.top")
		public ModelAndView managerDocumentDetail(ModelAndView mav, HttpServletRequest request) {
			mav.setViewName("admin/approval/documentDetail.tiles3");
			return mav;
		}
		
		// ---------------------------------- 결재 관리 끝 ----------------------------------------------
	
		
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
	
	
	
	// 관리자-게시글 관리(신고글 조회)페이지 이동
	@RequestMapping(value="/manager/board/boardOut.top")
	public ModelAndView managerBoardOut(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/board/boardOut.tiles3");
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
		
	// 관리자-인사 관리(사원정보-상세)페이지 이동
	@RequestMapping(value="/manager/HR/detail.top")
	public ModelAndView managerHRdetail(ModelAndView mav, HttpServletRequest request) {
		mav.setViewName("admin/HR/detail.tiles3");
		return mav;
	}
	
	
}
