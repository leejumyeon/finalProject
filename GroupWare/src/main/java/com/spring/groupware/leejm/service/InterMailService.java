package com.spring.groupware.leejm.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MailVO;

public interface InterMailService {

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	List<EmployeesVO> searchReceive(HashMap<String, String> paraMap);

	// 메일 보내기 기능
	int mailSend(List<MailVO> mailList) throws Throwable;

	// 메일 그룹번호 채번하기
	String getMail_groupno();

	// 메일 리스트(받은 메일함, 보낸 메일함, 내게 쓴 메일함, 휴지통) 조회
	List<MailVO> mailList(HashMap<String, String> paraMap);

	// 메일 읽기 페이지 이동
	MailVO mailRead(String mail_seq) throws Throwable;

	// 메일 게시글 수 조회
	int getTotalCount(HashMap<String, String> paraMap);

	// 메일 읽음 / 안읽음 으로 readStatus 업데이트
	int mailReadUpdate(HashMap<String, Object> paraMap);

	// 메일 휴지통으로 삭제
	int mailDel(HashMap<String, String[]>paraMap);

	// 메일 영구삭제
	int mailDeletion(HashMap<String, String[]> paraMap);

	// 삭제할 메일의 첨부파일 조회(status도 같이 조회 = 업로드 경로 확정시키기 위한 요소)
	List<MailVO> deleteFileList(HashMap<String, String[]> paraMap);

	// 메일 복구하기
	int mailRestore(HashMap<String, String[]> paraMap);

}
