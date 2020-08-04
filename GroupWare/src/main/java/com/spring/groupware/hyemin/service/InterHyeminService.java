package com.spring.groupware.hyemin.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.ReservationVO;

public interface InterHyeminService {
	
	// 예약 가능한 시간 조회(Ajax)
	List<ReservationVO> select_possibleTime(HashMap<String, String> paraMap);

	
	
}
