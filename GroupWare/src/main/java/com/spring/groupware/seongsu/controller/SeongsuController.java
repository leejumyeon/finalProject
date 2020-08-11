package com.spring.groupware.seongsu.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.spring.board.model.BoardVO;
import com.spring.groupware.seongsu.service.InterSeongsuService;

@Controller
public class SeongsuController {

	@Autowired
	private InterSeongsuService service;
	
	@RequestMapping(value="/board.top")
	public ModelAndView goBoardPage(ModelAndView mav) {
		
		mav.setViewName("/board/board.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/list.top")
	public ModelAndView list(HttpServletRequest request, ModelAndView mav) {
		
		List<com.spring.groupware.commonVO.BoardVO> boardList = null;
		
		return mav;		
	}	
	
	@RequestMapping(value="/board/write.top", method= {RequestMethod.GET})
	public ModelAndView goWritePage(ModelAndView mav) {
		
		mav.setViewName("/board/write.tiles1");
		
		return mav;
	}
	
    @RequestMapping(value="/board/write.top", method= {RequestMethod.POST})
    public ModelAndView openBoardList(ModelAndView mav, HttpServletRequest request) {
        
    	String subject = request.getParameter("subject");
    	
    	HashMap<String, String> paraMap = new HashMap<>();
    	paraMap.put("subject", subject);
    	
    	service.writeBoard(paraMap);
        
        mav.setViewName("redirect:/board.top");
        return mav;
    }
}
