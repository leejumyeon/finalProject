package com.spring.groupware.seongsu.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AlbumVO;

public interface InterSeongsuService {

	public List<HashMap<String, String>> getAlbumCategory(); // 앨범 카태고리 받아오기

	public void insertAlbumTable(HashMap<String, String> paraMap);	// 앨범 글쓰기

	public List<AlbumVO> getAlbumList(HashMap<String, String> paraMap);	// 앨범 리스트 보기
	
}
