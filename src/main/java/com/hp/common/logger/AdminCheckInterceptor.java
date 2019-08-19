package com.hp.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter{
	private Logger log = Logger.getLogger(this.getClass());
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		if(log.isDebugEnabled()){
	         log.debug("===AdminCheckInterceptor 진입===");
	      }
        HttpSession session = request.getSession();
        
        String user_id = (String) session.getAttribute("user_id");
        
        if(log.isDebugEnabled()) log.debug("session user_id : " + user_id);
        
        if (user_id == null || !user_id.equals("admin")){
      	    response.sendRedirect(request.getContextPath()+"/main.do");
      	    return false;
        }else {
        	return true;
        }
    }
}
