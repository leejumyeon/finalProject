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

	// 받은 메일 조회
	List<MailVO> receiveMailList(HashMap<String, String> paraMap);

	// 보낸 메일 조회
	List<MailVO> sendMailList(HashMap<String, String> paraMap);

	// 검색 메일 조회
	List<MailVO> searchMailList(HashMap<String, String> paraMap);

	// 내게 쓴 메일 조회
	List<MailVO> mineMailList(HashMap<String, String> paraMap);

	// 안 읽은 메일 조회
	List<MailVO> noReadMailList(HashMap<String, String> paraMap);

	// 첨부파일 있는 메일 조회
	List<MailVO> attachMailList(HashMap<String, String> paraMap);

	// 메일 읽기 
	MailVO mailRead(String mail_seq);

	// readCount 업데이트(0->1)
	void updateReadstatus(String mail_seq);
}
