package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.PostCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingBookController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingBookForm.do", method=RequestMethod.GET)
	public String bookPostingForm() {
		
		return "postingBookForm";
	}
	
	@RequestMapping(value="/admin/postingBookSub.do", method=RequestMethod.POST)
	public String postingBookSub(@ModelAttribute("postCommand") PostCommand postCommand, 
			@RequestParam(value="book_cate_arr", required=false) List<String> book_cate_arr, 
			@RequestParam(value="book_group_arr", required=false) List<String> book_group_arr, 
			HttpServletRequest request) {
		
		if(log.isDebugEnabled()){
			log.debug("postCommand : " + postCommand);
			log.debug("book_cate_arr : " + book_cate_arr);
			log.debug("book_group_arr : " + book_group_arr);
		}

		String save_path = request.getSession().getServletContext().getRealPath("/unionbooks_img");
		
		String book_cate = StringUtils.join(book_cate_arr, ",");
		postCommand.setBook_cate(book_cate);
		
		String book_group = StringUtils.join(book_group_arr, ",");
		postCommand.setBook_group(book_group);

		postService.uploadBookInfo(postCommand, save_path); 
		
		return "redirect:/admin/postingBookForm.do";
	}
}