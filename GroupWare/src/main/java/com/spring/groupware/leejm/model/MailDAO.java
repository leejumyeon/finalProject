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
		return null;
	}

	// 첨부파일 있는 메일 조회
	@Override
	public List<MailVO> attachMailList(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}
}
