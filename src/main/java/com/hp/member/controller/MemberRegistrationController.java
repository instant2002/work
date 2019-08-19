package com.hp.member.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.member.domain.MemberCommand;
import com.hp.member.service.MemberService;

@Controller
public class MemberRegistrationController{
	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name="memberService")
	private MemberService memberService;
	
	@Resource
	BCryptPasswordEncoder passEncoder;
	
	@RequestMapping(value="/member/registForm.do",method=RequestMethod.GET)
	public String registAgreeForm(){
		return "registAgreeForm";
	}
	
	@RequestMapping(value="/member/registForm.do",method=RequestMethod.POST)
	public String registForm(){
		return "registrationForm";
	}
	
	@RequestMapping(value="/member/regist.do",method=RequestMethod.POST)
	public String submit(@ModelAttribute("memberCommand") MemberCommand memberCommand, HttpServletResponse response) throws IOException{
		if(log.isDebugEnabled()){
			log.debug("memberCommand : " + memberCommand);
		}
		
		/*String encPasswd = passEncoder.encode(memberCommand.getUser_pwd());
		memberCommand.setUser_pwd(encPasswd);*/
		
		memberService.insert(memberCommand);
		
		return "redirect:/main.do";
} 
}