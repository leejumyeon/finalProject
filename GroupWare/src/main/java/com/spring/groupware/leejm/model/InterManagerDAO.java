package com.spring.groupware.leejm.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.DocumentVO;


public interface InterManagerDAO {
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글목록] 
	List<BoardVO> managerNoticeList();
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글쓰기]
	int managerNoticeInsert(HashMap<String, String> paraMap);
	
	// 관리자 - 게시글 관리(FAQ 리스트)페이지[글목록]
	List<BoardVO> managerFaqList();
	
	// 관리자- 결재 관리(결재현황 리스트)페이지 이동[글목록]
	List<DocumentVO> managerApprovalList();
	
	

}
