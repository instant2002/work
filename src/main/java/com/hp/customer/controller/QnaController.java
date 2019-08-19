package com.hp.customer.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.admin.domain.QnaAdminCommand;
import com.hp.customer.service.CustomerService;
import com.hp.service.domain.QnaCommand;

@Controller
public class QnaController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	
	@RequestMapping(value="/customer/qnaList.do")
	public String listForm(HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		
		List<QnaCommand> qna_list = customerService.getQnaList(user_id);
		
		model.addAttribute("qna_list", qna_list);
		return "qnaList";
	}
	
	@RequestMapping(value="/customer/qnaView.do")
	public String detailView(@ModelAttribute(value="qnaCommand")QnaCommand qnaCommand, HttpSession session, Model model) {
		String user_id = (String) session.getAttribute("user_id");
		qnaCommand.setUser_id(user_id);
		
		QnaCommand qnaView = customerService.getQnaView(qnaCommand);
		QnaCommand answer = customerService.getQnaAnswer(qnaCommand);
		
		model.addAttribute("qnaView", qnaView);
		model.addAttribute("answer", answer);
		return "qnaView";
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/qnaDelSub.do", method=RequestMethod.POST)
	public boolean qnaAnsSub(@ModelAttribute(value="qnaCommand")QnaCommand qnaCommand, HttpSession session) {
		String user_id = (String) session.getAttribute("user_id");
		
		qnaCommand.setUser_id(user_id);
		
		try {
			customerService.qnaDelSub(qnaCommand);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		
	}
}
