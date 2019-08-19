package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.CourierCommand;
import com.hp.admin.domain.OrderAdminCommand;
import com.hp.admin.service.OrderAdminService;
import com.hp.common.domain.Criteria;
import com.hp.common.util.PageMaker;

@Controller
public class OrderAdminController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="orderAdminService")
	private OrderAdminService orderAdminService;
	
	@RequestMapping("/admin/orderList.do")
	public String orderAdminList(Criteria criteria, HttpSession session, Model model) {
		
		int order_count = orderAdminService.getOrderAdminListCount(criteria);
		
		PageMaker pageMaker = new PageMaker();
		if(criteria.getPerPageNum() <= 10) {
			criteria.setPerPageNum(10); //UI상 10개씩만 보이게 한다
		}
		
		pageMaker.setCri(criteria);
	    pageMaker.setTotalCount(order_count); //전체 페이지 수 
	    List<OrderAdminCommand> order_list = orderAdminService.getOrderAdminList(criteria);
	    pageMaker.setPage(criteria.getPage());//현재 페이지 넘기기
		
		model.addAttribute("order_list", order_list);
		model.addAttribute("criteria", criteria);
		model.addAttribute("pageMaker", pageMaker);
		return "orderAdminList";
	}
	
	@RequestMapping("/admin/orderDetail.do")
	public String orderAdminDetail(@RequestParam(value="order_code",required=false) String order_code, Model model) {
		
		List<OrderAdminCommand> order_view = orderAdminService.getOrderAdminDetail(order_code);
		
		CourierCommand courier = orderAdminService.getCourierData(order_code);
		
		model.addAttribute("order_view", order_view);
		model.addAttribute("courier", courier);

		return "orderAdminDetail";
	}
	
}
