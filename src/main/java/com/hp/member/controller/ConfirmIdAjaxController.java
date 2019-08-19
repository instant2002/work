package com.hp.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.member.domain.MemberCommand;
import com.hp.member.service.MemberService;

@Controller
public class ConfirmIdAjaxController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource
	MemberService memberService;
	
	@RequestMapping(value="/member/confirmId.do", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,String> process(@RequestParam(value="userId",required=false)String user_id){
		if(log.isDebugEnabled()) log.debug("user_id : " + user_id);
		
		Map<String,String> map = new HashMap<String,String>();
		
		try {
			MemberCommand member = memberService.selectMember(user_id);
			if(member != null){
				map.put("result", "idDuplicated");
			}else{
				map.put("result", "idNotFound");
			}
		} catch (Exception e) {
			log.error(e);
			map.put("result", "idNotFound");
		}
		return map;
	}
}
