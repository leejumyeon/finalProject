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
	List<MailVO> mailRead(HashMap<String, String> paraMap);

	// readCount 업데이트(0->1)
	void updateReadstatus(String mail_seq);


	// 메일 건 수
	int mailCount(HashMap<String, String> paraMap);

	// 메일 읽음 / 안읽음 수정
	int mailreadUpdate(HashMap<String, Object> paraMap);

	// 메일 휴지통으로 이동
	int mailDel(HashMap<String, String[]>paraMap);

	// 메일 영구삭제
	int mailDeletion(HashMap<String, String[]> paraMap);

	// 삭제할 메일의 첨부파일 조회(status도 같이 조회 = 업로드 경로 확정시키기 위한 요소)
	List<MailVO> deleteFileList(HashMap<String, String[]> paraMap);

	// 메일 복구하기
	int mailResotre(HashMap<String, String[]> paraMap);

	// 보낸 사람 찾기
	MailVO mailSenderFind(String mail_groupno);

	// 받는 사람들 찾기
	List<MailVO> mailReceiverFind(String mail_groupno);

	// 1개 메일 찾기
	MailVO findMail(String mail_seq);

	// 휴지통 비우기
	int mailDrop(String loginSeq);


	
}
