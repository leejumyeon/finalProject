package com.spring.groupware.choijh.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groupware.choijh.model.InterChoijhDAO;
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CommentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

@Service
public class ChoijhService implements InterChoijhService {

	@Autowired 
	private InterChoijhDAO dao;

	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	@Override
	public List<EmployeesVO> allEmployeeView(String employee_seq) {
		List<EmployeesVO> empList = dao.allEmployeeView(employee_seq);
		return empList;
	}

	
	// 채팅 방 존재유무 조회하기
	@Override
	public String roomExist(HashMap<String, String> map) {
		String roomNumber = dao.roomExist(map);
		return roomNumber;
	}


	// 방번호 채번해오기
	@Override
	public int getRoomNumber() {
		int roomNum =dao.getRoomNumber();
		return roomNum;
	}

	
	// 채팅방 생성
	@Override
	public void createRoom(HashMap<String, String> map) {		
		dao.createRoom(map);
	}


	// 채팅방 내용 읽어오기 
	@Override
	public List<MessengerVO> contentView(String roomNumber) {
		List<MessengerVO> msgList = dao.contentView(roomNumber);
		return msgList;
	}


	// 채팅방 글쓰기
	@Override
	public int goWriteMsg(HashMap<String, String> map) {
		int n = dao.goWriteMsg(map);
		return n;
	}


	// 대화목록 보여주기
	@Override
	public List<HashMap<String, String>> msgRoomListView(HashMap<String,String> map) {
		List<HashMap<String, String>> mapList = dao.msgRoomListView(map);
		return mapList;
	}
	

	// 채팅 방 삭제하기
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	@Override
	public int roomDelete(HashMap<String, String> map) {
		
		dao.roomOutMsgInsert(map); // 채팅방 나갈시 메시지 띄우기
		
		int n = dao.roomDelete(map);
		return n;
	}


	// 그룹채팅 방 생성하기(자신)
	@Override
	public int groupChattRoomCreate_My(HashMap<String, Object> map) {
		int n = dao.groupChattRoomCreate_My(map);
		return n;
	}


	// 그룹채팅 방 생성하기(상대방)
	@Override
	public int groupChattRoomCreate_Other(HashMap<String, Object> map) {
		int m = dao.groupChattRoomCreate_Other(map);
		return m;
	}


	// 대화방을 나간 방번호 조회하기
	@Override
	public List<HashMap<String, String>> selectCnt(String employee_seq) {
		List<HashMap<String,String>> cntMapList = dao.selectCnt(employee_seq);
		return cntMapList;
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 자유 게시판 //
	

	// 자유게시판 글쓰기(첨부파일이 없는 경우)
	@Override
	public int add(BoardVO bvo) {
		int n = dao.add(bvo);
		return n;
	}

	
	// 자유게시판 글번호 채번해오기
	@Override
	public int getBordNum() {
		int n = dao.getBordNum();
		return n;
	}

	
	// 자유게시판 글쓰기(첨부파일이 있는 경우)
	@Override
	public int add_withFile(BoardVO bvo) {
		int n = dao.add_withFile(bvo);
		return n;
	}

	
	// 자유게시판 첨부파일 테이블 insert하기
	@Override
	public void addFile(AttachFileVO attachvo) {
		dao.addFile(attachvo);
	}

	// 자유게시판 글 보여주기
	@Override
	public List<BoardVO> boardlistView() {
		List<BoardVO> boardList = dao.boardlistView();
		return boardList;
	}


	// 자유게시판 글조회수 증가와 함께 글1개를 조회를 해주는 것 
	@Override
	public BoardVO detailView(String board_seq, String employee_seq) {
		
		BoardVO bvo = dao.detailView(board_seq);
		
		if(bvo != null && 
		   employee_seq != null && 
		   !bvo.getFk_employee_seq().equals(employee_seq)) {
			// 글조회수 증가는 다른 사람의 글을 읽을때만 증가하도록 해야 한다.
			// 로그인 하지 않은 상태에서는 글 조회수 증가는 없다.
			
			dao.setAddReadCount(board_seq); // 글 조회수 1증가 하기
			bvo = dao.detailView(board_seq);
		}
		
		return bvo;
	}

	
	// 자유게시판 글 조회수 증가 없이 단순히 글1개 조회하기
	@Override
	public BoardVO detailViewNoAddCount(String board_seq) {
		BoardVO bvo = dao.detailView(board_seq);
		return bvo;
	}
	

	// 해당게시글의 첨부파일 읽어오기 
	@Override
	public List<AttachFileVO> getfileView(String board_seq) {
		List<AttachFileVO> attachvoList = dao.getfileView(board_seq);
		return attachvoList;
	}
	
	
	// 자유게시판 글 삭제
	@Override
	public int del(String board_seq) {
		int n = dao.del(board_seq);
		return n;
	}


	// 자유게시판 글 수정 하기 
	@Override
	public int edit(BoardVO bvo) {
		int n = dao.edit(bvo);
		return n;
	}

	
	// 댓글 쓰기 및 원글게시물 댓글수 +1 증가
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addComment(CommentVO cvo) {
		int n = 0;
		int result = 0;
		
		n = dao.addComment(cvo); // 자유게시판 댓글쓰기
		
		if(n ==1) {
			result = dao.updateCommentCnt(cvo.getFk_board_seq()); // 해당 댓글의 게시물에 댓글 수 증가
		}
		
		return result;
	}


	// 댓글 내용(페이징처리 x) 보여주기
	@Override
	public List<CommentVO> goReadComment(String fk_board_seq) {
		List<CommentVO> commentList = dao.goReadComment(fk_board_seq);
		return commentList;
	}


	// 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		int totalCount = dao.getTotalCount(paraMap);
		return totalCount;
	}


	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
	@Override
	public List<BoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = dao.boardListSearchWithPaging(paraMap);
		return boardList;
	}

	// 답글쓰기 및 원글게시물 댓글수 +1 증가
	@Override
	@Transactional(propagation=Propagation.REQUIRED, isolation=Isolation.READ_COMMITTED, rollbackFor= {Throwable.class})
	public int addChildComment(CommentVO cvo) {
		
		int n = 0;
		int result = 0;
		
		n = dao.addChildComment(cvo); // 자유게시판 댓글의 답글 쓰기
		
		if(n ==1) {
			result = dao.updateChildCommentCnt(cvo.getFk_board_seq()); // 해당 댓글의 게시물에 댓글 수 +1 증가
		}
		
		return result;
	}

	

	

	


	

	

	
	
	
}
