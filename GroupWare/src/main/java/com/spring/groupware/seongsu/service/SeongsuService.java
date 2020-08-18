package com.spring.groupware.seongsu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	

}
