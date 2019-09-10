package com.hp.main.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.domain.PostCommand;
import com.hp.admin.service.PostService;
import com.hp.service.domain.ServiceNoticeCommand;
import com.hp.service.service.ServicesService;

@Controller
public class MainController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@Resource(name="servicesService")
	private ServicesService servicesService;
	
	@RequestMapping(value = "/")
	public String form(HttpServletRequest request) {
		request.getSession().setAttribute("destination", null);
		return "redirect:/main.do";
	}
	
	@RequestMapping(value = "/main.do")
	public String openSampleList(HttpServletRequest request, Model model) {
		request.getSession().setAttribute("destination", null);
		
		String book_new_num = "1";
		String book_commend_num = "2";
		
		List<PostCommand> book_new = postService.getMainBooksInfo(book_new_num);
		List<PostCommand> book_commend = postService.getMainBooksInfo(book_commend_num);
		List<ServiceNoticeCommand> notice = servicesService.getNoticeSomeList();
		
		
		if(log.isDebugEnabled()){
			log.debug("book_new : " + book_new);
			log.debug("book_commend : " + book_commend);
		}
		
		model.addAttribute("book_new", book_new);
		model.addAttribute("book_commend", book_commend);
		model.addAttribute("notice", notice);
		
		return "main";
	}
}
