package com.spring.groupware.leejm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.leejm.model.InterManagerDAO;


@Service
public class ManagerService implements InterManagerService {
	
	@Autowired
	private InterManagerDAO dao;
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글목록] 
	@Override
	public List<BoardVO> managerNoticeList() {
		
		List<BoardVO> boardvoList = dao.managerNoticeList();
		
		return boardvoList;
	}
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글쓰기] 
	@Override
	public int managerNoticeInsert(HashMap<String, String> paraMap) {
		
		int n = dao.managerNoticeInsert(paraMap);
		
		return n;
	}
    
	// 관리자 - 게시글 관리(FAQ 리스트)페이지[글목록]
	@Override
	public List<BoardVO> managerFaqList() {
		
		List<BoardVO> boardvoList = dao.managerFaqList();
		
		return boardvoList;
	}

	
	
	

}
