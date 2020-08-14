package com.spring.groupware.leejm.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MailVO;

public interface InterMailDAO {

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	List<EmployeesVO> searchReceive(HashMap<String, String> paraMap);

	// 메일 보내기 기능
	int mailSend(MailVO mail);

	// 메일 그룹번호 채번하기
	String getMail_groupno();

	// 메일 조회
	List<MailVO> mailList(HashMap<String, String> paraMap);

	// 메일 읽기 
	MailVO mailRead(String mail_seq);

	// readCount 업데이트(0->1)
	void updateReadstatus(String mail_seq);


	// 메일 건 수
	int mailCount(HashMap<String, String> paraMap);

	// 메일 읽음 / 안읽음 수정
	int mailreadUpdate(HashMap<String, Object> paraMap);

	// 메일 휴지통으로 이동
	int mailDel(HashMap<String, String[]>paraMap);


	
}
