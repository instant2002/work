package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.service.PostService;


@Controller
public class PostingNoticeEditController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingNoticeEditForm.do", method=RequestMethod.GET)
	public String form(@RequestParam(value="num",required=false) int num,  Model model) {
		
		NoticeCommand noticeCommand = postService.getNoticeView(num);
		List<NoticeCommand> file_list= postService.getNoticeFile(num);
		model.addAttribute("notice", noticeCommand);
		model.addAttribute("file_list", file_list);
		
		return "postingNoticeEditForm";
	}
	
	@RequestMapping(value="/admin/postingNoticeEditSub.do", method=RequestMethod.POST)
	public String postingNoticeEditSub(@ModelAttribute("noticeCommand") NoticeCommand noticeCommand, MultipartHttpServletRequest mtf_request) {
		
		String save_img_path = mtf_request.getSession().getServletContext().getRealPath("/notice_img");
		String save_file_path = mtf_request.getSession().getServletContext().getRealPath("/notice_file");
		
		if(log.isDebugEnabled()){
			log.debug("noticeCommand : " + noticeCommand);
		}
		
		postService.postingNoticeEditSub(noticeCommand, save_img_path, mtf_request, save_file_path);
		
		return "redirect:/admin/postingNoticeList.do";
	}
}
