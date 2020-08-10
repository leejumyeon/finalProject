package com.spring.groupware.cha.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

@Repository
public class ChaDAO implements ChaInterDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정
	@Override
	public List<PersonalCalVO> fullCalendar() {
		
		List<PersonalCalVO> perCalvo = sqlsession.selectList("cha.fullCalendar");
		
		return perCalvo;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 추가
	@Override
	public int insertFullCalendar(HashMap<String, String> paraMap) {
		
		int n = sqlsession.insert("cha.insertFullCalendar", paraMap);
		
		return n;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 수정
	@Override
	public int updateFullCalendar(HashMap<String, String> paraMap) {
		
		int n = sqlsession.update("cha.updateFullCalendar", paraMap);
		
		return n;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 삭제
	@Override
	public int deleteFullCalendar(HashMap<String, String> paraMap) {
		
		int n = sqlsession.delete("cha.deleteFullCalendar", paraMap);
		
		return n;
	}
	
	// 관리자 페이지 일정
	@Override
	public List<CompanyCalVO> adminFullCalendar() {

		List<CompanyCalVO> comCalvo = sqlsession.selectList("cha.adminFullCalendar");
		
		return comCalvo;
	}

	
	
	
	
	
	

}
