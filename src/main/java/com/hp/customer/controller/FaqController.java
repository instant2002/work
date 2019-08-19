package com.hp.customer.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FaqController {
	
	@RequestMapping(value="/customer/faqList.do")
	public String form() {
		return "faqList";
	}
	
}
