package com.spring.groupware.choijh.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
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

	int getBordNum(); // 자유게시판 글번호 채번해오기
	int add_withFile(BoardVO bvo, AttachFileVO attachvo); // 자유게시판 글쓰기(첨부파일이 있는 경우)

	List<BoardVO> boardlistView(); // 자유게시판 글 보여주기

	BoardVO detailView(String board_seq); // 자유게시판 상세 글 보여주기 

	
	

}
