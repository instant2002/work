package com.hp.admin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.PostCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingBookEditController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingBookEditForm.do", method=RequestMethod.GET)
	public String form(@RequestParam(value="product_no",required=false) int product_no,  Model model) {
		
		PostCommand postCommand = postService.getBookInfo(product_no);
		
		String[] book_group_arr = null;
		String[] book_cate_arr = null;
		
		String book_cate = postCommand.getBook_cate();
		if(book_cate != null) {
			book_cate_arr = book_cate.split(",");
		}
		
		String book_group = postCommand.getBook_group();
		if(book_group != null) {
			book_group_arr = book_group.split(",");
		}
		
		model.addAttribute("book", postCommand);
		model.addAttribute("book_cate_arr", book_cate_arr);
		model.addAttribute("book_group_arr", book_group_arr);
		
		return "postingBookEditForm";
	}
	
	@RequestMapping(value="/admin/postingBookEditSub.do", method=RequestMethod.POST)
	public String postingBookEditSub(@ModelAttribute("postCommand") PostCommand postCommand, HttpServletRequest request) {
		
		String save_path = request.getSession().getServletContext().getRealPath("/unionbooks_img");
		
		if(log.isDebugEnabled()){
			log.debug("postCommand : " + postCommand);
			log.debug("save_path : " + save_path);
		}
		
		postService.postingBookEditSub(postCommand,save_path,request);
		
		return "redirect:/admin/postingBookList.do";
	}
}
