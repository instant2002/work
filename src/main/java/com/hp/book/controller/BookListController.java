package com.hp.book.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.admin.domain.NoticeCommand;
import com.hp.admin.domain.PostCommand;
import com.hp.book.service.BookService;
import com.hp.common.domain.Criteria;
import com.hp.common.util.PageMaker;
import com.hp.service.domain.ServiceNoticeCommand;
import com.hp.service.service.ServicesService;

@Controller
public class BookListController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="bookService")
	private BookService bookService;
	
	@Resource(name="servicesService")
	private ServicesService servicesService;
	
	@RequestMapping(value="/book/bookList.do", method=RequestMethod.GET)
	public String form(Criteria criteria, HttpSession session, Model model) {
		PageMaker pageMaker = new PageMaker();
		
		if(criteria.getPerPageNum() <= 12) {
			criteria.setPerPageNum(12); //UI상 9개씩만 보이게 한다
		}
		
		HashMap<String, Object> ordering = new HashMap<String,Object>();
		ordering.put("sortby", criteria.getSortby());
		ordering.put("perPageNum", criteria.getPerPageNum());
		ordering.put("book_group", criteria.getBook_group());
		
	    pageMaker.setCri(criteria);
	    pageMaker.setTotalCount(bookService.getBookListCount(criteria)); //전체 페이지 수
	    
		List<PostCommand> book_list = bookService.getBookList(criteria);
		List<ServiceNoticeCommand> notice = servicesService.getNoticeSomeList();
		
		pageMaker.setPage(criteria.getPage());//현재 페이지 넘기기
		
		String user_id = (String) session.getAttribute("user_id");
		String isLogin;
		
		if(user_id != null) {
			isLogin = "yes";
		}else {
			isLogin = "no";
		}
		
		model.addAttribute("isLogin", isLogin);
		model.addAttribute("book_list", book_list);
		model.addAttribute("notice", notice);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("ordering", ordering);
		model.addAttribute("keyword", criteria.getKeyword());
		return "bookList";
	}
}
