package com.spring.groupware.cha.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AlbumVO;
import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

public interface ChaInterService {
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 캘린더
	List<PersonalCalVO> fullCalendar(String employee);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 추가
	int insertFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정수정
	int updateFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정삭제
	int deleteFullCalendar(HashMap<String, String> paraMap);
	
	// 마이페이지(동호회) - 뿌리기
	List<HashMap<String,String>> club(HashMap<String, String> paraMap);
	
	// 마이페이지(동호회) - 팝업창에 해당 동호회 명단 뿌리기
	List<HashMap<String, String>> popup(HashMap<String, String> paraMap);
	
	// 마이페이지(예약) - 뿌리기
	List<HashMap<String, String>> reservation(HashMap<String, String> paraMap);
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정
	List<CompanyCalVO> adminFullCalendar();
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가
	int insertAdminCalendar(HashMap<String, String> paraMap);
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	int updateAdminCalendar(HashMap<String, String> paraMap);
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	int deleteAdminCalendar(HashMap<String, String> paraMap);
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 공지사항
	List<HashMap<String, String>> indication(HashMap<String, String> paraMap);
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 자유게시판
	List<HashMap<String, String>> freedom(HashMap<String, String> paraMap);
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 앨범게시판
	List<AlbumVO> album();

	// 메인페이지(공지사항 페이징 처리 된 거)
	int getTotalCount(HashMap<String, String> paraMap);

	// 메인페이지(페이징 처리한 공지사항 글목록 얻어오기)
	List<BoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap);

	// 메인페이지(공지사항 상세보기 가져오기)
	BoardVO detailNotice(String board_seq, String employee_seq);

	// 조호수 증가 없이 읽어오기
	BoardVO detailNoticeNoAddCount(String board_seq);

	// 첨부파일 읽어오기
	List<AttachFileVO> getfileView(String board_seq);

	
	
	
	
	

	
	
	
	
	
	
	
	

	


}
