package com.spring.groupware.leejm.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MailVO;

@Repository
public class MailDAO implements InterMailDAO{
	@Autowired 
	private SqlSessionTemplate sqlsession;

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	@Override
	public List<EmployeesVO> searchReceive(HashMap<String, String> paraMap) {
		List<EmployeesVO> receiveList = sqlsession.selectList("mail.searchReceive",paraMap);
		return receiveList;
	}

	// 메일 보내기 기능
	@Override
	public int mailSend(MailVO mail) {
		int n = sqlsession.insert("mail.mailSend",mail);
		return n;
	}

	// 메일 그룹번호 채번하기
	@Override
	public String getMail_groupno() {
		String mail_groupno = sqlsession.selectOne("mail.getMail_groupno");
		return mail_groupno;
	}

	// 메일 조회
	@Override
	public List<MailVO> mailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.mailList",paraMap);
		return mailList;
	}

	
	// 메일 읽기
	@Override
	public List<MailVO> mailRead(HashMap<String,String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.mailRead",paraMap);
		return mailList;
	}

	// readStatus 업데이트(0->1)
	@Override
	public void updateReadstatus(String mail_seq) {
		sqlsession.update("mail.updateReadstatus",mail_seq);
		
	}


	// 메일 건 수
	@Override
	public int mailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.mailCount",paraMap);
		return result;
	}

	// readStatus 업데이트(복수개, 0->1 or 1->0)
	@Override
	public int mailreadUpdate(HashMap<String, Object> paraMap) {
		int n = sqlsession.update("mail.mailreadUpdate",paraMap);
		return n;
	}

	// 메일 휴지통으로 이동
	@Override
	public int mailDel(HashMap<String, String[]>paraMap) {
		int n = sqlsession.update("mail.mailDel",paraMap);
		return n;
	}

	// 메일 영구삭제
	@Override
	public int mailDeletion(HashMap<String, String[]> paraMap) {
		int n = sqlsession.delete("mail.mailDeletion",paraMap);
		return n;
	}

	// 삭제할 메일의 첨부파일 조회(status도 같이 조회 = 업로드 경로 확정시키기 위한 요소)
	@Override
	public List<MailVO> deleteFileList(HashMap<String, String[]> paraMap) {
		List<MailVO> deleteFileList = sqlsession.selectList("mail.deleteFileList",paraMap);
		return deleteFileList;
	}

	// 메일 복구하기
	@Override
	public int mailResotre(HashMap<String, String[]> paraMap) {
		int n = sqlsession.update("mail.mailRestore",paraMap);
		return n;
	}

	// 보낸 사람 찾기
	@Override
	public MailVO mailSenderFind(String mail_groupno) {
		MailVO sender = sqlsession.selectOne("mail.mailSenderFind",mail_groupno);
		return sender;
	}

	// 받는 사람 찾기
	@Override
	public List<MailVO> mailReceiverFind(String mail_groupno) {
		List<MailVO> receiver = sqlsession.selectList("mail.mailReceiverFind",mail_groupno);
		return receiver;
	}

	// 1개 메일 찾기
	@Override
	public MailVO findMail(String mail_seq) {
		MailVO mail = sqlsession.selectOne("mail.findMail",mail_seq);
		return mail;
	}

	// 휴지통 비우기
	@Override
	public int mailDrop(String loginSeq) {
		int result = sqlsession.delete("mail.drop",loginSeq);
		return result;
	}

}
