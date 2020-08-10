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
	public List<String> headSearchShow(String searchHead) {
		List<String> headList = sqlsession.selectList("hyemin.headSearchShow", searchHead);
		return headList;
	}

	
	
}
