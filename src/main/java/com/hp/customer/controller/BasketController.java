package com.hp.customer.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hp.book.domain.BookCommand;
import com.hp.customer.domain.CustomerCommand;
import com.hp.customer.service.CustomerService;

@Controller
public class BasketController {
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="customerService")
	private CustomerService customerService;
	   
	@RequestMapping(value="/customer/basketList.do")
	public String form(HttpSession session, HttpServletRequest request, Model model) throws UnsupportedEncodingException {
		String user_id = (String) session.getAttribute("user_id");
		
		if(user_id == null) { //비회원 장바구니 쿠키 조회
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
			List<String> product_list = new ArrayList<String>();
			List<String> quantity_list = new ArrayList<String>();
			String product_no = null;
			if(!basket_value.equals("")) {
				for(int i=0; i<basket_split.length; i++) {
					product_no = product_no + basket_split[i].substring(0,1);
					product_list.add(basket_split[i].substring(0,1));
					quantity_list.add(basket_split[i].substring(2,3));
				}
				List<BookCommand> bookCommand = customerService.getBasketCookieList(product_list);
				model.addAttribute("basket", bookCommand);
				model.addAttribute("quantity_list", quantity_list);
			}else {
				model.addAttribute("basket", "");
			}
		}else {
			List<BookCommand> bookCommand = customerService.getBasketList(user_id);
			model.addAttribute("basket", bookCommand);
		}
		
		return "basketList";
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/basketSub.do")
	public boolean basketSub(@ModelAttribute("customerCommand") CustomerCommand customerCommand, 
			HttpServletResponse response, HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		String user_id = (String) session.getAttribute("user_id");
		customerCommand.setUser_id(user_id);
		
		if(log.isDebugEnabled()) log.debug("CustomerCommand : " + customerCommand);
		
		try {
			if (user_id == null) {
				String basket_value = "";
				Cookie get_cookie[] = request.getCookies();
				if (get_cookie != null) {
					for (int i = 0; i < get_cookie.length; i++) {
						if (get_cookie[i].getName().equals("basket_cookie")) {
							basket_value = URLDecoder.decode(get_cookie[i].getValue(), "UTF-8");
						}
					}
				}

				String key = "basket_cookie";
				String value = basket_value + customerCommand.getProduct_no() + "_" + customerCommand.getQuantity()	+ ",";
				boolean Duplicate = true;

				String[] basket_split = basket_value.split(",");
				String basket_stringval;
				if (basket_value != "") {
					for (int i = 0; i < basket_split.length; i++) {
						basket_stringval = basket_split[i].substring(0, 1);
						if (basket_stringval.equals(customerCommand.getProduct_no())) {
							Duplicate = false;
							break;
						}
						basket_stringval = "";
					}
					if (Duplicate) {
						Cookie cookie = new Cookie(key, value);
						cookie.setMaxAge(60 * 60 * 24 * 1);
						cookie.setPath("/");
						cookie.setVersion(0);
						response.addCookie(cookie);
					}
				} else {
					Cookie cookie = new Cookie(key, value);
					cookie.setMaxAge(60 * 60 * 24 * 1);
					cookie.setPath("/");
					cookie.setVersion(0);
					response.addCookie(cookie);
				}

			} else {
				customerService.insertBasket(customerCommand);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@ResponseBody
	@RequestMapping(value="/customer/basketDelete.do", method=RequestMethod.POST)
	public boolean basketDelete(@RequestParam(value="product_arr",required=false) List<String> product_arr, 
			HttpServletResponse response, HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		if (log.isDebugEnabled())log.debug("product_arr : " + product_arr);
		String user_id = (String) session.getAttribute("user_id");

		try {
			if (user_id == null) {
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
				String basket_cookie = null;
				String product_no_del = null;
				for(int i = 0; i < product_arr.size(); i++) {
					product_no_del += product_arr.get(i)+",";
				}
				
				if (!basket_value.equals("")) {
					for (int j = 0; j < basket_split.length; j++) {
						if(product_no_del.indexOf(basket_split[j].substring(0, 1)) <= -1)  {
							basket_cookie = basket_cookie + basket_split[j]+",";
						}
					}
					if(basket_cookie != null) {
						basket_cookie = basket_cookie.replace("null", ""); //null일시 피하기
					}else {
						basket_cookie = "";
					}
				}
				String key = "basket_cookie";
				Cookie cookie = new Cookie(key, basket_cookie);
				cookie.setMaxAge(60 * 60 * 24 * 1);
				cookie.setPath("/");
				cookie.setVersion(0);
				response.addCookie(cookie);
			} else {
				HashMap<String, Object> hm = new HashMap<String, Object>();
				hm.put("user_id", user_id);
				hm.put("product_arr", product_arr);
				customerService.basketDelete(hm);
			}
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}
}
