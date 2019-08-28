package com.hp.admin.controller;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hp.admin.domain.SampleCommand;
import com.hp.admin.service.PostService;

@Controller
public class SampleImgController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="postService")
	private PostService postService;
	
	@RequestMapping(value="/admin/postingSampleImg.do", method=RequestMethod.GET)
	public String sampleImgForm () {
		
		return "SampleImgForm";
	}
	
	@RequestMapping(value="/admin/postingNoticeSub.do", method=RequestMethod.POST)
	public String postingNoticeSub(@ModelAttribute("sampleCommand") SampleCommand sampleCommand, MultipartHttpServletRequest mtf_request) {
		if(log.isDebugEnabled()) log.debug("SampleCommand : " + sampleCommand);
		
		String save_file_path = mtf_request.getSession().getServletContext().getRealPath("/sample_img");
		
		return "redirect:/admin/postingNoticeForm.do";
	}
}
