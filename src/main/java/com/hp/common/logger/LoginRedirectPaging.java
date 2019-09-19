package com.hp.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginRedirectPaging extends HandlerInterceptorAdapter {
	private Logger log = Logger.getLogger(this.getClass());
    private static final String LOGIN = "login";
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        HttpSession httpSession = request.getSession();
        // 기존의 로그인 정보 제거
        if (httpSession.getAttribute(LOGIN) != null) {
            httpSession.removeAttribute(LOGIN);
        }
        
        return true;
    }
    
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    	
    	HttpSession httpSession = request.getSession();
    	Object userVO = modelAndView.getModelMap().get("user_id");
    	Object nonMem = modelAndView.getModelMap().get("nonMem");
    	
    	if(log.isDebugEnabled())log.debug("userVO : " + userVO);
    	
    	if (userVO != null && userVO != "itsNotUser") {
    		
    		httpSession.setAttribute(LOGIN, userVO);
    		Object destination = httpSession.getAttribute("destination");
    		Object referrer = request.getHeader("Referer");
    		Object redirectPage;
    		
    		redirectPage = destination != null ? destination : referrer;
    		
    		if((redirectPage.toString()).indexOf("/member/loginForm.do") > -1) {
    			if(log.isDebugEnabled()) log.debug("referrer = '/member/loginForm.do' ...set null");
    			redirectPage = null;
    		}

    		if(log.isDebugEnabled()) {
    			log.debug("referrer : " + referrer);
    			log.debug("destination : " + destination);
    			log.debug("redirectPage : " + redirectPage );
    		}
    		
    		response.sendRedirect(redirectPage != null ? (String) redirectPage : "/main.do");
    	}else if(nonMem != null && nonMem == "Y") {
    		Object destination = httpSession.getAttribute("destination");
    		Object referrer = request.getHeader("Referer");
    		Object redirectPage;
    		
    		redirectPage = destination != null ? destination : referrer;
    		
    		if((redirectPage.toString()).indexOf("/member/loginForm.do") > -1) {
    			if(log.isDebugEnabled()) log.debug("referrer = /member/loginForm.do... set Null");
    			redirectPage = null;
    		}

    		if(log.isDebugEnabled()) {
    			log.debug("비회원 주문 시도");
    			log.debug("referrer : " + referrer);
    			log.debug("destination : " + destination);
    			log.debug("redirectPage : " + redirectPage );
    		}
    		
    		response.sendRedirect(redirectPage != null ? (String) redirectPage : "/main.do");
    	}
    }
}