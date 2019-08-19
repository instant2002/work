package com.hp.customer.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.book.domain.BookCommand;
import com.hp.common.util.PageMaker;
import com.hp.customer.service.CustomerService;
import com.hp.member.domain.MemberCommand;
import com.hp.order.domain.PaymentCommand;
import com.hp.service.domain.QnaCommand;

@Controller
public class MypageController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;

	@RequestMapping("customer/mypage.do")
	public String form(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		MemberCommand memberCommand = customerService.getUserInfo(user_id);
		model.addAttribute("user", memberCommand);
		
	    List<PaymentCommand> order_list = customerService.getMypageOrderList(user_id);
		model.addAttribute("order_list", order_list);
		
		List<BookCommand> bookCommand = customerService.getMypageBasketList(user_id);
		model.addAttribute("basket", bookCommand);
		
		HashMap<String, Object> hm = customerService.getMypageCount(user_id);
		model.addAttribute("my_count", hm);
		
		return "mypage";
	}
}
