package com.spring.groupware.hyemin.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.ReservationVO;

public interface InterHyeminDAO {

	// 예약 가능한 시간 조회(Ajax)
	List<ReservationVO> select_possibleTime(HashMap<String, String> paraMap);

	// 검색어 입력 시 자동글 완성하기
	List<HashMap<String, String>> headSearchShow(String searchHead);

	// 회의실 예약하기(insert)
	void reserveRoomEnd(HashMap<String, String> paraMap);

	// 예약 신청 현황 조회(관리자)(Ajax)
	List<ReservationVO> waitingReservation(HashMap<String, String> paraMap);

	// 예약 결과 현황 조회(관리자)(Ajax)
	List<ReservationVO> resultReservation(HashMap<String, String> paraMap);

	// 예약 승인하기(관리자)(update)
	void approveRoom(String reservation_seq);

	
	
}
