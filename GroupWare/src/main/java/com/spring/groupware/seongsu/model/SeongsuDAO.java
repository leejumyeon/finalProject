package com.spring.groupware.seongsu.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SeongsuDAO implements InterSeongsuDAO {
	
	@Autowired
	private SqlSessionTemplate sqlsession;

	// === 앨범 카태고리 받아오기 === //
	@Override
	public List<HashMap<String, String>> getAlbumCategory() {

		List<HashMap<String, String>> albumCategory = sqlsession.selectList("seongsu.getAlbumCategory");
		
		return albumCategory;
	}

	// === 앨범 글쓰기 === //
	@Override
	public void insertAlbumTable(HashMap<String, String> paraMap) {

		sqlsession.insert("seongsu.insertAlbumTable", paraMap);
	}
	
	
}
