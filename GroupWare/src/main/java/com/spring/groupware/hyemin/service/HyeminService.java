package com.spring.groupware.hyemin.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
}
