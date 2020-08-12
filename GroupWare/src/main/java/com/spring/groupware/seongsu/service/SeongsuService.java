package com.spring.groupware.seongsu.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CommentVO;

@Service
public class SeongsuService implements InterSeongsuService {

	@Override
	public void addBoard(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int getTotalCount(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<BoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int add(BoardVO boardvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int add_withFile(BoardVO boardvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public BoardVO getView(String seq, String userid) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BoardVO getViewWithNoAddCount(String seq) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int edit(BoardVO boardvo) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int del(HashMap<String, String> paraMap) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int addComment(CommentVO commentvo) {
		// TODO Auto-generated method stub
		return 0;
	}

}
