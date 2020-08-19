package com.spring.groupware.hyemin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.AttachFileVO;
import com.spring.groupware.commonVO.ReservationVO;
import com.spring.groupware.hyemin.model.InterHyeminDAO;

// === #31. Service 선언 ===
@Service
public class HyeminService implements InterHyeminService {

	// === #34. 의존객체 주입하기(DI) ===
	@Autowired
	private InterHyeminDAO dao;

	// === 예약 가능한 시간 조회(Ajax) ===	
	@Override
	public List<ReservationVO> select_possibleTime(HashMap<String, String> paraMap) {
		List<ReservationVO> rsvtvoList = dao.select_possibleTime(paraMap);
		return rsvtvoList;
	}

	// === 검색어 입력 시 자동글 완성하기 4 ===
	@Override
	public List<HashMap<String, String>> headSearchShow(String searchHead) {		
		List<HashMap<String, String>> headList = dao.headSearchShow(searchHead);
		return headList;
	}

	// === 회의실 예약하기(insert) ===
	@Override
	public void reserveRoomEnd(HashMap<String, String> paraMap) {
		dao.reserveRoomEnd(paraMap);
	}

	// === 예약 신청 현황 조회(관리자)(Ajax) === //
	@Override
	public List<ReservationVO> waitingReservation(HashMap<String, String> paraMap) {
		List<ReservationVO> rsvtvoList = dao.waitingReservation(paraMap);
		return rsvtvoList;
	}

	// === 예약 결과 현황 조회(관리자)(Ajax) === //
	@Override
	public List<ReservationVO> resultReservation(HashMap<String, String> paraMap) {
		List<ReservationVO> rsvtvoList = dao.resultReservation(paraMap);
		return rsvtvoList;
	}

	// === 예약 승인하기(관리자)(update) === //
	@Override
	public void approveRoom(String reservation_seq) {
		dao.approveRoom(reservation_seq);
	}
	
	// === 글번호 채번하기 === 
	@Override
	public int getBoard_seq() {
		int n = dao.getBoard_seq();
		return n;
	}
	
	// === 게시글 관리(공지사항 리스트)글 작성(관리자)(insert) === //
	@Override
	public int managerNoticeInsert(HashMap<String, Object> paraMap) {
		int n = dao.managerNoticeInsert(paraMap);
		return n;
	}
	
	// === 게시글 관리(공지사항 리스트)글 작성 시 첨부파일 추가(관리자)(insert) === //
	@Override
	public int managerNoticeFileInsert(AttachFileVO attachFile) {
		int m = dao.managerNoticeFileInsert(attachFile);
		return m;
	}


	
}
