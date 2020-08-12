package com.spring.groupware.seongsu.service;

import java.util.HashMap;
import java.util.List;

import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.commonVO.CommentVO;

public interface InterSeongsuService {

	public void addBoard(HashMap<String, String> paraMap);

	public int getTotalCount(HashMap<String, String> paraMap);

	public List<BoardVO> boardListSearchWithPaging(HashMap<String, String> paraMap);

	public int add(BoardVO boardvo);

	public int add_withFile(BoardVO boardvo);

	public BoardVO getView(String seq, String userid);

	public BoardVO getViewWithNoAddCount(String seq);

	public int edit(BoardVO boardvo);

	public int del(HashMap<String, String> paraMap);

	public int addComment(CommentVO commentvo);
	
}
