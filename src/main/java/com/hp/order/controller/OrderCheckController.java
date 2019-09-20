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
import org.springframework.web.bind.annotation.RequestParam;
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
	public String form(@ModelAttribute("orderCommand") OrderCommand orderCommand, HttpServletRequest request, HttpServletResponse response, 
			 @RequestParam(value="total_price",required=false) String total_price, Model model) {
		if(log.isDebugEnabled())log.debug("OrderCommand! : " + orderCommand);
		
		/*상품번호 배열로 받아오기*/
		List<String> product_no_list = new ArrayList<String>();
		List<String> quantity_list = new ArrayList<String>();
		
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		
		if(flashMap != null && orderCommand.getProduct_no_list()==null) {
			if(log.isDebugEnabled())log.debug("OrderCheckController flashMap : " + flashMap);
			
			String[] product_no_arr = (String[]) flashMap.get("product_no_list");
			String[] quantity_arr = (String[]) flashMap.get("quantity_list");
			total_price = (String) flashMap.get("total_price");
			
			FlashMap flashMap2 = new FlashMap();
			flashMap2.put("product_no_list", flashMap.get("product_no_list"));
			flashMap2.put("quantity_list", flashMap.get("quantity_list"));
			flashMap2.put("total_price", flashMap.get("total_price"));
			
			for(int i=0; i<product_no_arr.length; i++) {
				product_no_list.add(product_no_arr[i]);
				quantity_list.add(quantity_arr[i]);
			}
			
			if(log.isDebugEnabled()) log.debug("setting again flashMap1 : " + flashMap2);
			
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			flashMapManager.saveOutputFlashMap(flashMap2, request, response);
		}else {
/*		if(orderCommand.getProduct_no_list() != null) {*/
			
			FlashMap flashMap2 = new FlashMap();
			flashMap2.put("product_no_list", orderCommand.getProduct_no_list());
			flashMap2.put("quantity_list", orderCommand.getQuantity_list());
			flashMap2.put("total_price", total_price);
			
			if(log.isDebugEnabled()) log.debug("setting again flashMap2 : " + flashMap2);
			
			Iterator<String> it = orderCommand.getProduct_no_list().iterator();
			Iterator<String> it2 = orderCommand.getQuantity_list().iterator();
			while(it.hasNext()) {
				String str = it.next();
				String str2 = it2.next();
				product_no_list.add(str);
				quantity_list.add(str2);
			}
		}
		
		List<OrderCommand> orderList = orderService.getOrderBook(product_no_list);
		model.addAttribute("order", orderList);
		model.addAttribute("quantity", quantity_list);
		
		return"orderCheckForm";
	}
}
