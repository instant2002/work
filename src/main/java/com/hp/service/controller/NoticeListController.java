package com.hp.service.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.service.domain.ServiceNoticeCommand;
import com.hp.service.service.ServicesService;

@Controller
public class NoticeListController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="servicesService")
	private ServicesService servicesService;
	
	@RequestMapping(value="/service/noticeList.do", method=RequestMethod.GET)
	public String form(Model model) {
		
		List<ServiceNoticeCommand> notice = servicesService.getNoticeList();
		model.addAttribute("notice", notice);
		
		return "noticeList";
	}
	
}
