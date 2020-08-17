package com.spring.groupware.commonVO;

import org.springframework.web.multipart.MultipartFile;

public class AttachFileVO { //게시글 첨부파일VO
	private String file_seq; //첨부파일 번호
	private String fk_board_seq; // 게시글 번호
	private String fileName; // 업로드 파일명
	private String orgFileName; // 기존 파일명
	private String fileSize; // 파일크기

	private MultipartFile attach;

	public String getFile_seq() {
		return file_seq;
	}

	public void setFile_seq(String file_seq) {
		this.file_seq = file_seq;
	}

	public String getFk_board_seq() {
		return fk_board_seq;
	}

	public void setFk_board_seq(String fk_board_seq) {
		this.fk_board_seq = fk_board_seq;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getOrgFileName() {
		return orgFileName;
	}

	public void setOrgFileName(String orgFileName) {
		this.orgFileName = orgFileName;
	}

	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	public MultipartFile getAttach() {
		return attach;
	}

	public void setAttach(MultipartFile attach) {
		this.attach = attach;
	}
	
	
	
}
