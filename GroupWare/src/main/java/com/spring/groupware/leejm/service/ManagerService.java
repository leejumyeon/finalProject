package com.spring.groupware.leejm.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.ChartVO;
import com.spring.groupware.commonVO.DocumentVO;
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

	// 관리자 - 게시글관리(공지사항 상세)페이지
	@Override
	public BoardVO boardDetail(String board_seq) {
		BoardVO board = dao.boardDetail(board_seq);
		return board;
	}

	// 게시글 첨부파일 목록 조회
	@Override
	public List<AttachFileVO> boardFileList(String board_seq) {
		List<AttachFileVO> fileList = dao.boardFileList(board_seq);
		return fileList;
	}

	// 게시글 수정 - 삭제할 파일 찾기
	@Override
	public List<AttachFileVO> deleteFileList(HashMap<String, Object> paraMap) {
		List<AttachFileVO> deleteFileList = dao.deleteFileList(paraMap);
		return deleteFileList;
	}

	// 게시글 수정 - 첨부파일 삭제
	@Override
	public int deleteFile(HashMap<String, Object> paraMap) {
		int result = dao.deleteFile(paraMap);
		return result;
	}

	// 게시글 수정 - 본문 수정
	@Override
	public int boardUpdate(HashMap<String, Object> paraMap) {
		int result = dao.boardUpdate(paraMap);
		return result;
	}

	// 게시글 수정 - 첨부파일 추가
	@Override
	public int insertFile(AttachFileVO uploadFile) {
		int result = dao.insertFile(uploadFile);
		return result;
	}

	// 게시글 관리 - 게시글 삭제
	@Override
	public int boardDelete(HashMap<String, Object> paraMap) {
		String[] board_seqArr = (String[]) paraMap.get("board_seqArr");
		int result = dao.boardDelete(paraMap);
		return result;
	}

	// 매출관리 - 프로젝트 매출금액
	@Override
	public List<ChartVO> saleCartList() {
		List<ChartVO> saleChartList = dao.saleChartList();
		return saleChartList;
	}

	// 매출관리 - 인건비 조회
	@Override
	public List<ChartVO> laborCostChartList() {
		List<ChartVO> laborCostChartList = dao.laborCostChartList();
		return laborCostChartList;
	}

	// 매출관리 - 시설유지비 조회
	@Override
	public List<ChartVO> maintainChartList() {
		List<ChartVO> maintainChartList = dao.maintainChartList();
		return maintainChartList;
	}

	// 매출관리 - 순이익조회
	@Override
	public List<ChartVO> profitChartList() {
		List<ChartVO> profitChartList = dao.profitChartList();
		return profitChartList;
	}
	

}
