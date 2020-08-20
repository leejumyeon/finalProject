package com.spring.groupware.leejm.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.ChartVO;
import com.spring.groupware.commonVO.DocumentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.SalesVO;


public interface InterManagerService {
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글목록] 
	List<BoardVO> managerNoticeList();
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글쓰기] 
	int managerNoticeInsert(HashMap<String, String> paraMap);
	
	// 관리자 - 게시글 관리(FAQ 리스트)페이지[글목록]
	List<BoardVO> managerFaqList();

	// 관리자 - 게시글 상세보기
	BoardVO boardDetail(String board_seq);

	// 게시글 - 첨부파일 목록 조회
	List<AttachFileVO> boardFileList(String board_seq);

	// 게시글 수정 - 삭제할 파일 조회
	List<AttachFileVO> deleteFileList(HashMap<String, Object> paraMap);

	// 게시글 수정 - 첨부파일 삭제
	int deleteFile(HashMap<String, Object> paraMap);

	// 게시글 수정 - 본문 수정
	int boardUpdate(HashMap<String, Object> paraMap);

	// 게시글 수정 - 첨부파일 추가(업데이트, 추가)
	int insertFile(AttachFileVO uploadFile);

	// 게시글 관리 - 게시글 삭제
	int boardDelete(HashMap<String, Object> paraMap);

	// 매출관리 - 매출금액 조회
	List<ChartVO> saleCartList();

	// 매출관리 - 순이익 조회
	List<ChartVO> profitChartList();

	// 매출관리 - 매출 내용 조회
	List<SalesVO> salesList();

}
