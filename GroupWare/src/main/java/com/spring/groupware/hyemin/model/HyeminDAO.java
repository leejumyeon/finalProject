package com.spring.groupware.hyemin.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.ReservationVO;

//=== #32. DAO 선언 ===
@Repository
public class HyeminDAO implements InterHyeminDAO {

	// === #33. 의존객체 주입하기(DI) ===
	@Resource
	private SqlSessionTemplate sqlsession;

	// === 예약 가능한 시간 조회(Ajax) ===
	@Override
	public List<ReservationVO> select_possibleTime(HashMap<String, String> paraMap) {
		List<ReservationVO> rsvtvoList = sqlsession.selectList("hyemin.select_possibleTime", paraMap);
		return rsvtvoList;
	}

	// === 검색어 입력 시 자동글 완성하기 5 ===
	@Override
	public List<HashMap<String, String>> headSearchShow(String searchHead) {
		List<HashMap<String, String>> headList = sqlsession.selectList("hyemin.headSearchShow", searchHead);
		return headList;
	}

	// === 회의실 예약하기(insert) ===
	@Override
	public void reserveRoomEnd(HashMap<String, String> paraMap) {
		sqlsession.insert("hyemin.reserveRoomEnd", paraMap);
	}

	// === 예약 신청 현황 조회(관리자)(Ajax) ===
	@Override
	public List<ReservationVO> waitingReservation(HashMap<String, String> paraMap) {
		List<ReservationVO> rsvtvoList = sqlsession.selectList("hyemin.waitingReservation", paraMap);
		return rsvtvoList;
	}

	// === 예약 결과 현황 조회(관리자)(Ajax) ===
	@Override
	public List<ReservationVO> resultReservation(HashMap<String, String> paraMap) {
		List<ReservationVO> rsvtvoList = sqlsession.selectList("hyemin.resultReservation", paraMap);
		return rsvtvoList;
	}

	// === 예약 승인하기(관리자)(update) ===
	@Override
	public void approveRoom(String reservation_seq) {
		sqlsession.update("hyemin.approveRoom", reservation_seq);
	}

	// === 예약 반려하기 (관리자) === //
	@Override
	public void rejectRoom(String reservation_seq) {
		sqlsession.update("hyemin.rejectRoom", reservation_seq);
	}
	
}
