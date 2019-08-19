package com.hp.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.admin.domain.OrderAdminCommand;
import com.hp.admin.service.OrderAdminService;
import com.hp.common.domain.Criteria;
import com.hp.common.util.PageMaker;

@Controller
public class OrderCancelAdminController {

	@Resource(name="orderAdminService")
	private OrderAdminService orderAdminService;
	
	@RequestMapping("/admin/orderCancelList.do")
	public String orderCancelAdminList(Criteria criteria, HttpSession session, Model model) {
		int cancel_count = orderAdminService.getCancelOrderAdminListCount(criteria);
		
		PageMaker pageMaker = new PageMaker();
		if(criteria.getPerPageNum() <= 10) {
			criteria.setPerPageNum(10); //UI상 10개씩만 보이게 한다
		}
		
		pageMaker.setCri(criteria);
	    pageMaker.setTotalCount(cancel_count); //전체 페이지 수
	    List<OrderAdminCommand> cancel_list = orderAdminService.getCancelOrderAdminList(criteria); 
	    pageMaker.setPage(criteria.getPage());//현재 페이지 넘기기
	    model.addAttribute("cancel_list", cancel_list);
		model.addAttribute("criteria", criteria);
		model.addAttribute("pageMaker", pageMaker);
		
		return "orderCancelAdminList";
	}
	
	@RequestMapping("/admin/orderCancelDetail.do")
	public String orderCancelAdminDetail(@RequestParam(value="order_code",required=false) String order_code, Model model) {
		List<OrderAdminCommand> cancel_view = orderAdminService.getOrderCancelAdminDetail(order_code);
		
		model.addAttribute("cancel_view", cancel_view);
		
		return "orderCancelAdminDetail";
	}
}
