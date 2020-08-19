package com.spring.groupware.seongsu.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AlbumVO;

public interface InterSeongsuService {

	public List<HashMap<String, String>> getAlbumCategory(); // 앨범 카태고리 받아오기

	public void insertAlbumTable(HashMap<String, String> paraMap);	// 앨범 글쓰기

	public List<AlbumVO> getAlbumList(HashMap<String, String> paraMap);	// 앨범 리스트 보기

	public AlbumVO getDetailAlbum(String album_seq);	// 앨범 내용 가져오기

	public void updateEnd(HashMap<String, String> paraMap);	// 앨범 수정 하기

	public void deleteAlbum(String album_seq);	// 앨범 삭제하기

	public int getTotalCount(HashMap<String, String> paraMap);	// 총 게시물 수 알아오기
	
}
