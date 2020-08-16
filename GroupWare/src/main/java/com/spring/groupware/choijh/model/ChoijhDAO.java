package com.spring.groupware.choijh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MessengerVO;

@Repository
public class ChoijhDAO implements InterChoijhDAO {

	@Autowired
	private SqlSessionTemplate sqlsession;

	// 로그인 한 사원 정보를 제외한 모든 사원 정보 불러오기
	@Override
	public List<EmployeesVO> allEmployeeView(String employee_seq) {
		List<EmployeesVO> empList = sqlsession.selectList("messenger.allEmployeeView", employee_seq);
		return empList;
	}

	// 채팅 방 존재유무 조회하기
	@Override
	public String roomExist(HashMap<String, String> map) {
		String roomNumber = sqlsession.selectOne("messenger.roomExist", map);
		return roomNumber;
	}

	// 채팅 방번호 채번해오기
	@Override
	public int getRoomNumber() {
		int roomNum = sqlsession.selectOne("messenger.getRoomNumber");
		return roomNum;
	}

	// 채팅방 생성
	@Override
	public void createRoom(HashMap<String, String> map) {
		sqlsession.insert("messenger.createRoom_S", map);
		sqlsession.insert("messenger.createRoom_R", map);
	}

	// 채팅방 내용 읽어오기
	@Override
	public List<MessengerVO> contentView(String roomNumber) {
		List<MessengerVO> msgList = sqlsession.selectList("messenger.contentView", roomNumber);
		return msgList;
	}

	// 채팅방 글쓰기
	@Override
	public int goWriteMsg(HashMap<String, String> map) {
		int n = sqlsession.insert("messenger.goWriteMsg", map);
		return n;
	}

	// 대화목록 보여주기
	@Override
	public List<HashMap<String, String>> msgRoomListView(HashMap<String,String> map) {
		List<HashMap<String, String>> mapList = sqlsession.selectList("messenger.msgRoomListView", map);
		return mapList;
	}
	
	// 채팅 방 삭제하기
	@Override
	public int roomDelete(HashMap<String, String> map) {
		int n = sqlsession.delete("messenger.roomDelete",map);
		return n;
	}

	// 채팅방 나갈시 메시지 띄우기
	@Override
	public void roomOutMsgInsert(HashMap<String, String> map) {
		sqlsession.insert("messenger.roomOutMsgInsert", map);
	}
	
	// 그룹채팅 방 생성하기(자신)
	@Override
	public int groupChattRoomCreate_My(HashMap<String, Object> map) {
		int n = sqlsession.insert("messenger.groupChattRoomCreate_My", map);
		return n;
	}

	// 그룹채팅 방 생성하기(상대방)
	@Override
	public int groupChattRoomCreate_Other(HashMap<String, Object> map) {
		int m = sqlsession.insert("messenger.groupChattRoomCreate_Other", map);
		return m;
	}

	// 대화방을 나간 방번호 조회하기
	@Override
	public List<HashMap<String, String>> selectCnt(String employee_seq) {
		List<HashMap<String, String>> cntMapList = sqlsession.selectList("messenger.selectCnt", employee_seq);
		return cntMapList;
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// 자유 게시판 //
	
	
	// 자유게시판 글쓰기(첨부파일이 없는 경우)
	@Override
	public int add(BoardVO bvo) {
		int n = sqlsession.insert("freeboard.add", bvo);
		return n;
	}

	// 자유게시판 글번호 채번해오기
	@Override
	public int getBordNum() {
		int n = sqlsession.selectOne("freeboard.getBordNum");
		return n;
	}
	
	// 자유게시판 글쓰기(첨부파일이 있는 경우)
	@Override
	public int add_withFile(BoardVO bvo) {
		int n = sqlsession.insert("freeboard.add_withFile", bvo);
		return n;
	}

	// 자유게시판 첨부파일 테이블 insert하기
	@Override
	public int addFile(AttachFileVO attachvo) {
		int m = sqlsession.insert("freeboard.addFile", attachvo);
		return m;
	}

	// 자유게시판 글 보여주기
	@Override
	public List<BoardVO> boardlistView() {
		List<BoardVO> boardList = sqlsession.selectList("freeboard.boardlistView");
		return boardList;
	}

	// 자유게시판 상세 글 보여주기 
	@Override
	public BoardVO detailView(String board_seq) {
		BoardVO bvo = sqlsession.selectOne("freeboard.detailView", board_seq);
		return bvo;
	}

	

	

	
}
