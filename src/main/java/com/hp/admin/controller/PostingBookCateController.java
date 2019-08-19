package com.hp.admin.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hp.admin.service.PostService;

@Controller
public class PostingBookCateController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping("/admin/postingBookCateForm.do")
	public String form() {
		
		return "postingBookCateForm";
	}
	
	
}
