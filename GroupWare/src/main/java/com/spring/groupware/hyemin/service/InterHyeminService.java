package com.spring.groupware.hyemin.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.ReservationVO;

public interface InterHyeminService {
	
	// 예약 가능한 시간 조회(Ajax)
	List<ReservationVO> select_possibleTime(HashMap<String, String> paraMap);

	// 검색어 입력 시 자동글 완성하기
	List<HashMap<String, String>> headSearchShow(String searchHead);

	// 회의실 예약하기(insert)
	void reserveRoomEnd(HashMap<String, String> paraMap);

	// 예약 신청 현황 조회(관리자)
	List<ReservationVO> waitingReservation();

	
	
}
