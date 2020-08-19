package com.spring.groupware.seongsu.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.groupware.commonVO.AlbumVO;

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

	// === 앨범 리스트 보기 === //
	@Override
	public List<AlbumVO> getAlbumList(HashMap<String, String> paraMap) {

		List<AlbumVO> albumList = sqlsession.selectList("seongsu.getAlbumList", paraMap);
		
		return albumList;
	}
	
	
}
