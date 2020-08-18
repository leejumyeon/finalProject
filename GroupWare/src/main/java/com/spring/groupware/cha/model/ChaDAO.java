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
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가
	@Override
	public int insertAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = sqlsession.insert("cha.insertAdminCalendar", paraMap);
		
		System.out.println(n);
		
		return n;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	@Override
	public int updateAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = sqlsession.update("cha.updateAdminCalendar", paraMap);
		
		return n;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	@Override
	public int deleteAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = sqlsession.delete("cha.deleteAdminCalendar",paraMap);
		
		return n;
	}
	
	// 마이페이지(동호회) - 뿌리기
	@Override
	public List<HashMap<String,String>> club(HashMap<String, String> paraMap) {
		
		List<HashMap<String,String>> resultList = sqlsession.selectList("cha.club", paraMap);
		return resultList;
		
	}

	
	
	
	
	
	

}
