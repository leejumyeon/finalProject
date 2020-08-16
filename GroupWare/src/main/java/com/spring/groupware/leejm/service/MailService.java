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
	public MailVO mailRead(HashMap<String, String> paraMap) throws Throwable {
		List<MailVO> mailList = dao.mailRead(paraMap); // 읽을 메일이 들어가 있는 메일 리스트 조회
		int index = 0;
		MailVO mail = null;
		// 메일리스트 중에서 읽을 메일 조회
		for(int i=0; i<mailList.size(); i++) {
			if(paraMap.get("mail_seq").equals(mailList.get(i).getMail_seq())) {
				index = i;
				mail = mailList.get(i);
			}
		}
		
		String groupNo = mail.getMail_groupno();
		
		// 다음 글번호 채번하기
		for(int i=mailList.size()-1; i>index; i--) {
			if(!mailList.get(i).getMail_groupno().equals(groupNo)) {
				mail.setNext_seq(mailList.get(i).getMail_seq());
				mail.setNext_subject(mailList.get(i).getSubject());
			}
		}
		
		// 이전 글번호 채번하기
		for(int i=0; i<index; i++) {
			if(!mailList.get(i).getMail_groupno().equals(groupNo)) {
				mail.setPrev_seq(mailList.get(i).getMail_seq());
				mail.setPrev_subject(mailList.get(i).getSubject());
			}
		}
		
		if(mail!=null) {
			dao.updateReadstatus(paraMap.get("mail_seq"));
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

	// 메일 휴지통으로 이동
	@Override
	public int mailDel(HashMap<String, String[]>paraMap) {
		int n = dao.mailDel(paraMap);
		return n;
	}

	// 메일 영구삭제
	@Override
	public int mailDeletion(HashMap<String, String[]> paraMap) {
		int n = dao.mailDeletion(paraMap);
		return n;
	}

	// 삭제할 메일의 첨부파일 조회(status도 같이 조회 = 업로드 경로 확정시키기 위한 요소)
	@Override
	public List<MailVO> deleteFileList(HashMap<String, String[]> paraMap) {
		List<MailVO> deleteFileList = dao.deleteFileList(paraMap);
		return deleteFileList;
	}

	// 메일 복구하기
	@Override
	public int mailRestore(HashMap<String, String[]> paraMap) {
		int n = dao.mailResotre(paraMap);
		return n;
	}

	// 보낸 사람 찾기
	@Override
	public MailVO mailSenderFind(String mail_seq) {
		MailVO sender = dao.mailSenderFind(mail_seq);
		return sender;
	}

	// 받는 사람 찾기
	@Override
	public List<MailVO> mailReceiverFind(String mail_groupno) {
		List<MailVO> receiver = dao.mailReceiverFind(mail_groupno);
		return receiver;
	}

	// 1개 메일 찾기
	@Override
	public MailVO findMail(String mail_seq) {
		MailVO mail = dao.findMail(mail_seq);
		return mail;
	}
}
