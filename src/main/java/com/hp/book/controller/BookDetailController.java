package com.hp.book.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.book.domain.BookCommand;
import com.hp.book.service.BookService;

@Controller
public class BookDetailController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="bookService")
	private BookService bookService;
	
	@RequestMapping(value="/book/detailView.do", method=RequestMethod.GET)
	public String form(@RequestParam(value="product_no",required=false) int product_no, HttpSession session,Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		BookCommand bookCommand = bookService.getBookDetailView(product_no);
		
		if(log.isDebugEnabled()){
			log.debug("bookCommand : " + bookCommand);
		}
		String isLogin;
		
		if(user_id != null) {
			isLogin = "yes";
		}else {
			isLogin = "no";
		}
		model.addAttribute("book", bookCommand);
		model.addAttribute("isLogin", isLogin);
		return "detailView";
	}
}