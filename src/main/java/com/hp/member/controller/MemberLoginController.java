package com.hp.member.controller;

import java.io.PrintWriter;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.hp.member.domain.MemberCommand;
import com.hp.member.service.MemberService;

@Controller
public class MemberLoginController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	@Resource
	BCryptPasswordEncoder passEncoder;
	
	//페이지 요청 정보 저장
	   private void saveDestination(HttpServletRequest request) {
		   String uri = request.getRequestURI();
		   String query = request.getQueryString();
		   if(query == null || query.equals("null")) {
			   query = "";
		   }else {
			   query = "?" + query;
		   }
		    
		   if(request.getMethod().equals("GET")) {
			   if(log.isDebugEnabled())log.debug("destination : " + (uri + query));
			   request.getSession().setAttribute("destination", uri + query);
		   }
	   }
	
	@RequestMapping(value="/member/loginForm.do", method=RequestMethod.GET) //로그인 폼으로 이동
	public String form(@RequestParam(value="orderLogin", required=false) String orderLogin, HttpServletRequest request,  HttpServletResponse response,  Model model){
		
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		FlashMap fm = new FlashMap();
		
		if(flashMap !=null) {
			fm.put("product_no_list", flashMap.get("product_no_list"));
			fm.put("quantity_list", flashMap.get("quantity_list"));
			fm.put("total_price", flashMap.get("total_price"));
			
			if(log.isDebugEnabled()) log.debug("LoginForm flashMap : " + flashMap);
			
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
		    flashMapManager.saveOutputFlashMap(fm, request, response);
		}
		
		model.addAttribute("orderLogin",orderLogin);
		
		return "memberLoginForm";
	}
	
	@RequestMapping(value="/member/loginSub.do", method=RequestMethod.POST) //로그인 시도
	public String loginSubmit(@ModelAttribute("memberCommand") MemberCommand memberCommand, HttpSession session, 
			HttpServletResponse response, Model model, HttpServletRequest request){
		
		/*String encPasswd = passEncoder.encode(memberCommand.getUser_pwd());
		memberCommand.setUser_pwd(encPasswd);*/
		String total_price = null;
		
		try{
			if(log.isDebugEnabled()) log.debug("Login beginning memberCommand : " + memberCommand);

			boolean check = false;
			
			MemberCommand member = memberService.loginSubmit(memberCommand);
			
			if(member != null) {
				check = true;
			}
			
			Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
			FlashMap fm = new FlashMap();
			
			if(flashMap !=null) {
				fm.put("product_no_list", flashMap.get("product_no_list"));
				fm.put("quantity_list", flashMap.get("quantity_list"));
				fm.put("total_price", flashMap.get("total_price"));
				
				total_price = (String) flashMap.get("total_price");
				
				if(log.isDebugEnabled()) log.debug("LoginSub flashMap : " + flashMap);
				
				FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
				flashMapManager.saveOutputFlashMap(fm, request, response);
			}
			
			if(check) {
				if(log.isDebugEnabled()) log.debug("Login True memberCommand : " + memberCommand);
				session.setAttribute("user_id", member.getUser_id());
				session.setAttribute("nonMem", "N");
				model.addAttribute("nonMem", "N");
				model.addAttribute("user_id", member.getUser_id());
				saveDestination(request);
				
				//비회원일 때 담았던 장바구니 저장
				String basket_value = "";
				Cookie get_cookie[] = request.getCookies();
				if (get_cookie != null) {
					for (int i = 0; i < get_cookie.length; i++) {
						if (get_cookie[i].getName().equals("basket_cookie")) {
							basket_value = URLDecoder.decode(get_cookie[i].getValue(), "UTF-8");
						}
					}
				}
				String[] basket_split = basket_value.split(",");
				if(!basket_value.equals("")) {
					for(int i=0; i<basket_split.length; i++) {
						memberService.insertCooikeBasket(basket_split[i].substring(0,1), basket_split[i].substring(2,3),member.getUser_id());
					}
					Cookie cookie = new Cookie("basket_cookie", "");
					cookie.setMaxAge(60 * 60 * 24 * 1);
					cookie.setPath("/");
					cookie.setVersion(0);
					response.addCookie(cookie);
				}
				return "main";
			}else {
				if(log.isDebugEnabled()) log.debug("Login False memberCommand : " + memberCommand);
				
				HttpSession httpSession = request.getSession();
				/* 로그인 실패 시 머물렀던 페이지 저장... 다시 로그인 시 저장된 페이지로 이동시키게  destination 설정*/
				if(!request.getHeader("referer").contains("/member/loginForm.do")) {
					request.getSession().setAttribute("destination", request.getHeader("referer"));
					Object destination = httpSession.getAttribute("destination");
					if(log.isDebugEnabled()) log.debug("destination_referer : " + destination);
				}
				
				model.addAttribute("user_id","itsNotUser");
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				
				String param = null;
				if(total_price != null) {
		    		  param = "?orderLogin=Y";
		    	  }
				if(param == null) param = "";
				out.println("<script>alert('아이디 또는 비밀번호가 일치하지 않습니다.'); location.href='/member/loginForm.do"+param+"';</script>");
				out.flush();
				return "memberLoginForm";
			}
		}catch (Exception e) {
			if(log.isDebugEnabled()) log.debug("Login Error memberCommand : " + memberCommand);
			if(log.isDebugEnabled()) log.debug("Login Error exception : " + e);
			
			return "memberLoginForm";
		}
	}
	
	@RequestMapping(value="/member/nonMemberSub.do", method=RequestMethod.POST) //비회원 주문 시도
	public String nonMemSubmit(@RequestParam(value="nonMem", required=false) String nonMem, HttpSession session, HttpServletResponse response, Model model, HttpServletRequest request){
		try{
			if(log.isDebugEnabled()) log.debug("nonMem : " + nonMem);
			
			boolean check = false;
			
			if(nonMem != null) {
				check = true;
			}
			
			Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
			FlashMap fm = new FlashMap();
			
			if(flashMap !=null) {
				fm.put("product_no_list", flashMap.get("product_no_list"));
				fm.put("quantity_list", flashMap.get("quantity_list"));
				fm.put("total_price", flashMap.get("total_price"));
				
				if(log.isDebugEnabled()) log.debug("LoginSub flashMap : " + flashMap);
				
				FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
				flashMapManager.saveOutputFlashMap(fm, request, response);
			}
			
			if(check) {
				if(log.isDebugEnabled()) log.debug("비회원 주문 페이지 요청 완료");
				session.setAttribute("nonMem", "Y");
				model.addAttribute("nonMem", "Y");
				saveDestination(request);
				return "main";
			}else {
				if(log.isDebugEnabled()) log.debug("비회원 주문 페이지 요청 실패");
				
				HttpSession httpSession = request.getSession();
				/* 로그인 실패 시 머물렀던 페이지 저장... 다시 로그인 시 저장된 페이지로 이동시키게  destination 설정*/
				if(!request.getHeader("referer").contains("/member/loginForm.do")) {
					request.getSession().setAttribute("destination", request.getHeader("referer"));
					Object destination = httpSession.getAttribute("destination");
					if(log.isDebugEnabled()) log.debug("destination_referer : " + destination);
				}
				
				model.addAttribute("user_id","itsNotUser");
				
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('잘못된 시도입니다.'); location.href='/member/loginForm.do?orderLogin=Y';</script>");
				out.flush();
				return "memberLoginForm";
			}
		}catch (Exception e) {
			if(log.isDebugEnabled()) log.debug("nonMember Login Error exception : " + e);
			return "memberLoginForm";
		}
	}
	
	@RequestMapping(value="/member/logout.do") //로그아웃
	public String logout(HttpSession session) {
		session.removeAttribute("user_id");
		session.removeAttribute("nonMem");
		session.invalidate();
		return "redirect: /main.do";
	}
}