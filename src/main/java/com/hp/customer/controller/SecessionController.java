package com.hp.customer.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.customer.service.CustomerService;
import com.hp.member.domain.MemberCommand;

@Controller
public class SecessionController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="customer/secessionForm.do", method=RequestMethod.GET)
	public String form() { //회원 탈퇴 폼
		return "secessionForm";
	}
	
	@RequestMapping(value="customer/secessionSub.do", method=RequestMethod.POST)
	public String secessionSub(@RequestParam(value="secession_contents",required=false)String secession_contents,
							   @RequestParam(value="secession_num",required=false)int secession_num, HttpSession session) {
		
		MemberCommand memberCommand = new MemberCommand();
		
		String user_id = (String) session.getAttribute("user_id");
		
		memberCommand = customerService.getUserInfo(user_id);
		
		memberCommand.setSecession("Y");
		memberCommand.setSecession_contents(secession_contents);
		memberCommand.setSecession_num(secession_num);
		
		if(log.isDebugEnabled()) log.debug("memberCommand : " + memberCommand);
		
		customerService.secessionSub(memberCommand);
		
		session.removeAttribute("user_id");
		session.invalidate();
		
		return "index";
	}
}
