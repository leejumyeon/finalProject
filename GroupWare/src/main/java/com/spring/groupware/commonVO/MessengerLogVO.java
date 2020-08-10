package com.spring.groupware.commonVO;

public class MessengerLogVO { //메신저 로그VO(메신저 대화를 읽었는지 유무판단용)
	private String fk_message_seq; // 대화번호
	private String msg_receiver; // 읽을사람(사원번호)
	
	
	public String getFk_message_seq() {
		return fk_message_seq;
	}
	
	public void setFk_message_seq(String fk_message_seq) {
		this.fk_message_seq = fk_message_seq;
	}
	
	public String getMsg_receiver() {
		return msg_receiver;
	}
	
	public void setMsg_receiver(String msg_receiver) {
		this.msg_receiver = msg_receiver;
	}
	
	
	
}
