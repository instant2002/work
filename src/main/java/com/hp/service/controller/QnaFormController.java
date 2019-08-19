package com.hp.service.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hp.member.domain.MemberCommand;
import com.hp.member.service.MemberService;
import com.hp.service.domain.QnaCommand;
import com.hp.service.service.ServicesService;

@Controller
public class QnaFormController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="servicesService")
	private ServicesService servicesService;
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@RequestMapping(value="/service/qnaForm.do")
	public String form(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		MemberCommand member = memberService.selectMember(user_id);
		
		model.addAttribute("member", member);
		return "qnaForm";
	}
	
	@RequestMapping(value="/service/qnaSub.do")
	public String qnaSub(@ModelAttribute("qnaCommand") QnaCommand qnaCommand, HttpSession session) throws IOException {
		String user_id = (String) session.getAttribute("user_id");
		
		qnaCommand.setUser_id(user_id);
		
		if(log.isDebugEnabled()) log.debug("QnaCommand : " + qnaCommand);
		
		servicesService.qnaSub(qnaCommand);
		
		return "redirect:/customer/qnaList.do";
	}
}
