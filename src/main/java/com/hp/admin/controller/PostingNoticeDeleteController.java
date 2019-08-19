package com.hp.admin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingNoticeDeleteController {
private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingNoticeDel.do", method=RequestMethod.GET)
	public String postingBookDel(@RequestParam(value="num",required=false) int num, HttpServletRequest request) {
		
		String save_path = request.getSession().getServletContext().getRealPath("/notice_img");
		
		if(log.isDebugEnabled()){
			log.debug("num : " + num);
			log.debug("save_path : " + save_path);
		}
		
		NoticeCommand noticeCommand = postService.getNoticeView(num);
		
		postService.postingNoticeDel(noticeCommand,save_path);
		
		return "redirect:/admin/postingNoticeList.do";
	}
}
