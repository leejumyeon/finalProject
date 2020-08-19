package com.spring.groupware.choijh.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CommentVO;
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
	public void addFile(AttachFileVO attachvo) {
		sqlsession.insert("freeboard.addFile", attachvo);
	}

	// 자유게시판 글 보여주기
	@Override
	public List<BoardVO> boardlistView() {
		List<BoardVO> boardList = sqlsession.selectList("freeboard.boardlistView");
		return boardList;
	}

	// 자유게시판 글1개를 조회를 해주는 것 
	@Override
	public BoardVO detailView(String board_seq) {
		BoardVO bvo = sqlsession.selectOne("freeboard.detailView", board_seq);
		return bvo;
	}
	
	// 글 조회수 1증가 하기
	@Override
	public void setAddReadCount(String board_seq) {
		sqlsession.update("freeboard.setAddReadCount", board_seq);
	}
	
	// 해당게시글의 첨부파일 읽어오기
	@Override
	public List<AttachFileVO> getfileView(String board_seq) {
		List<AttachFileVO> attachvoList = sqlsession.selectList("freeboard.getfileView", board_seq);
		return attachvoList;
	}
	

	// 자유게시판 글 삭제
	@Override
	public int del(String board_seq) {
		int n = sqlsession.delete("freeboard.del", board_seq);
		return n;
	}

	
	// 자유게시판 글 수정 하기 
	@Override
	public int edit(BoardVO bvo) {
		int n = sqlsession.update("freeboard.edit", bvo);
		return n;
	}

	// 자유게시판 댓글쓰기
	@Override
	public int addComment(CommentVO cvo) {
		int n = sqlsession.insert("freeboard.addComment", cvo);
		return n;
	}

	// 해당 댓글의 게시물에 댓글 수 증가
	@Override
	public int updateCommentCnt(String fk_board_seq) {
		int result = sqlsession.update("freeboard.updateCommentCnt", fk_board_seq);
		return result;
	}

	// 댓글 내용(페이징처리 x) 보여주기
	@Override
	public List<CommentVO> goReadComment(String fk_board_seq) {
		List<CommentVO> commentList = sqlsession.selectList("freeboard.goReadComment", fk_board_seq);
		return commentList;
	}

	// 댓글 내용(페이징처리 o) 보여주기
	@Override
	public List<CommentVO> getCommentListPaging(HashMap<String, String> paraMap) {
		List<CommentVO> commentList = sqlsession.selectList("freeboard.getCommentListPaging", paraMap);
		return commentList;
	}
	
	// 원글 글번호에(parentSeq)에 해당하는 댓글의 총갯수를 알아오기
	@Override
	public int getCommentTotalPage(HashMap<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("freeboard.getCommentTotalPage", paraMap);
		return totalCount;
	}
	
	// 총 게시물 건수(totalCount)
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		int totalCount = sqlsession.selectOne("freeboard.getTotalCount", paraMap);
		return totalCount;
	}

	// 페이징 처리한 글목록 가져오기(검색이 있든지, 검색이 없든지 모두 다 포함한것)
	@Override
	public List<BoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap) {
		List<BoardVO> boardList = sqlsession.selectList("freeboard.boardListSearchWithPaging", paraMap);
		return boardList;
	}

	// 자유게시판 댓글의 답글 쓰기
	@Override
	public int addChildComment(CommentVO cvo) {
		int n = sqlsession.insert("freeboard.addChildComment", cvo);
		return n;
	}

	// 해당 댓글의 게시물에 댓글 수 +1 증가
	@Override
	public int updateChildCommentCnt(String fk_board_seq) {
		int result = sqlsession.update("freeboard.updateChildCommentCnt", fk_board_seq);
		return result;
	}

	// 보존할 것들 이외 삭제할 첨부파일 번호 조회
	@Override
	public List<AttachFileVO> deleteFileList(HashMap<String, Object> paraMap) {
		List<AttachFileVO> deleteFileList = sqlsession.selectList("freeboard.deleteFileList", paraMap);
		return deleteFileList;
	}

	// 게시글 수정 - 첨부파일 삭제
	@Override
	public int deleteFile(HashMap<String, Object> paraMap) {
		int n = sqlsession.delete("freeboard.deleteFile", paraMap);
		return n;
	}

	// 게시글 수정 - 첨부파일 추가
	@Override
	public int insertFile(AttachFileVO uploadFile) {
		int n = sqlsession.insert("freeboard.insertFile", uploadFile);
		return n;
	}

	

	

	

	


	

	
}
