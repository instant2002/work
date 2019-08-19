package com.hp.customer.controller;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.book.domain.BookCommand;
import com.hp.customer.domain.CustomerCommand;
import com.hp.customer.service.CustomerService;

@Controller
public class WishController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="/customer/wishList.do")
	public String form(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		List<BookCommand> bookCommand = customerService.getWishList(user_id);
		if(log.isDebugEnabled()) log.debug("BookCommand : " + bookCommand);
		
		model.addAttribute("wish", bookCommand);
		
		return "wishList";
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/wishSub.do")
	public boolean wishSub(@ModelAttribute("customerCommand") CustomerCommand customerCommand, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		
		customerCommand.setUser_id(user_id);
		
		if(log.isDebugEnabled()) log.debug("CustomerCommand : " + customerCommand);
		
		try {
			customerService.insertWish(customerCommand);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/wishDelete.do", method=RequestMethod.POST)
	public boolean wishDelete(@RequestParam(value="product_arr",required=false) List<String> product_arr, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		
		if(log.isDebugEnabled()) log.debug("product_arr : " + product_arr);
		
		try {
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("user_id", user_id);
			hm.put("product_arr", product_arr);
			
			customerService.wishDelete(hm);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/toBasket.do", method=RequestMethod.POST)
	public boolean toBasket(@RequestParam(value="product_arr",required=false) List<String> product_arr, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		
		if(log.isDebugEnabled()) log.debug("product_arr : " + product_arr);
		
		try {
			HashMap<String, Object> hm = new HashMap<String, Object>();
			hm.put("user_id", user_id);
			hm.put("product_arr", product_arr);
			
			customerService.toBasket(hm);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
