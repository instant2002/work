package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.admin.domain.PostCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingBookListController {

	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingBookList.do", method=RequestMethod.GET)
	public String form(Model model) {
		
		List<PostCommand> book = postService.getAllBooksInfo();
		model.addAttribute("book", book);
		
		return "postingBookList";
	}
}
