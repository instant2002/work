package com.hp.common.logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.servlet.support.RequestContextUtils;

@Component
public class LogonCheckInterceptor extends HandlerInterceptorAdapter{
	private Logger log = Logger.getLogger(this.getClass());
   
   //페이지 요청 정보 저장
   private void saveDestination(HttpServletRequest request) {
	   String uri = request.getRequestURI();
	   String query = request.getQueryString();
	   if(query == null || query.equals("null")) {
		   query = "";
	   }else {
		   query = "?" + query;
	   }
	   
		   if(log.isDebugEnabled())log.debug("destination : " + (uri + query));
		   request.getSession().setAttribute("destination", uri + query);
   }
   
   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{
      if(log.isDebugEnabled()){
         log.debug("===LogonCheckInterceptor 진입===");
      }
      
      String product_no = request.getParameter("order_list[0].product_no");
      String quantity = request.getParameter("order_list[0].quantity");
      
      System.out.println("product_no : " + product_no);
      System.out.println("quantity : " + quantity);
      
      if(product_no != null && quantity != null) {
	      FlashMap flashMap = new FlashMap();
	      flashMap.put("product_no", product_no);
	      flashMap.put("quantity", quantity);
	      
	      if(log.isDebugEnabled()) log.debug("Setting flashMap : " + flashMap);
	      
	      FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
	      flashMapManager.saveOutputFlashMap(flashMap, request, response);
      }
      
      HttpSession session = request.getSession();
      
      if(session.getAttribute("user_id")==null){
    	  saveDestination(request);
    	  response.sendRedirect(request.getContextPath()+"/member/loginForm.do");
    	  
         return false;
      }
      return true;
   }
   
}