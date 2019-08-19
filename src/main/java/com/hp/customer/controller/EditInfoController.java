package com.hp.customer.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.customer.service.CustomerService;
import com.hp.member.domain.MemberCommand;

@Controller
public class EditInfoController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="customer/editInfo.do")
	public String identificationForm(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam(value= "user_pwd", required=false) String user_pwd , HttpSession session, Model model) throws IOException {
		
		String user_id = (String) session.getAttribute("user_id");
		
		if(request.getMethod().equals("POST")) {
			
			if(log.isDebugEnabled()) log.debug("user_id : " + user_id + "user_pwd : " + user_pwd);
			
			boolean chk = customerService.chkPassword(user_id, user_pwd);
			
			if(chk) {
				MemberCommand memberCommand = customerService.getUserInfo(user_id);
				model.addAttribute("user", memberCommand);
				
				return "editInfoForm"; //회원정보 수정 페이지
			}else {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('비밀번호가 일치하지 않습니다.'); location.href='/customer/editInfo.do';</script>");
				out.flush();
				return null;
			}
		}else {
			return "identificationForm"; //비밀번호 확인 페이지
		}
	}
	
	@RequestMapping(value="/customer/modifySub.do", method=RequestMethod.POST)
	public String modifySub(@ModelAttribute("memberCommand") MemberCommand memberCommand,
			@RequestParam(value= "nuser_pwd", required=false) String nuser_pwd, HttpServletResponse response) throws IOException {
		
		boolean chk = false;
		
		String user_id = memberCommand.getUser_id();
		
		if(nuser_pwd != "") {
			String user_pwd = memberCommand.getUser_pwd();
			
			chk = customerService.chkPassword(user_id, user_pwd);
		}else {
			chk = true;
		}
		
		if(chk) {
			memberCommand.setUser_pwd(nuser_pwd);
			if(log.isDebugEnabled()){
				log.debug("memberCommand has passwd : " + memberCommand);
			}
			customerService.updateUser(memberCommand);
			
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('회원 정보가 수정되었습니다.'); location.href='/customer/mypage.do';</script>");
			out.flush();
			
			return null;
		}else {
			if(log.isDebugEnabled()){
				log.debug("memberCommand empty passwd : " + memberCommand);
			}
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
			out.flush();
		
			return null;
		}
	}
}
