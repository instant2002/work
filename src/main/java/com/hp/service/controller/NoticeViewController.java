package com.hp.service.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.hp.service.domain.NoticeFileCommand;
import com.hp.service.domain.ServiceNoticeCommand;
import com.hp.service.service.ServicesService;

@Controller
public class NoticeViewController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="servicesService")
	private ServicesService servicesService;

	@RequestMapping(value="/service/noticeView.do", method=RequestMethod.GET)
	public String form(@RequestParam(value="num",required=false) int num, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		Cookie[] cookies = request.getCookies();
		Cookie viewCookie = null;
		
		if (cookies != null && cookies.length > 0){
            for (int i = 0; i < cookies.length; i++){
                // Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("cookie"+num)){
                	if(log.isDebugEnabled())log.debug("처음 쿠키가 생성된 뒤 들어옴");
                    viewCookie = cookies[i];
                }
            }
        }
            // 만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
        if (viewCookie == null) {
        	if(log.isDebugEnabled())log.debug("쿠키 없음");
            // 쿠키 생성(이름, 값)
            Cookie newCookie = new Cookie("cookie"+num, "|" + num + "|");
            // 쿠키 추가
                response.addCookie(newCookie);
                // 쿠키를 추가 시키고 조회수 증가시킴
            servicesService.increaseViews(num);
        }
        else {
            // 쿠키 값 받아옴.
            String value = viewCookie.getValue();
            if(log.isDebugEnabled())log.debug("쿠키 있음 / value : " + value);
    
        }
        ServiceNoticeCommand noticeCommand = servicesService.noticeView(num);
        List<NoticeFileCommand> file_list = servicesService.getNoticeFile(num);
        List<NoticeFileCommand> attFile_list = servicesService.getNoticeAttFile(num);
        model.addAttribute("notice", noticeCommand);
        model.addAttribute("file_list", file_list);
        model.addAttribute("attFile_list", attFile_list);
		
		return "noticeView";
	}
	
	@RequestMapping(value="/service/showSample.do", method=RequestMethod.POST)
	public String showAttfile(@ModelAttribute("NoticeFileCommand") NoticeFileCommand noticeFileCommand,	Model model) {
		if(log.isDebugEnabled())log.debug("NoticeFileCommand : " + noticeFileCommand);
		
		String notice_attFile_storedName = servicesService.showAttfile(noticeFileCommand);
		
		model.addAttribute("storedName", notice_attFile_storedName);
		
		return "showAttfile";
	}
	
}
