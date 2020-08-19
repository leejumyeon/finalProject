package com.spring.groupware.seongsu.model;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.AlbumVO;

public interface InterSeongsuDAO {

	List<HashMap<String, String>> getAlbumCategory();	// 앨범 카태고리 받아오기

	void insertAlbumTable(HashMap<String, String> paraMap);	// 앨범 글쓰기

	List<AlbumVO> getAlbumList(HashMap<String, String> paraMap);	// 앨범 리스트 보기

	AlbumVO getDetailAlbum(String album_seq);	// 앨범 내용 가져오기

	void updateEnd(HashMap<String, String> paraMap);	// 앨범 수정하기

	void deleteAlbum(String album_seq);	// 앨범 삭제하기

	int getTotalCount(HashMap<String, String> paraMap);	// 총 게시물 수 알아오기

}
