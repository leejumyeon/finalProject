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
	public int mailSend(List<MailVO> mailList) throws Throwable{
		int result = 0;
		for(MailVO mail : mailList) {
			
			System.out.println("확인용 : " + mail.getFk_employee_seq());
			
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
		List<MailVO> mailList = dao.mailList(paraMap);
		return mailList;
	}

	// 메일 읽기 페이지 이동(트랜잭션 처리 - 페이지 이동과 동시에 readStatus값 업데이트)
	@Override
	@Transactional(propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = {Throwable.class})
	public MailVO mailRead(String mail_seq) throws Throwable {
		MailVO mail = dao.mailRead(mail_seq);
		
		if(mail!=null) {
			dao.updateReadstatus(mail_seq);
		}
		
		return mail;
	}

	// 메일 건 수 조회
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		int result = dao.mailCount(paraMap);
		return result;
	}

	// 메일 읽음 안읽음 수정
	@Override
	public int mailReadUpdate(HashMap<String, Object> paraMap) {
		int n = dao.mailreadUpdate(paraMap);
		return n;
	}
}
