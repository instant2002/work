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
	   
		   if(log.isDebugEnabled())log.debug("func destination : " + (uri + query));
		   request.getSession().setAttribute("destination", uri + query);
   }
   
   @Override
   public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception{
      if(log.isDebugEnabled()){
         log.debug("===LogonCheckInterceptor 진입===");
      }
      
      HttpSession session = request.getSession();
      
      /*String product_no_list = request.getParameter("order_list[0].product_no");
      String quantity_list = request.getParameter("order_list[0].quantity");*/
      String product_no_list = request.getParameter("product_no_list");
      String quantity_list = request.getParameter("quantity_list");
      String total_price = request.getParameter("total_price");
      
      if(product_no_list != null && quantity_list != null) {
    	  FlashMap flashMap = new FlashMap();
    	  flashMap.put("product_no_list", product_no_list);
    	  flashMap.put("quantity_list", quantity_list);
    	  flashMap.put("total_price", total_price);
    	  
    	  if(log.isDebugEnabled()) log.debug("Setting flashMap : " + flashMap);
    	  
    	  FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
    	  flashMapManager.saveOutputFlashMap(flashMap, request, response);
      }

      String param = "";
      
      if(session.getAttribute("user_id")==null){
    	  saveDestination(request);
    	  if(product_no_list != null) {
    		  param = "?orderLogin=Y";
    	  }
    	  response.sendRedirect(request.getContextPath()+"/member/loginForm.do"+param);
    	  
         return false;
      }
      return true;
   }
   
}