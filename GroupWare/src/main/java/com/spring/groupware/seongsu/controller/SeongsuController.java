package com.spring.groupware.seongsu.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SeongsuController {
		
	@RequestMapping(value="/board.top")
	public ModelAndView goBoardPage(ModelAndView mav) {
		
		mav.setViewName("/board/board.tiles1");
		
		return mav;
	}
		
	@RequestMapping(value="/detailboard.top")
	public ModelAndView requiredLogin_detailboard(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/detailboard.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/write.top")
	public ModelAndView requiredLogin_write(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/write.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/list.top")
	public ModelAndView requiredLogin_list(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/list.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/update.top")
	public ModelAndView requiredLogin_update(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		mav.setViewName("board/update.tiles1");
		
		return mav;
	}
	
/*
<<<<<<< HEAD
=======
	// === #77. 글삭제 페이지 완료하기 ==
	@RequestMapping(value="/delEnd.top", method= {RequestMethod.POST})
	public ModelAndView delEnd(HttpServletRequest request, ModelAndView mav) throws Throwable {
		
		  글 삭제를 하려면 원본글의 글암호와 삭제시 입력해준 암호가 일치할때만 
		        글 삭제가 가능하도록 해야한다. 
		String seq = request.getParameter("seq");
		String pw = request.getParameter("pw");
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("seq", seq);
		paraMap.put("pw", pw);
		
		int n = service.del(paraMap);

		if(n == 0) {
			mav.addObject("msg", "암호가 일치하지 않아 글 삭제가 불가합니다.");
			mav.addObject("loc", request.getContextPath()+"/view.top?seq="+seq);
		}
		else {
			mav.addObject("msg", "글삭제 성공!!");
			mav.addObject("loc", request.getContextPath()+"/list.top"); 
		}
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	@ResponseBody
    @RequestMapping(value="/addComment.top", method= {RequestMethod.POST})      
    public String pointPlus_addComment(HashMap<String, String> paraMap, com.spring.groupware.commonVO.CommentVO commentvo) {
	   
	   String jsonStr = "";
	   
	   try {
		   paraMap.put("userid", commentvo.getGetFk_userid());
		   // === after Advice용 (댓글을 작성하면 포인트 50 을 주기위해서 글쓴이가 누구인지 알아온다.) === 
	   
		   int n = service.addComment(commentvo);
		   // 댓글쓰기(insert) 및 
		   // 원게시물(tblBoard 테이블)에 댓글의 갯수 증가(update 1씩 증가)하기  
>>>>>>> 34e8f93b4056cc994ac3708350dab48c4929c87a
*/	
	
}