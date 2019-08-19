package com.hp.admin.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.admin.domain.CourierCommand;
import com.hp.admin.service.OrderAdminService;

@Controller
public class CourierAdminController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="orderAdminService")
	private OrderAdminService orderAdminService;
	
	@ResponseBody
	@RequestMapping(value="/admin/deliverySub.do", method=RequestMethod.POST)
	public boolean deliverySub(@ModelAttribute("courierCommand") CourierCommand courierCommand){
		if(log.isDebugEnabled()) log.debug("CourierCommand : " + courierCommand);
		
		try{
			orderAdminService.shipProduct(courierCommand);
			orderAdminService.updateOrderTable(courierCommand);
			orderAdminService.updateCancelTable(courierCommand);
		}catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
}
