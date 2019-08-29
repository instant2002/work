package com.hp.admin.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@RequestMapping(value="/admin/postingSampleImgSub.do", method=RequestMethod.POST)
	public String postingNoticeSub(@ModelAttribute("sampleCommand") SampleCommand sampleCommand, MultipartHttpServletRequest mtf_request) {
		if(log.isDebugEnabled()) log.debug("SampleCommand : " + sampleCommand);
		
		String save_img_path = mtf_request.getSession().getServletContext().getRealPath("/sample_img");
		
		postService.uploadSample(sampleCommand, save_img_path, mtf_request);
		
		return "redirect:/admin/postingSampleImgList.do";
	}
	
	@RequestMapping(value="/admin/postingSampleImgList.do", method=RequestMethod.GET)
	public String sampleImgList (Model model) {
		
		List<SampleCommand> sample_list = postService.getSampleList();
		
		model.addAttribute("sample_list", sample_list);
		return "SampleImgList";
	}
	
	@RequestMapping(value="/admin/postingSampleDel.do", method=RequestMethod.GET)
	public String sampleDel (@RequestParam(value="sample_calling_name",required=false) String sample_calling_name, HttpServletRequest request) {
		String save_img_path = request.getSession().getServletContext().getRealPath("/sample_img");
		
		List<SampleCommand> del_list = postService.getSampleImg(sample_calling_name);
		postService.postingSampleDel(del_list, sample_calling_name, save_img_path);
		return "redirect:/admin/postingSampleImgList.do";
	}
	
	@RequestMapping(value="/service/sampleView.do", method=RequestMethod.GET)
	public String sampleView (@RequestParam(value="calling",required=false) String sample_calling_name, Model model) {
		
		List<SampleCommand> img_list = postService.getSampleImg(sample_calling_name);
		
		model.addAttribute("img_list", img_list);
		return "sampleView";
	}
}
