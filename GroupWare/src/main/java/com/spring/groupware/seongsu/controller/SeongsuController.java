/*package com.spring.groupware.seongsu.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.FileManager;
import com.spring.common.MyUtil;
import com.spring.groupware.commonVO.BoardVO;
import com.spring.groupware.seongsu.member.SeongsuMemberVO;
import com.spring.groupware.seongsu.service.InterSeongsuService;

@Controller
public class SeongsuController {
	
	@Autowired
	private FileManager fileManager;
	
	@Autowired
	private InterSeongsuService service;
	
	@RequestMapping(value="/board.top")
	public ModelAndView goBoardPage(ModelAndView mav) {
		
		mav.setViewName("/board/board.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/add.top")
	public ModelAndView requiredLogin_add(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
				
		String fk_seq = request.getParameter("fk_seq");
		String groupno = request.getParameter("groupno");
		String depthno = request.getParameter("depthno");
		
		mav.addObject("fk_seq", fk_seq);
		mav.addObject("groupno", groupno);
		mav.addObject("depthno", depthno);
		
		mav.setViewName("board/add.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/addEnd.top", method = {RequestMethod.POST})
	
	public String pointPlus_addEnd(HashMap<String, String> paraMap, BoardVO boardvo, MultipartHttpServletRequest mrequest) throws Exception {
	
		MultipartFile attach = boardvo.getAttach();
		if( !attach.isEmpty() ) {
		
			HttpSession session = mrequest.getSession();
			String root = session.getServletContext().getRealPath("/");
			String path = root + "resources" + File.separator +"files";
			
			String newFileName = "";
			
			byte[] bytes = null;
			
			long fileSize = 0;
			
			try {
				bytes = attach.getBytes();
				
				newFileName = fileManager.doFileUpload(bytes, attach.getOriginalFilename(), path);
				
				boardvo.setFileName(newFileName);
				
				boardvo.setOrgFilename(attach.getOriginalFilename());
				
				fileSize = attach.getSize();
				boardvo.setFileSize(String.valueOf(fileSize));
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	
		int n = 0;
		if( attach.isEmpty() ) {
			
			n = service.add(boardvo);
		}
		else {
			
			n = service.add_withFile(boardvo);
		}
		
		paraMap.put("userid", boardvo.getFk_userid());
		
		if(n==1) {
			paraMap.put("pointPlus", "100"); 
			
			return "redirect:/list.top";
			}
		else { 
			paraMap.put("pointPlus", "0"); 
			
			return "redirect:/add.top";
			
		}
		
	}
	
	@RequestMapping(value="/list.top")
	public ModelAndView list(HttpServletRequest request, ModelAndView mav) {
		
		List<BoardVO> boardList = null;
		
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		String str_currentShowPageNo = request.getParameter("currentShowPageNo");
		
		if(searchWord == null || searchWord.trim().isEmpty()) {
			searchWord = "";
		}
		
		if(searchType == null) {
			searchType = "";
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("searchType", searchType);
		paraMap.put("searchWord", searchWord);
	 
		int totalCount = 0;   		// 총 게시물 건수 
		int sizePerPage = 10; 		// 한 페이지당 보여줄 게시물 건수 
		int currentShowPageNo = 0;  // 현재 보여주는 페이지 번호로서, 초기치로는 1페이지로 설정 
		int totalPage = 0; 			// 총 페이지 수(웹브라우저상에서 보여줄 총 페이지 개수, 페이지바)			
		int startRno = 0;	// 시작 행번호
		int endRno = 0;		// 끝 행번호
		
		totalCount = service.getTotalCount(paraMap);
		
		totalPage = (int) Math.ceil( (double)totalCount/sizePerPage );
		
		if(str_currentShowPageNo == null) {
			
			currentShowPageNo = 1;
		}
		else {
			try {
				currentShowPageNo = Integer.parseInt(str_currentShowPageNo); 
				if(currentShowPageNo < 1 || currentShowPageNo > totalPage) {
					currentShowPageNo = 1;
				}
			} catch(NumberFormatException e) {
				currentShowPageNo = 1;
			}
		}
		
		startRno = ((currentShowPageNo - 1 ) * sizePerPage) + 1;
		endRno = startRno + sizePerPage - 1; 

		paraMap.put("startRno", String.valueOf(startRno));
		paraMap.put("endRno", String.valueOf(endRno));
		
		boardList = service.boardListSearchWithPaging(paraMap);
		
		if(!"".equals(searchWord)) {
			mav.addObject("paraMap", paraMap);
		}
		
		String pageBar = "<ul style='list-style:none;'>";
		
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ((currentShowPageNo - 1)/blockSize) * blockSize + 1;
		
		String url = "list.top";
					
		if(pageNo != 1) {
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+(pageNo-1)+"'>[이전]</a></li>";
		}
		
		
		while( !( loop > blockSize || pageNo > totalPage)) {
			
			if(pageNo == currentShowPageNo) {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";
			}
			else {
				pageBar += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>"+pageNo+"</a></li>";
			}
			
			loop++;
			pageNo ++;
			
		if( !(pageNo > totalPage) ) { 
			pageBar += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='"+url+"?searchType="+searchType+"&searchWord="+searchWord+"&currentShowPageNo="+pageNo+"'>[다음]</a></li>";
		}
		
		pageBar += "</ul>";
		
		mav.addObject("pageBar", pageBar);
					
		String gobackURL = MyUtil.getCurrentURL(request);
		
		mav.addObject("gobackURL", gobackURL);
		
		HttpSession session = request.getSession();
		session.setAttribute("readCountPermission", "yes");
		
		mav.addObject("boardList", boardList);
		mav.setViewName("board/list.tiles1");
		
		}
		
		return mav;
        
	}
	
	@RequestMapping(value="/view.top")
	public ModelAndView view(HttpServletRequest request, ModelAndView mav) {

		String seq = request.getParameter("seq");
		
		String gobackURL = request.getParameter("gobackURL");
		
		mav.addObject("gobackURL", gobackURL);
		
		HttpSession session = request.getSession();
		SeongsuMemberVO loginuser = (SeongsuMemberVO)session.getAttribute("loginuser");
		
		String userid = null;
		
		if(loginuser != null) {
			userid = loginuser.getUserid();
		}
		
		BoardVO boardvo = null;
		
		if("yes".equals(session.getAttribute("readCountPermission")) ) {
			
			boardvo = service.getView(seq, userid);
			
			session.removeAttribute("readCountPermission");
		}
		else {			
			boardvo = service.getViewWithNoAddCount(seq);
		}
		
		mav.addObject("boardvo",boardvo);
		mav.setViewName("board/view.tiles1");
		
		return mav;
	}
	
	@RequestMapping(value="/edit.top")
	public ModelAndView requiredLogin_edit(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		
		BoardVO boardvo = service.getViewWithNoAddCount(seq);
		
		HttpSession session = request.getSession();
		SeongsuMemberVO loginuser = (SeongsuMemberVO)session.getAttribute("loginuser");
		
		if( !loginuser.getUserid().equals(boardvo.getFk_userid()) ) {
			String msg = "다른 사용자의 글은 수정이 불가합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg",msg);
			mav.addObject("loc",loc);
			mav.setViewName("msg");
		}
		else {
			mav.addObject("boardvo", boardvo);
			mav.setViewName("board/edit.tiles1");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/editEnd.top", method = {RequestMethod.POST})
	public ModelAndView editEnd(HttpServletRequest request, ModelAndView mav, BoardVO boardvo) {
		
		int n = service.edit(boardvo);
		
		if(n == 0) {
			mav.addObject("msg", "암호가 일치하지 않아 글 수정이 불가합니다.");
		}
		else {
			mav.addObject("msg", "글수정 성공!!");
		}
		
		mav.addObject("loc", request.getContextPath()+"/view.top?seq="+boardvo.getSeq());
		mav.setViewName("msg");
		
		return mav;
	}
	
	@RequestMapping(value="/del.top")
	public ModelAndView requiredLogin_del(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		String seq = request.getParameter("seq");
		
		BoardVO boardvo = service.getViewWithNoAddCount(seq);
		
		HttpSession session = request.getSession();
		SeongsuMemberVO loginuser = (SeongsuMemberVO)session.getAttribute("loginuser");
		
		if( loginuser != null && !loginuser.getUserid().equals(boardvo.getFk_userid()) ) {
			String msg = "다른 사용자의 글은 삭제가 불가합니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg",msg);
			mav.addObject("loc",loc);
			mav.setViewName("msg");
		}
		else {
			// 자신의 글을 삭제할 경우 
			// 글작성시 입력해준 암호와 일치하는지 여부를 알아오도록 암호를 입력받아주는 del.jsp 페이지를 띄우도록 한다.
			mav.addObject("seq", seq);
			mav.setViewName("board/del.tiles1");
		}
		
		return mav;
	}
	
	
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
	
		   if(n==1) {
			   paraMap.put("pointPlus", "50");
			   // === after Advice용 (댓글을 작성하면 포인트 50 을 준다.) === 
		   }
		   else {
			   paraMap.put("pointPlus", "0");
				// === after Advice용 (댓글을 작성이 실패되면 포인트 0 을 준다.) === 
		   }
	   
		   JSONObject jsonObj = new JSONObject();
		   jsonObj.put("n", n);
		   
		   jsonStr = jsonObj.toString();
	   
	    } catch (Throwable e) {
		    e.printStackTrace();
	    }
	   
	   return jsonStr;
    }
	
}	
	
*/