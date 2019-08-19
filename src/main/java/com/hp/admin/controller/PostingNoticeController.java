package com.hp.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingNoticeController {
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingNoticeForm.do", method=RequestMethod.GET)
	public String form () {
		
		return "postingNoticeForm";
	}
	
	@RequestMapping(value="/admin/postingNoticeSub.do", method=RequestMethod.POST)
	public String postingNoticeSub (@ModelAttribute("noticeCommand") NoticeCommand noticeCommand, HttpSession session, 
			MultipartHttpServletRequest mtf_request) throws Exception {
		String user_id = (String) session.getAttribute("user_id");
		
		if(log.isDebugEnabled()){
			log.debug("noticeCommand : " + noticeCommand);
		}
		
		noticeCommand.setUser_id(user_id);
		String save_img_path = mtf_request.getSession().getServletContext().getRealPath("/notice_img");
		String save_file_path = mtf_request.getSession().getServletContext().getRealPath("/notice_file");
		
		postService.uploadNotice(noticeCommand, save_img_path, mtf_request, save_file_path); 
		
		return "redirect:/admin/postingNoticeForm.do";
	}
}
