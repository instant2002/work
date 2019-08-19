package com.hp.admin.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.PostCommand;
import com.hp.admin.service.PostService;

@Controller
public class PostingBookDeleteController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingBookDel.do", method=RequestMethod.GET)
	public String postingBookDel(@RequestParam(value="product_no",required=false) int product_no, HttpServletRequest request) {
		
		String save_path = request.getSession().getServletContext().getRealPath("/unionbooks_img");
		
		if(log.isDebugEnabled()){
			log.debug("product_no : " + product_no);
			log.debug("save_path : " + save_path);
		}
		
		PostCommand postCommand = postService.getBookInfo(product_no);
		
		postService.postingBookDel(postCommand,save_path);
		
		return "redirect:/admin/postingBookList.do";
	}
}
