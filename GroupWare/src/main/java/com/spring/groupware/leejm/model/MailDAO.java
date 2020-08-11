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

	// 받은 메일 조회
	@Override
	public List<MailVO> receiveMailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.receiveMailList",paraMap);
		return mailList;
	}

	// 보낸 메일 조회
	@Override
	public List<MailVO> sendMailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.sendMailList",paraMap);
		return mailList;
	}

	// 검색 메일 조회
	@Override
	public List<MailVO> searchMailList(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}

	// 내게 쓴 메일 조회
	@Override
	public List<MailVO> mineMailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.mineMailList",paraMap);
		return mailList;
	}

	// 안 읽은 메일 조회
	@Override
	public List<MailVO> noReadMailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.noReadMailList", paraMap);
		return mailList;
	}

	// 첨부파일 있는 메일 조회
	@Override
	public List<MailVO> attachMailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.attachMailList",paraMap);
		return mailList;
	}

	// 메일 읽기
	@Override
	public MailVO mailRead(String mail_seq) {
		MailVO mail = sqlsession.selectOne("mail.mailRead",mail_seq);
		return mail;
	}

	// readCount 업데이트(0->1)
	@Override
	public void updateReadstatus(String mail_seq) {
		sqlsession.update("mail.updateReadstatus",mail_seq);
		
	}

	// 휴지통 이동
	@Override
	public List<MailVO> delMailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = sqlsession.selectList("mail.delMailList",paraMap);
		return mailList;
	}

	// 받은 메일 건 수
	@Override
	public int receiveMailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.receiveMailCount",paraMap);
		return result;
	}

	// 보낸 메일 건 수
	@Override
	public int sendMailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.sendMailCount",paraMap);
		return result;
	}

	// 내게 쓴 메일 건 수
	@Override
	public int mineMailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.mineMailCount",paraMap);
		return result;
	}

	// 안 읽은 메일 건 수
	@Override
	public int noReadMailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.noReadMailCount",paraMap);
		return result;
	}

	// 첨부파일 있는 메일 건 수
	@Override
	public int attachMailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.attachMailCount",paraMap);
		return result;
	}

	// 검색 메일 건 수
	@Override
	public int searchMailCount(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	// 휴지통 메일 건 수
	@Override
	public int delMailCount(HashMap<String, String> paraMap) {
		int result = sqlsession.selectOne("mail.delMailCount",paraMap);
		return result;
	}
}
