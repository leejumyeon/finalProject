package com.spring.groupware.seongsu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.AlbumVO;
import com.spring.groupware.seongsu.model.InterSeongsuDAO;

@Service
public class SeongsuService implements InterSeongsuService {

	@Autowired
	private InterSeongsuDAO dao;

	// === 앨범 카태고리 받아오기 === //
	@Override
	public List<HashMap<String, String>> getAlbumCategory() {

		List<HashMap<String, String>> albumCategory = dao.getAlbumCategory();
		
		return albumCategory;
	}

	// === 앨범 글쓰기 === //
	@Override
	public void insertAlbumTable(HashMap<String, String> paraMap) {

		dao.insertAlbumTable(paraMap);
	}

	// === 앨범 리스트 보기 === //
	@Override
	public List<AlbumVO> getAlbumList(HashMap<String, String> paraMap) {

		List<AlbumVO> albumList = dao.getAlbumList(paraMap);
		
		return albumList;
	}

	// === 앨범 내용 가져오기 === //
	@Override
	public AlbumVO getDetailAlbum(String album_seq) {

		AlbumVO detailAlbum = dao.getDetailAlbum(album_seq);
		
		return detailAlbum;
	}

	// === 앨범 수정 하기 === //
	@Override
	public void updateEnd(HashMap<String, String> paraMap) {

		dao.updateEnd(paraMap);
	}

	// === 앨범 삭제하기 === //
	@Override
	public void deleteAlbum(String album_seq) {

		dao.deleteAlbum(album_seq);
	}

	// === 총 게시물 수 알아오기 === //
	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {

		int totalCount = dao.getTotalCount(paraMap);
		
		return totalCount;
	}
	
	

}
