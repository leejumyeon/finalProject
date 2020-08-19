package com.spring.groupware.cha.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.cha.model.ChaInterDAO;
import com.spring.groupware.commonVO.AlbumVO;
import com.spring.groupware.commonVO.CompanyCalVO;
import com.spring.groupware.commonVO.PersonalCalVO;

@Service
public class ChaService implements ChaInterService {
	
	@Autowired
	private ChaInterDAO dao;
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 캘린더
	@Override
	public List<PersonalCalVO> fullCalendar(String employee) {
		
		List<PersonalCalVO> perCalvo = dao.fullCalendar(employee);
		
		return perCalvo;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 추가
	@Override
	public int insertFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.insertFullCalendar(paraMap);
		
		return n;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 수정
	@Override
	public int updateFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.updateFullCalendar(paraMap);
		
		return n;
	}
	
	// 마이페이지(개인 일정 캘린더 & 책검색) - 일정 삭제
	@Override
	public int deleteFullCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.deleteFullCalendar(paraMap);
		
		return n;
	}
	
	// 마이페이지(동호회) - 뿌리기
	@Override
	public List<HashMap<String,String>> club(HashMap<String, String> paraMap) {
		
		List<HashMap<String,String>> resultList = dao.club(paraMap);
		
		return resultList;
	}
	
	// 마이페이지(동호회) - 팝업창에 해당 동호회 명단 뿌리기
	@Override
	public List<HashMap<String, String>> popup(HashMap<String, String> paraMap) {
		
		List<HashMap<String, String>> resultList = dao.popup(paraMap);
		
		return resultList;
	}
	
	// 마이페이지(예약) - 뿌리기
	@Override
	public List<HashMap<String, String>> reservation(HashMap<String, String> paraMap) {
		
		List<HashMap<String, String>> resultList = dao.reservation(paraMap);
		
		return resultList;
	}

	// 관리자 메인페이지(회사 일정 캘린더) - 회사 일정 캘린더
	@Override
	public List<CompanyCalVO> adminFullCalendar() {

		List<CompanyCalVO> comCalvo = dao.adminFullCalendar();
		
		return comCalvo;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정추가
	@Override
	public int insertAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.insertAdminCalendar(paraMap);
		
		return n;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 수정
	@Override
	public int updateAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.updateAdminCalendar(paraMap);
		
		return n;
	}
	
	// 관리자 메인페이지(회사 일정 캘린더) - 일정 삭제
	@Override
	public int deleteAdminCalendar(HashMap<String, String> paraMap) {
		
		int n = dao.deleteAdminCalendar(paraMap);
		
		return n;
	}
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 공지사항
	@Override
	public List<HashMap<String, String>> indication(HashMap<String, String> paraMap) {
		
		List<HashMap<String, String>> resultList = dao.indication(paraMap);
		
		return resultList;
		
	}
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 자유게시판
	@Override
	public List<HashMap<String, String>> freedom(HashMap<String, String> paraMap) {
		
		List<HashMap<String, String>> resultList = dao.freedom(paraMap);
		
		return resultList;
	}
	
	// 메인페이지(공지사항 및 자주묻는 질문, 자유게시판, 앨범게시판) - 앨범게시판
	@Override
	public List<AlbumVO> album() {
		
		List<AlbumVO> albumvoList = dao.album();
		
		return albumvoList;
	}
	
	

	
	

	
	

	


	

}
