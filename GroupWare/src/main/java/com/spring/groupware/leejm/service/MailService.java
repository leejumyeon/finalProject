package com.spring.groupware.leejm.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.groupware.commonVO.EmployeesVO;
import com.spring.groupware.commonVO.MailVO;
import com.spring.groupware.leejm.model.InterMailDAO;

@Service
public class MailService implements InterMailService{
	@Autowired
	private InterMailDAO dao;

	// 메일작성 시에 사용하는 받는 사람 메일 검색기능
	@Override
	public List<EmployeesVO> searchReceive(HashMap<String, String>paraMap) {
		List<EmployeesVO> receiveList = dao.searchReceive(paraMap);
		return receiveList;
	}

	// 메일 보내기 기능(트랜잭션 처리 필요 - 메일의 수 만큼 insert를 해야 하고 중간에 오류가 발생할 경우 rollback)
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class})
	public int mailSend(List<MailVO> mailList) {
		int result = 0;
		for(MailVO mail : mailList) {
			result += dao.mailSend(mail);
		}
		return result;
	}

	// 메일 그룹번호 채번하기
	@Override
	public String getMail_groupno() {
		String mail_groupno = dao.getMail_groupno();
		return mail_groupno;
	}

	// 메일 리스트 조회
	@Override
	public List<MailVO> mailList(HashMap<String, String> paraMap) {
		List<MailVO> mailList = new ArrayList<MailVO>();
		if("receive".equals(paraMap.get("type"))) {
			mailList = dao.receiveMailList(paraMap);
		}
		else if("send".equals(paraMap.get("type"))) {
			mailList = dao.sendMailList(paraMap);
		}
		else if("mine".equals(paraMap.get("type"))) {
			mailList = dao.mineMailList(paraMap);
		}
		else if("read".equals(paraMap.get("type"))) {
			mailList = dao.noReadMailList(paraMap);
		}
		else if("attach".equals(paraMap.get("type"))) {
			mailList = dao.attachMailList(paraMap);
		}
		else if("search".equals(paraMap.get("type"))) {
			mailList = dao.searchMailList(paraMap);
		}
		return mailList;
	}

	// 메일 읽기 페이지 이동
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class})
	public MailVO mailRead(String mail_seq) {
		MailVO mail = dao.mailRead(mail_seq);
		
		if(mail!=null) {
			dao.updateReadstatus(mail_seq);
		}
		
		return mail;
	}
}
