package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingNoticeListController {
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingNoticeList.do", method=RequestMethod.GET)
	public String form(Model model) {
		
		List<NoticeCommand> notice = postService.getNoticeList();
		model.addAttribute("notice", notice);
		
		return "postingNoticeList";
	}
}
