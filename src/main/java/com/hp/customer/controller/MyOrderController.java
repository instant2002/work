package com.hp.customer.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.PostCommand;
import com.hp.common.domain.Criteria;
import com.hp.common.util.PageMaker;
import com.hp.customer.service.CustomerService;
import com.hp.order.domain.PaymentCommand;

@Controller
public class MyOrderController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping("/customer/orderList.do")
	public String orderListForm(Criteria criteria, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		criteria.setUser_id(user_id);
		
		int order_count = customerService.getOrderListCount(criteria);
		
		PageMaker pageMaker = new PageMaker();
		if(criteria.getPerPageNum() <= 10) {
			criteria.setPerPageNum(10); //UI상 10개씩만 보이게 한다
		}
		
		pageMaker.setCri(criteria);
	    pageMaker.setTotalCount(order_count); //전체 페이지 수 
	    List<PaymentCommand> order_list = customerService.getOrderList(criteria);
		pageMaker.setPage(criteria.getPage());//현재 페이지 넘기기
		
		model.addAttribute("order_list", order_list);
		model.addAttribute("criteria", criteria);
		model.addAttribute("pageMaker", pageMaker);
		return "orderList";
	}
	
	@RequestMapping("/customer/orderDetail.do")
	public String orderDetailForm(@RequestParam(value="order_code",required=false) String order_code, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("order_code", order_code);
		map.put("user_id", user_id);
		
		List<PaymentCommand> order_view = customerService.getOrderDetail(map);
		
		model.addAttribute("order_view", order_view);

		return "orderDetail";
	}
	
	@RequestMapping("/customer/cancel.do")
	public String cancel() {
		return "inicancel";
	}
}
