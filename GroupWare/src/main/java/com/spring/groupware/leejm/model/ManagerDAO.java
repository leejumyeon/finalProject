package com.spring.groupware.leejm.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.DocumentVO;


@Repository
public class ManagerDAO implements InterManagerDAO {
	
	@Autowired 
	private SqlSessionTemplate sqlsession;
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글목록]
	@Override
	public List<BoardVO> managerNoticeList() {
		
		List<BoardVO> boardvoList = sqlsession.selectList("manager.managerNoticeList");
		
		return boardvoList;
	}
	
	// 관리자 - 게시글 관리(공지사항 리스트)페이지[글쓰기]
	@Override
	public int managerNoticeInsert(HashMap<String, String> paraMap) {
		
		int n = sqlsession.insert("manager.managerNoticeInsert",paraMap);
		
		return n;
	}
	
	// 관리자 - 게시글 관리(FAQ 리스트)페이지[글목록]
	@Override
	public List<BoardVO> managerFaqList() {
		
		List<BoardVO> boardvoList = sqlsession.selectList("manager.managerFaqList");
		
		return boardvoList;
		
	}

	// 관리자 - 게시글 관리(상세페이지)
	@Override
	public BoardVO boardDetail(String board_seq) {
		BoardVO board = sqlsession.selectOne("manager.boardDetail",board_seq);
		return board;
	}

	// 게시글 첨부파일 항목 조회
	@Override
	public List<AttachFileVO> boardFileList(String board_seq) {
		List<AttachFileVO> fileList = sqlsession.selectList("manager.boardFileList",board_seq);
		return fileList;
	}

}
