package com.hp.order.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.hp.order.domain.OrderCommand;
import com.hp.order.service.OrderService;

@Controller
public class OrderCheckController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="orderService")
	private OrderService orderService;
	
	@RequestMapping(value="/order/orderCheckForm.do")
	public String form(@ModelAttribute("orderCommand") OrderCommand orderCommand, HttpServletRequest request, HttpServletResponse response, Model model) {
		if(log.isDebugEnabled())log.debug("OrderCommand! : " + orderCommand);
		
		/*상품번호 배열로 받아오기*/
		List<String> product_no_list = new ArrayList<String>();
		List<String> quantity_list = new ArrayList<String>();

		if(orderCommand.getOrder_list() != null) {
			Iterator<OrderCommand> it = orderCommand.getOrder_list().iterator();
			while(it.hasNext()) {
				OrderCommand str = it.next();
				product_no_list.add(str.getProduct_no());
				quantity_list.add(str.getQuantity());
			}
		}
		
		//List의 null값 제거
		product_no_list.removeAll(Collections.singleton(null));
		quantity_list.removeAll(Collections.singleton(null));
		
		System.out.println("product_no_list : " + product_no_list);
		System.out.println("quantity_list : " + quantity_list);
		
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		
		if(flashMap != null) {
			if(log.isDebugEnabled())log.debug("OrderCheckForm flashMap : " + flashMap);
			
			String product_no_String = (String) flashMap.get("product_no");
			String quantity_String = (String) flashMap.get("quantity");
			
			/*int product_no = Integer.parseInt(product_no_String);
			int quantity = Integer.parseInt(quantity_String);*/
			
			orderCommand.setProduct_no(product_no_String);
			orderCommand.setQuantity(quantity_String);
			
			product_no_list.add(product_no_String);
			quantity_list.add(quantity_String);
			
			FlashMap flashMap2 = new FlashMap();
			flashMap2.put("product_no", product_no_String);
			flashMap2.put("quantity", quantity_String);
			
			if(log.isDebugEnabled()) log.debug("setting again flashMap : " + flashMap2);
			
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			flashMapManager.saveOutputFlashMap(flashMap2, request, response);
		}
		
		List<OrderCommand> orderList = orderService.getOrderBook(product_no_list);
		model.addAttribute("order", orderList);
		model.addAttribute("quantity", quantity_list);
		
		return"orderCheckForm";
	}
}
