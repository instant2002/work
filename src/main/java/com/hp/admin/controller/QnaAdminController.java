package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.admin.domain.QnaAdminCommand;
import com.hp.admin.service.PostService;

@Controller
public class QnaAdminController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/qnaList.do")
	public String listForm(Model model) {
		
		List<QnaAdminCommand> qna_list = postService.getQnaList();
		
		model.addAttribute("qna_list", qna_list);
		return "qnaAdminList";
	}
	
	@RequestMapping(value="/admin/qnaView.do")
	public String detailView(@ModelAttribute(value="qnaAdminCommand")QnaAdminCommand qnaAdminCommand, Model model) {
		
		QnaAdminCommand qnaView = postService.getQnaView(qnaAdminCommand);
		QnaAdminCommand answer = postService.getQnaAnswer(qnaAdminCommand);
		
		model.addAttribute("qnaView", qnaView);
		model.addAttribute("answer", answer);
		return "qnaAdminView";
		
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/qnaAnsSub.do", method=RequestMethod.POST)
	public boolean qnaAnsSub(@ModelAttribute(value="qnaAdminCommand")QnaAdminCommand qnaAdminCommand, Model model) {
		if(log.isDebugEnabled())log.debug("QnaAdminCommand : " + qnaAdminCommand);
		
		try {
			postService.qnaAnsSub(qnaAdminCommand);
			postService.updateQuestionIsanswer(qnaAdminCommand.getIdx());
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		
		
	}
	
}
