package com.spring.groupware.hyemin.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.ReservationVO;

public interface InterHyeminDAO {

	// 예약 가능한 시간 조회(Ajax)
	List<ReservationVO> select_possibleTime(HashMap<String, String> paraMap);

	// 검색어 입력 시 자동글 완성하기
	List<HashMap<String, String>> headSearchShow(String searchHead);

	
	
}
