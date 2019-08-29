package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hp.admin.domain.MemberAdminCommand;
import com.hp.admin.service.MemberAdminService;

@Controller
public class MemberAdminController {
	
	@Resource(name="memberAdminService")
	private MemberAdminService memberAdminService;
	
	@RequestMapping(value="/admin/memberList.do", method=RequestMethod.GET)
	public String memberList(Model model) {
		
		List<MemberAdminCommand> member_list = memberAdminService.getAllMember();
		
		model.addAttribute("member_list", member_list);
		return "memberList";
	}
	
}
