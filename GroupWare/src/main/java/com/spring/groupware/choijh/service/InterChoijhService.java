package com.spring.groupware.choijh.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CommentVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

public interface InterChoijhService {

	List<EmployeesVO> allEmployeeView(String employee_seq); // 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기

	String roomExist(HashMap<String, String> map); // 채팅 방 존재유무 조회하기 

	int getRoomNumber(); // 방번호 채번해오기
	
	void createRoom(HashMap<String, String> map); // 채팅방 생성

	List<MessengerVO> contentView(String roomNumber); // 채팅방 내용 읽어오기 

	int goWriteMsg(HashMap<String, String> map); // 채팅방 글쓰기

	List<HashMap<String, String>> msgRoomListView(HashMap<String,String> map); // 대화목록 보여주기 
	
	int roomDelete(HashMap<String, String> map); // 채팅 방 삭제하기

	int groupChattRoomCreate_My(HashMap<String, Object> map); // 그룹채팅 방 생성하기(자신)

	int groupChattRoomCreate_Other(HashMap<String, Object> map); // 그룹채팅 방 생성하기(상대방)

	List<HashMap<String, String>> selectCnt(String employee_seq); // 대화방을 나간 방번호 조회하기

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 자유 게시판 //
	
	
	int add(BoardVO bvo); // 자유게시판 글쓰기(첨부파일이 없는 경우)

	int getBordNum(); 					 // 자유게시판 글번호 채번해오기
	int add_withFile(BoardVO bvo); 		 // 자유게시판 글쓰기(첨부파일이 있는 경우)
	void addFile(AttachFileVO attachvo); // 자유게시판 첨부파일 테이블 insert하기
	
	List<BoardVO> boardlistView(); // 자유게시판 글 보여주기

	BoardVO detailView(String board_seq, String employee_seq); 	// 자유게시판 글조회수 증가와 함께 글1개를 조회를 해주는 것
	BoardVO detailViewNoAddCount(String board_seq); 			// 자유게시판 글 조회수 증가 없이 단순히 글1개 조회하기
	
	List<AttachFileVO> getfileView(String board_seq); // 해당 게시글의 첨부파일 읽어오기 
	
	int del(String board_seq); // 자유게시판 글 삭제

	int edit(BoardVO bvo); // 자유게시판 글 수정 하기 

	int addComment(CommentVO cvo); // 댓글 쓰기 및 원글게시물 댓글수 +1 증가

	List<CommentVO> goReadComment(String fk_board_seq); // 댓글 내용(페이징처리 x) 보여주기

	int getTotalCount(HashMap<String, String> paraMap); // 총 게시물 건수(totalCount)

	List<BoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap); // 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)

	int addChildComment(CommentVO cvo); // 답글쓰기 및 원글게시물 댓글수 +1 증가

	

	

	

	
	

}
