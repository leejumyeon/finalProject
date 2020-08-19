package com.spring.groupware.leejm.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.metadata.GenericTableMetaDataProvider;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.ChartVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.leejm.service.InterManagerService;


@Controller
public class ManagerController {
	
	@Autowired
	private InterManagerService service;	
	
	@Autowired
	private FileManager fileManager;
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
	@RequestMapping(value="/manager/board/noticeUpdate.top", method= {RequestMethod.GET})
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
	
	// 관리자-게시글 관리(공지사항 수정하기) 기능 수행
	@RequestMapping(value="/manager/board/noticeUpdate.top", method= {RequestMethod.POST})
	public ModelAndView managerNoticeUpdateEnd(ModelAndView mav, MultipartHttpServletRequest mrequest) {
		String board_seq = mrequest.getParameter("board_seq");
		String subject = mrequest.getParameter("subject");
		String content = mrequest.getParameter("content");
		
		String[] orgFileNameList = mrequest.getParameterValues("orgFileName"); //기존 파일명
		String[] file_seqArr = mrequest.getParameterValues("file_seq"); // 기존 파일 번호
		String[] fileNameList = mrequest.getParameterValues("fileName"); // 기존 파일명(업로드 이름)
		String[] fileSizeList = mrequest.getParameterValues("fileSize"); // 기존 파일크기
		List<MultipartFile> attachList = mrequest.getFiles("attach"); //기존 파일 (업데이트)
		List<MultipartFile> newAttachList = mrequest.getFiles("newAttach"); // 새롭게 추가하는 파일
		
		System.out.println("attachList:"+attachList.size()+" / newAttachList:"+newAttachList.size());
		
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("board_seq", board_seq);
		paraMap.put("subject", subject);
		paraMap.put("content", content);
		paraMap.put("file_seqArr", file_seqArr);
		
		List<AttachFileVO> uploadFileList = new ArrayList<>(); // 업데이트 되는 또는 추가되는 파일 정보 저장용
		
		int result = 0; //DB에서 작업한 결과 저장용
		
		//글 수정
		result = service.boardUpdate(paraMap); //글 수정
		
		
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
		deleteFileList = service.deleteFileList(paraMap); //보존할 것들 이외 삭제할 첨부파일 번호 조회
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
			result += service.deleteFile(paraMap); //DB에서 삭제
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
						attachFile.setFk_board_seq(board_seq);
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
						attachFile.setFk_board_seq(board_seq);
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
				result += service.insertFile(uploadFile);
			}
		}
		
		
		String msg = "게시글 수정에 실패했습니다.";
		String loc = mrequest.getContextPath()+"/manager/board/noticeUpdate.top?board_seq="+board_seq;
		
		if(result == (uploadFileList.size()+deleteFileList.size()+1)) {
			msg = "게시글 수정에 성공했습니다.";
			loc = mrequest.getContextPath()+"/manager/board/noticeDetail.top?board_seq="+board_seq;
		}
		
		mav.addObject("message", msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		return mav;
	}
	
	// 관리자-게시글 관리(공지사항 삭제)
	@RequestMapping(value="/manager/board/noticeDelete.top")
	public ModelAndView managerNoticeDelete(ModelAndView mav, HttpServletRequest request) {
		String[] board_seqArr = request.getParameterValues("board_seq");
		HashMap<String, Object> paraMap = new HashMap<>();
		paraMap.put("board_seqArr", board_seqArr);
		
		HttpSession session = request.getSession();
		String root = session.getServletContext().getRealPath("/");
		String path = root + "resources" + File.separator + "freeboard";
		// 삭제하기 전에 첨부파일 존재 유무 확인 및 삭제
		for(String board_seq: board_seqArr) {
			paraMap.put("board_seq", board_seq);
			List<AttachFileVO> deleteFileList = service.deleteFileList(paraMap);
			if(!deleteFileList.isEmpty()) {
				for(AttachFileVO deleteFile: deleteFileList) {
					try {
						fileManager.doFileDelete(deleteFile.getFileName(), path);
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		
		int result = service.boardDelete(paraMap);
		
		String msg = "게시글 삭제에 실패했습니다.";
		String loc = "history.back()";
		
		if(result == board_seqArr.length) {
			msg = "게시글 삭제에 성공했습니다.";
			loc = request.getContextPath()+"/manager/board/noticeList.top";
		}
		
		mav.addObject("message", msg);
		mav.addObject("loc",loc);
		mav.setViewName("msg");
		
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
		List<ChartVO> projectChartList = service.saleCartList(); //프로젝트 매출금액 조회
		
		mav.setViewName("admin/finance/salesList.tiles3");
		return mav;
	}
	
}
